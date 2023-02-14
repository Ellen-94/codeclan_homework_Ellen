--MVP
--Q1 


SELECT 
e.first_name, 
e.last_name,
t.name 
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id; 


-- b) 

SELECT 
e.first_name, 
e.last_name,
t.name 
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id
WHERE pension_enrol = TRUE

-- c) 

SELECT 
e.first_name, 
e.last_name,
t.name, 
t.charge_cost
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id
WHERE CAST (t.charge_cost AS INT) > 80 


-- Q2 

SELECT 
e.*,
p.local_account_no,
p.local_sort_code
FROM employees AS e LEFT JOIN pay_details AS p 
ON e.pay_detail_id = p.id
WHERE p.local_account_no IS NOT NULL AND p.local_sort_code IS NOT NULL


-- b) 

SELECT 
e.*,
p.local_account_no,
p.local_sort_code,
t.name
FROM (employees AS e LEFT JOIN pay_details AS p 
ON e.pay_detail_id = p.id) 
LEFT JOIN teams AS t ON e.team_id = t.id
WHERE p.local_account_no IS NOT NULL AND p.local_sort_code IS NOT NULL


---Q3
--a 
SELECT 
e.id, 
t.name
FROM employees AS e LEFT JOIN teams AS T 
ON e.team_id = t.id

-- B


SELECT 
count(e.id), 
t.name
FROM employees AS e LEFT JOIN teams AS T 
ON e.team_id = t.id
GROUP BY t.name

-- C 
SELECT 
count(e.id) AS no_in_team, 
t.name
FROM employees AS e LEFT JOIN teams AS T 
ON e.team_id = t.id
GROUP BY t.name
ORDER BY count(e.id)

-- Q4

--a 

SELECT
t.id, 
t.name, 
count(e.id) AS number_of_employees
FROM teams AS t INNER JOIN employees AS e
ON e.team_id = t.id
GROUP BY t.id
ORDER BY t.id


-- b 

SELECT
t.id, 
t.name, 
count(e.id) AS number_of_employees,
CAST (t.charge_cost AS INT) * count(e.id) AS total_day_charge 
FROM teams AS t INNER JOIN employees AS e
ON e.team_id = t.id
GROUP BY t.id 
ORDER BY t.id


--- c


SELECT
t.id, 
t.name, 
count(e.id) AS number_of_employees,
CAST (t.charge_cost AS INT) * count(e.id) AS total_day_charge 
FROM teams AS t INNER JOIN employees AS e
ON e.team_id = t.id
GROUP BY t.id 
HAVING CAST (t.charge_cost AS INT) * count(e.id) > 5000



-- EXTENSION 

-- Q5 

SELECT 
count(DISTINCT(employee_id))
FROM employees_committees


-- Q5 

SELECT 
count(e.id)
FROM employees_committees AS c FULL JOIN employees AS e 
ON e.id = employee_id
WHERE c.employee_id IS NULL







