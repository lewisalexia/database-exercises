use employees;
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

-- 1.
-- Write a query that returns all employees, 
-- their department number, 
-- their start date, 
-- their end date, 
-- and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

-- 
select *
from employees; -- emp_no, birth and hire_date, first and last_name, gender
select *
from dept_emp; -- emp_no, dept_no, from and to_date

-- return all employees who are current and not AND who haven't swtiched departments in dept_emp
select emp_no, max(to_date)
from dept_emp
group by emp_no
;
-- join employee table
select *
from (select emp_no, max(to_date)
from dept_emp
group by emp_no) as cur_emp
join employees e using (emp_no)
;
-- make new column 'is_current_employee' that is 1 if current and 0 if not
select *, 
	CASE
		WHEN emp_date >= curdate() then '1'
        ELSE 0
	END 'is_current_employee'
from (select emp_no, max(to_date) as emp_date
from dept_emp
group by emp_no) as cur_emp
join employees e using (emp_no)
;

-- VERIFYING number of NOT employed
select count(e.emp_no) 
from employees e
where e.emp_no not in (select distinct (emp_no)
from dept_emp
where to_date > curdate())
; -- 59900

-- counting who is current and who is not
select is_current_employee, count(*)
from (select *, 
	CASE
		WHEN emp_date >= curdate() then '1'
        ELSE 0
	END 'is_current_employee'
from (select emp_no, max(to_date) as emp_date
from dept_emp
group by emp_no) as cur_emp
join employees e using (emp_no)) as p
group by is_current_employee
; -- :)


-- 2.
-- Write a query that returns all employee names (previous and current),
-- and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

-- 
select *
from employees; -- emp_no, birth and hire_date, first and last_name, gender
select *
from dept_emp; -- emp_no, dept_no, from and to_date

-- FUTURE EXPLORATION: count to address duplicates...
select first_name, last_name, count(*)
from employees
group by first_name, last_name
order by count(*) desc
;

-- filter to see first and last names
select first_name, last_name
from employees
group by first_name, last_name
;

-- add new column sorting by first letter of last name
select *,
	CASE last_name
		WHEN substr(last_name,1,1) between 'A' and 'H' then 'A-H' -- left(last_name,1) <= 'H'
        WHEN substr(last_name,1,1) between 'I' and 'Q' then 'I-Q' -- left(last_name,1) < 'Q' and > 'I'
        WHEN substr(last_name,1,1) between 'R' and 'Z' then 'R-Z' -- left(last_name,1) < 'Z' and > 'R'
    END alpha_group
from (select first_name, last_name
from employees
group by first_name, last_name) as a
;

-- 3.
-- How many employees (current or previous) were born in each decade?
-- Perform count for each decade
-- Find out min and max of birth dates to establish parameters for decades...
select min(birth_date), max(birth_date)
from employees
; -- 1952 and 1965 (50-60 and 60-70)

-- list out current and previous employees
select first_name, last_name, birth_date
from employees
;

-- make new columns for decades
select *,
	CASE 
		WHEN birth_date between '1950-01-01' and '1959-12-31' then '50s-60s'
        WHEN birth_date between '1960-01-01' and '1969-12-31' then '60s-70s'
	END birth_year_decades
from (select first_name, last_name, birth_date
from employees) as birth_years
;

-- perform count for new column items
select birth_year_decades, count(*)
from (select
		CASE 
			WHEN birth_date between '1950-01-01' and '1959-12-31' then '50s'
			WHEN birth_date between '1960-01-01' and '1969-12-31' then '60s'
		END birth_year_decades
from (select first_name, last_name, birth_date
from employees) as birth_years) b_year
group by birth_year_decades
;

-- 4.
-- What is the current average salary for each of the following department groups:
-- R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
-- find current salaries
-- create average for each department
-- display

select
	case
		when dept_name in ('research','development') then 'R&D'
		when dept_name in ('sales','marketing') then 'Sales & Marketing'
        when dept_name in ('production','quality management') then 'Prod & QM'
        when dept_name in ('finance','human resources') then 'Finance & HR'
        else dept_name
	end as dept_group,
    round(avg(salary),2)
    -- dept_emp.*, -- > built in sanity check!!!
    -- salaries.* -- > built in sanity check!!!
from departments
join dept_emp using (dept_no)
join salaries using (emp_no)
where salaries.to_date >= curdate()
	and dept_emp.to_date >= curdate()
group by dept_group
;


