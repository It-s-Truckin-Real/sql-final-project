-- Drop Temporary Tables
DROP TEMPORARY TABLE IF EXISTS enumerated_addresses;
DROP TEMPORARY TABLE IF EXISTS enumerated_franchises;
DROP TEMPORARY TABLE IF EXISTS enumerated_people;

-- Insert Addresses
INSERT INTO addresses (street_1, street_2, city, state, zip_code)
VALUES ("122 N 5th E", null, "Rexburg", "ID", "83440")
,      ("320 S 3rd E", "APT 12", "Rexburg", "ID", "83440")
,      ("456 N 2nd W", "APT 35", "Rexburg", "ID", "83440")
,      ("456 N 2nd W", "APT 34", "Rexburg", "ID", "83440");

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
('Pierce','Joseph','1989-10-03', (
	SELECT enumerated_addresses.address_id 
    FROM enumerated_addresses
	WHERE row_num = 3));

-- Insert Customers

-- Insert Franchises
INSERT INTO franchises (address_id) 
(
	SELECT enumerated_addresses.address_id
    FROM enumerated_addresses
    WHERE row_num = 2
);

-- Insert Positions
 INSERT INTO  positions(position_name, hourly_wage)
 VALUES
 ('Server', '7.25'),
 ('Chef', '18'),
 ('Manager', '25'),
 ('Host','14');
-- Insert Employees
 INSERT INTO 
-- Insert Inspections
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

INSERT INTO inspections (inspection_date, inspection_score, franchise_id, inspector_person_id)
VALUES ("2022-11-18", 83, (
	SELECT enumerated_franchises.franchise_id
    FROM enumerated_franchises
    WHERE row_num = 1), (
	SELECT enumerated_people.person_id
    FROM enumerated_people
    WHERE row_num = 2));

-- Insert Inspections Employees

-- Insert Time Off Requests

-- Insert Payroll

-- Insert Ingredients

-- Insert Dishes

-- Insert Orders

-- Insert Dish Ingredients

-- Insert Order Dishes
