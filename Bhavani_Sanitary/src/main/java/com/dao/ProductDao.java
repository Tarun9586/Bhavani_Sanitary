package com.dao;

import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import com.entity.category;
import com.entity.product;

public class ProductDao {
    private SessionFactory factory;

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }

    public List<category> getAllCategories() {
        List<category> list = null;
        try (Session s = this.factory.openSession()) {
            Query q = s.createQuery("from category");
            list = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean saveProduct(product p) {
        boolean f = false;
        Transaction tx = null;
        try (Session s = this.factory.openSession()) {
            tx = s.beginTransaction();
            s.save(p);
            tx.commit();
            f = true;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
        return f;
    }
    
    // JOIN FETCH use kiya hai taaki product ke sath category_categoryID bina loop ke safely chal sake
    public List<product> getAllProducts() {
        List<product> list = null;
        try (Session s = this.factory.openSession()) {
            Query q = s.createQuery("select p from product p join fetch p.category");
            list = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<product> getProductsByCategoryId(int cid) {
        List<product> list = null;
        try (Session s = this.factory.openSession()) {
            Query q = s.createQuery("select p from product p join fetch p.category where p.category.categoryID = :id");
            q.setParameter("id", cid);
            list = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public product getProductById(int pid) {
        product p = null;
        try (Session s = this.factory.openSession()) {
            p = s.get(product.class, pid);
        } catch (Exception e) { 
            e.printStackTrace(); 
        }
        return p;
    }

    public void deleteProduct(int pid) {
        Transaction tx = null;
        try (Session s = this.factory.openSession()) {
            tx = s.beginTransaction();
            product p = s.get(product.class, pid);
            if(p != null) s.delete(p);
            tx.commit();
        } catch (Exception e) { 
            if (tx != null) tx.rollback();
            e.printStackTrace(); 
        }
    }

    public boolean updateProduct(product p) {
        boolean f = false;
        Transaction tx = null;
        try (Session s = this.factory.openSession()) {
            tx = s.beginTransaction();
            s.update(p);
            tx.commit();
            f = true;
        } catch (Exception e) { 
            if (tx != null) tx.rollback();
            e.printStackTrace(); 
        }
        return f;
    }
    
    public List<product> getAllProductsByCategoryId(int cid) {
        List<product> list = null;
        try (Session s = this.factory.openSession()) {
            Query q = s.createQuery("select p from product p join fetch p.category where p.category.categoryID = :id");
            q.setParameter("id", cid);
            list = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<product> getSearchProducts(String ch) {
        List<product> list = null;
        try (Session session = this.factory.openSession()) {
            String searchTerm = ch.toLowerCase().trim();
            String singularTerm = searchTerm;
            if (searchTerm.endsWith("s") && searchTerm.length() > 3) {
                singularTerm = searchTerm.substring(0, searchTerm.length() - 1);
            }

            String hql = "select p from product p join fetch p.category where lower(p.pName) like :key "
                       + "or lower(p.pDescription) like :key "
                       + "or lower(p.category.categoryTitle) like :key "
                       + "or lower(p.pName) like :sKey "
                       + "or lower(p.category.categoryTitle) like :sKey";
            
            Query q = session.createQuery(hql);
            q.setParameter("key", "%" + searchTerm + "%");
            q.setParameter("sKey", "%" + singularTerm + "%");
            
            list = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}