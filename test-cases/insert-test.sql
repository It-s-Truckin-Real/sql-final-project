-- Drop Temporary Tables
DROP TEMPORARY TABLE IF EXISTS enumerated_addresses;
DROP TEMPORARY TABLE IF EXISTS enumerated_franchises;
DROP TEMPORARY TABLE IF EXISTS enumerated_people;
DROP TEMPORARY TABLE IF EXISTS enumerated_customers;
DROP TEMPORARY TABLE IF EXISTS enumerated_employees;
DROP TEMPORARY TABLE IF EXISTS enumerated_orders;

-- Insert Addresses
INSERT INTO addresses (street_1, street_2, city, state, zip_code)
VALUES ("122 N 5th E", NULL, "Rexburg", "ID", "83440")
,      ("320 S 3rd E", "APT 12", "Rexburg", "ID", "83440")
,      ("456 N 2nd W", "APT 35", "Rexburg", "ID", "83440")
,      ("456 N 2nd W", "APT 34", "Rexburg", "ID", "83440")
,      ("510 S Center St", NULL, "Rexburg", "ID", "83440")
,      ("275 Yellowstone Ave", NULL, "Pocatello", "ID", "83201");

-- Insert People
CREATE TEMPORARY TABLE IF NOT EXISTS enumerated_addresses (
	SELECT 
	ROW_NUMBER() OVER(ORDER BY address_id ASC) AS row_num
	, address_id
	FROM addresses
);

INSERT INTO people(first_name,last_name,dob,address_id)
VALUES 
('Amirah','Webster','1980-10-02', (
	SELECT enumerated_addresses.address_id 
    FROM enumerated_addresses
	WHERE row_num = 1));

INSERT INTO people(first_name,last_name,dob,address_id)
VALUES 
('Andy','Montoya','2000-02-05', (
	SELECT enumerated_addresses.address_id 
    FROM enumerated_addresses
	WHERE row_num = 1));

INSERT INTO people(first_name,last_name,dob,address_id)
VALUES 
('Essence','Grimes','1989-08-09', (
	SELECT enumerated_addresses.address_id 
    FROM enumerated_addresses
	WHERE row_num = 3));

INSERT INTO people(first_name,last_name,dob,address_id)
VALUES 
('Pierce','Grimes','1990-10-03', (
	SELECT enumerated_addresses.address_id 
    FROM enumerated_addresses
	WHERE row_num = 3));

INSERT INTO people(first_name,last_name,dob,address_id)
VALUES 
('Steven','Stroingle','1979-01-07', (
	SELECT enumerated_addresses.address_id 
    FROM enumerated_addresses
	WHERE row_num = 4));

INSERT INTO people(first_name,last_name,dob,address_id)
VALUES 
('Bobby','Brown','1979-01-07', (
	SELECT enumerated_addresses.address_id 
    FROM enumerated_addresses
	WHERE row_num = 5));

-- Insert Franchises
INSERT INTO franchises (address_id) 
(
	SELECT address_id
    FROM enumerated_addresses
    WHERE row_num = 2
);

INSERT INTO franchises (address_id) 
(
	SELECT address_id
    FROM enumerated_addresses
    WHERE row_num = 6
);

-- Insert Positions
 INSERT INTO position (position_name, hourly_wage)
 VALUES
 ('Server', '7.25'),
 ('Chef', '18'),
 ('Manager', '25'),
 ('Host','14');

-- Insert Employees
CREATE TEMPORARY TABLE IF NOT EXISTS enumerated_franchises (
	SELECT 
	ROW_NUMBER() OVER(ORDER BY franchise_id ASC) AS row_num
	, franchise_id
	FROM franchises
);

CREATE TEMPORARY TABLE IF NOT EXISTS enumerated_people (
	SELECT 
	ROW_NUMBER() OVER(ORDER BY person_id ASC) AS row_num
	, person_id
	FROM people
);

 INSERT INTO employees (position_id, person_id, franchise_id)
 VALUES
 (
	(SELECT position_id 
    FROM position
    WHERE position_name = "Manager"),
    (SELECT person_id
    FROM enumerated_people
    WHERE row_num = 1),
    (SELECT franchise_id
    FROM enumerated_franchises
    WHERE row_num = 1)
);
 
-- Insert Inspections
INSERT INTO inspections (inspection_date, inspection_score, franchise_id, inspector_person_id)
VALUES ("2022-11-18", 83, (
	SELECT franchise_id
    FROM enumerated_franchises
    WHERE row_num = 1), (
	SELECT person_id
    FROM enumerated_people
    WHERE row_num = 2));

-- Insert Inspections Employees
INSERT INTO inspections_employees (inspection_id, employee_id)
VALUES (
	(SELECT i.inspection_id
    FROM inspections i
    INNER JOIN enumerated_franchises f
    ON i.franchise_id = f.franchise_id
    WHERE i.inspection_date = "2022-11-18"
    AND f.row_num = 1),
    (SELECT e.employee_id
    FROM employees e
    INNER JOIN enumerated_people p
    ON p.person_id = e.person_id
    WHERE p.row_num = 1));

