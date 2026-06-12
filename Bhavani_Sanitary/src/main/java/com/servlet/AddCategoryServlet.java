package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.dao.CategoryDao;
import com.db.HibernateUtil;
import com.entity.category;

@WebServlet("/AddCategoryServlet")
public class AddCategoryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("catTitle");
        String desc = request.getParameter("catDesc");

        category cat = new category(title, desc, null);
        CategoryDao dao = new CategoryDao(HibernateUtil.getSessionFactory());
        
        boolean f = dao.saveCategory(cat);
        HttpSession session = request.getSession();

        if (f) {
            session.setAttribute("msg", "Category Added Successfully!");
        } else {
            session.setAttribute("msg", "Something went wrong!");
        }
        response.sendRedirect(request.getContextPath() + "/user/admin.jsp");

    }
}