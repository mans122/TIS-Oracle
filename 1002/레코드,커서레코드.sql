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
    
    
--


declare
    vs_emp_name employees.emp_name%type;
    emp_dep_curvar sys_refcursor; --��Ʈ��Ÿ��Ŀ�� ����
begin
    open emp_dep_curvar for select emp_name
                            from employees
                            where department_id=90;
    
    loop
        fetch emp_dep_curvar into vs_emp_name;
        exit when emp_dep_curvar%notfound; --eof�̸� ��������
        
        dbms_output.put_line(vs_emp_name);
        end loop;
        
    close emp_dep_curvar;
end;

-- ���ڵ�
create table ch11_dep2
as
select * from departments where 1<>1;

declare
    --���̺��� ���ڵ� ���� ����
    vr_dep departments%ROWTYPE;
begin
    --�μ����̺��� ��� ������ ���ڵ� ������ �ִ´�.
    select *
    into vr_dep
    from departments
    where department_id=20;
    
    --���ڵ� ������ �̿��� ch1_dep2���̺� �����͸� �ִ´�.
    insert into ch11_dep2 values vr_dep;
    
    commit;
end;

select * from ch11_dep2;

--Ŀ���� ���ڵ�
create table ch11_dep(
    department_id    NUMBER(4)
    , department_name  VARCHAR2(30)
    , parent_id number(4)
    , manager_id number(4)
);

declare
    --Ŀ�� ����
    cursor c1 
    is
    select department_id, department_name, parent_id, manager_id
    from departments;
    
    --Ŀ���� ���ڵ� ���� ����
    vr_dep c1%rowtype;
begin
    --������ ���� 
    delete ch11_dep;
    
    --Ŀ�� ����
    open c1;
    
    --������ ���� vr_dep ���ڵ� ������ ���� �ְ�, �ٽ� ch11_dep�� insert
    loop
        fetch c1 into vr_dep;
        
        exit when c1%notfound;
        --���ڵ� ������ �̿��� ch11_dep2 ���̺� �����͸� �ִ´�.
        insert into ch11_dep values vr_dep;
        
    end loop;
    
    commit;
end;    

select * from ch11_dep;
delete ch11_dep;


create table ch11_dep
as
select department_id, department_name, parent_id, manager_id
from departments 
where 1<>1;


