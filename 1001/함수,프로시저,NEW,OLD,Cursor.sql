declare
    vi_num number:=0;
begin
    vi_num :=10/0;
    DBMS_OUTPUT.PUT_LINE('success!');
    
    exception when others then
        DBMS_OUTPUT.PUT_LINE('오류가 발생했습니다.');
end;        


create or replace procedure ch10_raise_test_proc(p_num NUMBER)
is
begin
    if p_num<=0 then 
        --raise invalid_number;
        RAISE_APPLICATION_ERROR(-20000, '양수만된다고 ');
    end if;
    DBMS_OUTPUT.PUT_LINE(p_num);
    
    exception
    when invalid_number then
        DBMS_OUTPUT.PUT_LINE('양수만 입력받을 수 있습니다.');
    when others then
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        DBMS_OUTPUT.PUT_LINE(SQLCODE);
end;        

execute ch10_raise_test_proc(-10);



-- Trigger

-- 18:00 ~19:00 사이가 아닌 경우 에러 발생시키는 트리거

create or replace trigger t_order
before insert on ordersJungsan --before,after,instead of
begin
    if(to_char(sysdate,'HH24:MI') not between '18:00' and '19:00') then
        raise_application_error(-20100,'허용시간이 아닙니다.');
    end if;        
end;

select * from ordersJungsan;

EXECUTE proc_jungsan;


-------------------------------------------------------------------------
create table triggerT1(
    name varchar2(50),
    age number
);
insert into triggerT1 values('홍길동',20);
insert into triggerT1 values('이순신',30);
insert into triggerT1 values('왕건',30);

create table triggerT2(
    joindate date
);


--1.after trigger
create or replace trigger tr1
after insert on triggerT1
begin 
    insert into triggerT2 values(sysdate);
    raise_application_error(-20101,'에러에러에러에러');
end;

insert into triggerT1 values('강감찬',70);

select * from triggerT1;
select * from triggerT2;

--2.before trigger
create or replace trigger tr2
before insert on triggerT1
begin
    insert into triggerT2 values(sysdate);
end;
insert into triggerT1 values('을지문덕',80);


-- NEW / OLD 테이블
create or replace trigger tr3
after insert on triggerT1
for each row -- new/old 사용하려면 for each row 옵션을 적어줘야함 (행 레벨 트리거)
begin 
    insert into triggerT2 values(sysdate);
    --new 테이블
    DBMS_OUTPUT.PUT_LINE(:new.name);
    DBMS_OUTPUT.PUT_LINE(:new.age);
end;

drop trigger tr1;
drop trigger tr2;

insert into triggerT1 values('징기스칸',20);

--update는 new,old 둘다 존재
create or replace trigger tr4
after update on triggerT1
for each row -- new/old 사용하려면 for each row 옵션을 적어줘야함 (행 레벨 트리거)
begin 
    insert into triggerT2 values(sysdate);
     --old 테이블
    DBMS_OUTPUT.PUT_LINE('변경 전 : '||:old.name ||' '|| :old.age);
    DBMS_OUTPUT.PUT_LINE('==============');
    --new 테이블
    DBMS_OUTPUT.PUT_LINE('변경 후 : '||:new.name ||' '|| :new.age);
end;

select * from triggerT1;

update triggerT1 set name='홍길동',age=51 where name='홍길동';

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
    
