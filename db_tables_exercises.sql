show databases;
use albums_db;
select database();
show tables;
use employees;
show create table source;
show tables;
show create table dept_manager;

-- 11. Which table(s) do you think contain a numeric type column?: salaries
-- 12. Which table(s) do you think contain a string type column?: departments, dept_emp, dept_manager, employees, and titles
-- 13. Which table(s) do you think contain a date type column?: employees
-- 14. What is the relationship between the employees and the department’s tables?: the dept_emp table is a joiner table because there is no obvious relationship.
-- 15. CREATE TABLE `dept_manager` (  `emp_no` int NOT NULL,  `dept_no` char(4) NOT NULL,  `from_date` date NOT NULL,  `to_date` date NOT NULL,  PRIMARY KEY (`emp_no`,`dept_no`),  KEY `dept_no` (`dept_no`),  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT, CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT) ENGINE=InnoDB DEFAULT CHARSET=latin1
-- 15. EXERCISE SOLUTION: show create table dept_manager;