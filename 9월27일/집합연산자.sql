--�������� 
select e.employee_id �����ȣ, e.emp_name ����̸�, e.department_id �μ���ȣ, d.department_name �μ��̸�
from employees e, departments d
where e.department_id = d.department_id 
order by e.employee_id;

-- ANSI join
select e.employee_id �����ȣ, e.emp_name ����̸�, e.department_id �μ���ȣ, d.department_name �μ��̸�
from employees e inner join departments d
on e.department_id = d.department_id
where d.deparment_id>30
order by e.employee_id;


select e.employee_id �����ȣ, e.emp_name ����̸�, e.department_id �μ���ȣ, d.department_name �μ��̸�
from employees e, departments d
where e.department_id = d.department_id
and d.department_id>30 
and d.department_name ='��ȹ��'
order by e.employee_id;


-----------------------------------------------------------------------------
create table members(
    id varchar2(50) primary key,
    name varchar2(50) not null,
    dept_id varchar2(50) not null,
    dongari_id varchar2(50)
);
    
    insert into members values('hkd','ȫ�浿','0001','0001');
    insert into members values('lss','�̼���','0002','0002');
    insert into members values('wg','�հ�','0002',null);
    
create table dept(
    dept_id varchar2(50) primary key,
    dept_name varchar2(50) not null
);

insert into dept values('0001','��ǻ�Ͱ��а�');
insert into dept values('0002','ö�а�');

create table dongari(
    dongari_id varchar2(50) primary key,
    dongari_name varchar2(50) not null
);

insert into dongari values('0001','â�����Ƹ�');
insert into dongari values('0002','���ֵ��Ƹ�');
insert into dongari values('0003','�籸���Ƹ�');

--INNER JOIN�� �����ո� ���
select members.name,dongari.dongari_name
from members, dongari
where members.dongari_id=dongari.dongari_id;

--LEFT OUTER JOIN ���ʱ��� ������ > �ڿ����� Column�� �ڿ� (+)�� �ٿ��ش�
select members.name,dongari.dongari_name
from members, dongari
where members.dongari_id=dongari.dongari_id(+);

--RIGHT OUTER JOIN �����ʱ��� ��� ��� > �տ����� Column�� �ڿ� (+)�� �ٿ��ش�
select members.name,dongari.dongari_name
from members, dongari
where members.dongari_id(+)=dongari.dongari_id;

--FULL OUTER JOIN
select members.name, dongari.dongari_name
from members full outer join dongari
on members.dongari_id=dongari.dongari_id;

--�л���,�а���,���Ƹ��� ����ϰ����
select members.name �л��̸�, dept.dept_id ���Ƹ���ȣ, dongari.dongari_name ���Ƹ��̸�
from members, dept, dongari
where members.dept_id = dept.dept_id
and members.dongari_id = dongari.dongari_id;

--VIEW �����
create or replace view v1
as
select members.name �л��̸�, dept.dept_id ���Ƹ���ȣ, dongari.dongari_name ���Ƹ�
from members, dept, dongari
where members.dept_id = dept.dept_id
and members.dongari_id = dongari.dongari_id;

select * from v1;










select m.name �л��̸�, d.dept_id ���Ƹ���ȣ, do.dongari_name ���Ƹ��̸�
from members m inner join dept d
on m.dept_id = d.dept_id
inner join dongari do
on m.dongari_id = do.dongari_id;

select * from employees;

select e1.employee_id �����ȣ, e1.emp_name �����̸�, e2.emp_name �Ŵ����̸�
from employees e1, employees e2
where e1.manager_id = e2.employee_id
order by e1.employee_id;


create table category(
    c_no varchar2(10) primary key,
    c_name varchar2(50) not null,
    c_parent_no varchar2(10),
    c_depth number not null
);
insert into category values('0001','����',null,2);
insert into category values('1001','TV','0001',2);
insert into category values('1002','����Ʈ��','0001',2);

insert into category values('2001','��','0002',2);
insert into category values('2002','����','0002',2);

select * from category where c_depth=1;
select * from category where c_parent_no=0001;

select c1.c_no,c1.c_name,c2.c_name
from category c1 inner join category c2
on c1.c_parent_no = c2.c_no;

--FULL OUTER JOIN�� ANSI SQL�θ� �ۼ�����


select emp_name,salary 
from employees 
where salary >= (select avg(salary) from employees)
order by salary;

----�Ϲ����� ��������
--> ����(�Ʒ�)�������� ���� �� �ٱ�(��) ������ �����

----�������� ��������
--> �ٱ� ������ ���̺��� �� �྿ ���������� ���޵Ǿ� ���������� �����.
--  �ٱ����� ���̺��� ��� �࿡ ���ؼ� �۾��� ������ �ٱ� ������ order by ���� ����Ǿ� �ϼ���

--������ ���� ��������
select count(*)
from employees
where department_id in( select department_id 
                        from departments
                        where parent_id is not null
                        );
                        
-- ������ �ִ� �������� > �ٱ��� ���̺�� ���������̺��� ���ϸ� �������� �ִ°Ŵ�
--> ���κ��� �ӵ��� ������, join�� ����ϴ�
select a.department_id, a.department_name
from departments a
where exists    (select 1  
                from job_history b
                where a.department_id = b.department_id);

--�ζ��� ��
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
insert into salesAsia values('5','�ҳ�Ÿ','10',default);
insert into salesAsia values('6','�׷���','20',default);
insert into salesAsia values('7','��Ÿ��','30',default);
insert into salesAsia values('8','���׽ý�','40',default);

create table salesEurope(
    sNo number primary key,
    carName varchar2(20) not null,
    ea number not null,
    saleDate date default sysdate
);

insert into salesEurope values('15','�ҳ�Ÿ','10',default);
insert into salesEurope values('16','�׷���','20',default);
insert into salesEurope values('17','��Ÿ��','30',default);
insert into salesEurope values('18','���׽ý�','40',default);

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
select department_id,count(*) as ��
from employees
where department_id >= 100
group by department_id;

select '100' as department_id, count(*) as ��
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

--LISTAGG�� ���� �ǹ� ���� ( �ο�>Į��)
select department_id,listagg(emp_name,',')within group (order by emp_name) as empnames
from employees
where department_id is not null
group by department_id;
