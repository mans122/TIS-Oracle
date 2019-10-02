 --사용자 정의 테이블 함수
 create or replace type ch14_num_nt is table of number;

--ch14_num_nt 컬렉션을 반환하는 함수 작성 
create or replace function fn_ch14_table1 (p_n number)
    return ch14_num_nt
is
    --컬렉션 변수 선언(컬렉션 타입이므로 초기화를 한다.)
    vnt_return ch14_num_nt := ch14_num_nt();
begin
    --1부터 입력매개변수인 p_n만큼 숫자 넣기
    for i in 1..p_n
    loop
        vnt_return.EXTEND;
        vnt_return(i) := i;
    end loop;
    
    return vnt_return;
end;    

select fn_ch14_table1(20) from dual;

select * from table(fn_ch14_table1(20));