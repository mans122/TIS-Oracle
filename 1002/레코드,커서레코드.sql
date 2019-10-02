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


declare
    vs_emp_name employees.emp_name%type;
    emp_dep_curvar sys_refcursor; --빌트인타입커서 선언
begin
    open emp_dep_curvar for select emp_name
                            from employees
                            where department_id=90;
    
    loop
        fetch emp_dep_curvar into vs_emp_name;
        exit when emp_dep_curvar%notfound; --eof이면 루프종료
        
        dbms_output.put_line(vs_emp_name);
        end loop;
        
    close emp_dep_curvar;
end;

-- 레코드
create table ch11_dep2
as
select * from departments where 1<>1;

declare
    --테이블형 레코드 변수 선언
    vr_dep departments%ROWTYPE;
begin
    --부서테이블의 모든 정보를 레코드 변수에 넣는다.
    select *
    into vr_dep
    from departments
    where department_id=20;
    
    --레코드 변수를 이용해 ch1_dep2테이블에 데이터를 넣는다.
    insert into ch11_dep2 values vr_dep;
    
    commit;
end;

select * from ch11_dep2;

--커서형 레코드
create table ch11_dep(
    department_id    NUMBER(4)
    , department_name  VARCHAR2(30)
    , parent_id number(4)
    , manager_id number(4)
);

declare
    --커서 선언
    cursor c1 
    is
    select department_id, department_name, parent_id, manager_id
    from departments;
    
    --커서형 레코드 변수 선언
    vr_dep c1%rowtype;
begin
    --데이터 삭제 
    delete ch11_dep;
    
    --커서 오픈
    open c1;
    
    --루프를 돌며 vr_dep 레코드 변수에 값을 넣고, 다시 ch11_dep에 insert
    loop
        fetch c1 into vr_dep;
        
        exit when c1%notfound;
        --레코드 변수를 이용해 ch11_dep2 테이블에 데이터를 넣는다.
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


