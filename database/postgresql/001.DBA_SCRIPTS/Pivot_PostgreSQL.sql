---------------------------
--PostgreSQL Pivot
---------------------------

select bb.department_id,
       count(*) filter (where bb.year = '2004')       as YEAR2004_EMPLOYEES_HIRED,
       sum(bb.salary) filter (where bb.year = '2004') as YEAR2004_SALARIES,
       count(*) filter (where bb.year = '2005')       as YEAR2005_EMPLOYEES_HIRED,
       sum(bb.salary) filter (where bb.year = '2005') as YEAR2005_SALARIES
from (
         SELECT aa.department_id,
                TO_CHAR(aa.hire_date, 'YYYY') AS YEAR,
                aa.salary
         FROM hr.employees aa
     ) bb
group by bb.department_id
order by bb.department_id
;
