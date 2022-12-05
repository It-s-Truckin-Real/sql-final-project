SELECT 	p.employee_id employee_id
,		SUM(TIMESTAMPDIFF(SECOND, p.clock_in, p.clock_out) / 3600) time_worked
,		pos.hourly_wage hourly_wage
,		TRUNCATE(SUM(TIMESTAMPDIFF(SECOND, p.clock_in, p.clock_out) / 3600) * pos.hourly_wage, 2) earnings
FROM payroll p
INNER JOIN employees e
ON p.employee_id = e.employee_id
INNER JOIN position pos
ON e.position_id = pos.position_id
GROUP BY p.employee_id;

SELECT TRUNCATE(SUM(TIMESTAMPDIFF(SECOND, p.clock_in, p.clock_out) / 3600) * pos.hourly_wage, 2) total_employee_pay
FROM payroll p
INNER JOIN employees e
ON p.employee_id = e.employee_id
INNER JOIN position pos
ON e.position_id = pos.position_id;

SELECT dish_name, dish_price
FROM dishes;

WITH dish_price_and_cost AS (
SELECT	d.dish_id dish_id
,		d.dish_price dish_price
,		SUM(i.ingredient_price) ingredient_cost
FROM dishes d
INNER JOIN dish_ingredients di
ON d.dish_id = di.dish_id
INNER JOIN ingredients i
ON di.ingredient_id = i.ingredient_id
GROUP BY d.dish_name
)
SELECT 	CONCAT(p1.first_name, " ", p1.last_name) customer_name
,		CONCAT(p2.first_name, " ", p2.last_name) employee_serving
,		CONCAT_WS("", a.street_1, CONCAT(" ", a.street_2), ", ", a.city, ", ", a.state, ", ", a.zip_code) franchise_location
,		GROUP_CONCAT(d.dish_name ORDER BY d.dish_name SEPARATOR "\n") dishes_ordered 
,		(
	SELECT SUM(dpc.dish_price)
    ) total_price
,		(
	SELECT SUM(dpc.ingredient_cost)
    ) total_ingredient_cost
FROM orders o
INNER JOIN employees e
ON o.employee_id = e.employee_id
INNER JOIN people p1
ON e.person_id = p1.person_id
INNER JOIN customers c
ON o.customer_id = c.customer_id
INNER JOIN people p2
ON c.person_id = p2.person_id
INNER JOIN franchises f
ON o.franchise_id = f.franchise_id
INNER JOIN addresses a
ON f.address_id = a.address_id
INNER JOIN order_dishes od
ON o.order_id = od.order_id
INNER JOIN dishes d
ON od.dish_id = d.dish_id
INNER JOIN dish_price_and_cost dpc
ON d.dish_id = dpc.dish_id
ORDER BY franchise_location;