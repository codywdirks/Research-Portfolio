/*
* Name: Database Design
* Author: Cody Dirks
* Date: 11/10/23
* Description: This is the code will create new tables for the students and their respecitve coureses
database
* Change Log:
*/

-- Creating the Student Table
CREATE TABLE [Student]
(
[T_Number] VARCHAR(9) NOT NULL,
[FirstName] NVARCHAR(200) NOT NULL,
[LastName] NVARCHAR(200) NOT NULL,
[MiddleName] NVARCHAR(200),
[Email] NVARCHAR(200) NOT NULL,
[Major] NVARCHAR(200) NOT NULL,
[Minor] NVARCHAR(200),
[Advisor] NVARCHAR(200) NOT NULL,
[Address] NVARCHAR(200) NOT NULL,
[GPA] DECIMAL(3,2) NOT NULL,
PRIMARY KEY (T_Number));

-- Creating the Course Table
CREATE TABLE [Course]
(
[CRN] VARCHAR(5) NOT NULL,
[CourseName] VARCHAR(200) NOT NULL,
[Subject] VARCHAR(200) NOT NULL,
[CourseNumber] VARCHAR(200) NOT NULL,
[Class] VARCHAR(3) NOT NULL,
[CoReq] VARCHAR(200),
[PreReq] VARCHAR(200),
[CreditHours] INTEGER NOT NULL,
[Instruction] VARCHAR(200) NOT NULL,
[SemesterSesh] VARCHAR(200) NOT NULL,
[Instructor] VARCHAR(200) NOT NULL,
PRIMARY KEY (CRN),
FOREIGN KEY (CoReq) REFERENCES Course(CourseNumber));
/*
* If there was a table for the different instructors, I would also include a foreign
* key here for that. However, this is what I have right at this current time. We may want
* to reach out and see if I am missing anything here.
*/

-- Creating the Registration Table
CREATE TABLE [Registration]
(
[T_Number] VARCHAR(9) NOT NULL,
[CRN] VARCHAR(5) NOT NULL,
[Waitlisted] VARCHAR(1) NOT NULL,
FOREIGN KEY (T_Number) REFERENCES Student(T_Number),
FOREIGN KEY (CRN) REFERENCES Course(CRN));
/*
* Here we hit some issues with forigen and primary key syntax. When comparing 
* to other RA's we found that it was due to a Mac vs PC difference. We may
* want to reach out to IT to see if this is normal or not.
*/

-- List of Students in Each Class
SELECT
(CASE WHEN s.MiddleName IS NULL THEN (s.FirstName || " " || s.LastName) ELSE
(s.FirstName || " " || s.MiddleName || " " || s.LastName) END) As "Student Name"
, c.CourseNumber AS "Course"
, c.CourseName AS "Course Name"
, c.CreditHours
, c.Instruction
, c.SemesterSesh
FROM Student s
LEFT JOIN Registration r
ON s.T_Number = r.T_Number
LEFT JOIN Course c
ON c.CRN = r.CRN
ORDER BY c.CourseNumber
/*
 * Here is my code for the students taking each class in the School of Business (ordered by the CRN).
 * This querty will provide the student, the CRN, the given name of the course (ex. Intro to Microeconomics),
 * the total credit hours of the course, the medium of instruction (i.e. in-person, remote, online), and what
 * session the course is in (or if it is a full-term course).
 */
