package com.dao;

import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import com.entity.category;

public class CategoryDao {
    private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }

    public boolean saveCategory(category cat) {
        boolean f = false;
        Transaction tx = null;
        // try-with-resources se session automatic close ho jata hai error aane par bhi
        try (Session session = this.factory.openSession()) {
            tx = session.beginTransaction();
            session.save(cat);
            tx.commit();
            f = true;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
        return f;
    }
    
    public category getCategoryById(int cid) {
        category cat = null;
        try (Session session = this.factory.openSession()) {
            cat = session.get(category.class, cid);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cat;
    }
    
    public List<category> getAllCategories() {
        List<category> list = null;
        try (Session session = this.factory.openSession()) {
            Query q = session.createQuery("from category");
            list = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public void deleteCategory(int cid) {
        Transaction tx = null;
        try (Session s = this.factory.openSession()) {
            tx = s.beginTransaction();
            category cat = s.get(category.class, cid);
            if (cat != null) {
                s.delete(cat);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }
    
    public void updateCategory(category cat) {
        Transaction tx = null;
        try (Session s = this.factory.openSession()) {
            tx = s.beginTransaction();
            s.update(cat);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }
}