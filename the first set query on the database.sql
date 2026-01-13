--- to run this query put your cusor on on one query 
--- and run it as a statement
---

 --- 1 List the details of all departments located in E Block. ---
SELECT *
FROM department
WHERE location = 'E block';


--- 2 List the title, start, and end dates of all modules run in the PgDIT course
Select m.module_title,
m.Start_Date,
m.End_Date
From  module m
Join course c
on m.courseid = c.courseid
where c.course_title = 'PgDIT';


--- 3 List name, address, and salary for each female member of academic staff who manages a department

select s.first_name,
s.last_name,s.address,
s.salary
from Staff s
JOIN department d
on s.staffno = d.manager_staffno
where s.sex = 'Female';

--- 4 1. List name, sex, and salary for each lecturer with a PhD degree.
select first_name,
       last_name,
       sex,
       salary
from staff
where post = 'lecturer'
and qualiflictions like '%PHD%';

---5 List the last name, post, and qualifications of all members of academic staff who are employed by the CIS department.
SELECT s.last_name,
s.post,
s.qualiflictions
FROM STAFF s
join department d
on s.deptno = d.deptno
where d.name = 'CIS';

----6 List the matriculation number, last name, and sex of all students who are studying the 'multi-media' module. Order results alphabetically by last name.
select s.matricno,
s.last_name,
s.sex
from student s
join module_result mr
on s.matricno =  mr.matricNO
join Module m
on mr.moduleid = m.moduleid
where m.module_title = 'multi-media'
ORDER by s.last_name;

---7 List staff number, last name, sex, and post of all academic staff whose salary is greater than the average salary of all academic staff.
Select staffno,
      last_name,
      sex,
      post
from staff
where salary > (
Select Avg(salary)
from staff
);

---8 * For each course with more than 10 students, list the course title and the number of students (under an appropriate header).
SELECT C. course_title AS "COURSE TITLE",
        COUNT(s.matricno) AS "NUMBER OF STUDENT"


 FROM COURSE C
 JOIN student S
 ON c.courseid = s.courseid
GROUP BY c.course_title
HAVING COUNT(s.matricno) >10;

---9 List the number of female members of academic staff and the number of male members of academic staff employed by the CIS department.
SELECt s.sex,
count(*) as "sum"

from staff s

JOIN department d
on s.deptno = d.deptno
where d.name = 'CIS'
GROUP BY s.sex;

--10 For each member of academic staff who spends more than 6 hours teaching any module, list the member of academic staff's last name, the module title, and the number of hours.
select s.last_name,
       m.module_title, 
       t.hours_per_week

from teaching t
join staff s
on t.staffNo = s.staffNo
join module m
     on t.ModuleID = m.moduleID
where t.hours_per_week >6;

--- 11For each department, list the department name, the number of female members of academic staff, and the number of male members of academic staff under the appropriate header
Select d.name as "Department",
       SUM(CASE when s.sex = 'Male' THEN 1 ELSE 0 END ) AS "MALE STAFF",
       SUM(CASE when s.sex = 'Female' THEN 1 ELSE 0 END) AS "FEMALE STAFF"
FROM Department d
LEFT JOIN staff s
on d.deptno = s.deptno
Group by d.name;