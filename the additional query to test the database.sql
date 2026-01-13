---- addtional query ---
--- List of modules coordinated by staff with the staffNo (SF101)
select module_title, assessmentscheme
from module
where coordinator_staffno = 'SF101';

---- 2 list of modules without any enrolled student
select  m.module_title
from module m
Left JOIN module_result mr
on m.moduleid = mr.moduleid
where mr.moduleid is null;

--- 3list of all student who receive a financial loan less than 7000---

SELECT matricno,
      first_name,
      last_name,
      financial_loan
from student
where financial_loan < 7000;

--- 4 List of students and their courses

Select s.matricno,
       s.first_name,
       s.last_name,
       c.course_title
from student s
join course c
on s.courseid = c.courseid;


---- 5 the average salary per deparment
select d.name  AS "DEPARTMENT",
        ROUND(AVG(S.salary),-2) AS "average salary"
from DEPARTMENT D
JOIN STAFF S
on d.deptno = s.deptno
Group by d.name;

--- 6  the list of modules per course--
select c.course_title,
    count(m.moduleid) AS "Number of module"

from course c
left join module m
On c.courseid = m.courseid
group by c.course_title;

--- 7 the list staff not managing any department but are still in the department
select s.staffno,
       s.first_name,
       s.Last_name,
       d.name
from staff s
join department d
on s.deptno = d.deptno

where staffno Not in (
          select manager_staffNo
          from department
          where manager_staffNO is not Null
          );

--- 8. List of Students that fail a module---
select s.matricno,
       s.first_name,
       s.last_name,
       m.module_title
from student s
join module_result mr
on s.matricno = mr.matricno
Join module m
on m.moduleid = mr.moduleid
where mr.performance = 'Fail';


--- 9 the number of modules taught by a staff member---
select s.staffno,
       s.first_name,
       s.last_name,
       count(t.moduleid) AS "MODULES TAUGHT"
from staff s
join teaching t
ON s.staffno = t.staffno
GROUP BY s.staffno,s.first_name,s.last_name
;

---- 10 list od staff memeber that are not teaching any modules

select
s.staffno,s.last_name,s.post
from staff s
left join Teaching t
on s.staffno = t.staffno
where t.staffno IS NULL;