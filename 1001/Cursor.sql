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