departments
-
dept_no VARCHAR(10) PK
dept_name VARCHAR(40)

dept_emp
-
emp_no INTEGER PK FK >- employees.emp_no
dept_no VARCHAR(10) PK  FK - departments.dept_no

dept_manager
-
dept_no VARCHAR(10) PK FK - departments.dept_no
emp_no INTEGER PK FK - employees.emp_no

employees
-
emp_no INTEGER PK
emp_title_id VARCHAR(10) FK - titles.title_id
birth_date DATE
first_name VARCHAR(40)
last_name VARCHAR(40)
sex VARCHAR(4)
hire_date DATE

salaries
-
emp_no INTEGER PK FK - employees.emp_no
salary BIGINT

titles
-
title_id VARCHAR(10) PK
title VARCHAR(40)
