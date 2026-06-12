package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.CategoryDao;
import com.db.HibernateUtil;
import com.entity.category;

@WebServlet("/UpdateCategoryServlet")
public class UpdateCategoryServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Form se data nikalna
            int cid = Integer.parseInt(request.getParameter("cid"));
            String title = request.getParameter("catTitle");
            String desc = request.getParameter("catDesc");

            CategoryDao dao = new CategoryDao(HibernateUtil.getSessionFactory());
            
            // Database se purani category nikalna
            category cat = dao.getCategoryById(cid);
            
            // Naya data set karna
            cat.setCategoryTitle(title);
            cat.setCategoryDescription(desc);

            // Update fire karna
            dao.updateCategory(cat);

            HttpSession session = request.getSession();
            session.setAttribute("succMsg", "Category Updated Successfully!");
            
            // REDIRECT FIX: Servlet root mein hai aur admin.jsp 'user' folder mein
            response.sendRedirect("user/admin.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user/admin.jsp");
        }
    }
}