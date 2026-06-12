package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.dao.CartDao;
import com.db.HibernateUtil;

@WebServlet("/remove_item")
public class RemoveCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // JSP se cartId (cid) pakdo
        int cid = Integer.parseInt(req.getParameter("cid"));
        
        CartDao dao = new CartDao(HibernateUtil.getSessionFactory());
        boolean f = dao.removeProductFromCart(cid);
        
        HttpSession session = req.getSession();
        
        if (f) {
            session.setAttribute("succMsg", "Item Removed from Cart");
        } else {
            session.setAttribute("errorMsg", "Something went wrong on server");
        }
        
        // Wapas Cart page pe bhej do
        resp.sendRedirect("all_products.jsp");
    }
}