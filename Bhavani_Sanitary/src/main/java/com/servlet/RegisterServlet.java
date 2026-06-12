package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.dao.UserDao;
import com.db.HibernateUtil;
import com.entity.User;

@WebServlet("/userRegister")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // .trim() removes spaces at the beginning or end of input strings
        String name = req.getParameter("name").trim();
        String email = req.getParameter("email").trim();
        String phno = req.getParameter("phno").trim();
        String password = req.getParameter("password");
        String address=req.getParameter("address");

        HttpSession session = req.getSession();
        UserDao dao = new UserDao(HibernateUtil.getSessionFactory());

        // Step 1: Check for duplicate email
        if (dao.checkEmail(email)) {
            session.setAttribute("msg", "Email ID already exists! Please try another.");
            resp.sendRedirect("register.jsp");
            return; // Stops the execution so the user is NOT saved below
        } 
        
        // Step 2: Proceed with registration if email is unique
        User u = new User(name, email, phno, password,address, "user");
        boolean f = dao.saveUser(u);

        if (f) {
            session.setAttribute("msg", "Registration Successful! Please Login.");
            resp.sendRedirect("register.jsp");
        } else {
            session.setAttribute("msg", "Something went wrong on the server. Try again.");
            resp.sendRedirect("register.jsp");
        }
    }
}