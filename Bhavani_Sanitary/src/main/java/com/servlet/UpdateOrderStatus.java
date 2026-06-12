package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.dao.OrderDao;
import com.db.HibernateUtil;
import com.entity.Order;
import com.helper.EmailUtility; // Email utility ka import

@WebServlet("/UpdateOrderStatus")
public class UpdateOrderStatus extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 1. Form se data nikalna
            int oid = Integer.parseInt(request.getParameter("oid"));
            String status = request.getParameter("status");

            OrderDao dao = new OrderDao(HibernateUtil.getSessionFactory());
            Order o = dao.getOrderById(oid);
            
            if (o != null) {
                // 2. Database mein status update karna
                o.setOrderStatus(status);
                boolean f = dao.updateOrder(o);
                
                HttpSession session = request.getSession();
                
                if (f) {
                    // 3. Email Details taiyaar karna
                    String userEmail = o.getUser().getEmail(); 
                    String customerName = o.getCustomerName();
                    String productName = o.getProductName();
                    
                    // --- 📧 AUTOMATIC EMAIL LOGIC START ---
                    
                    if ("Shipped".equalsIgnoreCase(status)) {
                        // SHIPPED EMAIL
                        String subject = "Order Out for Delivery! - Bhavani Sanitary";
                        String body = "Dear " + customerName + ",\n\n"
                                    + "Good news! Your order #" + oid + " (" + productName + ") has been shipped.\n"
                                    + "It is now on its way to your address.\n\n"
                                    + "Thank you for choosing Bhavani Sanitary!\n"
                                    + "Best Regards,\nAdmin Team";

                        new Thread(() -> {
                            EmailUtility.sendEmail(userEmail, subject, body);
                        }).start();

                    } else if ("Delivered".equalsIgnoreCase(status)) {
                        // DELIVERED EMAIL
                        String subject = "Order Delivered Successfully! - Bhavani Sanitary";
                        String body = "Dear " + customerName + ",\n\n"
                                    + "Congratulations! Your order #" + oid + " (" + productName + ") has been delivered.\n\n"
                                    + "We hope you are satisfied with your purchase. Please visit us again!\n"
                                    + "Best Regards,\nBhavani Sanitary Team";

                        new Thread(() -> {
                            EmailUtility.sendEmail(userEmail, subject, body);
                        }).start();
                    }
                    
                    // --- 📧 AUTOMATIC EMAIL LOGIC END ---

                    session.setAttribute("succMsg", "Order #" + oid + " status updated to " + status);
                } else {
                    session.setAttribute("errorMsg", "Something went wrong on server!");
                }
            }
            
            // 4. Admin page par wapas bhejna
            response.sendRedirect("user/admin.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user/admin.jsp");
        }
    }
}