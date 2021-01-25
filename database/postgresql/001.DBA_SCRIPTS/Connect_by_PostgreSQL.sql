---------------------------
--PostgreSQL Connect by
---------------------------

with RECURSIVE re_emp (employee_id, first_name, last_name, manager_id, boss, chart)
as (
    select a.employee_id, a.first_name, a.last_name, a.manager_id, a.last_name as boss, concat(',',a.last_name::text) chart
    from employees a
    where a.manager_id is null
    union ALL
    select b.employee_id, b.first_name, b.last_name, b.manager_id, re.boss, concat(re.chart::text, ',', b.last_name)
    from employees b inner join re_emp re on re.employee_id = b.manager_id
)
select aa.employee_id, aa.first_name, aa.last_name, aa.manager_id, aa.boss, aa.chart,
       CASE WHEN (SELECT COUNT(*) FROM employees a WHERE a.manager_id = aa.employee_id) > 0 THEN 0
       ELSE 1 END AS is_leaf
from re_emp aa
;