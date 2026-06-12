package com.servlet;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.dao.CategoryDao;
import com.dao.ProductDao;
import com.db.HibernateUtil;
import com.entity.category;
import com.entity.product;

@WebServlet("/UpdateProductServlet")
@MultipartConfig
public class UpdateProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        try {
            int pId = Integer.parseInt(request.getParameter("pId"));
            String pName = request.getParameter("pName");
            String pDesc = request.getParameter("pDesc");
            int pPrice = Integer.parseInt(request.getParameter("pPrice"));
            int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
            int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
            int catId = Integer.parseInt(request.getParameter("catId"));
            String oldImage = request.getParameter("oldImage");

            Part part = request.getPart("pPhoto");
            String statusImageName = part.getSubmittedFileName();

            ProductDao pdao = new ProductDao(HibernateUtil.getSessionFactory());
            product p = pdao.getProductById(pId);

            p.setpName(pName);
            p.setpDescription(pDesc);
            p.setpPrice(pPrice);
            p.setpDiscount(pDiscount);

            try { p.setpQauntity(pQuantity); } catch(Exception e) { p.setpQuantity(pQuantity); }

            CategoryDao cdao = new CategoryDao(HibernateUtil.getSessionFactory());
            category cat = cdao.getCategoryById(catId);
            p.setCategory(cat);

            if (statusImageName != null && !statusImageName.isEmpty()) {
                p.setpPhoto(statusImageName);
            } else {
                p.setpPhoto(oldImage);
            }

            boolean f = pdao.updateProduct(p);

            if (f) {
                if (statusImageName != null && !statusImageName.isEmpty()) {
                    String path = request.getServletContext().getRealPath("") + "img" + File.separator + "products";
                    part.write(path + File.separator + statusImageName);
                }
                session.setAttribute("succMsg", "Product Updated Successfully!");
            } else {
                session.setAttribute("errorMsg", "Something went wrong on database server!");
            }
            
            response.sendRedirect(request.getContextPath() + "/user/admin.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/user/admin.jsp");
        }
    }
}