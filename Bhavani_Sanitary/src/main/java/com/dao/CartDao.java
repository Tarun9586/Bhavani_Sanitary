package com.dao;

import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import com.entity.Cart;

public class CartDao {
	private SessionFactory factory;

	public CartDao(SessionFactory factory) {
		this.factory = factory;
	}

	public boolean addCart(Cart c) {
		boolean f = false;
		try (Session session = factory.openSession()) {
			Transaction tx = session.beginTransaction();
			session.save(c);
			tx.commit();
			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public List<Cart> getCartByUser(int userId) {
		List<Cart> list = null;
		try (Session session = factory.openSession()) {
			Query q = session.createQuery("from Cart where userId=:uid");
			q.setParameter("uid", userId);
			list = q.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

    // 🔥 NAYA METHOD: ID se cart dhoondne ke liye
    public Cart getCartById(int cid) {
        Cart c = null;
        try (Session session = factory.openSession()) {
            c = session.get(Cart.class, cid);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return c;
    }

    // 🔥 NAYA METHOD: Cart ki quantity/price update karne ke liye
    public boolean updateCart(Cart c) {
        boolean f = false;
        Transaction tx = null;
        try (Session session = factory.openSession()) {
            tx = session.beginTransaction();
            session.update(c);
            tx.commit();
            f = true;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
        return f;
    }

	public boolean removeProductFromCart(int cid) {
		boolean f = false;
		try (Session session = factory.openSession()) {
			Transaction tx = session.beginTransaction();
			Cart c = session.get(Cart.class, cid);
			if (c != null) {
				session.delete(c);
				tx.commit();
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public boolean deleteCartByUser(int userId) {
		boolean f = false;
		try (Session session = factory.openSession()) {
			Transaction tx = session.beginTransaction();
			Query q = session.createQuery("delete from Cart where userId = :uid");
			q.setParameter("uid", userId);
			int res = q.executeUpdate();
			if (res > 0) {
				f = true;
			}
			tx.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	
	public boolean addCart(int uid, int pid) {
	    boolean f = false;
	    try (Session session = factory.openSession()) {
	        Transaction tx = session.beginTransaction();
	        
	        // Query to check if product already exists in cart for this user
	        // (Taki quantity update ho sake, par abhi simple rakhte hain)
	        Cart cart = new Cart();
	        cart.setCartId(uid);
	        cart.setProductId(pid);
	        cart.setQuantity(1);

	        session.save(cart);
	        tx.commit();
	        f = true;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return f;
	}
}