select substr(sales_month,1,4) from sales;


select substr(sales_month,1,4) as year, count(*)
from sales
group by substr(sales_month,1,4)
order by year ;

select  sum(case substr(sales_month,1,4) when '1998' then 1 else 0 end) as "1998",
        sum(case substr(sales_month,1,4) when '1999' then 1 else 0 end) as "1999",
        sum(case substr(sales_month,1,4) when '2000' then 1 else 0 end) as "2000",
        sum(case substr(sales_month,1,4) when '2001' then 1 else 0 end) as "2001"
from sales;


select to_char(hire_date,'YYYY') as year,count(*)
from employees
group by to_char(hire_date,'YYYY')
order by year;

select  sum(case to_char(hire_date,'YYYY') when '1998' then 1 else 0 end) as "1998",
        sum(case to_char(hire_date,'YYYY') when '1999' then 1 else 0 end) as "1999",
        sum(case to_char(hire_date,'YYYY') when '2000' then 1 else 0 end) as "2000",
        sum(case to_char(hire_date,'YYYY') when '2001' then 1 else 0 end) as "2001",
        sum(case to_char(hire_date,'YYYY') when '2002' then 1 else 0 end) as "2002",
        sum(case to_char(hire_date,'YYYY') when '2003' then 1 else 0 end) as "2003",
        sum(case to_char(hire_date,'YYYY') when '2004' then 1 else 0 end) as "2004",
        sum(case to_char(hire_date,'YYYY') when '2005' then 1 else 0 end) as "2005",
        sum(case to_char(hire_date,'YYYY') when '2006' then 1 else 0 end) as "2006",
        sum(case to_char(hire_date,'YYYY') when '2007' then 1 else 0 end) as "2007",
        sum(case to_char(hire_date,'YYYY') when '2008' then 1 else 0 end) as "2008",
        count(*) as total
from employees;

select  sum(decode(to_char(hire_date,'YYYY'),'1998',1,0)) as "1998",
        sum(decode(to_char(hire_date,'YYYY'),'1999',1,0)) as "1999",
        sum(decode(to_char(hire_date,'YYYY'),'2000',1,0)) as "2000",
        sum(decode(to_char(hire_date,'YYYY'),'2001',1,0)) as "2001",
        sum(decode(to_char(hire_date,'YYYY'),'2002',1,0)) as "2002",
        sum(decode(to_char(hire_date,'YYYY'),'2003',1,0)) as "2003",
        sum(decode(to_char(hire_date,'YYYY'),'2004',1,0)) as "2004",
        sum(decode(to_char(hire_date,'YYYY'),'2005',1,0)) as "2005",
        sum(decode(to_char(hire_date,'YYYY'),'2006',1,0)) as "2006",
        sum(decode(to_char(hire_date,'YYYY'),'2007',1,0)) as "2007",
        sum(decode(to_char(hire_date,'YYYY'),'2008',1,0)) as "2008",
        count(*) as total
from employees;

--°èÃşÇü Äõ¸® ¸¸µé±â
--level1 ÃÖ»óÀ§°èÃş
select  department_id,department_name,
        0 as parent_id, 
        1 as levels,
        parent_id || department_id as sort
from departments
where parent_id is null
union all
--level2 °èÃş > ºÎ¸ğ°¡ 1°èÃşÀÎ°É Ã£´Â´Ù
select  t2.department_id,
        lpad('  ',3*(2-1)) || t2.department_name as department_name,
        t2.parent_id,
        2 as levels,
        t2.parent_id || t2.department_id as sort
from    departments t1,
        departments t2
where t1.parent_id is null
and     t2.parent_id = t1.department_id -- ºÎ¸ğ°¡ 10¹øÀÎ°Å
union all
--level3 °èÃş ºÎ¸ğ°¡ 2°èÃşÀÎ°É Ã£´Â´Ù
select  t3.department_id,
        lpad('  ',3*(3-1)) || t3.department_name as department_name,
        t3.parent_id,
        3 as levels,
        t2.parent_id ||t3.parent_id|| t3.department_id as sort
from    departments t1,
        departments t2,
        departments t3
where   t1.parent_id is null
and     t2.parent_id = t1.department_id
and     t3.parent_id = t2.department_id
union all
--level4 °èÃş
select  t4.department_id,
        lpad('  ',3*(4-1)) || t4.department_name as department_name,
        t4.parent_id,
        4 as levels,
        t2.parent_id ||t3.parent_id||t4.parent_id||t4.department_id as sort
from    departments t1,
        departments t2,
        departments t3,
        departments t4
where   t1.parent_id is null
and     t2.parent_id = t1.department_id
and     t3.parent_id = t2.department_id
and     t4.parent_id = t3.department_id
order by sort;

--°èÃşÇü Äõ¸® ±¸¹®
select  department_id,
        lpad(' ',3*(level-1)) || department_name,
        level
from departments
start with parent_id is null
connect by prior department_id = parent_id;

--°èÃşÇüÄõ¸® ±¸¹® Á¶ÀÎ
select  a.employee_id,
        lpad(' ',3*(level-1)) || a.emp_name,
        level,
        b.department_name
from employees a,
    departments b
where a.department_id = b.department_id
start with a.manager_id is null
connect by prior a.employee_id = a.manager_id;




--PIVOT
select * from employees where department_id =60;

select  emp_name,
        decode(department_id,10,'ÃÑ¹«±âÈ¹ºÎ',
                            20,'ÃÑ¹«±âÈ¹ºÎ',
                            30,'ÃÑ¹«±âÈ¹ºÎ',
                            '±âÅ¸'
        )
        as dept
from employees;


select  emp_name,
        decode(department_id,80,
                                decode(job_id,'SA_MAN','¿µ¾÷¸Å´ÏÀú','¿µ¾÷»ç¿ø')) as dep
        from employees;R