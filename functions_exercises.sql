use employees;
select database();
select * from employees;

-- 2
select first_name, last_name,
	CONCAT(first_name, last_name) as full_name
from employees
where last_name like 'E%'
	and last_name like '%E'
;

-- 3
select first_name, last_name,
	CONCAT(UPPER(first_name), UPPER(last_name)) as full_name
from employees
where last_name like 'E%'
	and last_name like '%E'
;

-- 4
select count(first_name)
from employees
where last_name like 'E%'
	and last_name like '%E'
;
-- 899

-- 5
select datediff(now(), '1990-01-01'), hire_date, birth_date
from employees
where (hire_date like '199%'
	and birth_date like '%-12-25')
;

-- 6
select *
from salaries;
select min(salary), max(salary)
from salaries;

-- 7
select *
from employees;
select first_name, last_name, birth_date
from employees;
select first_name, last_name, birth_date,
	CONCAT(LOWER(SUBSTR(FIRST_NAME, 1, 1)), (LOWER(SUBSTR(LAST_NAME, 1, 4))), '_', SUBSTR(birth_date, 6,2), SUBSTR(birth_date, 3,2))
    as username
from employees
limit 10
;