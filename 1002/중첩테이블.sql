declare
    type av_type is table of varchar2(40)
                    index by pls_integer; --pl/sql에서 지원하는 정수형타입
                    
    vav_test av_type;
    
begin
    
    vav_test(10):= '10에 대한 값';
    vav_test(20):= '20에 대한 값';
    
    dbms_output.put_line(vav_test(10));
    dbms_output.put_line(vav_test(20));
end;

--varray

declare
    type va_type is varray(5) of varchar2(20);
    --varray 변수 선언
    vva_test va_type;

    vn_cnt number:=0;
begin
    --생성자를 사용해 값 할당
    vva_test:=va_type('fisrt','second','third','','');
    
    loop
        vn_cnt := vn_cnt+1;
        if vn_cnt > 5 then
            exit;
        end if;            
        dbms_output.put_line(vva_test(vn_cnt));
    end loop;
    
    vva_test(2) := 'TEST';
    vva_test(4) := 'FOURTH';
    
    vn_cnt:=0;
    loop
        vn_cnt := vn_cnt+1;
        if vn_cnt > 5 then
            exit;
        end if;            
        dbms_output.put_line(vva_test(vn_cnt));
    end loop;
end;    

--중첩테이블

declare
    --중첩테이블 선언
    type nt_typ is table of varchar2(10);
    
    --변수 선언
    vnt_test nt_typ;
begin
    --생성자를 사용해 값 할당
    vnt_test := nt_typ('first','second','third');
    
    --값 출력
    dbms_output.put_line(vnt_test(1));
    dbms_output.put_line(vnt_test(2));
    dbms_output.put_line(vnt_test(3));
END;    

