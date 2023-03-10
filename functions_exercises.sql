use employees;
select database();
select * from employees;

-- 2 
select first_name, last_name,
	CONCAT(first_name, last_name) as full_name
from employees
where last_name like 'e%e'
;

-- 3
select first_name, last_name,
	UPPER(CONCAT(first_name, ' ', last_name)) as full_name
from employees
where last_name like 'e%e'
;

-- 4
select count(*)
from employees
where last_name like 'e%e'
;
-- 899

-- 5
select datediff(now(), hire_date) as total_days, hire_date, birth_date
from employees
where (hire_date like '199%'
	and birth_date like '%-12-25')
;

-- 6
select min(salary), max(salary)
from salaries
where to_date > now()
limit 1
;

-- 7
select *
from employees;
select first_name, last_name, birth_date
from employees;
select first_name, last_name, birth_date,
	CONCAT(LOWER(SUBSTR(FIRST_NAME, 1, 1))
    -- left(first_name, 1)
    ,(LOWER(SUBSTR(LAST_NAME, 1, 4)))
    -- left(last_name, 4)
    ,'_'
    ,SUBSTR(birth_date, 6,2)
    ,SUBSTR(birth_date, 3,2))
		as username
from employees
limit 10
;

-- select *,
-- lower(concat(
-- left(first_name, 1)
-- ' '
-- left(last_name, 4)
-- substr(birth_date, 6,2)
-- substr(birth_date, 3,2)
-- as username

-- dateformat(birth_date, '_%m%y)