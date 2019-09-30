`--PL/SQL 데이터 타입 BOOLEAN,PLS_INTEGER,BINARY_INTEGER
--상수 선언 
--> 상수명 CONSTANT 데이터타입 := 상수값;

set serverout on;

declare
    vi_num number;
begin
    vi_num:=100;
    dbms_output.put_line(vi_num);
end;

--DML문 267p,268p
DECLARE
    vs_emp_name employees.emp_name%TYPE;
    vs_dep_name departments.department_name%TYPE;
BEGIN
    select  a.emp_name, b.department_name
    INTO    vs_emp_name, vs_dep_name
    from    employees a, departments b
    where   a.department_id = b.department_id
    and     a.employee_id = 100;
    DBMS_OUTPUT.put_line(vs_emp_name || ' - ' || vs_dep_name);
END;    

--9장 PL/SQL 제어문
declare
    vn_base_num number  :=3;
    vn_cnt      number  :=1;
begin
    loop
        dbms_output.put_line(vn_base_num || '*' || vn_cnt || '=' ||vn_base_num*vn_cnt);
        vn_cnt:=vn_cnt+1;
        exit when vn_cnt>9;
    end loop;
end;    