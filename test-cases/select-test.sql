SELECT 	SUM(TIMESTAMPDIFF(SECOND, p.clock_in, p.clock_out) / 3600) time_worked
,		pos.hourly_wage hourly_wage
,		TRUNCATE(SUM(TIMESTAMPDIFF(SECOND, p.clock_in, p.clock_out) / 3600) * pos.hourly_wage, 2) earnings
FROM payroll p
INNER JOIN employees e
ON p.employee_id = e.employee_id
INNER JOIN position pos
ON e.position_id = pos.position_id
GROUP BY p.employee_id;

SELECT TRUNCATE(SUM(TIMESTAMPDIFF(SECOND, p.clock_in, p.clock_out) / 3600) * pos.hourly_wage, 2) total_expenses
FROM payroll p
INNER JOIN employees e
ON p.employee_id = e.employee_id
INNER JOIN position pos
ON e.position_id = pos.position_id;