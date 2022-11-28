-- Insert Addresses
INSERT INTO addresses (street_1, street_2, city, state, zip_code)
VALUES ("122 N 5th E", null, "Rexburg", "ID", "83440")
,      ("320 S 3rd E", "APT 12", "Rexburg", "ID", "83440")
,      ("456 N 2nd W", "APT 35", "Rexburg", "ID", "83440");

-- Insert People

-- Insert Customers

-- Insert Franchises
INSERT INTO franchises (address_id) 
(
	SELECT enumerated_addresses.address_id
    FROM
    (
		SELECT 
		ROW_NUMBER() OVER(ORDER BY address_id ASC) AS row_num
		, address_id
		FROM addresses 
		WHERE state = "ID"
    ) enumerated_addresses
    WHERE row_num = 2
);

-- Insert Positions

-- Insert Employees

-- Insert Inspections
INSERT INTO inspections (inspection_date, inspection_score, franchise_id, inspector_person_id)
VALUES ("2022/11/18", 83, (
	SELECT enumerated_franchises.franchise_id
    FROM
    (
		SELECT 
		ROW_NUMBER() OVER(ORDER BY franchise_id ASC) AS row_num
		, franchise_id
		FROM franchises
    ) enumerated_franchises
    WHERE row_num = 2), (
	SELECT enumerated_people.person_id
    FROM
    (
		SELECT 
		ROW_NUMBER() OVER(ORDER BY person_id ASC) AS row_num
		, person_id
		FROM people
    ) enumerated_people
    WHERE row_num = 2));

-- Insert Inspections Employees

-- Insert Time Off Requests

-- Insert Payroll

-- Insert Ingredients

-- Insert Dishes

-- Insert Orders

-- Insert Dish Ingredients

-- Insert Order Dishes


