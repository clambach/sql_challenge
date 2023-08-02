CREATE TABLE departments (
    dept_no VARCHAR(10) NOT NULL,
    dept_name VARCHAR(40) NOT NULL,
    PRIMARY KEY (dept_no)
);

CREATE TABLE titles (
    title_id VARCHAR(10) NOT NULL,
    title VARCHAR(40) NOT NULL,
    PRIMARY KEY (title_id)
);

CREATE TABLE employees (
	emp_no INTEGER NOT NULL,
	emp_title_id VARCHAR(10) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(40) NOT NULL,
	last_name VARCHAR(40) NOT NULL,
	sex VARCHAR(2) NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)
);

CREATE TABLE dept_emp (
    emp_no INTEGER NOT NULL,
    dept_no VARCHAR(10) NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

CREATE TABLE dept_manager (
    dept_no VARCHAR(10) NOT NULL,
    emp_no INTEGER NOT NULL,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE salaries (
	emp_no INTEGER NOT NULL,
	salary BIGINT NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

--List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary 
FROM employees e
LEFT JOIN salaries s
ON e.emp_no = s.emp_no


--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT  first_name, last_name, hire_date 
FROM employees 
WHERE hire_date <= '1986-12-31' AND hire_date >= '1986-01-01'



--List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT e.first_name, e.last_name, e.emp_no, dm.dept_no, d.dept_name
FROM employees e
INNER JOIN  dept_manager dm
ON e.emp_no = dm.emp_no
INNER JOIN departments d
ON dm.dept_no = d.dept_no


--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT e.first_name, e.last_name, e.emp_no, de.dept_no, d.dept_name
FROM employees e
LEFT JOIN  dept_emp de
ON e.emp_no = de.emp_no
LEFT JOIN departments d
ON de.dept_no = d.dept_no


--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'



--List each employee in the Sales department, including their employee number, last name, and first name.
SELECT e.emp_no, e.first_name, e.last_name
FROM employees e 
WHERE e.emp_no IN
	(SELECT de.emp_no
	FROM dept_emp de
	WHERE de.dept_no IN
	 (SELECT d.dept_no
	  FROM departments d
	  WHERE d.dept_name = 'Sales'
	 ))

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
FROM employees e 
LEFT JOIN  dept_emp de
ON e.emp_no = de.emp_no
LEFT JOIN departments d
ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development')

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, Count(last_name) AS frequency
FROM employees
GROUP BY last_name
ORDER BY (frequency) DESC
