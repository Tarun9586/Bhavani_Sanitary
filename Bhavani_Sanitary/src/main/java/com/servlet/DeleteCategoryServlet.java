package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.CategoryDao;
import com.db.HibernateUtil;

@WebServlet("/DeleteCategoryServlet")
public class DeleteCategoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int cid = Integer.parseInt(request.getParameter("cid"));
            
            CategoryDao dao = new CategoryDao(HibernateUtil.getSessionFactory());
            dao.deleteCategory(cid);
            
            request.getSession().setAttribute("succMsg", "Category Deleted Successfully!");
            response.sendRedirect("user/admin.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("succMsg", "Error: Pehle is category ke products delete karein!");
            response.sendRedirect("user/admin.jsp");
        }
    }
}