use employees;
select database();
select *
from employees
;

select *
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
;
-- 10200, 10397, 10610

select *
from employees
where first_name = 'Irena'
	or first_name = 'Vidya'
	or first_name = 'Maya'
;
-- 10200, 10397, 10610, yes

select *
from employees
where first_name = 'Irena' and gender = 'M'
	or first_name = 'Vidya' and gender = 'M'
	or first_name = 'Maya' and gender = 'M'
;
-- 10200, 10397, 10821

select distinct last_name
from employees
where last_name like 'E%'
;

select distinct last_name
from employees
where last_name like '%E' 
	or last_name like 'E%'
;

select distinct last_name
from employees
where last_name like '%E'
	and last_name not like 'E%'
;

select distinct last_name
from employees
where last_name like '%E'
	and last_name like 'E%'
;

select hire_date, emp_no
from employees
where hire_date like '199%'
	limit 3
;
-- 10008, 10011, 10012

select birth_date, emp_no
from employees
where birth_date like '%-12-25'
;
-- 10078, 10115, 10261

select hire_date, emp_no
from employees
where hire_date like '199%'
	and birth_date like '%-12-25'
    limit 3
;
-- 10261, 10438, 10681

select distinct last_name
from employees
where last_name like '%q%'
;

select distinct last_name
from employees
where last_name like '%q%'
	and last_name not like '%qu%'
;