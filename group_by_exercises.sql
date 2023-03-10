-- 2.
use employees;
show tables;

select *
from titles;

select distinct title
from titles
;
-- 7


-- 3.
select last_name
from employees
where last_name like 'e%e'
group by last_name
;

-- 4.
select last_name, first_name
from employees
where last_name like 'e%e'
group by last_name, first_name
;

-- 5.
select last_name
from employees
where last_name like '%q%'
	and last_name not like '%qu%'
group by last_name
; -- Chleq, Lindqvist, Qiwen

-- 6.
select last_name, count(*)
from employees
where last_name like '%q%'
	and last_name not like '%qu%'
group by last_name
;

-- 7.
select first_name, gender, count(*)
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
group by first_name, gender
;

-- 8. 
select
	CONCAT(LOWER(SUBSTR(FIRST_NAME, 1, 1)),(LOWER(SUBSTR(LAST_NAME, 1, 4))),'_',SUBSTR(birth_date, 6,2),SUBSTR(birth_date, 3,2))
		as username, count(*)
from employees
group by username
;

-- 9. yes, 6
select
	CONCAT(LOWER(SUBSTR(FIRST_NAME, 1, 1)),(LOWER(SUBSTR(LAST_NAME, 1, 4))),'_',SUBSTR(birth_date, 6,2),SUBSTR(birth_date, 3,2))
		as username, count(*) as duplicate
from employees
group by username
order by count(*) desc
-- having count(*) > 1 desc
;

-- 9 bonus | sum = 27403 count = 13251
select count(*)
from (select
	CONCAT(LOWER(SUBSTR(FIRST_NAME, 1, 1)),(LOWER(SUBSTR(LAST_NAME, 1, 4))),'_',SUBSTR(birth_date, 6,2),SUBSTR(birth_date, 3,2))
		as username, count(*) as duplicate
from employees
group by username
having duplicate > 1)
as total_duplicates
;

-- bonus 1
select emp_no, round(avg(salary),2)
from salaries
group by emp_no
;

-- bonus 2
select dept_no, count(*) as current_dept_emp
from dept_emp
where to_date > now()
group by dept_no
;

-- bonus 3
select emp_no, count(*)
from salaries
group by emp_no
order by count(*) desc
;

-- bonus 4
select emp_no, max(salary)
from salaries
group by emp_no
order by max(salary)
;

-- bonus 5
select emp_no, min(salary)
from salaries
group by emp_no
order by min(salary) 
;

-- bonus 6
select emp_no, round(std(salary),1)
from salaries
group by emp_no
;

-- bonus 7
select emp_no, max(salary)
from salaries
group by emp_no
having max(salary) > 150000
;

-- bonus 8
select emp_no, round(avg(salary), 2) as AVG_SALARY
from salaries
group by emp_no
having avg_salary between 80000 and 90000
;

