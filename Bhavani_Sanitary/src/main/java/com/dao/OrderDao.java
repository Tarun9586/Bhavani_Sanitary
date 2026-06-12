package com.dao;

import com.entity.Order;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import java.util.List;

public class OrderDao {
    private SessionFactory factory;

    public OrderDao(SessionFactory factory) {
        this.factory = factory;
    }

    // Order save karne ke liye
    public boolean saveOrder(Order order) {
        boolean f = false;
        Transaction tx = null;
        try (Session session = this.factory.openSession()) {
            tx = session.beginTransaction();
            session.save(order);
            tx.commit();
            f = true;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
        return f;
    }

    // Saare orders admin ko dikhane ke liye
    public List<Order> getAllOrders() {
        List<Order> list = null;
        try (Session session = this.factory.openSession()) {
            Query<Order> q = session.createQuery("from Order order by orderId desc", Order.class);
            list = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ID se order nikalne ke liye (Status update ke waqt kaam aayega)
    public Order getOrderById(int id) {
        Order o = null;
        try (Session session = this.factory.openSession()) {
            o = session.get(Order.class, id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return o;
    }

    // Status update karne ke liye
    public boolean updateOrder(Order order) {
        boolean f = false;
        Transaction tx = null;
        try (Session session = this.factory.openSession()) {
            tx = session.beginTransaction();
            session.update(order);
            tx.commit();
            f = true;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
        return f;
    }
    
 // Login user ke orders fetch karne ke liye
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> list = null;
        try (Session session = this.factory.openSession()) {
            Query<Order> q = session.createQuery("from Order where user.id = :uid order by orderId desc", Order.class);
            q.setParameter("uid", userId);
            list = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}