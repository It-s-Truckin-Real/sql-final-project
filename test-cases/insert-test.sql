
INSERT INTO addresses (street_1, street_2, city, state, zip_code)
VALUES ("122 N 5th E", null, "Rexburg", "ID", "83440")
,      ("320 S 3rd E", "APT 12", "Rexburg", "ID", "83440")
,      ("456 N 2nd W", "APT 35", "Rexburg", "ID", "83440");

INSERT INTO franchises (address_id) 
	(SELECT address_id 
    FROM addresses 
    WHERE state = "ID" 
    LIMIT 1);
    
INSERT INTO inspections (inspection_date, inspection_score, franchise_id, inspecctor_person_id)
VALUES ();
