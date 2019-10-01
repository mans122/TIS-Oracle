--round 반올림하기 (실수,반올림할 자리수)
select round(123.456,2) as result from dual;
select round(123.558,2) from dual;

--concat 문자열 합치기=> '문자' || '문자' > '문자 + 문자'
select 'oracl' || 'sql' as result from dual;

--mod 나머지구하기 mod(숫자,나눌숫자)
select mod(9,2) from dual;

--SUBSTR(char,pos,len) : char의 pos번째 문자부터 len길이만큼 자른다.
select substr('ABCDEFG',1,4) from dual;
select substr('ABCDEFG',-5,2) from dual;

--SUBSTRB(char,pos,len) : char의 pos번째 문자부터 바이트단위로 len길이만큼 자른다.
select substrb('가나다라ABCDEFGHI',1,4) from dual;

--trim 모든 공백제거 | ltrim(왼쪽공백제거) | rtrim(오른쪽공백제거)
select 'abc'||trim('     def     ') || 'ghi' from dual;
select 'abc'||ltrim('     def     ') || 'ghi' from dual;
select 'abc'||rtrim('     def     ') || 'ghi' from dual;
--trim이 없는 언어는 l,r 같이사용한다
select 'abc'||ltrim(rtrim('     def     ')) || 'ghi' from dual;

select ltrim('010-1134-5678','010-') from dual;
select ltrim(ltrim('010)1134-5678','010'),'-') from dual;

--lpad 왼쪽부터 자릿수 맞춤
select lpad('abcd',10) as result from dual
union
select lpad('a',10) as result from dual;

--replace 문자 대체
select replace('abcd','ab','**') from dual;

--instr > index위치 반환
select instr('abcdefgabcdefgabcdefg','f') as result1,
       instr('abcdefgabcdefgabcdefg','f',5) as result2,
       instr('abcdefgabcdefgabcdefg','f',1,3) as result3
       from dual;  
select instr('abcdefgabcdefgabcdefg','f',-1,1) as result1 from dual;       
select instr('asjdlqjwe.hwp','.',-1,1) as "확장자" from dual;


--length 길이반환
select length('asdwe2') from dual;
select length('a가마다..e2') from dual;

--reverse 뒤집기
select reverse('asjdlwj.hwp') from dual;

----------------변환함수------------------

--to_char
select add_months(sysdate,1) from dual;
select to_char(sysdate,'yyyy-mm-dd') from dual;
select to_char(sysdate,'dl') from dual;
select to_char(sysdate,'yyyy"년"mm"월"dd"일"') from dual;

--NVL(expr1,expr2) expr1이 null이면 expr2로 반환/같은타입으로

select emp_name, nvl(manager_id,0) from employees;
select emp_name, nvl(commission_pct,0) as commission from employees;

select employee_id, NVL2(commission_pct, salary + ( salary*commission_pct),salary)
as salary2
from employees;

--Greatest
select greatest(20,30,40) from dual;

--Decode
select * from sales where rownum<10;

select prod_id,
decode(channel_id,
            3,'A',
            9,'B',
            5,'C',
            4,'D',
            'F') as decodes
from sales
where rownum<10;



