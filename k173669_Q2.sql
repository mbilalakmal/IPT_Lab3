-- k173669_Q2
-- SQL scripts tested and developed with Azure Data Studio

-- Get a list of tables and views in the current database
SELECT table_catalog [database], table_schema [schema], table_name [name], table_type [type]
FROM INFORMATION_SCHEMA.TABLES
GO

-- Create StudentAudit table from Student table
SELECT TOP 0 * INTO StudentAudit FROM Student

-- Q2 (a)
CREATE CLUSTERED INDEX StudentId_ClusteredIndex ON StudentAudit (StudentId ASC)
CREATE NONCLUSTERED INDEX StudentId_NonClusteredIndex ON StudentAudit (StudentId ASC)
GO

-- Q2 (b) 1.
CREATE TRIGGER trackStudentInsert ON STUDENT AFTER INSERT AS
SET IDENTITY_INSERT StudentAudit ON
BEGIN
INSERT INTO StudentAudit(StudentId, StudentName, Gender, AdmissionYear) SELECT StudentId, StudentName, Gender, AdmissionYear FROM INSERTED AS I
END
GO
-- TESTING
INSERT INTO Student VALUES ('MR. BILAL AKMAL', 'MALE', '1984-07-15')
SELECT * FROM Student
SELECT * FROM StudentAudit
GO

--Q2 (B) 2.
CREATE TRIGGER trackStudentUpdate ON STUDENT AFTER UPDATE AS

BEGIN
UPDATE StudentAudit SET StudentName=U.StudentName, Gender=U.Gender,AdmissionYear=U.AdmissionYear FROM inserted AS U
WHERE StudentAudit.StudentId = U.StudentId
END
GO
-- TESTING
UPDATE Student set StudentName='Bilal Akmal' WHERE StudentName= 'MR. BILAL AKMAL'
SELECT * FROM Student
SELECT * FROM StudentAudit
GO