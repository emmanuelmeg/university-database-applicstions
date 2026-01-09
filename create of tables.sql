-- this is to create the table needed for the database

-- student table
create table Student(
matricNO  VARCHAR2(20) Primary Key,
first_name VARCHAR2(50) not null,
last_name  VARCHAR2(50) not NULL,
town   VARCHAR2(20),
Street VARCHAR2(20),
post_code VARCHAR2(10),
date_of_brith  DATE,
sex  VARCHAR2(6),
financial_loan  NUMBER(10,2),
networkID      VARCHAR2(20) UNIQUE,
CourseID   VARCHAR2(10)
);

-- staff table
CREATE TABLE Staff(
StaffNo    VARCHAR2(10) PRIMARY KEY,
First_name  VARCHAR2(50) NOT NULL,
Last_name   VARCHAR2(50) NOT NULL,
Sex    VARCHAR2(6),
Salary  NUMBER(10,2),
Post   VARCHAR2(50),
Qualiflictions  VARCHAR2(60),
PhoneExt  VARCHAR2(10),
OfficeNo VARCHAR2(10),
address VARCHAR2(56),
deptNO VARCHAR2(10),
networkID VARCHAR2(20) UNIQUE
);

-- department table
CREATE TABLE Department(
deptNO  VARCHAR2(10) PRIMARY key,
name   VARCHAR2(50) NOT NULL,
Phone  VARCHAR2(20),
fax   VARCHAR2(20),
Location  VARCHAR2(50),
manager_staffNo  VARCHAR2(10),
data_Started_Managing   DATE,
CONSTRAINT fk_dept_manager
    FOREIGN KEY (manager_staffNO)
    REFERENCES Staff(StaffNo)
);

--- add an constraint for the staff table
ALTER TABLE Staff
ADD CONSTRAINT fk_Staff_department
FOREIGN KEY(deptNO)
REFERENCES Department(deptNO);



--- the next of kin table
Create TABLE next_of_kin(
Student_MarticNo   VARCHAR2(10) PRIMARY KEY,
Frist_name    VARCHAR2(50) NOT NULL,
Last_name     VARCHAR2(50) NOT NULL,
Address       VARCHAR2(100),
Phone          VARCHAR2(12),
Relationship   VARCHAR2(30),
CONSTRAINT fk_nok_student
    FOREIGN KEY (Student_MarticNO)
    REFERENCES Student(matricNo)
);

--- the table that store information of the course
CREATE TABLE Course(
 CourseID   VARCHAR2(10) PRIMARY KEY,
 Course_Title  VARCHAR2(30) NOT NULL,
 Leader_StaffNo  VARCHAR2(20),
 Durations VARCHAR2 (20),
 deptNO VARCHAR2(10),
 CONSTRAINT fk_course_department
    FOREIGN KEY(deptNO)
    REFERENCES department(deptNo),

 CONSTRAINT fk_course_leader
     FOREIGN KEY(Leader_StaffNo)
     REFERENCES Staff(StaffNo)
);

-- add a constraint to student table
ALTER TABLE Student
Add CONSTRAINT fk_enroll_course
    FOREIGN KEY(courseID)
    REFERENCES Course(CourseID)
);

 -- the module table
CREATE TABLE Module(
ModuleID  VARCHAR2(10) PRIMARY KEY,
Module_title  VARCHAR2(225) NOT NULL,
Start_Date    DATE,
End_Date      DATE,
CourseID     VARCHAR2(15),
coordinator_Staffno VARCHAR2(10),
assessmentScheme  VARCHAR2(100),
text   VARCHAR2(225),
CONSTRAINT fk_module_course
    FOREIGN KEY(CourseID)
    REFERENCES Course(CourseID),
CONSTRAINT fk_module_coordinator
    FOREIGN KEY(Coordinator_StaffNo)
    REFERENCES Staff(StaffNo)
    );
 
 -- teaching table  
CREATE TABLE Teaching (
StaffNo  VARCHAR2(10),
ModuleID VARCHAR2(10),
Hours_per_week NUMBER(2),
CONSTRAINT pk_teaching PRIMARY KEY(StaffNo, ModuleID),
CONSTRAINT fk_teaching_Staff
   FOREIGN KEY (StaffNo)
   REFERENCES Staff(StaffNo),
CONSTRAINT fk_teaching_module
    FOREIGN KEY (ModuleID)
    REFERENCES Module(ModuleID)
);



-- the module result table
CREATE TABLE Module_Result(
matricNo   VARCHAR2(10),
moduleID  VARCHAR2(10),
Performance VARCHAR2(10),
CONSTRAINT pk_moulde_result PRIMARY KEY(matricNO, ModuleID),
CONSTRAINT fk_result_student
   FOREIGN KEY (matricNO)
   REFERENCES Student(matricNO),
CONSTRAINT fk_result_module
    FOREIGN KEY (ModuleID)
    REFERENCES Module(ModuleID)

);

COMMIT;
