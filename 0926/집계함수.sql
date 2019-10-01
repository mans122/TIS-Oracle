--COUNT 로우 수를 반환
select count(*) from employees;
-- *은 null도 포함해서 카운트한다.
select count(employee_id) from employees;
select count(manager_id) from employees; 
-- Column 을 지정해주면 null을 제외한다.

select count(nvl(manager_id,0)) from employees; 
--nvl로 null을 0으로 치환하여 값을 구하면 총row 수를 구할 수 있음.

--SUM,AVG,MAX,MIN
select sum(salary)||'$' from employees;
select round(avg(salary),1) from employees;
select max(salary) from employees;
select min(salary) from employees;

--GROUP BY 
-->특정그룹으로 묶어 데이터 집계 시 사용
-->WHERE 과 ORDER BY사이에 위치,집계함수와 사용
-->Select list에서 집계함수를 제외한 모든 컬럼과 표현식은 GROUP BY 절에 명시해야함

select sum(salary) from employees where job_id='IT_PROG';
select sum(salary) from employees where job_id='SA_MAN';

select job_id,sum(salary) 
from employees 
group by job_id;
select * from employees;

select MAX(salary)
from employees 
group by job_id;

select job_id ,max(salary) as salary
from employees
group by job_id
order by salary;

select  sum(commission_pct)
from employees;

select count(commission_pct) from employees;

select avg(commission_pct) from employees;
select avg(nvl(commission_pct,0)) from employees;

--HAVING은 GROUP BY와 같이사용한다.
--> GROUP BY로 집계한 값을 필터링할때 사용
select department_id, count(*) as counts
from employees
group by department_id
having count(*)<10;

select department_id, round(avg(salary)) as salary
from employees
where department_id is not null
group by department_id 
having avg(salary)>=5000
order by department_id;

select job_id, round(avg(salary)) as salary
from employees
group by job_id
order by salary;

select DISTINCT department_id from employees order by department_id; 
select* from employees where department_id is null;

--ROLLUP(expr1,expr2,......)
-->GROUP BY절에서 사용됨

select * 
from kor_loan_status 
order by period,region,loan_jan_amt;


select period, sum(loan_jan_amt)
from kor_loan_status
group by period
order by period;

select period,gubun, sum(loan_jan_amt)
from kor_loan_status
group by period,gubun;

--ROLLUP 사용
select period,gubun, sum(loan_jan_amt) as total_jan
from kor_loan_status
group by rollup(period,gubun);

select period,gubun, sum(loan_jan_amt) as total_jan
from kor_loan_status
group by rollup(gubun),period;

--CUBE 사용
select nvl(period,'총합'),nvl(gubun,'합계'), sum(loan_jan_amt) as total_jan
from kor_loan_status
group by cube(period,gubun);

select period,gubun, sum(loan_jan_amt) as total_jan
from kor_loan_status
group by cube(gubun),period;

select period,nvl(gubun,''), sum(loan_jan_amt) as total_jan
from kor_loan_status
group by cube(period),gubun;