--COUNT �ο� ���� ��ȯ
select count(*) from employees;
-- *�� null�� �����ؼ� ī��Ʈ�Ѵ�.
select count(employee_id) from employees;
select count(manager_id) from employees; 
-- Column �� �������ָ� null�� �����Ѵ�.

select count(nvl(manager_id,0)) from employees; 
--nvl�� null�� 0���� ġȯ�Ͽ� ���� ���ϸ� ��row ���� ���� �� ����.

--SUM,AVG,MAX,MIN
select sum(salary)||'$' from employees;
select round(avg(salary),1) from employees;
select max(salary) from employees;
select min(salary) from employees;

--GROUP BY 
-->Ư���׷����� ���� ������ ���� �� ���
-->WHERE �� ORDER BY���̿� ��ġ,�����Լ��� ���
-->Select list���� �����Լ��� ������ ��� �÷��� ǥ������ GROUP BY ���� ����ؾ���

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

--HAVING�� GROUP BY�� ���̻���Ѵ�.
--> GROUP BY�� ������ ���� ���͸��Ҷ� ���
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
-->GROUP BY������ ����

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

--ROLLUP ���
select period,gubun, sum(loan_jan_amt) as total_jan
from kor_loan_status
group by rollup(period,gubun);

select period,gubun, sum(loan_jan_amt) as total_jan
from kor_loan_status
group by rollup(gubun),period;

--CUBE ���
select nvl(period,'����'),nvl(gubun,'�հ�'), sum(loan_jan_amt) as total_jan
from kor_loan_status
group by cube(period,gubun);

select period,gubun, sum(loan_jan_amt) as total_jan
from kor_loan_status
group by cube(gubun),period;

select period,nvl(gubun,''), sum(loan_jan_amt) as total_jan
from kor_loan_status
group by cube(period),gubun;