package com.servlet;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.CartDao;
import com.dao.OrderDao;
import com.dao.ProductDao;
import com.db.HibernateUtil;
import com.entity.Cart;
import com.entity.Order;
import com.entity.User;
import com.entity.product;
import com.helper.EmailUtility; // 🔥 Yeh import check kar lena

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("activeUser");
            
            if (user == null) { 
                response.sendRedirect("login.jsp"); 
                return; 
            }

            String customerName = request.getParameter("username"); 
            String mobile = request.getParameter("mobile");
            String address = request.getParameter("address");
            String payment = request.getParameter("payment");

            CartDao cdao = new CartDao(HibernateUtil.getSessionFactory());
            OrderDao odao = new OrderDao(HibernateUtil.getSessionFactory());
            ProductDao pdao = new ProductDao(HibernateUtil.getSessionFactory());

            List<Cart> cartList = cdao.getCartByUser(user.getId());
            
            if (cartList == null || cartList.isEmpty()) {
                session.setAttribute("errorMsg", "Cart is empty!");
                response.sendRedirect("all_products.jsp");
                return;
            }

            boolean isOrderSaved = false;
            double grandTotal = 0; // Email mein total price dikhane ke liye

            for (Cart c : cartList) {
                product p = pdao.getProductById(c.getProductId());
                
                Order order = new Order();
                order.setOrderStatus("Pending");
                order.setPaymentMode(payment);
                order.setOrderDate(new Date());
                order.setUser(user);
                order.setProduct(p); 
                order.setQuantity(c.getQuantity()); 
                order.setPrice(c.getTotalPrice()); 
                order.setCustomerName(customerName);
                order.setMobile(mobile);
                order.setAddress(address);
                order.setProductName(c.getProductName());

                isOrderSaved = odao.saveOrder(order);
                grandTotal += c.getTotalPrice(); // Price add kar rahe hain
                
                if (isOrderSaved) {
                    int updatedStock = p.getpQauntity() - c.getQuantity();
                    p.setpQauntity(updatedStock); 
                    pdao.updateProduct(p);
                }
            }

            if (isOrderSaved) {
                // ---------------------------------------------------------
                // 📧 EMAIL LOGIC START
                // ---------------------------------------------------------
                String userEmail = user.getEmail(); // User object se email nikaala
                String subject = "Order Confirmed - Bhavani Sanitary";
                String body = "Dear " + customerName + ",\n\n"
                            + "Thank you for shopping at Bhavani Sanitary! Your order has been successfully placed.\n"
                            + "Total Amount: ₹" + grandTotal + "\n"
                            + "Shipping Address: " + address + "\n\n"
                            + "We will notify you once your order is dispatched.\n"
                            + "Best Regards,\nBhavani Sanitary Team";

                // Thread use kar rahe hain taaki email background mein jaye aur user ko wait na karna pade
                new Thread(() -> {
                    EmailUtility.sendEmail(userEmail, subject, body);
                }).start();
                // ---------------------------------------------------------
                // 📧 EMAIL LOGIC END
                // ---------------------------------------------------------

                cdao.deleteCartByUser(user.getId());
                session.setAttribute("succMsg", "Order Success! Check your email.");
                response.sendRedirect("index.jsp");
            } else {
                session.setAttribute("errorMsg", "Order Failed!");
                response.sendRedirect("user/Checkout.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp");
        }
    }
}