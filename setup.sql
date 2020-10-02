DROP DATABASE [IF EXISTS] ntua_internetapps_2020;
CREATE DATABASE ntua_internetapps_2020;
USE ntua_internetapps_2020;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS order_products;

/* CREATE THE 4 TABLES */
CREATE TABLE users (username VARCHAR(40) NOT NULL, name VARCHAR(40) NOT NULL, date DATE NOT NULL, password VARCHAR(40) NOT NULL, PRIMARY KEY(username) ) ENGINE = InnoDB;
CREATE TABLE products (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(40) NOT NULL, price INT NOT NULL) ENGINE = InnoDB;
CREATE TABLE orders (id INT AUTO_INCREMENT, username VARCHAR(40) NOT NULL, PRIMARY KEY (id), price INT NOT NULL, FOREIGN KEY (username) REFERENCES users(username)) ENGINE = InnoDB;
CREATE TABLE order_products (order_id INT NOT NULL, prod_id INT NOT NULL, PRIMARY KEY (order_id, prod_id), FOREIGN KEY (prod_id) REFERENCES products(id), FOREIGN KEY (order_id) REFERENCES orders(id)) ENGINE = InnoDB;


/* INSERT INSTRUCTIONS STRUCTURE 
INSERT INTO users (username, name, date, password) VALUES ('dog', 'lito', '2010-04-20', 'dogpass');
INSERT INTO products (name, price) VALUES ('MacBook Air', 500);
INSERT INTO orders (username, price) VALUES ('dog', 50000);
INSERT INTO order_products (order_id, prod_id) VALUES (1, 2);

!!! The price is calculated as pennies , thus it's integer !!!
*/

/* INSERT DUMMY PRODUCTS */
INSERT INTO products (name, price) VALUES ('DELL XPS 13', 100000);
INSERT INTO products (name, price) VALUES ('HP ENVY X360', 74000);
INSERT INTO products (name, price) VALUES ('MACBOOK AIR', 99900);
INSERT INTO products (name, price) VALUES ('ASUS ROG ZEPHYRUS G14', 145000);
INSERT INTO products (name, price) VALUES ('MACBOOK PRO (16-INCH)', 239900);
INSERT INTO products (name, price) VALUES ('HP ELITE DRAGONFLY', 196200);
INSERT INTO products (name, price) VALUES ('LENOVO CHROMEBOOK DUET', 29900);
INSERT INTO products (name, price) VALUES ('RAZER BLADE PRO 17', 299900);
INSERT INTO products (name, price) VALUES ('HP SPECTRE X360 13', 125000);
INSERT INTO products (name, price) VALUES ('MACBOOK PRO 13', 179900);
INSERT INTO products (name, price) VALUES ('ACER CHROMEBOOK SPIN 713', 62900);
INSERT INTO products (name, price) VALUES ('GIGABYTE AERO 15', 268500);
INSERT INTO products (name, price) VALUES ('DELL G5 15 SE', 91000);
INSERT INTO products (name, price) VALUES ('DELL XPS 17', 294000);

/* INSERT DUMMY USERS */
INSERT INTO users (username, name, date, password) VALUES ('dog', 'lito', '2010-02-20', 'dogpass');
INSERT INTO users (username, name, date, password) VALUES ('cat', 'miaou', '2015-01-20', 'catpass');
INSERT INTO users (username, name, date, password) VALUES ('bird', 'krakra', '2014-09-20', 'birdpass');
INSERT INTO users (username, name, date, password) VALUES ('bear', 'grrr', '2000-08-20', 'bearpass');
INSERT INTO users (username, name, date, password) VALUES ('lion', 'roar', '2004-07-20', 'lionpass');
