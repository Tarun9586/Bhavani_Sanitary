package com.servlet; // Package name sahi karo

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.ProductDao;
import com.db.HibernateUtil;

@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // URL se pid nikalna
            int pid = Integer.parseInt(request.getParameter("pid"));
            
            ProductDao dao = new ProductDao(HibernateUtil.getSessionFactory());
            dao.deleteProduct(pid);
            
            HttpSession session = request.getSession();
            session.setAttribute("succMsg", "Product Deleted Successfully!");
            
            // Redirect wapas admin page pe (jo user folder mein hai)
            response.sendRedirect("user/admin.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user/admin.jsp");
        }
    }
}