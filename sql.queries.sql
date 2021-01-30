DROP Table titles CASCADE;
DROP Table employees CASCADE;
DROP Table departments CASCADE;
DROP Table dept_managers CASCADE;
Drop Table deptartment_employees CASCADE;

CREATE table titles(
	title_id VARCHAR   NOT NULL,
    title VARCHAR   NOT NULL,
	PRIMARY KEY (title_id)
	);
CREATE Table employees(
	emp_no INT   NOT NULL,
	emp_title VARCHAR NOT NULL,
    birth_date date   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    sex VARCHAR   NOT NULL,
    hire_date date   NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);
Select * from employees;

CREATE table departments(
	dept_no VARCHAR NOT NULL,
	dept_name VARCHAR NOT NULL,
	PRIMARY KEY (dept_no)
);
Select * from departments;

CREATE table dept_managers(
	dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
	);
Select * from dept_managers;	

CREATE table employees(
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
	);	
Select * from employees;	

CREATE table salaries(
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
	);
Select * from salaries;	

CREATE TABLE dept_emp (
    emp_no int  NOT NULL,
    dept_no varchar  NOT NULL,
	PRIMARY KEY (dept_no, emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
); 

COPY departments
FROM 'C:\Users\Tiffa\Documents\sql-challenge\EmployeeSQL\departments.csv'
DELIMITER ','
CSV HEADER;

Select * from departments;

COPY employees
FROM 'C:\Users\Tiffa\Documents\sql-challenge\EmployeeSQL\employees.csv'
DELIMITER ','
CSV HEADER;
Select * from employees;

COPY salaries
FROM 'C:\Users\Tiffa\Documents\sql-challenge\EmployeeSQL\salaries.csv'
DELIMITER ','
CSV HEADER;

Select * from salaries;

COPY titles
FROM 'C:\Users\Tiffa\Documents\sql-challenge\EmployeeSQL\titles.csv'
DELIMITER ','
CSV HEADER;
Select * from titles;

COPY dept_managers
FROM 'C:\Users\Tiffa\Documents\sql-challenge\EmployeeSQL\dept_manager.csv'
DELIMITER ','
CSV HEADER;
Select * from dept_managers;

COPY dept_emp
FROM 'C:\Users\Tiffa\Documents\sql-challenge\EmployeeSQL\dept_emp.csv'
DELIMITER ','
CSV HEADER;
Select * from dept_emp;


--List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary 
FROM employees AS e
LEFT JOIN salaries AS s
ON e.emp_no = s.emp_no
ORDER BY s.salary DESC;

--List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE date_part('year', hire_date) = '1986';

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT d.dept_no, dp.dept_name, d.emp_no, e.last_name, e.first_name
FROM dept_managers AS d
JOIN employees AS e
ON d.emp_no = e.emp_no
JOIN departments AS dp
ON d.dept_no = dp.dept_no;

--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM employees AS e
LEFT JOIN dept_emp AS d
ON e.emp_no = d.emp_no
LEFT JOIN departments as dp
ON d.dept_no = dp.dept_no;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT d.emp_no, e.last_name, e.first_name, dp.dept_name
FROM dept_emp AS d
JOIN employees AS e
ON d.emp_no = e.emp_no
JOIN departments AS dp
ON d.dept_no = dp.dept_no
WHERE dp.dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT d.emp_no, e.last_name, e.first_name, dp.dept_name
FROM dept_emp AS d
JOIN employees AS e
ON d.emp_no = e.emp_no
JOIN departments AS dp
ON d.dept_no = dp.dept_no
WHERE dp.dept_name = 'Sales' OR dp.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS last_name_frequency
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;
