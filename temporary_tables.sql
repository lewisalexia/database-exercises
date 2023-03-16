use employees;
-- 1. 
/* Using the example from the lesson, create a temporary table called employees_with_departments that contains
first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create 
this table on your own database.
*/

select first_name, last_name, dept_name
from employees
	join dept_emp using (emp_no)
    join departments using (dept_no)
where to_date > now()
;

-- create temp table from query
create temporary table pagel_2182.problem_1
(
select first_name, last_name, dept_name
from employees
	join dept_emp using (emp_no)
    join departments using (dept_no)
where to_date > now()
)
;

select * from pagel_2182.problem_1;

-- 1.a
-- Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of 
-- the first name and last name columns.
ALTER TABLE pagel_2182.problem_1
add full_name varchar(240) -- > typo! didn't catch until too late. Can I change? YES! Using modify...
;
alter table pagel_2182.problem_1 
modify full_name varchar(30)
;
describe pagel_2182.problem_1
;
-- 1.b
-- Update the table so that the full_name column contains the correct data.

Update pagel_2182.problem_1 set full_name = concat(first_name,' ', last_name)
;

-- 1.c
-- Remove the first_name and last_name columns from the table.

alter table pagel_2182.problem_1 
drop column first_name,
drop column last_name
;

-- 1.d
-- What is another way you could have ended up with this same table?
/* Another way could be to skip the first_name and last_name columns and create those in the very beginning using the concat
statement. That could eliminate the extra steps at the end.
*/

-- 2.
-- Create a temporary table based on the payment table from the sakila database.
use sakila;
show tables from sakila;
select * from payment;
-- Write the SQL necessary to transform the amount column such that it is stored 
-- as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
create temporary table pagel_2182.sakila_update
(select *
from payment
)
;

select * from pagel_2182.sakila_update;

alter table pagel_2182.sakila_update add amount_update int signed
;

update pagel_2182.sakila_update set amount_update = amount * 100
;

-- 3. 
-- Find out how the current average pay in each department compares to the overall current pay for everyone at the company.
-- For this comparison, you will calculate the z-score for each salary. In terms of salary, what is the best department
-- right now to work for? The worst?

-- Overall current salary stats
select avg(salary), std(salary) from employees.salaries where to_date > now()
; -- 72,012 overall average salary, 17,310 overall standard deviation
create temporary table pagel_2182.overall_aggregates as
(select avg(salary) as avg_salary, std(salary) as std_salary
    from employees.salaries  where to_date > now()
)
;
select * from pagel_2182.overall_aggregates
;

use pagel_2182;

select dept_name, avg(salary) as department_current_average
from employees.salaries
join employees.dept_emp using(emp_no)
join employees.departments using(dept_no)
where employees.dept_emp.to_date > curdate()
and employees.salaries.to_date > curdate()
group by dept_name
;

-- create the temp table using the query above
create temporary table current_info as (
    select dept_name, avg(salary) as department_current_average
    from employees.salaries
    join employees.dept_emp using(emp_no)
    join employees.departments using(dept_no)
    where employees.dept_emp.to_date > curdate()
    and employees.salaries.to_date > curdate()
    group by dept_name
)
;

select * from current_info;

alter table current_info add overall_avg float(10,2);
alter table current_info add overall_std float(10,2);
alter table current_info add zscore float(10,2);

-- set the avg and std
update current_info set overall_avg = (select avg_salary from overall_aggregates);
update current_info set overall_std = (select std_salary from overall_aggregates);

-- update the zscore column to hold the calculated zscores
update current_info 
set zscore = (department_current_average - overall_avg) / overall_std;

select * from pagel_2182.current_info
order by zscore desc;

-- Sales is the best! HR is the worst :(

-- BONUS (in progress)
-- Determine the overall historic department average salary, the historic overall average, and the historic
-- z-scores for salary. Do the z-scores for current department average salaries (from exercise 3) tell a similar
-- or a different story than the historic department salary z-scores?
	-- HINT: How should the SQL code used in exercise 3 be altered to instead use historic salary values?
    
select round(avg(salary),0) as hist_avg, d.dept_name
from	(select emp_no, salary, dept_no
		from (select emp_no, salary, to_Date
				from salaries s
				) as a
		join dept_emp de using (emp_no)
		) as b
join departments d using (dept_no)
group by dept_no
;
-- make above into temp table hist_dept
-- can create temp table with hist_overall and join
-- then create historic_zscore and join


-- historic dept avg salary		pagel_2182.hist_dept
create temporary table pagel_2182.hist_dept
(select round(avg(salary),0) as hist_avg, d.dept_name
from	(select emp_no, salary, dept_no
		from (select emp_no, salary, to_Date
				from salaries s
				) as a
		join dept_emp de using (emp_no)
		) as b
join departments d using (dept_no)
group by dept_no
)
;
select * from pagel_2182.hist_dept;


-- historic overall salary		pagel_2182.hist_overall
select round(avg(salary),2)
from salaries
; -- 63810.74

create temporary table pagel_2182.hist_overall
(select round(avg(salary),2)
from salaries
)
;
select * from pagel_2182.hist_overall;

-- historic z-scores for each salary 	pagel_2182.hist_zscore_sal
SELECT salary,
	(salary - (SELECT AVG(salary) FROM salaries))
	/
	(SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries
;
create temporary table pagel_2182.hist_zscore_sal
(SELECT salary,
	(salary - (SELECT AVG(salary) FROM salaries))
	/
	(SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries
)
;
select * from pagel_2182.hist_zscore_sal;
select * from pagel_2182.zscores2;

-- ...