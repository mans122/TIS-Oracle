/*
����ŬDB�� TABLESPACE�� �����������
myts��� �̸����� 100MBũ���� �����Ұ���. ���⼭�� ����Ŭ�� ��ġ��C:\app\1class-014\oradata\myoracle������ myts.dbf���
�̸����� ������ ����.�׸��� �������� ����� �ڵ����� 5mb�� �����ϴ� �ɼ� AUTOEXTEND �� �߰��Ұ�.
--�Է�--
CREATE TABLESPACE myts DATAFILE
'C:\app\1class-014\oradata\myoracle\myts.dbf' SIZE 100M AUTOEXTEND ON NEXT 5M;

����� �����ϱ� 
--�Է�--
CREATE USER ora_user IDENTIFIED BY hong
DEFAULT TABLESPACE myts
TEMPORARY TABLESPACE temp;

����(��,Role) �ο��ϱ� | DBA(�����ͺ��̽�������)������ ora_user���� �ش�
--�Է�--
GRANT DBA TO ora_user

���ý�Ű�� ��ġ
1.http://github.com/gilbutitbook/006696  �� ���� expall.dmp �� expcust.dmp �ٿ�޴´�. > ���� �뤊�� �޾Ƽ� �ȿ��ִ°Ÿ� ����
2.C: �� backup ������ �ϳ� �����ϰ� ���� ������ ��ġ��Ų��.
3.���â�� ���� ��ġ�� C:\backup���� �̵��Ѵ�.
 -- win+R > cmd �Է� > cd C:\backup > ����
4. imp ora_user/hong file=expall.dmp log=empall.log ignore=y grants=y rows=y indexes=y full=y �Է�
5. imp ora_user/hong file=expcust.dmp log=expcust.log ignore=y grants=y rows=y indexes=y full=y �Է�

SQL Developer���� ���������� �����غ���
--�Է�--
SELECT table_name FROM user_tables;
*/
--���--
--TABLE_NAME
------------
--CUSTOMERS
--SALES2
--SALES
--,,, 
------------

--���� ���̺��� ������
--�Է�--
create table mytable(
    id varchar2(100) primary key,
    name varchar2(50) not null
    );

--���̺� ������ �־�����
--�Է�--
insert into mytable values('hkd','ȫ�浿');

--commit���� �������� �������. 
--�Է�--
commit;


--�������� table�� ����� ����.
--�Է�--
create table ex2_2(
    column1 varchar2(3),
    column2 varchar2(3 byte),
    column3 varchar2(3 char)
    ); --ex2_2��� ���̺��� ����� ������Ÿ���� varchar�� �����ؼ� 3������
--���� �Է�--
commit;

--�Է�--
insert into ex2_2 values('abc','abc','abc'); --ex2_2���̺� ���� ���� ������� �־���

--�����Է�--
commit;

--�Է�--
select * from ex2_2; --ex2_2 ���̺��� ������� ǥ��

create table ex2_3(
    col_int integer,
    col_dec decimal,
    col_num number
    );

commit;
insert into ex2_3 values(10,20,30);
commit;

select column_id, column_name, data_type, data_length
from user_tab_cols 
where table_name ='EX2_3' 
order by column_id;


--��¥ ������ Ÿ��
--date�� timestamp�� ����
--�Է�--
select sysdate from dual;
select systimestamp from dual;

--���� 2_5
--�Է�--
create table ex2_5(
    col_date        date,
    col_timestamp   timestamp
    );
commit;
insert into ex2_5 values (sysdate, systimestamp);
commit;
select * from ex2_5;




create table ex2_5(
    col_date        date,
    col_timestamp   timestamp
    );
commit;
insert into ex2_5 values (sysdate, systimestamp);
commit;
select * from ex2_5;

insert into ex2_5 values (sysdate, systimestamp);

--��������--
--1.NOT NULL

create Table ex2_6(
    col_null    varchar2(10),
    col_not_null    varchar2(10) not null
    );
commit;

--ex2_6table�� col_not_null �÷��� 10 �Է�
insert into ex2_6(col_not_null) values(10);
commit;

--ex2_6table�� null �÷��� 10 �Է�
insert into ex2_6(null) values(10);
--col_not_null�� null ���� ����

--ex2_6 TABLE �� Į���� ���� ������� 'aa','' �Է�
insert into ex2_6 values ('aa','');
--not null �� �����ߴµ� ������ �Է��ؼ� ������ �߻�

insert into ex2_6 values ('aa','bb');
commit;
    
select * from ex2_6;

--�⺻Ű
create table ex2_8(
    col1 varchar2(10)   primary key,
    col2 varchar2(10)
    );

commit;

select constraint_name, constraint_type, table_name, search_condition
from user_constraints
where table_name = 'EX2_8';

--pk�� ''�Է½� �����߻�
insert into EX2_8 values('','aa');

--col1,2�� ���� �־��ش�
insert into EX2_8 values('aa','aa');
commit;
-- �Ȱ��� ���� �ѹ��� �������Ѵٸ� ���Ἲ �������� ������ ���� ���

