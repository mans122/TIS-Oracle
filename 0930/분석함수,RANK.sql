--1.ROW_NUMBER()
select department_id, emp_name,
        row_number() over (partition by department_id order by department_id,emp_name)dep_rows
from employees;

--원래 테이블의 rownum을 가져옴.
select rownum, employee_id, emp_name,salary
from employees
order by salary;


select rownum,employee_id,emp_name,salary
from(select employee_id,emp_name,salary from employees order by salary) a;

select employee_id,emp_name,salary,department_id,
    row_number() over (partition by department_id order by department_id,emp_name)as dpe_rows
    from employees;
    
select employee_id,emp_name,salary,
row_number() over ( order by salary) as rn
from employees;

--RNAK
select employee_id,emp_name,salary,
rank() over ( order by salary) as rank
from employees;

select employee_id,emp_name,salary,
dense_rank() over ( order by salary) as rank
from employees;

select employee_id,emp_name,salary,department_id,
    row_number() over (partition by department_id order by department_id,emp_name desc)as dpe_rows
    from employees;
    

select employee_id,emp_name,salary,
    rank() over (partition by department_id order by salary) raking
    --,cume_dist() over (partition by department_id order by salary)cum_dist_value
    ,percent_rank() over (partition by department_id order by salary) percentile
from employees
where department_id = 60;

