DROP DATABASE myproject;
CREATE DATABASE myproject;
use myproject;

CREATE TABLE Scholarship (
	scholarshipID INT UNSIGNED,
    scholarship_value INT(10) NOT NULL,
    scholarship_condition TEXT NOT NULL,
    scholarship_desc TEXT NOT NULL,
    PRIMARY KEY(scholarshipID)
);

CREATE TABLE Student (
	studentID INT UNSIGNED NOT NULL,
    scholarshipID INT UNSIGNED,
    firstname VARCHAR(35) NOT NULL,
    lastname VARCHAR(35) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M','F','U')),
    date_of_birth DATE NOT NULL,
    PRIMARY KEY(studentID)
);

CREATE TABLE Subject (
	subjectID CHAR(4) NOT NULL UNIQUE,
    subject_name VARCHAR(40) NOT NULL,
    prerequisite VARCHAR(40) DEFAULT NULL,
    credit INT(5) NOT NULL,
    PRIMARY KEY(subjectID)
);

CREATE TABLE Result (
	studentID INT UNSIGNED NOT NULL,
    subjectID CHAR(4) NOT NULL,
	score INT(5) NOT NULL,
    attempt INT(5) NOT NULL
);

CREATE TABLE Enrolment (
	enrolmentID INT UNSIGNED NOT NULL UNIQUE,
    studentID INT UNSIGNED NOT NULL,
    description TEXT DEFAULT NULL,
    PRIMARY KEY(enrolmentID)
);

CREATE TABLE Class (
	classID INT UNSIGNED NOT NULL UNIQUE,
    subjectID CHAR(4) NOT NULL,
    note TEXT DEFAULT NULL,
    PRIMARY KEY(classID)
);

CREATE TABLE Provider (
	providerID CHAR(5) NOT NULL,
    provider_name VARCHAR(40) NOT NULL,
    company_no INT(5) NOT NULL,
    PRIMARY KEY(providerID)
);

CREATE TABLE Scholarship_Provider (
	scholarshipID INT UNSIGNED,
    providerID CHAR(5) NOT NULL,
	note TEXT DEFAULT NULL
);

ALTER TABLE Student
ADD CONSTRAINT fk_student_scholarship
FOREIGN KEY(scholarshipID) REFERENCES Scholarship(scholarshipID);

ALTER TABLE Result
ADD CONSTRAINT fk_result_student
FOREIGN KEY(studentID) REFERENCES Student(studentID);

ALTER TABLE Result
ADD CONSTRAINT fk_result_subject
FOREIGN KEY(subjectID) REFERENCES Subject(subjectID);

ALTER TABLE Enrolment
ADD CONSTRAINT fk_enrolment_student
FOREIGN KEY(studentID) REFERENCES Student(studentID);

ALTER TABLE Class
ADD CONSTRAINT fk_class_subject
FOREIGN KEY(subjectID) REFERENCES Subject(subjectID);

ALTER TABLE Scholarship_Provider
ADD CONSTRAINT fk_scholarship_provider
FOREIGN KEY(scholarshipID) REFERENCES Scholarship(scholarshipID);

ALTER TABLE Scholarship_Provider
ADD CONSTRAINT fk_provider_scholarship
FOREIGN KEY(providerID) REFERENCES Provider(providerID);

INSERT INTO Subject (subjectID, subject_name, credit)
VALUES ('A101', 'Data Management', 15);
INSERT INTO Subject (subjectID, subject_name, credit)
VALUES ('B202', 'Statistics', 15);
INSERT INTO Subject (subjectID, subject_name, credit)
VALUES ('C303', 'Data Visualisation', 20);
INSERT INTO Subject (subjectID, subject_name, credit)
VALUES ('D404', 'Artificial Intelligence', 30);
INSERT INTO Subject (subjectID, subject_name, credit)
VALUES ('E505', 'Data Analytics', 20);

INSERT INTO Scholarship(scholarshipID, scholarship_value, scholarship_condition, scholarship_desc)
VALUES(1111, 15000, 'No fail unit', 'Available');
INSERT INTO Scholarship(scholarshipID, scholarship_value, scholarship_condition, scholarship_desc)
VALUES(2222, 20000, 'At least 2 HD', 'Available');
INSERT INTO Scholarship(scholarshipID, scholarship_value, scholarship_condition, scholarship_desc)
VALUES(3333, 25000, 'At least 3 HD', 'Available');
INSERT INTO Scholarship(scholarshipID, scholarship_value, scholarship_condition, scholarship_desc)
VALUES(4444, 26000, 'HD on every subject', 'Available');

