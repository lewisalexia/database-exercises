-- using the chipotle database,
-- find how many times someone ordered a chicken or veggie bowl
-- with a quantity greater than 1

use chipotle;
select database();

show tables;

select *
from orders;

select quantity, item_name
from orders
where item_name in ('Chicken Bowl', 'Veggie Bowl')
	and quantity > 1
;
-- 35 rows

-- find all unique items with chicken
select distinct item_name
from orders
where item_name like '%chicken%'
;

select item_name -- cannot use * without providing an additional aggregate function, [think rectangle output]
from orders
where item_name like '%chicken%'
group by item_name
;

-- can group by multiple variables
-- find all unique combinations of items with chicken and their quantity
select item_name, quantity -- have to match
from orders
where item_name like '%chicken%'
group by item_name, quantity -- have to match
order by item_name
;

-- count & how many chicken bowls have been ordered?
select count(*), item_name
from orders
where item_name = 'Chicken Bowl'
;

-- for each chicken item, how many times was it ordered?
select distinct item_name, count(*)
from orders
where item_name like '%chicken%'
group by item_name
;

-- for each chicken item, how many items were actually sold?
select distinct item_name, sum(quantity)
from orders
where item_name like '%chicken%'
group by item_name
;

-- for each chicken item, what is the minimum, maximum, rounded average, sum, and count of order quantity
select distinct item_name, min(quantity), max(quantity), round(avg(quantity),1), sum(quantity), count(*)
from orders
where item_name like '%chicken%'
group by item_name
;

-- find all order items that have been ordered over 100 times
-- 1. group all items 2. get the count of each item_name 3. filter by counts greater than 100(having) 4. limit to top 5
select item_name, sum(quantity) as total_orders
from orders
group by item_name
having total_orders > 100
order by total_orders desc
limit 5
;

use employees;
select *
from employees;

show create table employees;

/* 'CREATE TABLE `employees` (
  `emp_no` int NOT NULL,
  `birth_date` date NOT NULL,
  `first_name` varchar(14) NOT NULL,
  `last_name` varchar(16) NOT NULL,
  `gender` enum(''M'',''F'') NOT NULL,
  `hire_date` date NOT NULL,
  PRIMARY KEY (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1' */

use salaries;
show create table salaries;

/*'CREATE TABLE `salaries` (
  `emp_no` int NOT NULL,
  `salary` int NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`from_date`),
  CONSTRAINT `salaries_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1' */

describe titles;
show create table titles;

/* 
'CREATE TABLE `titles` (
  `emp_no` int NOT NULL,
  `title` varchar(50) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date DEFAULT NULL,
  PRIMARY KEY (`emp_no`,`title`,`from_date`),
  CONSTRAINT `titles_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1'
*/

show create table dept_manager;

/* 'CREATE TABLE `dept_manager` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1' */

show create table departments;

/* 'CREATE TABLE `departments` (
  `dept_no` char(4) NOT NULL,
  `dept_name` varchar(40) NOT NULL,
  PRIMARY KEY (`dept_no`),
  UNIQUE KEY `dept_name` (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1' */

show create table authors;

/* 'CREATE TABLE `authors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `first_name` (`first_name`,`last_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1' */

show create table dept_emp;

/* CREATE TABLE `dept_emp` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_emp_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_emp_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1 */ 

-- HAS: dept_emp, dept_manager, employees, salaries, and titkes
-- DOES NOT HAS: authors, departments, and quotes

describe authors; -- pri and mul
describe departments; -- pri and uni
describe dept_emp; -- two pri
describe dept_manager; -- two pri
describe employees; -- pri
describe quotes; -- pri and uni
describe salaries; -- two pri
describe titles; -- 3 pri

ALTER TABLE quotes
ADD UNIQUE (identifier);

select database();

-- JOINING TABLES
select *
from employees
join dept_emp on employees.emp_no = dept_emp.emp_no; -- emp.no CAN be a different name in the other table but must be same value
-- I'm selecting everything from employees and I want to (inner)join this table on the dept_emp
-- table ON emp_no (what is the thing in common) is the same to the dept_emp.emp_no
-- left join returns everything in "from" and only matches in the right, vice-versa

select *
from departments;
select *
from dept_emp;
-- cannot have multiple emp_no but can have multiple employees in the same dept
-- known as one to many or many to one
-- one employee can only work in one dept (one-one)
-- many employees can work in the same department (many-one)
-- actors to movies (many-many)

-- Joining on multiple tables
select *
from employees
join dept_emp on employees.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
;

-- selecting certain things from the tables
select employees.first_name,
		employees.last_name,
		departments.dept_name
from employees
join dept_emp on employees.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
;

-- shorthand on joining multiple tables and selecting specific values AS ALIAS'S
select e.first_name,
		e.last_name,
		d.dept_name
from employees as e
join dept_emp as de on e.emp_no = de.emp_no
join departments as d on de.dept_no = d.dept_no
;

-- Aliasing using WHERE clause
select e.first_name,
		e.last_name,
		d.dept_name
from employees as e
join dept_emp as de on e.emp_no = de.emp_no
join departments as d on de.dept_no = d.dept_no
where e.gender = 'F' -- if you alias in one place you are going to have to alias throughout UNLESS it is totally unique
;

-- If they both share the same primary key as in physical name use below (more breakable)
select e.first_name,
		e.last_name,
		d.dept_name
from employees as e
join dept_emp as de using(emp_no)
join departments as d on de.dept_no = d.dept_no
;