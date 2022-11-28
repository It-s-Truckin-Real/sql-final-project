-- Drop Temporary Tables
DROP TEMPORARY TABLE IF EXISTS enumerated_addresses;
DROP TEMPORARY TABLE IF EXISTS enumerated_franchises;
DROP TEMPORARY TABLE IF EXISTS enumerated_people;

-- Create Temporary Tables
CREATE TEMPORARY TABLE IF NOT EXISTS enumerated_addresses (
	SELECT 
	ROW_NUMBER() OVER(ORDER BY address_id ASC) AS row_num
	, address_id
	FROM addresses
);

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

-- Update Statements
UPDATE addresses
SET street_2 = "APT 13"
WHERE state = "ID"
LIMIT 1;

UPDATE franchises
SET address_id = (
	SELECT address_id
    FROM addresses
    ORDER BY address_id DESC
    LIMIT 1
    )
LIMIT 1;

