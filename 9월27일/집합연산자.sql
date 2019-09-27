--동등조인 
select e.employee_id 사원번호, e.emp_name 사원이름, e.department_id 부서번호, d.department_name 부서이름
from employees e, departments d
where e.department_id = d.department_id 
order by e.employee_id;

-- ANSI join
select e.employee_id 사원번호, e.emp_name 사원이름, e.department_id 부서번호, d.department_name 부서이름
from employees e inner join departments d
on e.department_id = d.department_id
where d.deparment_id>30
order by e.employee_id;


select e.employee_id 사원번호, e.emp_name 사원이름, e.department_id 부서번호, d.department_name 부서이름
from employees e, departments d
where e.department_id = d.department_id
and d.department_id>30 
and d.department_name ='기획부'
order by e.employee_id;


-----------------------------------------------------------------------------
create table members(
    id varchar2(50) primary key,
    name varchar2(50) not null,
    dept_id varchar2(50) not null,
    dongari_id varchar2(50)
);
    
    insert into members values('hkd','홍길동','0001','0001');
    insert into members values('lss','이순신','0002','0002');
    insert into members values('wg','왕건','0002',null);
    
create table dept(
    dept_id varchar2(50) primary key,
    dept_name varchar2(50) not null
);

insert into dept values('0001','컴퓨터공학과');
insert into dept values('0002','철학과');

create table dongari(
    dongari_id varchar2(50) primary key,
    dongari_name varchar2(50) not null
);

insert into dongari values('0001','창업동아리');
insert into dongari values('0002','음주동아리');
insert into dongari values('0003','당구동아리');

--INNER JOIN은 교집합만 출력
select members.name,dongari.dongari_name
from members, dongari
where members.dongari_id=dongari.dongari_id;

--LEFT OUTER JOIN 왼쪽기준 모두출력 > 뒤에오는 Column명 뒤에 (+)를 붙여준다
select members.name,dongari.dongari_name
from members, dongari
where members.dongari_id=dongari.dongari_id(+);

--RIGHT OUTER JOIN 오른쪽기준 모두 출력 > 앞에오는 Column명 뒤에 (+)를 붙여준다
select members.name,dongari.dongari_name
from members, dongari
where members.dongari_id(+)=dongari.dongari_id;

--FULL OUTER JOIN
select members.name, dongari.dongari_name
from members full outer join dongari
on members.dongari_id=dongari.dongari_id;

--학생명,학과명,동아리명 출력하고싶음
select members.name 학생이름, dept.dept_id 동아리번호, dongari.dongari_name 동아리이름
from members, dept, dongari
where members.dept_id = dept.dept_id
and members.dongari_id = dongari.dongari_id;

--VIEW 만들기
create or replace view v1
as
select members.name 학생이름, dept.dept_id 동아리번호, dongari.dongari_name 동아리
from members, dept, dongari
where members.dept_id = dept.dept_id
and members.dongari_id = dongari.dongari_id;

select * from v1;










select m.name 학생이름, d.dept_id 동아리번호, do.dongari_name 동아리이름
from members m inner join dept d
on m.dept_id = d.dept_id
inner join dongari do
on m.dongari_id = do.dongari_id;

select * from employees;

select e1.employee_id 사원번호, e1.emp_name 직원이름, e2.emp_name 매니저이름
from employees e1, employees e2
where e1.manager_id = e2.employee_id
order by e1.employee_id;


create table category(
    c_no varchar2(10) primary key,
    c_name varchar2(50) not null,
    c_parent_no varchar2(10),
    c_depth number not null
);
insert into category values('0001','전자',null,2);
insert into category values('1001','TV','0001',2);
insert into category values('1002','스마트폰','0001',2);

insert into category values('2001','빵','0002',2);
insert into category values('2002','우유','0002',2);

select * from category where c_depth=1;
select * from category where c_parent_no=0001;

