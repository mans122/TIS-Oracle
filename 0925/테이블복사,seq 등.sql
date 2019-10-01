--테이블01 생성 및 oNo,gCode로 복합키 생성
create table table01(
    oNo number not null,
    gCode number not null,
    oDate date not null,
    
    --기본키 만드는법:constraint 복합키이름 primary key (컬럼,컬럼)
    constraint pk_table01 primary key (oNo,gCode)
);
commit; 

--1번주문
insert into table01 values(1,100,sysdate); 
insert into table01 values(1,200,sysdate); 
commit;

/* 제약조건
1. Primary Key(기본키 or 주 키) 
    => 중복방지

2. Foreign Key(외래키 or 참조키)
    => 참조무결성 유지 (
*/

--외래키를 지정해보자
create table memberT(
    id varchar2(50) primary key,
    name varchar2(50) not null
);
commit;

insert into memberT values('hkd','한별정');
insert into memberT values('lss','이순신');

create table orderT(
    oNo number not null,
    gCode number not null,
-- memberT의 id를 약식으로 참조하는법, 단점은 지정된 이름이 없다.
    id varchar2(50) not null references memberT(id)
);
insert into orderT values(1,100,'hkd');
insert into orderT values(1,200,'lss');
commit;

--무결성이 깨지기때문에 memberT에 없는 id값으로 바꿀수 없음.
update orderT set id='lss' where id ='jhb';
commit;

select * from memberT;
delete from memberT where id='hkd';

--cascade 지정을위해 orderT 테이블 지운 후 다시생성
drop table orderT;

--on delete cascade >> pk값 사라지면 fk값도 사라짐
create table orderT(
    oNo number not null,
    gCode number not null,
    id varchar2(50) not null references memberT(id) on delete cascade
    --on update cascade 도 있음.
);
insert into memberT values('hkd','한별정');
delete from memberT where id='hkd';
--memberT의 hkd을 참조하는 orderT의 칼럼들이 같이 삭제된다.

--테이블 변경 68p
CREATE TABLE ex2_10(
    Col1 varchar2(10) not null,
    Col2 varchar2(10) null,
    Create_date DATE DEFAULT SYSDATE --DEFAULT > 기본값으로 SYSDATE를 넣어라
);

select * from ex2_10;
desc ex2_10;

--ALTER를 이용해서 ex2_10테이블의 COLUMN 이름을 변경
ALTER TABLE ex2_10 RENAME COLUMN COL9 to COL1;
ALTER TABLE ex2_10 modify col2 varchar2(30);

desc ex2_10;

--컬럼 추가,삭제
alter table ex2_10 add col3 number;
alter table ex2_10 drop column col3;

--col1 을 pk로 지정,해제
alter table ex2_10 add constraint pk_ex2_10 primary key(col1);
alter table ex2_10 drop constraint pk_ex2_10;

--테이블 복사
create table ex2_10_1 as select * from ex2_10;
select * from ex2_10_1;

--테이블 원하는 칼럼만 복사
create table memberTCopy3
as
select id from memberT where id ='lss';

--데이터 없이 테이블구조만 복사하기
create table memberTcopy4
as
select * from memberT where 1<>1; -- 1!=1 도 가능하나 sql에선 1<>1을 사용

select * from memberTcopy4;

--시퀀스
create SEQUENCE my_seq1
increment by 1 -- 1씩증가
start with 1 -- 1부터 시작
minvalue 1 -- 최소값 1
maxvalue 1000 -- 최대값 1000
nocycle -- 1000까지가면 끝
nocache; -- 캐시사용 X

drop table ex2_8;

create table ex2_8(
    no number primary key,
    name varchar2(100) not null
);

insert into ex2_8 values (my_seq1.currval,'고길동');
insert into ex2_8 values (my_seq1.nextval,'고길동');
insert into ex2_8 values (my_seq1.nextval,'이순신');

select * from ex2_8;
create SEQUENCE mySequence01;

create table seqT(
no number,
name varchar2(50)
);

insert into seqT values (mySequence01.nextval,'홍길동');

delete from seqT where name='홍길동';
select * from seqT;
