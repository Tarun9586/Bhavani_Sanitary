package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        HttpSession session = req.getSession();
        
        // 1. Session se user hatana aur pura session khatam karna
        session.removeAttribute("activeUser");
        session.invalidate(); // Ye pura session clear kar dega (Security fix)

        // 2. Remember Me Cookies ko delete karna
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                // Jo naam tune LoginServlet mein rakhe the (uEmail, uPwd)
                if (c.getName().equals("uEmail") || c.getName().equals("uPwd")) {
                    c.setMaxAge(0); // Cookie ki life 0 kar di (Delete ho jayegi)
                    c.setPath("/"); // Path wahi hona chahiye jo save karte waqt tha
                    resp.addCookie(c);
                }
            }
        }

        // 3. Logout ke baad naya session banakar message dikhana
        // Purana session invalidate ho chuka hai, isliye naya session chahiye msg ke liye
        HttpSession session2 = req.getSession();
        session2.setAttribute("msg", "Logout Successfully");
        
        resp.sendRedirect("login.jsp");
    }
}