select *
from departments; -- dept_no, dept_name
select *
from dept_emp; -- emp_no, dept_no, from and to_date
select *
from dept_manager; -- emp_no, dept_no, from and to_date
select *
from employees; -- emp_no, birth and hire_date, first and last_name, gender
select *
from salaries; -- emp_no, salary, from and to_date
select *
from titles; -- emp_no, title, from and to_date

-- 1. Find all the current employees with the same hire date as employee 101010 using a subquery (column?)
use employees;
select *
from employees; -- emp_no, birth and hire_date, first and last_name, gender
-- Step 1/build inner query to find hire_date of emp_no
-- Step 2/build outer query to display all employees with inner queries 'where' using common variable 'hire_date' using IN

select emp_no, first_name, last_name, hire_date
from employees
where emp_no = 101010;

select emp_no, first_name, last_name, hire_date
from employees
where hire_date IN
	(select hire_date
	from employees
	where emp_no = 101010)
;
-- 2. Find all the titles ever held by all current employees with the first name Aamod (column?)
select *
from employees; -- emp_no, birth and hire_date, first and last_name, gender
select *
from titles; -- emp_no, title, from and to_date
-- Step 1/build inner query to identify employees with first_name Aamod
-- Step 2/build outer query to display all CURRENT titles held by inner query

select emp_no
from employees
where first_name = 'Aamod'
;

select *
from titles
where emp_no IN (select emp_no
from employees
where first_name = 'Aamod'
)
;
    
-- 3. How many people in the employees table are no longer working for the company? 
-- Give the answer in a comment in your code (join?)
select *
from dept_emp; -- emp_no, dept_no, from and to_date
select *
from employees; -- emp_no, birth and hire_date, first and last_name, gender
-- Step 1/build inner query where to_date is < curdate()
-- Step 2/build outer query for employees table count and JOIN?

select *
from dept_emp
where to_date < curdate()
;

select count(e.emp_no) 
from employees e
where e.emp_no not in (select distinct (emp_no)
from dept_emp
where to_date > curdate())
; -- 59900

-- 4. Find all the current department managers that are female. List their names in a comment in your code
select *
from dept_manager; -- emp_no, dept_no, from and to_date
select *
from employees; -- emp_no, birth and hire_date, first and last_name, gender
select *
from departments; -- dept_no, dept_name
-- Step 1/build query to identify current department managers, join releveant tables
-- Step 2/build query to identify female department managers then FROM table

select e.emp_no
from dept_manager d
join employees e on e.emp_no = d.emp_no
where d.to_date > curdate()
	and gender = 'F'
;

select concat(e.first_name,' ',e.last_name) 'Manager Name', e.gender
from employees e
where e.emp_no in (select e.emp_no
from dept_manager d
join employees e on e.emp_no = d.emp_no
where d.to_date > curdate()
	and gender = 'F'
)
;
-- Isamu Legleitner, Karsten Sigstarn, Leon DasSarma, Hilary Kambil

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.
select *
from employees; -- emp_no, birth and hire_date, first and last_name, gender
select *
from salaries; -- emp_no, salary, from and to_date
select *
from dept_emp; -- emp_no, dept_no, from and to_date
-- Step 1/build query to display historical average
-- Step 2/build query to display all salaries
-- Step 3/build query to identify current employees > hist_avg

select round(avg(salary),0)
from salaries
; -- 63811

select *
from salaries
;

select concat(first_name,' ',last_name) Employee, Salary
from salaries
join employees using (emp_no)
where salary > (select avg(salary)
				from salaries)
	and to_date > curdate()
order by salary asc
;

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? What percentage of all salaries is this?
--     	(Hint: you can use a built in function to calculate the standard deviation.) 
select *
from salaries; -- emp_no, salary, from and to_date
-- Step 1/build query to identify max salary
-- Step 2/build query to display current salaries
-- Step 3/build query to display current salaries within 1 stdev
-- Step 4/build query to calculate percentage of step 3 against all salaries (step 2)

select max(salary)
from salaries
where to_date>curdate()
; -- 158220

select round(std(salary),0)
from salaries
where to_date>curdate()
; -- 17310

select max(salary) - round(std(salary),0)
from salaries
where to_date > curdate()
;

select count(*)
from salaries
where salary > (select max(salary) - round(std(salary),0)
from salaries
where to_date > curdate())	
	and to_date>curdate()
; -- 83

select round(( (select count(*)
from salaries
where salary > (select max(salary) - round(std(salary),0)
from salaries
where to_date > curdate())	
	and to_date>curdate()) / (select count(*) from salaries where salaries.to_date>curdate())) * 100,2) as pctmaxstd
; -- 0.03%