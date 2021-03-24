DROP DATABASE week_5;
CREATE DATABASE week_5;
use week_5;

CREATE TABLE Student (
	stud_id INT unsigned not null,
    stud_name VARCHAR(40) not null,
    stud_phone VARCHAR(15) not null,
    stud_date_of_birth VARCHAR(15) not null,
    stud_city VARCHAR(15) not null,
    stud_address VARCHAR(40) not null,
    stud_postcode VARCHAR(5) not null,
    PRIMARY KEY (stud_id)
);

CREATE TABLE Subject (
	subj_code VARCHAR(10) not null,
    subj_title VARCHAR(40) not null,
    PRIMARY KEY (subj_code)
);

CREATE TABLE Subj_Enrolment (
	stud_id INT unsigned not null,
    subj_code VARCHAR(10) not null,
    semester SMALLINT unsigned not null,
    year SMALLINT unsigned not null,
    comment VARCHAR(50) not null,
    PRIMARY KEY (semester, year),
    CONSTRAINT Student_fk 
		FOREIGN KEY (stud_id) 
		REFERENCES Student(stud_id),
    CONSTRAINT Subject_fk
		FOREIGN KEY (subj_code) 
        REFERENCES Subject(subj_code)
);

CREATE TABLE Grade (
	stud_id INT unsigned not null,
    subj_code VARCHAR(10) not null,
    semester SMALLINT unsigned not null,
    year SMALLINT unsigned not null,
    grade CHAR(2),
    PRIMARY KEY (stud_id, subj_code, semester, year),
    CONSTRAINT Student_fk1
		FOREIGN KEY (stud_id) 
        REFERENCES Student(stud_id),
    CONSTRAINT Subject_fk1
		FOREIGN KEY (subj_code) 
        REFERENCES Subject(subj_code),
	CONSTRAINT Enrolment_fk
        FOREIGN KEY (semester,year) 
		REFERENCES Subj_Enrolment(semester,year)
);

ALTER TABLE Student 
ADD gender VARCHAR(10) not null,
ADD CONSTRAINT CHK_Gender CHECK (Gender in ('Male', 'Female', 'Unknown'));

ALTER TABLE Subj_Enrolment
DROP COLUMN comment;

desc Subj_Enrolment;