-- СВЯЗЬ "ОДИН КО МНОГИМ"

CREATE TABLE IF NOT EXISTS customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
    order_date TIMESTAMP DEFAULT NOW()
);

-- СВЯЗЬ "ОДИН К ОДИНОМУ"

CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
    order_date TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS payments (
    id SERIAL PRIMARY KEY,
    order_id INT UNIQUE REFERENCES orders(id) ON DELETE CASCADE,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT NOW(),
    payment_method VARCHAR(50) NOT NULL
);

-- СВЯЗЬ "МНОГИЕ КО МНОГИМ"

CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    category VARCHAR(30),
    price DECIMAL(10,2),
    stock INT
);

CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
    order_date TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS orders_products (
    order_id INT REFERENCES orders(id) ON DELETE CASCADE,
    product_id INT REFERENCES products(id) ON DELETE CASCADE,
    quantity INT CHECK (quantity > 0),
    PRIMARY KEY (order_id, product_id)
);


-- ЗАПОЛНЕНИЕ ТЕСТОВЫМИ ДАННЫМИ

INSERT INTO customers (name, email) VALUES
	('Alice', 'alice@example.com'),
	('Bob', 'bob@example.com'),
	('Charlie', 'charlie@example.com'),
	('Alex', 'alex@example.com');

INSERT INTO products (name, category, price, stock) VALUES
	('Laptop', 'Electronics', 1200.00, 10),
	('Smartphone', 'Electronics', 800.00, 15),
	('Headphones', 'Accessories', 100.00, 25);	

INSERT INTO orders (customer_id, order_date) VALUES
	(1, '2024-03-10 10:00:00'),
	(2, '2024-03-11 12:30:00'),
	(3, '2024-03-12 15:45:00');

INSERT INTO orders_products (order_id, product_id, quantity) VALUES
	(1, 1, 1),  -- Alice купила 1 ноутбук
	(1, 2, 2),  -- Alice купила 2 смартфона
	(2, 3, 1),  -- Bob купил 1 наушники
	(3, 1, 1);  -- Charlie купил 1 ноутбук


-- INNER JOIN

SELECT orders.id AS order_id, customers.name AS customer_name, orders.order_date -- вывод заказов вместе с клиентами
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id;

-- LEFT JOIN

SELECT customers.name, orders.id AS order_id, orders.order_date -- вывод клиентов и их заказов (если у келинта нет заказа, он все равно выводится, т.к. левая таблица - customers)
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id;

-- RIGHT JOIN
SELECT orders.id AS order_id, orders.order_date, customers.name -- вывод заказов и клиентов (если у келинта нет заказа, он все равно выводится, т.к. правая таблица - customers)
FROM orders
RIGHT JOIN customers ON orders.customer_id = customers.id;

-- FULL OUTER JOIN

SELECT customers.name, orders.id AS order_id, orders.order_date -- вывод всех клиентов и всех заказов, даже если они не имеют соответствующих данных
FROM customers
FULL OUTER JOIN orders ON customers.id = orders.customer_id;

-- CROSS JOIN

SELECT customers.name, orders.id AS order_id FROM customers CROSS JOIN orders;

-- SELF JOIN

CREATE TABLE IF NOT EXISTS categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    parent_category_id INT REFERENCES categories(id) -- Связь с самой собой
);

INSERT INTO categories (name, parent_category_id) VALUES
	('Электроника', NULL),  -- Главная категория
	('Смартфоны', 1),       -- Подкатегория "Смартфоны" в "Электронике"
	('Ноутбуки', 1),        -- Подкатегория "Ноутбуки" в "Электронике"
	('Аксессуары', 1),      -- Подкатегория "Аксессуары" в "Электронике"
	('Чехлы', 4),           -- Подкатегория "Чехлы" в "Аксессуарах"
	('Зарядные устройства', 4); -- Подкатегория "Зарядные устройства" в "Аксессуарах"


SELECT 
    c1.name AS subcategory,
    c2.name AS parent_category
FROM categories c1
LEFT JOIN categories c2 ON c1.parent_category_id = c2.id;