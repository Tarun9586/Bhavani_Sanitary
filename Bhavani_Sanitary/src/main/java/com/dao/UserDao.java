package com.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import com.entity.User;

public class UserDao {
	private SessionFactory factory;

	public UserDao(SessionFactory factory) {
		this.factory = factory;
	}

	// 1. Save User to Database
	public boolean saveUser(User u) {
		boolean f = false;
		Transaction tx = null;
		try (Session session = factory.openSession()) {
			tx = session.beginTransaction();
			session.save(u);
			tx.commit();
			f = true;
		} catch (Exception e) {
			if (tx != null) tx.rollback();
			e.printStackTrace();
		}
		return f;
	}

	// 2. Duplicate Email Check (Case Insensitive)
	public boolean checkEmail(String email) {
		boolean exists = false;
		try (Session session = factory.openSession()) {
			// Using lower() ensures 'Test@gmail.com' matches 'test@gmail.com'
			Query q = session.createQuery("from User where lower(email) = lower(:em)");
			q.setParameter("em", email);
			User u = (User) q.uniqueResult();
			if (u != null) {
				exists = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return exists;
	}

	// 3. User Login Logic
	public User login(String email, String password) {
		User u = null;
		try (Session session = factory.openSession()) {
			String hql = "from User where email=:em and password=:ps";
			Query q = session.createQuery(hql);
			q.setParameter("em", email);
			q.setParameter("ps", password);
			u = (User) q.uniqueResult();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return u;
	}
}