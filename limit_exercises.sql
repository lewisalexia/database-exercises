use employees;
select database();

select distinct last_name
from employees
order by last_name desc
limit 10
;

select hire_date, birth_date, first_name, last_name
from employees
where hire_date like '199%'
	and birth_date like '%-12-25'
order by hire_date
limit 5 offset 45
;
-- Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup

-- The relationship between limit, offset, and page number is that you can multiply limit and page number to
-- find your offset supposing you want the same amount of results on each page and then subtract whatever your limit is