-- Insert Time Off Requests
INSERT INTO time_off_requests (date_requested_off, date_when_requested, employee_id)
VALUES ("2022-12-25", "2022-11-18", 
	(SELECT e.employee_id
    FROM employees e
    INNER JOIN enumerated_people p
    ON p.person_id = e.person_id
    WHERE p.row_num = 1));

-- Insert Payroll
INSERT INTO payroll (clock_in, clock_out, employee_id)
VALUES (

	(SELECT TIMESTAMP("2022-11-18",  "9:58:37"))
,	(SELECT TIMESTAMP("2022-11-18",  "13:10:11"))
,	(SELECT e.employee_id
    FROM employees e
    INNER JOIN enumerated_people p
    ON p.person_id = e.person_id
    WHERE p.row_num = 1));
    
INSERT INTO payroll (clock_in, clock_out, employee_id)
VALUES (
	(SELECT TIMESTAMP("2022-11-18",  "13:42:52"))
,	(SELECT TIMESTAMP("2022-11-18",  "18:30:29"))
,	(SELECT e.employee_id
    FROM employees e
    INNER JOIN enumerated_people p
    ON p.person_id = e.person_id
    WHERE p.row_num = 1));

-- Insert Ingredients
INSERT INTO ingredients( ingredient_name, ingredient_price, ingredient_units, ingredient_units_plural)
VALUES 
('Enchilada Sauce',		'1.98',		'Can',		'Cans'),
('Coke',				'0.51',		'Can',		'Cans'),
('Brown Sugar',			'0.55',		'Cup',		'Cups'),
('Rice',				'0.72',		'Cup',		'Cups'),
('Lobster',				'48.95',	NULL,		NULL),
('Pork',				'5.02',		'Lb',		'Lbs'),
('Ground Beef',			'4.26',		'Lb',		'Lbs'),
('Egg',					'0.21',		NULL,		NULL),
('Chicken Stock',		'1.00',		'Cup',		'Cups'),
('Garlic',				'0.50',		'Bulb',		'Bulbs'),
('Tomato',				'0.38',		NULL,		NULL),
('Tamarind',			'11.61',	'Can',		'Cans'),
('Red Chilli',			'0.07',		NULL,		NULL),
('Green Chilli',		'0.06',		NULL,		NULL);

-- Insert Dishes
INSERT INTO dishes (dish_name, dish_price)
VALUES 
('Chilli Lobster',		'124.95'),
('Sweet Pork',			'24.95'),
('Green Rice', 			'18.45'),
('Meat Lover', 			'24.95');

-- Insert Customers
INSERT INTO customers (person_id, favorite_dish_id)
VALUES ((
	SELECT person_id
    FROM enumerated_people
    WHERE row_num = 2),
    (SELECT dish_id
    FROM dishes
    WHERE dish_name = "Green Rice"));

-- Insert Orders
CREATE TEMPORARY TABLE IF NOT EXISTS enumerated_customers (
	SELECT 
	ROW_NUMBER() OVER(ORDER BY customer_id ASC) AS row_num
	, customer_id
	FROM customers
);

CREATE TEMPORARY TABLE IF NOT EXISTS enumerated_employees (
	SELECT 
	ROW_NUMBER() OVER(ORDER BY employee_id ASC) AS row_num
	, employee_id
	FROM employees
);

INSERT INTO orders (franchise_id, employee_id, customer_id)
VALUES 	(
	(SELECT franchise_id
    FROM enumerated_franchises
    WHERE row_num = 1
	), 
	(SELECT employee_id
	FROM enumerated_employees
	WHERE row_num = 1
	),
	(SELECT customer_id
	FROM enumerated_customers
	WHERE row_num = 1 )
);

INSERT INTO orders (franchise_id, employee_id, customer_id)
VALUES 	(
	(SELECT franchise_id
    FROM enumerated_franchises
    WHERE row_num = 1
	), 
	(SELECT employee_id
	FROM enumerated_employees
	WHERE row_num = 1
	),
	(SELECT customer_id
	FROM enumerated_customers
	WHERE row_num = 1 )
);

INSERT INTO orders (franchise_id, employee_id, customer_id)
VALUES 	(
	(SELECT franchise_id
    FROM enumerated_franchises
    WHERE row_num = 1
	), 
	(SELECT employee_id
	FROM enumerated_employees
	WHERE row_num = 1
	),
	(SELECT customer_id
	FROM enumerated_customers
	WHERE row_num = 1 )
);

-- Insert Dish Ingredients
INSERT INTO dish_ingredients (dish_id, ingredient_id, ingredient_amount)
VALUES 	(
	(SELECT dish_id
	FROM dishes
	WHERE dish_name = 'Chilli Lobster' ),
	(SELECT ingredient_id
	FROM ingredients
	WHERE ingredient_name= 'Lobster'),
    2)