select c1.c_no,c1.c_name,c2.c_name
from category c1 inner join category c2
on c1.c_parent_no = c2.c_no;

--FULL OUTER JOIN은 ANSI SQL로만 작성가능


select emp_name,salary 
from employees 
where salary >= (select avg(salary) from employees)
order by salary;

----일반적인 서브쿼리
--> 안쪽(아래)쿼리부터 실행 후 바깥(위) 쿼리가 실행됨

----연관관계 서브쿼리
--> 바깥 쿼리의 테이블에서 한 행씩 안쪽쿼리에 전달되어 안쪽쿼리가 실행됨.
--  바깥쿼리 테이블의 모든 행에 대해서 작업이 끝나면 바깥 쿼리의 order by 등이 적용되어 완성됨

--연관성 없는 서브쿼리
select count(*)
from employees
where department_id in( select department_id 
                        from departments
                        where parent_id is not null
                        );
                        
-- 연관성 있는 서브쿼리 > 바깥의 테이블과 안쪽의테이블을 비교하면 연관성이 있는거다
--> 조인보다 속도가 느리다, join과 비슷하다
select a.department_id, a.department_name
from departments a
where exists    (select 1  
                from job_history b
                where a.department_id = b.department_id);

--인라인 뷰
select a.employee_id, a.emp_name, departments.department_name
from (select * from employees where salary>5000) a, departments
where a.department_id = departments.department_id;

select substr(sales_month,1,4) as year,sum(amount_sold) as sum,max(amount_sold) max
from sales
group by substr(sales_month,1,4);
select sales_month from sales;
select substr(sales_month,1,4) as year,max(amount_sold) max
from sales
group by substr(sales_month,1,4);

select s.cust_city,s.country_id,c.country_name
from customers s,countries c
where s.country_id = (select country_id from countries where country_name ='Italy')
order by country_name;

select * from customers;
select * from countries where country_name = 'Italy';

select a.emp_name,a.salary,d.department_name
from (select * from employees 
    where salary =(select max(salary)
    from employees)) a,departments d
where a.department_id = d.department_id;
    
create table salesAsia(
    sNo number primary key,
    carName varchar2(20) not null,
    ea number not null,
    saleDate date default sysdate
);
insert into salesAsia values('5','소나타','10',default);
insert into salesAsia values('6','그랜져','20',default);
insert into salesAsia values('7','싼타페','30',default);
insert into salesAsia values('8','제네시스','40',default);

create table salesEurope(
    sNo number primary key,
    carName varchar2(20) not null,
    ea number not null,
    saleDate date default sysdate
);

insert into salesEurope values('15','소나타','10',default);
insert into salesEurope values('16','그랜져','20',default);
insert into salesEurope values('17','싼타페','30',default);
insert into salesEurope values('18','제네시스','40',default);

select a.carName,sum(a.ea) as sells
from (select * from salesAsia
        union
        select * from salesEurope) a
group by a.carName
order by sells desc;

create table myt(
    a number,
    b number,
    c number,
    d number
);



insert into myt
select 1,2,3,4 from dual
union all
select 1,2,3,4 from dual;


create or replace view v2
as
select employees.employee_id, employees.emp_name,departments.department_name,employees.manager_id
from employees,departments
where employees.department_id = departments.department_id 
order by departments.department_id;

select v2.*,employees.emp_name
from v2,employees
where v2.manager_id = employees.employee_id;

--PIVOT
select department_id,count(*) as 명
from employees
where department_id >= 100
group by department_id;

select '100' as department_id, count(*) as 명
from employees
where department_id=100;


select
(select  count(*)
from employees
where department_id=100) "100",
(select  count(*)
from employees
where department_id=110) "110"
from dual;

--LISTAGG를 통한 피벗 구현 ( 로우>칼럼)
select department_id,listagg(emp_name,',')within group (order by emp_name) as empnames
from employees
where department_id is not null
group by department_id;
