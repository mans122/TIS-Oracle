--패키지
create or replace PACKAGE hr_pkg 
is
    function fn_get_emp_name(pn_employee_id in number)
    return varchar2;
end hr_pkg;

--패키지 본문
create or replace PACKAGE body hr_pkg 
is
    function fn_get_emp_name(pn_employee_id in number)
    return varchar2
    is
        vs_emp_name employees.emp_name%type;
    begin
        select emp_name 
        into vs_emp_name 
        from employees 
        where employee_id = pn_employee_id;
        
        return nvl(vs_emp_name,'해당사원 없음');
    end fn_get_emp_name;
end hr_pkg;

select hr_pkg.fn_get_emp_name(171) from dual;