/*DROP Table titles;
DROP Table employees;
DROP Table departments;
DROP Table department_managers;
Drop Table deptartment_employees;*/
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
	FOREIGN KEY (emp_title) REFERENCES titles(title_id)
);
Select * from employees;

CREATE table departments(
	dept_no VARCHAR NOT NULL,
	dept_name VARCHAR NOT NULL,
	PRIMARY KEY (dept_no)
);
Select * from departments;

CREATE table deptartment_managers(
	dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
	);
Select * from deptartment_managers;	

CREATE table deptartment_employees(
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
	);	
Select * from deptartment_employees;	

CREATE table salaries(
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
	);
Select * from salaries;	