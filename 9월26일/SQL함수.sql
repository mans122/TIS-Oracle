--round �ݿø��ϱ� (�Ǽ�,�ݿø��� �ڸ���)
select round(123.456,2) as result from dual;
select round(123.558,2) from dual;

--concat ���ڿ� ��ġ��=> '����' || '����' > '���� + ����'
select 'oracl' || 'sql' as result from dual;

--mod ���������ϱ� mod(����,��������)
select mod(9,2) from dual;

--SUBSTR(char,pos,len) : char�� pos��° ���ں��� len���̸�ŭ �ڸ���.
select substr('ABCDEFG',1,4) from dual;
select substr('ABCDEFG',-5,2) from dual;

--SUBSTRB(char,pos,len) : char�� pos��° ���ں��� ����Ʈ������ len���̸�ŭ �ڸ���.
select substrb('�����ٶ�ABCDEFGHI',1,4) from dual;

--trim ��� �������� | ltrim(���ʰ�������) | rtrim(�����ʰ�������)
select 'abc'||trim('     def     ') || 'ghi' from dual;
select 'abc'||ltrim('     def     ') || 'ghi' from dual;
select 'abc'||rtrim('     def     ') || 'ghi' from dual;
--trim�� ���� ���� l,r ���̻���Ѵ�
select 'abc'||ltrim(rtrim('     def     ')) || 'ghi' from dual;

select ltrim('010-1134-5678','010-') from dual;
select ltrim(ltrim('010)1134-5678','010'),'-') from dual;

--lpad ���ʺ��� �ڸ��� ����
select lpad('abcd',10) as result from dual
union
select lpad('a',10) as result from dual;

--replace ���� ��ü
select replace('abcd','ab','**') from dual;

--instr > index��ġ ��ȯ
select instr('abcdefgabcdefgabcdefg','f') as result1,
       instr('abcdefgabcdefgabcdefg','f',5) as result2,
       instr('abcdefgabcdefgabcdefg','f',1,3) as result3
       from dual;  
select instr('abcdefgabcdefgabcdefg','f',-1,1) as result1 from dual;       
select instr('asjdlqjwe.hwp','.',-1,1) as "Ȯ����" from dual;


--length ���̹�ȯ
select length('asdwe2') from dual;
select length('a������..e2') from dual;

--reverse ������
select reverse('asjdlwj.hwp') from dual;

----------------��ȯ�Լ�------------------

--to_char
select add_months(sysdate,1) from dual;
select to_char(sysdate,'yyyy-mm-dd') from dual;
select to_char(sysdate,'dl') from dual;
select to_char(sysdate,'yyyy"��"mm"��"dd"��"') from dual;

--NVL(expr1,expr2) expr1�� null�̸� expr2�� ��ȯ/����Ÿ������

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



