--���õ���SQL (NDS-Native Dynamic SQL)
begin
    execute immediate 'select employee_id, emp_name, job_id
                        from employees where job_id=''ad_asst'' ';
end;

--������ ���� �־ ��µǵ��� �ۼ�
declare
    --��� ���� ����
    vn_emp_id employees.employee_id%type;
    vs_emp_name employees.emp_name%type;
    vs_job_id employees.job_id%type;
begin
    execute immediate 'select employee_id, emp_name, job_id
                        from employees where job_id = ''AD_ASST'' '
            into vn_emp_id, vs_emp_name, vs_job_id;

    dbms_output.put_line('emp_id : '||vn_emp_id);            
    dbms_output.put_line('emp_name : '||vs_emp_name);
    dbms_output.put_line('job_id : '||vs_job_id);
end;    

-- ���ε� ���� ó�� where���� :������ ���·� ���

declare
    --��� ���� ����
    vn_emp_id employees.employee_id%type;
    vs_emp_name employees.emp_name%type;
    vs_job_id employees.job_id%type;
    
    vs_sql varchar(1000);
    
    --���ε� ���� ����� �� ����
    vs_job employees.job_id%type :='SA_REP';
    vn_sal employees.salary%type :=7000;
    vn_manager employees.manager_id%type:=148;
begin
    vs_sql:='select employee_id,emp_name,job_id
            from employees
            where job_id = :a
            and salary < :a
            and manager_id 6= :c';
                
    --sql������ ������ ������� USING
    Execute immediate vs_sql into vn_emp_id, vs_emp_name, vs_job_id
    USING vs_job, vn_sal, vn_manager;

    dbms_output.put_line('emp_id : '||vn_emp_id);            
    dbms_output.put_line('emp_name : '||vs_emp_name);
    dbms_output.put_line('job_id : '||vs_job_id);
end;    