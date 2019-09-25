--���̺�01 ���� �� oNo,gCode�� ����Ű ����
create table table01(
    oNo number not null,
    gCode number not null,
    oDate date not null,
    
    --�⺻Ű ����¹�:constraint ����Ű�̸� primary key (�÷�,�÷�)
    constraint pk_table01 primary key (oNo,gCode)
);
commit; 

--1���ֹ�
insert into table01 values(1,100,sysdate); 
insert into table01 values(1,200,sysdate); 
commit;

/* ��������
1. Primary Key(�⺻Ű or �� Ű) 
    => �ߺ�����

2. Foreign Key(�ܷ�Ű or ����Ű)
    => �������Ἲ ���� (
*/

--�ܷ�Ű�� �����غ���
create table memberT(
    id varchar2(50) primary key,
    name varchar2(50) not null
);
commit;

insert into memberT values('hkd','�Ѻ���');
insert into memberT values('lss','�̼���');

create table orderT(
    oNo number not null,
    gCode number not null,
-- memberT�� id�� ������� �����ϴ¹�, ������ ������ �̸��� ����.
    id varchar2(50) not null references memberT(id)
);
insert into orderT values(1,100,'hkd');
insert into orderT values(1,200,'lss');
commit;

--���Ἲ�� �����⶧���� memberT�� ���� id������ �ٲܼ� ����.
update orderT set id='lss' where id ='jhb';
commit;

select * from memberT;
delete from memberT where id='hkd';

--cascade ���������� orderT ���̺� ���� �� �ٽû���
drop table orderT;

--on delete cascade >> pk�� ������� fk���� �����
create table orderT(
    oNo number not null,
    gCode number not null,
    id varchar2(50) not null references memberT(id) on delete cascade
    --on update cascade �� ����.
);
insert into memberT values('hkd','�Ѻ���');
delete from memberT where id='hkd';
--memberT�� hkd�� �����ϴ� orderT�� Į������ ���� �����ȴ�.

--���̺� ���� 68p
CREATE TABLE ex2_10(
    Col1 varchar2(10) not null,
    Col2 varchar2(10) null,
    Create_date DATE DEFAULT SYSDATE --DEFAULT > �⺻������ SYSDATE�� �־��
);

select * from ex2_10;
desc ex2_10;

--ALTER�� �̿��ؼ� ex2_10���̺��� COLUMN �̸��� ����
ALTER TABLE ex2_10 RENAME COLUMN COL9 to COL1;
ALTER TABLE ex2_10 modify col2 varchar2(30);

desc ex2_10;

--�÷� �߰�,����
alter table ex2_10 add col3 number;
alter table ex2_10 drop column col3;

--col1 �� pk�� ����,����
alter table ex2_10 add constraint pk_ex2_10 primary key(col1);
alter table ex2_10 drop constraint pk_ex2_10;

--���̺� ����
create table ex2_10_1 as select * from ex2_10;
select * from ex2_10_1;

--���̺� ���ϴ� Į���� ����
create table memberTCopy3
as
select id from memberT where id ='lss';

--������ ���� ���̺����� �����ϱ�
create table memberTcopy4
as
select * from memberT where 1<>1; -- 1!=1 �� �����ϳ� sql���� 1<>1�� ���

select * from memberTcopy4;

--������
create SEQUENCE my_seq1
increment by 1 -- 1������
start with 1 -- 1���� ����
minvalue 1 -- �ּҰ� 1
maxvalue 1000 -- �ִ밪 1000
nocycle -- 1000�������� ��
nocache; -- ĳ�û�� X

drop table ex2_8;

create table ex2_8(
    no number primary key,
    name varchar2(100) not null
);

insert into ex2_8 values (my_seq1.currval,'��浿');
insert into ex2_8 values (my_seq1.nextval,'��浿');
insert into ex2_8 values (my_seq1.nextval,'�̼���');

select * from ex2_8;
create SEQUENCE mySequence01;

create table seqT(
no number,
name varchar2(50)
);

insert into seqT values (mySequence01.nextval,'ȫ�浿');

delete from seqT where name='ȫ�浿';
select * from seqT;
