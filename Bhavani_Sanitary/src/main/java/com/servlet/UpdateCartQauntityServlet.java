package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.dao.CartDao;
import com.db.HibernateUtil;
import com.entity.Cart;

// 🔥 Isse change kar, sirf /update_cart_qty rakh
@WebServlet("/update_cart_qty") 
public class UpdateCartQauntityServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int cid = Integer.parseInt(request.getParameter("cid"));
            String action = request.getParameter("action");

            CartDao dao = new CartDao(HibernateUtil.getSessionFactory());
            Cart c = dao.getCartById(cid);

            if (c != null) {
                int currentQty = c.getQuantity();
                if ("inc".equals(action)) {
                    c.setQuantity(currentQty + 1);
                } else if ("dec".equals(action) && currentQty > 1) {
                    c.setQuantity(currentQty - 1);
                }
                c.setTotalPrice(c.getPrice() * c.getQuantity());
                dao.updateCart(c);
            }
            
            // 🔥 JSP direct webapp mein hai toh bina kisi folder ke naam ke redirect kar
            response.sendRedirect("all_products.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("all_products.jsp");
        }
    }
}