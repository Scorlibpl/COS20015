DROP DATABASE company;
CREATE DATABASE company;
use company;

CREATE TABLE Department (
	dept_id INT UNSIGNED NOT NULL UNIQUE,
    dept_name VARCHAR(35) NOT NULL,
    mgr_id INT UNSIGNED NOT NULL UNIQUE,
    mgr_start_date DATE DEFAULT '1900-01-01',
    PRIMARY KEY (dept_id)
);

CREATE TABLE Employee (
	emp_id INT UNSIGNED NOT NULL UNIQUE,
    emp_fname VARCHAR(35) NOT NULL,
    emp_lname VARCHAR(35) NOT NULL,
    emp_bdate DATE NOT NULL DEFAULT '1900-01-01',
    emp_address VARCHAR(35) NOT NULL,
    gender CHAR(1) NOT NULL CHECK (gender IN ('M','F','U')),
    dept_id INT UNSIGNED NOT NULL UNIQUE,
    super_id INT UNSIGNED NOT NULL UNIQUE,
    PRIMARY KEY (emp_id),
    CONSTRAINT dept_fk FOREIGN KEY(dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Project (
	proj_id INT UNSIGNED NOT NULL UNIQUE,
    proj_name VARCHAR(35) NOT NULL,
    proj_loc VARCHAR(30) NOT NULL,
    dept_id INT UNSIGNED NOT NULL UNIQUE,
    PRIMARY KEY (proj_id),
    CONSTRAINT dept_fk1 FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Salary (
	emp_id INT UNSIGNED NOT NULL UNIQUE,
    salary INT(5) NOT NULL CHECK (salary >= 0),
    start_date DATE DEFAULT '1900-01-01',
    PRIMARY KEY (start_date),
    CONSTRAINT emp_fk FOREIGN KEY (emp_id) REFERENCES Employee (emp_id)
);

CREATE TABLE Role (
	emp_role VARCHAR(15) NOT NULL DEFAULT ('Technician'),
    sal_factor DECIMAL(5,2) NOT NULL CHECK (sal_factor >= 0),
    comments TEXT DEFAULT NULL,
    emp_id INT UNSIGNED NOT NULL UNIQUE,
    PRIMARY KEY (emp_role),
    CONSTRAINT emp_fk1 FOREIGN KEY (emp_id) REFERENCES Employee (emp_id)
);

CREATE TABLE Works_on (
	proj_id INT UNSIGNED NOT NULL UNIQUE,
    emp_id INT UNSIGNED NOT NULL UNIQUE,
    emp_role VARCHAR(15) NOT NULL DEFAULT ('Tehnician'),
    hours INT(5) NOT NULL CHECK (hours >= 0),
    PRIMARY KEY (proj_id, emp_id, emp_role),
    CONSTRAINT proj_fk FOREIGN KEY(proj_id) REFERENCES Project (proj_id),
    CONSTRAINT emp_fk2 FOREIGN KEY(emp_id) REFERENCES Employee (emp_id),
    CONSTRAINT role_fk FOREIGN KEY(emp_role) REFERENCES Role(emp_role)
);
    
