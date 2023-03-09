-- WHERE ADVANCED EXERCISES
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

-- ORDER BY EXERCISES
use employees;
select database();
select *
from employees
;

select *
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
order by first_name
;
-- Irena Reutenauer and Vidya Simmen

select *
from employees
where first_name = 'Irena'
	or first_name = 'Vidya'
	or first_name = 'Maya'
order by first_name, last_name
;
-- Irena Acton and Vidya Zweizig

select *
from employees
where first_name = 'Irena'
	or first_name = 'Vidya'
	or first_name = 'Maya'
order by last_name, first_name
;
-- Irena Acton and Maya Zyda

select first_name, last_name, emp_no
from employees
where last_name like 'E%'
	and last_name like '%E'
order by emp_no
;
-- 899, "10021 Ramzi Erde" and "499648 Tadahiro Erde"

select first_name, last_name, hire_date
from employees
where last_name like 'E%'
	and last_name like '%E'
order by hire_date desc
;
-- 899, Teiji Eldridge and Sergi Erde

select hire_date, birth_date, first_name, last_name
from employees
where hire_date like '199%'
	and birth_date like '%-12-25'
order by birth_date, hire_date desc
;
-- 362, Khun Bernini and Douadi Pettis