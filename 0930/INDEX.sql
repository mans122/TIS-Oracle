select * from ex2_10;
select * from ex2_10 where col1='aaa';

create unique index ex2_10_ix01
on ex2_10 (col1);

select index_name,index_type,table_name,uniqueness
from user_indexes
where table_name = 'EX2_10';

CREATE TABLE SALES2
as
select distinct * from sales;

select count(*) from sales2;
select count(*) from sales;


--sql문을 실행하면 컴파일시에 쿼리옵티마이저가 동작해서
--최적화된 실행계획(execute plan)을 만든다.실행계획에 따라서 실행됨
-->대부분은 쿼리옵티마이저에게 맡기는게 좋다.
-->order by 속도가 느릴 경우 인덱스로 미리 sort
--> 앞쪽 데이터가 주로 검색되면 asc, 뒤쪽데이터가 주로 검색되면 desc

select * from sales where prod_id = 130;
create index idx_sales1 on sales(prod_id);
select prod_id,cust_id from sales where prod_id=130;
create index idx_sales2 on sales(prod_id,cust_id);



