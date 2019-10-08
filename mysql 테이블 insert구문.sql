use sampledb;

create table student(
	id char(7) primary key,
    name varchar(10) not null,
    dept varchar(20) not null,
    address varchar(100) null
);

select * from student;

insert into student(name,dept,id) values('김철수','컴퓨터시스템','1091011');
insert into student(name,dept,id) values('최고봉','멀티미디어','0792012');
insert into student(name,dept,id) values('이기자','컴퓨터공학','0494013');
insert into student(name,dept,id) values('조피디','컴퓨터시스템','1091013');
insert into student(name,dept,id) values('인순이','멀티미디어','5091013');

select * from student where dept='멀티미디어';


insert into student(id,name,dept) values('4456754'	,'안철수'	,'컴퓨터시스템');	
insert into student(id,name,dept) values('1354654'	,'한별킹'	,'정보보호'	);
insert into student(id,name,dept) values('0067442'	,'조철왕'	,'생활체육'	);
insert into student(id,name,dept) values('0792015'	,'최고봉'	,'멀티미디어'	);
insert into student(id,name,dept) values('0792010'	,'최고봉'	,'멀티미디어'	);
insert into student(id,name,dept) values('4456751'	,'안철수'	,'컴퓨터시스템'	);
insert into student(id,name,dept) values('1456754'	,'안철수'	,'컴퓨터시스템'	);
insert into student(id,name,dept) values('1091012'	,'김철수'	,'컴퓨터시스템'	);
insert into student(id,name,dept) values('0792016'	,'최고봉'	,'멀티미디어'	);
insert into student(id,name,dept) values('0792013'	,'최고봉'	,'멀티미디어'	);
insert into student(id,name,dept) values('0494019'	,'이기자'	,'컴퓨터공학'	);
insert into student(id,name,dept) values('0791012'	,'최고봉'	,'멀티미디어'	);
insert into student(id,name,dept) values('1354651',	'한별킹'	,'정보보호'	);


create table books(
  no char(6) primary key, -- 책번호
  title varchar(50) not null, -- 책이름
  author varchar(50) not null -- 저자
);

insert into books values('000001','오라클기본','이황');
insert into books values('000002','자바정복','율곡');
insert into books values('000003','HTML5','강감찬');

create table bookRent
( no char(10) primary key, -- 대여번호
  id char(10) not null, -- 학번
  bookNo char(6) not null, -- 책번호
  rDate char(8) not null -- 대여일
 );

select * from bookRent;
insert into bookRent values('2017071301','2018001','000001','20170713');
insert into bookRent values('2017071302','2018002','000003','20170713');
insert into bookRent values('2017071303','2018003','000003','20170713');
insert into bookRent values('2017071304','0792012','000001','20170713');
insert into bookRent values('2017071305','0792012','000003','20170713');
insert into bookRent values('2017071306','0494513','000002','20170713');
insert into bookRent values('2017071307','4456754','000002','20170713');
insert into bookRent values('2017071308','1091011','000003','20170713');
insert into bookRent values('2017071309','0494513','000002','20170713');
