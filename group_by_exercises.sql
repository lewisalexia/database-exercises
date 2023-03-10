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
select distinct last_name
from employees
where last_name like 'e%e'
group by last_name
;

-- 4.
select distinct last_name, first_name
from employees
where last_name like 'e%e'
;

-- 5.
select distinct last_name
from employees
where last_name like '%q%'
	and last_name not like '%qu%'
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
;

-- 9 bonus | 27403
select sum(duplicate)
from (select
	CONCAT(LOWER(SUBSTR(FIRST_NAME, 1, 1)),(LOWER(SUBSTR(LAST_NAME, 1, 4))),'_',SUBSTR(birth_date, 6,2),SUBSTR(birth_date, 3,2))
		as username, count(*) as duplicate
from employees
group by username
having duplicate > 1)
as total_duplicates
;




