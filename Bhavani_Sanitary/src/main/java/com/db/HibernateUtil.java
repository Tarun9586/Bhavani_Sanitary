package com.db;

import java.util.Properties;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.service.ServiceRegistry;

import com.entity.User;
import com.entity.category;
import com.entity.product;
import com.entity.Cart;
import com.entity.Order;

public class HibernateUtil {
    private static SessionFactory sessionFactory;

    public static SessionFactory getSessionFactory() {
        if (sessionFactory == null) {
            try {
                Configuration configuration = new Configuration();

                Properties properties = new Properties();
                
                // Driver aur Dialect set karo
                properties.put(Environment.DRIVER, "org.postgresql.Driver");
                properties.put(Environment.DIALECT, "org.hibernate.dialect.PostgreSQLDialect");
                
                // Render ke Environment Variables se data uthao (Safe tarika)
                // Render dashboard mein 'DATABASE_URL', 'DB_USERNAME', 'DB_PASSWORD' set kar dena
                properties.put(Environment.URL, System.getenv("DATABASE_URL"));
                properties.put(Environment.USER, System.getenv("DB_USERNAME"));
                properties.put(Environment.PASS, System.getenv("DB_PASSWORD"));
                
                // Database settings
                properties.put(Environment.HBM2DDL_AUTO, "update");
                properties.put(Environment.SHOW_SQL, true);
                properties.put(Environment.FORMAT_SQL, true);

                configuration.setProperties(properties);
                
                // Annotations register karo
                configuration.addAnnotatedClass(User.class);
                configuration.addAnnotatedClass(category.class);
                configuration.addAnnotatedClass(product.class);
                configuration.addAnnotatedClass(Cart.class);
                configuration.addAnnotatedClass(Order.class);

                ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
                        .applySettings(configuration.getProperties()).build();

                sessionFactory = configuration.buildSessionFactory(serviceRegistry);
                System.out.println("Hibernate SessionFactory (PostgreSQL) Created Successfully via Env Vars!");
            } catch (Exception e) {
                System.err.println("CRITICAL ERROR: PostgreSQL Connection Failed!");
                e.printStackTrace();
            }
        }
        return sessionFactory;
    }
}
