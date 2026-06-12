package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.dao.UserDao;
import com.db.HibernateUtil;
import com.entity.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String remember = req.getParameter("remember"); // Checkbox ki value le rahe hain

        HttpSession session = req.getSession();
        String path = req.getContextPath();

        try {
            UserDao dao = new UserDao(HibernateUtil.getSessionFactory());
            User u = dao.login(email, password);

            if (u == null) {
                // Login Fail
                session.setAttribute("msg", "Invalid email or password");
                resp.sendRedirect("login.jsp");
            } else {
                // Login Success -> Session mein user set kiya
                session.setAttribute("activeUser", u);
                
                // --- UPDATE: Remember Me Logic (Cookies) ---
                if (remember != null && remember.equals("on")) {
                    // Email save karne ke liye cookie
                    Cookie cEmail = new Cookie("uEmail", email);
                    cEmail.setMaxAge(60 * 60 * 24 * 365); // 1 saal validity
                    resp.addCookie(cEmail);

                    // Password save karne ke liye cookie
                    Cookie cPwd = new Cookie("uPwd", password);
                    cPwd.setMaxAge(60 * 60 * 24 * 365);
                    resp.addCookie(cPwd);
                }
                // ------------------------------------------

                // Role-based redirection (Tera original logic)
                if ("admin".equalsIgnoreCase(u.getRole())) {
                    resp.sendRedirect(path + "/user/admin.jsp"); 
                } else {
                    resp.sendRedirect(path + "/index.jsp");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", "Something went wrong on server!");
            resp.sendRedirect("login.jsp");
        }
    }
}