CREATE TABLE Departments(
	dept_no VARCHAR NOT NULL,
	dept_Name VARCHAR NOT NULL,
	PRIMARY KEY (dept_no)
);

CREATE TABLE titles(
	title_ID VARCHAR NOT NULL, 
	title VARCHAR NOT NULL,
	PRIMARY KEY (title_ID)
);
DROP TABLE titles;

CREATE TABLE employees(
	emp_no INTEGER NOT NULL,
	emp_title_id VARCHAR NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES titles (title_ID)
	);
	
CREATE TABLE Dept_emp(
	emp_no INTEGER NOT NULL,
	dept_no VARCHAR NOT NULL,
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments (dept_no)
	);
	
CREATE TABLE Dept_manager(
	dept_no VARCHAR NOT NULL,
	emp_no INTEGER NOT NULL,
	PRIMARY KEY (dept_no, emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments (dept_no)
);

CREATE TABLE salaries(
	emp_no INTEGER NOT NULL,
	salary INTEGER NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

SELECT * FROM employees;

--1.
CREATE VIEW employee_salary AS
Select e.emp_no, e.first_name, e.last_name, e.sex, s.salary
FROM employees AS e
INNER JOIN salaries AS s ON
e.emp_no=s.emp_no;

SELECT * FROM employee_salary;

--2
SELECT first_name, last_name, hire_date FROM employees
WHERE date_part('year',hire_date)=1986;

--3 
DROP VIEW manager_info; 

CREATE VIEW manager_info AS
SELECT d.dept_no, d.dept_Name, Dept_manager.emp_no
FROM Departments AS d
INNER JOIN Dept_manager ON
d.dept_no=Dept_manager.dept_no;

SELECT * FROM manager_info;

CREATE VIEW manager_name AS
SELECT m.dept_no, m.dept_name, m.emp_no, e.first_name, e.last_name
FROM manager_info AS m
INNER JOIN employees AS e ON
m.emp_no=e.emp_no;

SELECT * FROM manager_name;

--4