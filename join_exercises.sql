use join_example_db;
select *
from users;
select *
from roles;

-- 2.
select *
from users
join roles on users.role_id = roles.id
;

select *
from users
left join roles on users.role_id = roles.id
;

select *
from users
right join roles on users.role_id = roles.id
;

-- 3.
select role_id, count(*)
from users
join roles on users.role_id = roles.id
group by role_id
;

select roles.name, count(*)
from roles
join users on roles.id = users.role_id
group by roles.name
;

-- 2. write a query that shows each department along with the name of the current manager for that department.
use employees;
select *
from departments;
select *
from dept_manager;
select *
from employees;

select departments.dept_name, employees.first_name, employees.last_name
from departments
join dept_manager on departments.dept_no = dept_manager.dept_no
join employees on dept_manager.emp_no = employees.emp_no
where to_date = '9999-01-01'
;

-- 3. Find the name of all departments currently managed by women.
select departments.dept_name, employees.first_name, employees.last_name, employees.gender
from departments
join dept_manager on departments.dept_no = dept_manager.dept_no
join employees on dept_manager.emp_no = employees.emp_no
where to_date = '9999-01-01'
	and gender = 'F'
;

-- 4. Find the current titles of employees currently working in the Customer Service department.
select *
from departments;
select *
from dept_manager;
select *
from employees; -- d009
select *
from titles; -- emp_no
select *
from dept_emp;

select titles.title as 'Title', count(*) as 'Count'
from titles
join employees on titles.emp_no = employees.emp_no
join dept_emp on employees.emp_no = dept_emp.emp_no
where dept_no = 'd009'
	and titles.to_date = '9999-01-01'
group by title
order by title asc
;

-- 5. Find the current salary of all current managers.
select *
from departments;
select *
from dept_manager;
select *
from employees; -- d009
select *
from titles; -- emp_no
select *
from dept_emp;
select *
from salaries;

select departments.dept_name, employees.first_name, employees.last_name, salaries.salary
from departments
join dept_manager on departments.dept_no = dept_manager.dept_no
join employees on dept_manager.emp_no = employees.emp_no
join salaries on employees.emp_no = salaries.emp_no
where dept_manager.to_date = '9999-01-01'
	and salaries.to_date = '9999-01-01'
order by dept_name asc
;

-- 6. Find the number of current employees in each department.
select *
from departments; -- dept_no, dept_name
select * 
from dept_emp; -- dept_no, count(here?), to_date

select departments.dept_no, departments.dept_name, count(*) as num_employees
from departments
join dept_emp on departments.dept_no = dept_emp.dept_no
where dept_emp.to_date = '9999-01-01'
group by dept_no
order by dept_no asc
;

-- 7. Which department has the highest average salary? Hint: Use current not historic information.
select *
from departments; -- dept_no, dept_name
select *
from salaries; -- emp_no, salary, to_date
select *
from dept_emp; -- emp_no, dept_no, to_date

select departments.dept_name, round(avg(salaries.salary), 4) as average_salary
from departments
join dept_emp on departments.dept_no = dept_emp.dept_no
join salaries on dept_emp.emp_no = salaries.emp_no
where salaries.to_date = '9999-01-01'
group by departments.dept_name
order by average_salary desc
limit 1
;

-- ?? HOW TO SINGLE OUT MAX SALARY IN A MORE EFFICIENT WAY

-- 8. Who is the highest paid employee in the Marketing department?
select *
from departments; -- dept_no, dept_name
select *
from salaries; -- emp_no, salary, to_date
select *
from dept_emp; -- emp_no, dept_no, to_date
select *
from employees; -- emp_no, first_name, last_name

select employees.first_name, employees.last_name
from departments
join dept_emp on departments.dept_no = dept_emp.dept_no
join salaries on dept_emp.emp_no = salaries.emp_no
join employees on salaries.emp_no = employees.emp_no
where departments.dept_name = 'Marketing'
	and dept_emp.to_date = '9999-01-01'
    and salaries.to_date = '9999-01-01'
group by employees.first_name, employees.last_name, salaries.salary
order by salaries.salary desc
limit 1
;

-- 9. Which current department manager has the highest salary?

select employees.first_name, employees.last_name, salaries.salary, departments.dept_name
from departments
join dept_manager on departments.dept_no = dept_manager.dept_no
join employees on dept_manager.emp_no = employees.emp_no
join salaries on employees.emp_no = salaries.emp_no
where dept_manager.to_date = '9999-01-01'
	and salaries.to_date = '9999-01-01'
order by salary desc
limit 1
;

-- 10. Determine the average salary for each department. Use all salary information and round your results.
select *
from departments; -- dept_no, dept_name
select *
from salaries; -- emp_no, salary, to_date
select *
from dept_emp; -- emp_no, dept_no, to_date

select departments.dept_name, round(avg(salaries.salary), 0) as average_salary
from departments
join dept_emp on departments.dept_no = dept_emp.dept_no
join salaries on dept_emp.emp_no = salaries.emp_no
group by departments.dept_name
order by average_salary desc
;

-- 11. Bonus Find the names of all current employees, their department name, and their current manager's name.
select *
from employees; -- emp_no, first and last_name
select *
from dept_emp; -- emp_no, dept_no, to_date
select *
from departments; -- dept_no, dept_name
select *
from dept_manager; -- emp_no, dept_no, to_date

-- subquery?
select a.employee as 'Employee Name', a.department_name as 'Department Name', a.employee_dept as 'Employee Dept',
	g.manager_name as 'Manager Name', g.manager_dept as 'Manager Dept'
from

	(select CONCAT(employees.first_name,' ',employees.last_name) as employee, 
	(departments.dept_name) as department_name, (dept_emp.dept_no) as employee_dept
	from employees
	join dept_emp on employees.emp_no = dept_emp.emp_no
	join departments on dept_emp.dept_no = departments.dept_no
	where dept_emp.to_date = '9999-01-01'
    order by employee_dept) as a
    
join
    (select CONCAT(employees.first_name,' ',employees.last_name) as manager_name, 
    (dept_manager.dept_no) as manager_dept
	from employees
	join dept_manager on employees.emp_no = dept_manager.emp_no
	where dept_manager.to_date = '9999-01-01'
    order by manager_dept) as g
    
    on employee_dept = manager_dept
;


-- 12. Bonus Who is the highest paid employee within each department.
select *
from departments; -- dept_no, dept_name
select *
from salaries; -- emp_no, salary, to_date
select *
from dept_emp; -- emp_no, dept_no, to_date
select *
from employees; -- emp_no, first_name, last_name

-- MAIN TABLE
select *
from salaries
join employees on salaries.emp_no = employees.emp_no
join dept_emp on employees.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
where salaries.to_date = '9999-01-01'
	and dept_emp.to_date = '9999-01-01'
;
