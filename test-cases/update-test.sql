
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

