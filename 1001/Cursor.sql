--커서 기본문법--
declare
    --사원명을 받아오기위한 변수 선언
    vs_emp_name employees.emp_name%type;
    
    --커서 선언,매개변수로 부서코드를 받기
    cursor cur_emp_dep (cp_department_id employees.department_id%type)
    is
    select emp_name
    from employees
    where department_id = cp_department_id;
begin
    --커서 오픈(매개변수로 90번 부서를 전달)
    open cur_emp_dep(90);
    
    --반복문을 통한 커서 패치 작업
    loop
        --커서 결과로 나온 로우를 패치함(사원명을 변수에 할당)
        --FETCH 커서이름 INTO 변수명... (select의 컬럼수랑 into 뒤의 변수 개수랑 일치해야함)
        fetch cur_emp_dep into vs_emp_name;
        
        --패치된 참조 로우가 더 없으면 loop탈출
        exit when cur_emp_dep%notfound; -- EOF이면 (end of file)
        
        --사원명 출력
        dbms_output.put_line(vs_emp_name);
    end loop;
    --반복문 종료 후 커서 닫기
    close cur_emp_dep;
end;    
    
    
--