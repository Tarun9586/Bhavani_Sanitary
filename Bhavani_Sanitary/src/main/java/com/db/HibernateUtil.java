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
                
                // 1. PostgreSQL Driver update kiya
                properties.put(Environment.DRIVER, "org.postgresql.Driver");
                
                // 2. Render ka URL update kiya (jdbc:postgresql format mein)
                properties.put(Environment.URL, "jdbc:postgresql://dpg-d8if13mq1p3s73el92og-a.singapore-postgres.render.com:5432/bhavani_sanitary");
                
                properties.put(Environment.USER, "bhavani_sanitary_user");
                properties.put(Environment.PASS, "dkxDv4cCDhXt0arpkYZOnIMSwdTTgW2o");
                
                // 3. PostgreSQL Dialect update kiya
                properties.put(Environment.DIALECT, "org.hibernate.dialect.PostgreSQLDialect");
                
                properties.put(Environment.HBM2DDL_AUTO, "update");
                properties.put(Environment.SHOW_SQL, true);
                properties.put(Environment.FORMAT_SQL, true);

                configuration.setProperties(properties);
                
                configuration.addAnnotatedClass(User.class);
                configuration.addAnnotatedClass(category.class);
                configuration.addAnnotatedClass(product.class);
                configuration.addAnnotatedClass(Cart.class);
                configuration.addAnnotatedClass(Order.class);

                ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
                        .applySettings(configuration.getProperties()).build();

                sessionFactory = configuration.buildSessionFactory(serviceRegistry);
                System.out.println("Hibernate SessionFactory (PostgreSQL) Created Successfully!");
            } catch (Exception e) {
                System.err.println("CRITICAL ERROR: PostgreSQL Connection Failed!");
                e.printStackTrace();
            }
        }
        return sessionFactory;
    }
}