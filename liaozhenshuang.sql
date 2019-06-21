---------------------------------------------（第二题）

CREATE DATABASE  [stdtb] ON
PRIMARY 
( NAME = N'stdtb_data',
FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\stdtb_data.mdf', SIZE = 10240KB,
MAXSIZE = 102400KB,
FILEGROWTH = 1024KB)
LOG ON
( NAME = N'stdtb_log',
FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\stdtb_log.ldf',
SIZE = 5120KB,
MAXSIZE = 102400KB,
FILEGROWTH = 10%)
COLLATE Chinese_PRC_CI_AS
GO

---------------------------------------------（第三题）

CREATE LOGIN liaozhenshuang
WITH PASSWORD='liaozhenshuang
DEFAULT_DATABASE=[stdtb],
DEFAULT_LANGUAGE=[简体中文],
CHECK_EXPIRATION=OFF,
CHECK_POLICY=OFF
GO

---------------------------------------------（第四题）

CREATE USER [usr1] FOR LOGIN [liaozhenshuang]
CREATE USER [usr2] FOR LOGIN [liaozhenshuang]
CREATE USER [usr3] FOR LOGIN [liaozhenshuang]
GO 

---------------------------------------------（第五题和第七题放一起做了）

USE stdtb
GO
CREATE TABLE Student
(
Sno varchar(7) PRIMARY KEY,
Sname varchar(10) NOT NULL,
Ssex char(2)check(Ssex = '男' or Ssex = '女'),
Sage int check(Sage between 15 and 45),
Sdept varchar(20)
)
USE stdtb
GO
CREATE TABLE Course
(
Cno varchar(10) PRIMARY KEY,
Cname varchar(20) NOT NULL,
Cpon varchar(10),
Ccredit INT CHECK(Sctedit>0)
)
USE stdtb
GO
CREATE TABLE SC
(
Sno varchar(7) FOREIGN KEY REFERENCES Student(Cno),
Grade INT CHECK(Grade BETWEEN 0 AND 100),
PRIMARY KEY(Sno,Cno)
)
GO

---------------------------------------------（第六题）

USE stdtb
GO
INSERT INTO Student
VALUES('201215121','李勇','男','20','CS'),
('201215122','刘晨','女','19','CS'),
('201215123','王敏','女','18','MA'),
('201215125','张立','男','20','IS'),
('201215129','李丹','女','20','EE');
GO

USE stdtb
GO
INSERT INTO Course
VALUES('1','数据库','5','4'),
('2','数学',' ','2'),
('3','信息系统','1','4'),
('4','操作系统','6','2'),
('5','数据结构','7','4'),
('6','数据处理',' ','2'),
('7','PASCAL语言','6','4');
GO

USE stdtb
GO
INSERT INTO SC
VALUES('201215121','1','92'),
('201215121','2','85'),
('201215121','3','88'),
('201215122','2','90'),
('201215122','3','80'),
('201215123','2','82'),
('201215125','2','78'),
('201215125','1','58');
GO

---------------------------------------------（第8题）

SELECT Sname,Sno,Sdept
FROM Student;


SELECT *
FROM Student;


SELECT Sname,2004-Sage
FROM Student;


SELECT Sname,2004-Sage,LOWER(Sdept) 
FROM Student;


SELECT DISTINCT Sno
FROM SC;


SELECT Sname,Sage
FROM Student
WHERE Sage<20;


SELECT DISTINCT Sno
FROM SC
WHERE GRADE<60;


SELECT Sname,Sdept,Sage
FROM Student
WHERE Sage BETWEEN 20 AND 23;


SELECT *
FROM Student
WHERE Sno='201215121';


SELECT Sname,Sno,Ssex
FROM Student
WHERE Sname LIKE'刘%';


SELECT Sno,Grade
FROM SC
WHERE Cno='2'
ORDER BY Grade DESC;


SELECT *
FROM Student
ORDER BY Sdept,Sage DESC;


SELECT COUNT(*)
FROM Student;


SELECT AVG(Grade)
FROM SC
WHERE Cno='1';


SELECT SUM(Ccredit)
FROM SC,Course
WHERE Sno='201215121' AND SC.Cno=Course.Cno;


SELECT Cno,COUNT(Sno)
FROM SC
GROUP BY Cno;


SELECT SC.Sno,Course.*
FROM SC,Course
WHERE SC.Cno=Course.Cno


SELECT Student.Sno,Sname,Course.Cname,SC.Grade
FROM Student,Course,SC
WHERE Student.Sno=SC.Sno AND SC.Cno=Course.Cno


SELECT Sname,Sage
FROM Student
WHERE Sage<ALL(SELECT Sage FROM Student WHERE Sdept='CS');

---------------------------------------------（第9题）

USE stdtb
GO
UPDATE Student SET Sage = Sage+1

---------------------------------------------（第10题）

USE stdtb
 GO
 CREATE VIEW IS_Student
        AS 
        SELECT Sno,Sname,Sage
        FROM Student
        WHERE Sdept='IS'
        WITH CHECK OPTION
        GO
        CREATE VIEW BT_S(Sno,Sname,Sbirth)
        AS 
        SELECT Sno,Sname,Sage
        FROM Student
GO

---------------------------------------------（第11题）
CREATE ROLE Teacher
GRANT SELECT,UPDATE,INSERT
ON Student
TO Teacher;
GRANT SELECT,UPDATE,INSERT
ON SC
TO Teacher;
EXEC sp_addrolemember Teacher, 'usr1'
EXEC sp_addrolemember Teacher, 'usr2'
EXEC sp_addrolemember Teacher, 'usr3'
GO

---------------------------------------------（第12题）

CREATE TABLE TEACHER(Eno NUMERIC(4)PRIMARY KEY,
Ename CHAR(10),
Job CHAR(8),
Sal NUMERIC(7,2),
Deduct NUMERIC(7,2),
Deptno NUMERIC(2),
CONSTRANT TEACHERKey FOREIGN KEY(Deptno)REFERENCES DEPT(Deptno),
CONSTRAINT C1 CHECK(Sal+Deduct>=3000));