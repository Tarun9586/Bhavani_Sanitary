package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.dao.CartDao;
import com.db.HibernateUtil;
import com.entity.Cart;
import com.entity.User; // User entity import kar lena

@WebServlet("/add_to_cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        try {
            HttpSession session = req.getSession();
            // 1. Check karo user login hai ya nahi
            User activeUser = (User) session.getAttribute("activeUser");
            if (activeUser == null) {
                session.setAttribute("failed", "Please Login First!");
                resp.sendRedirect("login.jsp");
                return;
            }

            // 2. Tera purana logic (Same to Same)
            int pid = Integer.parseInt(req.getParameter("pid"));
            int uid = Integer.parseInt(req.getParameter("uid"));
            String pName = req.getParameter("pname");
            Double price = Double.parseDouble(req.getParameter("price"));
            
            int qty = 1; 
            if(req.getParameter("qty") != null) {
                qty = Integer.parseInt(req.getParameter("qty"));
            }

            Cart c = new Cart();
            c.setProductId(pid);
            c.setUserId(uid);
            c.setProductName(pName);
            c.setAuthor(req.getParameter("author")); 
            c.setQuantity(qty); 
            c.setPrice(price);
            c.setTotalPrice(price * qty);

            CartDao dao = new CartDao(HibernateUtil.getSessionFactory());
            boolean f = dao.addCart(c);

            if (f) {
                session.setAttribute("addCart", "Item Added to Cart!");
            } else {
                session.setAttribute("failed", "Something went wrong...");
            }

            // 3. 🔥 UPDATE: Redirect wapas usi page par jahan se click kiya tha
            String referer = req.getHeader("Referer");
            resp.sendRedirect(referer);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}