,		(
	(SELECT dish_id
	FROM dishes
	WHERE dish_name = 'Chilli Lobster' ),
	(SELECT ingredient_id
	FROM ingredients
	WHERE ingredient_name= 'Garlic'),
    0.3)
,		(
	(SELECT dish_id
	FROM dishes
	WHERE dish_name = 'Chilli Lobster' ),
	(SELECT ingredient_id
	FROM ingredients
	WHERE ingredient_name= 'Tomato'),
    2)
,		(
	(SELECT dish_id
	FROM dishes
	WHERE dish_name = 'Chilli Lobster' ),
	(SELECT ingredient_id
	FROM ingredients
	WHERE ingredient_name= 'Tamarind'),
    0.5)
,		(
	(SELECT dish_id
	FROM dishes
	WHERE dish_name = 'Chilli Lobster' ),
	(SELECT ingredient_id
	FROM ingredients
	WHERE ingredient_name= 'Red Chilli'),
    1)
,		(
	(SELECT dish_id
	FROM dishes
	WHERE dish_name = 'Sweet Pork' ),
	(SELECT ingredient_id
	FROM ingredients
	WHERE ingredient_name= 'Brown Sugar'),
    1.5)
,		(
	(SELECT dish_id
	FROM dishes
	WHERE dish_name = 'Sweet Pork' ),
	(SELECT ingredient_id
	FROM ingredients
	WHERE ingredient_name= 'Pork'),
    3)
,		(
	(SELECT dish_id
	FROM dishes
	WHERE dish_name = 'Sweet Pork' ),
	(SELECT ingredient_id
	FROM ingredients
	WHERE ingredient_name= 'Coke'),
    3)
,		(
	(SELECT dish_id
	FROM dishes
	WHERE dish_name = 'Green Rice' ),
	(SELECT ingredient_id
	FROM ingredients
	WHERE ingredient_name= 'Rice'),
    2)
,		(
	(SELECT dish_id
	FROM dishes
	WHERE dish_name = 'Green Rice' ),
	(SELECT ingredient_id
	FROM ingredients
	WHERE ingredient_name= 'Enchilada Sauce'),
    0.5)
,		(
	(SELECT dish_id
	FROM dishes
	WHERE dish_name = 'Green Rice' ),
	(SELECT ingredient_id
	FROM ingredients
	WHERE ingredient_name= 'Garlic'),
    0.15)
,		(
	(SELECT dish_id
	FROM dishes
	WHERE dish_name = 'Green Rice' ),
	(SELECT ingredient_id
	FROM ingredients
	WHERE ingredient_name= 'Green Chilli'),
    8)
,		(
	(SELECT dish_id
	FROM dishes
	WHERE dish_name = 'Meat Lover' ),
	(SELECT ingredient_id
	FROM ingredients
	WHERE ingredient_name= 'Ground Beef'),
    1)
,		(
	(SELECT dish_id
	FROM dishes
	WHERE dish_name = 'Meat Lover' ),
	(SELECT ingredient_id
	FROM ingredients
	WHERE ingredient_name= 'Pork'),
    1)
,		(
	(SELECT dish_id
	FROM dishes
	WHERE dish_name = 'Meat Lover' ),
	(SELECT ingredient_id
	FROM ingredients
	WHERE ingredient_name= 'Chicken Stock'),
    1)
,		(
	(SELECT dish_id
	FROM dishes
	WHERE dish_name = 'Meat Lover' ),
	(SELECT ingredient_id
	FROM ingredients
	WHERE ingredient_name= 'Garlic'),
    0.25);

-- Insert Order Dishes
CREATE TEMPORARY TABLE IF NOT EXISTS enumerated_orders (
	SELECT 
	ROW_NUMBER() OVER(ORDER BY order_id ASC) AS row_num
	, order_id
	FROM orders
);

INSERT INTO order_dishes (order_id, dish_id)
VALUES 
	((SELECT order_id
	FROM enumerated_orders
    WHERE row_num = 1
	),
	(SELECT dish_id
	FROM dishes
	WHERE dish_name = 'Meat Lover' ));
    
INSERT INTO order_dishes (order_id, dish_id)
VALUES 
	((SELECT order_id
	FROM enumerated_orders
    WHERE row_num = 1
	),
	(SELECT dish_id
	FROM dishes
	WHERE dish_name = 'Green Rice' ));
    
INSERT INTO order_dishes (order_id, dish_id)
VALUES 
	((SELECT order_id
	FROM enumerated_orders
    WHERE row_num = 2
	),
	(SELECT dish_id
	FROM dishes
	WHERE dish_name = 'Chilli Lobster' ));
    
INSERT INTO order_dishes (order_id, dish_id)
VALUES 
	((SELECT order_id
	FROM enumerated_orders
    WHERE row_num = 3
	),
	(SELECT dish_id
	FROM dishes
	WHERE dish_name = 'Sweet Pork' ));