INSERT INTO Student(studentID, scholarshipID, firstname, lastname, gender, date_of_birth)
VALUES(1024, 2222, 'Scorlib', 'Lexrin', 'M', '2002-01-05');
INSERT INTO Student(studentID, scholarshipID, firstname, lastname, gender, date_of_birth)
VALUES(1025, 1111, 'Raymond', 'Andilsim', 'M', '2002-01-28');
INSERT INTO Student(studentID, scholarshipID, firstname, lastname, gender, date_of_birth)
VALUES(1026, 3333, 'Edward', 'Apriandy', 'M', '2001-04-11');
INSERT INTO Student(studentID, scholarshipID, firstname, lastname, gender, date_of_birth)
VALUES(1027, 4444, 'Jackson', 'Timmer', 'M', '2001-05-09');
INSERT INTO Student(studentID, scholarshipID, firstname, lastname, gender, date_of_birth)
VALUES(1028, 4444, 'Wilsen', 'Marchlen', 'M', '2001-08-9');
INSERT INTO Student(studentID, scholarshipID, firstname, lastname, gender, date_of_birth)
VALUES(1029, 2222, 'Angela', 'Chua', 'F', '2001-01-31');
INSERT INTO Student(studentID, firstname, lastname, gender, date_of_birth)
VALUES(1030, 'Putri', 'Fellany', 'F', '2002-01-05');
INSERT INTO Student(studentID, firstname, lastname, gender, date_of_birth)
VALUES(1031, 'Rudy', 'Santoso', 'M', '1970-05-24');

INSERT INTO Result(studentID, subjectID, attempt, score)
VALUES(1027, 'A101', 1, 75);
INSERT INTO Result(studentID, subjectID, attempt, score)
VALUES(1027, 'B202', 3, 60);
INSERT INTO Result(studentID, subjectID, attempt, score)
VALUES(1028, 'C303', 1, 90);
INSERT INTO Result(studentID, subjectID, attempt, score)
VALUES(1028, 'D404', 2, 55);
INSERT INTO Result(studentID, subjectID, attempt, score)
VALUES(1029, 'A101', 1, 80);
INSERT INTO Result(studentID, subjectID, attempt, score)
VALUES(1024, 'A101', 1, 100);
INSERT INTO Result(studentID, subjectID, attempt, score)
VALUES(1025, 'E505', 4, 30);
INSERT INTO Result(studentID, subjectID, attempt, score)
VALUES(1025, 'B202', 3, 45);
INSERT INTO Result(studentID, subjectID, attempt, score)
VALUES(1026, 'C303', 2, 70);
INSERT INTO Result(studentID, subjectID, attempt, score)
VALUES(1026, 'E505', 1, 95);

INSERT INTO Provider(providerID, provider_name, company_no)
VALUES('PT666', 'Microsoft', 116118);
INSERT INTO Provider(providerID, provider_name, company_no)
VALUES('TJ777', 'Government', 113115);
INSERT INTO Provider(providerID, provider_name, company_no)
VALUES('SA888', 'Swinburne', 114116);
INSERT INTO Provider(providerID, provider_name, company_no)
VALUES('CO999', 'Amazon', 115117);

INSERT INTO Scholarship_Provider(scholarshipID, providerID, note)
VALUES(4444, 'CO999', 'Congratulations');
INSERT INTO Scholarship_Provider(scholarshipID, providerID)
VALUES(2222, 'TJ777');
INSERT INTO Scholarship_Provider(scholarshipID, providerID)
VALUES(3333, 'SA888');

SELECT * FROM Student;
SELECT * FROM Scholarship;
SELECT * FROM Subject;

SELECT s.studentID, s.firstname, s.lastname, sc.scholarship_value, sc.scholarship_desc
FROM Student s NATURAL JOIN Scholarship sc
ORDER BY s.studentID;
 
SELECT s.studentID, CONCAT(s.firstname, ' ' ,s.lastname) AS 'Student Name', r.score AS 'Score'
FROM Student s JOIN Result r 
ON s.studentID = r.studentID
WHERE r.score > 50 
ORDER BY s.studentID;

SELECT sp.scholarshipID, sp.providerID, p.provider_name AS 'Provider Name'
FROM Scholarship_Provider sp LEFT JOIN Provider p
ON sp.providerID = p.providerID
ORDER BY scholarshipID;

SELECT CONCAT(s.firstname,' ',s.lastname) AS 'Student Name', 
SUM(r.attempt) AS 'NumberOfAttempts'
FROM Student s
INNER JOIN Result r 
ON s.studentID = r.studentID
GROUP BY s.lastname HAVING COUNT(r.attempt)>1;

SELECT s.firstname, s.lastname, COUNT(sj.subjectID) AS 'NumberOfSubjects'
FROM Student s 
NATURAL JOIN Subject sj
GROUP BY s.firstname;

SELECT studentID FROM Student s
WHERE NOT EXISTS(
				SELECT * FROM Result
                WHERE Score <= 50 AND studentID = s.studentID );

CREATE VIEW No_Scholarship AS
SELECT studentID AS 'Student ID', 
CONCAT(firstname, ' ' ,lastname) AS 'Student Name',
scholarshipID FROM Student
WHERE scholarshipID IS NULL;

SELECT * FROM Student;
SELECT * FROM Scholarship;

SELECT studentID AS 'Student ID', CONCAT(firstname, ' ', lastname) AS 'Student Name',
gender AS 'Gender', date_of_birth AS 'DOB', scholarshipID AS 'Scholarship ID'
FROM Student ORDER BY studentID;

SELECT scholarshipID AS 'Scholarship ID', 
scholarship_value AS 'Value', 
scholarship_condition AS 'Requirements',
scholarship_desc AS 'Description'
FROM Scholarship ORDER BY scholarshipID;


UPDATE Student SET lastname = 'Ng' WHERE studentID = '1027';
UPDATE Result SET score = 40 WHERE studentID = 1025 AND subjectID = 'E505';

SELECT * FROM Student;
SELECT * FROM Result;



 








    