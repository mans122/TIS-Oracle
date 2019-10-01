select employee_id, emp_name, salary, job_id
from employees
where salary>5000 or job_id='IT_PROG'
order by salary desc;

select department_id as 부서번호,department_name as 부서명 from departments;

select * from employees where employee_id = '200';
select * from employees where employee_id = '101';
select * from employees where employee_id = '100';

select * from memberT;

insert into memberT(id,name) values('wg','왕거니');
insert into memberT values('sjdw','세종대왕');

select * from ex2_10;
insert into ex2_10(col1) values ('ㅁㅁㅁ');
insert into ex2_10 values ('aaa2',null,default);

select * from memberT;

create table outmemberT
as
select * from memberT where 1<>1;

select * from outmemberT;

insert into outmemberT
select * from memberT where id ='sjdw';

update memberT set 
name='고길동',id='gkt'
where id='hkd';

select * from memberT;
delete from memberT where id = 'wg';
rollback;

select rownum, employee_id
from employees;


select employee_id, salary,
    case    when salary<=5000 then 'c'
            when salary>5000 and salary<=15000  then 'b'
            else 'A'
    end as  salary_grade
from employees;

select employee_id, salary,
    case salary when 5000 then 'c'
            when 10000 then 'A'
            when 3000 then 'b'
            else 'd'
    end as  salary_grade
from employees where salary='4000';

select * from employees where manager_id is not null order by employee_id;
select * from employees where salary between 2000 and 5000 order by salary;
select * from employees where salary>=2000 and salary<=5000 order by salary;

select * from employees where job_id='IT_PROG' or job_id='SH_CLERK';
select * from employees where job_id in ('IT_PROG','SH_CLERK');

select *
from employees
where Job_id in (select job_id from employees where salary>10000);

--급여가 2만보다 큰 사람이 존재하면 쿼리를 실행 / 없으면 실행X
select *
from employees
where exists (select * from employees where salary>10000);

select *
from employees
where emp_name like '%a%';