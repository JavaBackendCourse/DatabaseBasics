-- СОЗДАНИЕ БАЗЫ ДАННЫХ
CREATE DATABASE shop;

-- СОЗДАНИЕ ТАБЛИЦЫ

CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    category VARCHAR(30),
    price DECIMAL(10,2),
    stock INT
);

-- ВСТАВКА ДАННЫХ В ТАБЛИЦУ

INSERT INTO products (name, category, price, stock)  -- Вставка данных в таблицу products
VALUES 
('Laptop', 'Electronics', 1200.00, 10),
('Smartphone', 'Electronics', 800.00, 15),
('Table', 'Furniture', 150.00, 20), 
('Chair', 'Furniture', 80.00, 30);


-- ВЫВОД ЭЛЕМЕНТОВ

SELECT * FROM products; -- вывод всех продуктов со всеми столбцами

SELECT name FROM products; -- вывод только определенных столбцов из таблицы products

SELECT * FROM products WHERE name LIKE '%phone'; -- вывод строк с именем оканчивающимся на "phone"

SELECT * FROM products WHERE price > 500; -- вывод строк с ценой превышающей 500

SELECT COUNT(*) FROM products; -- вывод количества всех строк в таблцие products

SELECT COUNT(id) FROM products WHERE price > 500; -- вывод количества строк у которых цена больше 500

SELECT SUM(price) FROM products; -- вывод общей суммарной цены

SELECT AVG(price) FROM products; -- вывод средней цены

SELECT MIN(price) FROM products; -- вывод минимальной цены

SELECT MAX(price) FROM products; -- вывод максимальной цены

SELECT * FROM products LIMIT 5; -- выводе первых 5 строк

SELECT * FROM products ORDER BY price DESC; -- вывод отсортированный по цене в порядке убывания

SELECT * FROM products ORDER BY price ASC; -- вывод отсортированные по цене в порядке возрастания

SELECT category, COUNT(*) FROM products GROUP BY category; -- группировка по категории и вывод кол-ва элементов в каждой категории

SELECT category, AVG(price)
	FROM products 
	GROUP BY category 
	HAVING AVG(price) > 100;


-- ОБНОВЛЕНИЕ ЗАПИСЕЙ

UPDATE products SET price = 1100.00 WHERE name = 'Laptop'; -- обновление цены у продукта с именем Laptop

UPDATE products SET category = 'Electronics and Tech' WHERE category = 'Electronics'; -- обновление категории 'Electronics' на 'Electronics and Tech'

-- УДАЛЕНИЕ ЗАПИСЕЙ

DELETE FROM products WHERE name = 'Chair';
