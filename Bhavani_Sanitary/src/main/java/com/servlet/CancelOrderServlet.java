package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.dao.OrderDao;
import com.db.HibernateUtil;
import com.entity.Order;
import com.helper.EmailUtility;

@WebServlet("/CancelOrderServlet")
public class CancelOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int oid = Integer.parseInt(request.getParameter("oid"));
            OrderDao dao = new OrderDao(HibernateUtil.getSessionFactory());
            Order o = dao.getOrderById(oid);
            
            HttpSession session = request.getSession();

            if (o != null && "Pending".equalsIgnoreCase(o.getOrderStatus())) {
                o.setOrderStatus("Cancelled");
                boolean f = dao.updateOrder(o);
                
                if (f) {
                    // 📧 Email trigger for cancellation
                    String userEmail = o.getUser().getEmail();
                    String subject = "Order Cancelled - Bhavani Sanitary";
                    String body = "Dear " + o.getCustomerName() + ",\n\n"
                                + "Your order #" + oid + " has been successfully cancelled as per your request.\n"
                                + "If any payment was made, it will be refunded within 5-7 business days.\n\n"
                                + "Team Bhavani Sanitary";

                    new Thread(() -> {
                        EmailUtility.sendEmail(userEmail, subject, body);
                    }).start();

                    session.setAttribute("succMsg", "Order Cancelled Successfully!");
                } else {
                    session.setAttribute("errorMsg", "Failed to cancel order.");
                }
            } else {
                session.setAttribute("errorMsg", "Order cannot be cancelled now.");
            }
            
            response.sendRedirect("user/my_orders.jsp"); // Apni file ka sahi path check kar lena
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}