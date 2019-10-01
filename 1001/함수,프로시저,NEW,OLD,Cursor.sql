declare
    vi_num number:=0;
begin
    vi_num :=10/0;
    DBMS_OUTPUT.PUT_LINE('success!');
    
    exception when others then
        DBMS_OUTPUT.PUT_LINE('������ �߻��߽��ϴ�.');
end;        


create or replace procedure ch10_raise_test_proc(p_num NUMBER)
is
begin
    if p_num<=0 then 
        --raise invalid_number;
        RAISE_APPLICATION_ERROR(-20000, '������ȴٰ� ');
    end if;
    DBMS_OUTPUT.PUT_LINE(p_num);
    
    exception
    when invalid_number then
        DBMS_OUTPUT.PUT_LINE('����� �Է¹��� �� �ֽ��ϴ�.');
    when others then
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        DBMS_OUTPUT.PUT_LINE(SQLCODE);
end;        

execute ch10_raise_test_proc(-10);



-- Trigger

-- 18:00 ~19:00 ���̰� �ƴ� ��� ���� �߻���Ű�� Ʈ����

create or replace trigger t_order
before insert on ordersJungsan --before,after,instead of
begin
    if(to_char(sysdate,'HH24:MI') not between '18:00' and '19:00') then
        raise_application_error(-20100,'���ð��� �ƴմϴ�.');
    end if;        
end;

select * from ordersJungsan;

EXECUTE proc_jungsan;


-------------------------------------------------------------------------
create table triggerT1(
    name varchar2(50),
    age number
);
insert into triggerT1 values('ȫ�浿',20);
insert into triggerT1 values('�̼���',30);
insert into triggerT1 values('�հ�',30);

create table triggerT2(
    joindate date
);


--1.after trigger
create or replace trigger tr1
after insert on triggerT1
begin 
    insert into triggerT2 values(sysdate);
    raise_application_error(-20101,'����������������');
end;

insert into triggerT1 values('������',70);

select * from triggerT1;
select * from triggerT2;

--2.before trigger
create or replace trigger tr2
before insert on triggerT1
begin
    insert into triggerT2 values(sysdate);
end;
insert into triggerT1 values('��������',80);


-- NEW / OLD ���̺�
create or replace trigger tr3
after insert on triggerT1
for each row -- new/old ����Ϸ��� for each row �ɼ��� ��������� (�� ���� Ʈ����)
begin 
    insert into triggerT2 values(sysdate);
    --new ���̺�
    DBMS_OUTPUT.PUT_LINE(:new.name);
    DBMS_OUTPUT.PUT_LINE(:new.age);
end;

drop trigger tr1;
drop trigger tr2;

insert into triggerT1 values('¡�⽺ĭ',20);

--update�� new,old �Ѵ� ����
create or replace trigger tr4
after update on triggerT1
for each row -- new/old ����Ϸ��� for each row �ɼ��� ��������� (�� ���� Ʈ����)
begin 
    insert into triggerT2 values(sysdate);
     --old ���̺�
    DBMS_OUTPUT.PUT_LINE('���� �� : '||:old.name ||' '|| :old.age);
    DBMS_OUTPUT.PUT_LINE('==============');
    --new ���̺�
    DBMS_OUTPUT.PUT_LINE('���� �� : '||:new.name ||' '|| :new.age);
end;

select * from triggerT1;

update triggerT1 set name='ȫ�浿',age=51 where name='ȫ�浿';

--Ŀ�� �⺻����--
declare
    --������� �޾ƿ������� ���� ����
    vs_emp_name employees.emp_name%type;
    
    --Ŀ�� ����,�Ű������� �μ��ڵ带 �ޱ�
    cursor cur_emp_dep (cp_department_id employees.department_id%type)
    is
    select emp_name
    from employees
    where department_id = cp_department_id;
begin
    --Ŀ�� ����(�Ű������� 90�� �μ��� ����)
    open cur_emp_dep(90);
    
    --�ݺ����� ���� Ŀ�� ��ġ �۾�
    loop
        --Ŀ�� ����� ���� �ο츦 ��ġ��(������� ������ �Ҵ�)
        --FETCH Ŀ���̸� INTO ������... (select�� �÷����� into ���� ���� ������ ��ġ�ؾ���)
        fetch cur_emp_dep into vs_emp_name;
        
        --��ġ�� ���� �ο찡 �� ������ loopŻ��
        exit when cur_emp_dep%notfound; -- EOF�̸� (end of file)
        
        --����� ���
        dbms_output.put_line(vs_emp_name);
    end loop;
    --�ݺ��� ���� �� Ŀ�� �ݱ�
    close cur_emp_dep;
end;    
    
