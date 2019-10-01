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
