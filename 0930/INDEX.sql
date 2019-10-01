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


--sql���� �����ϸ� �����Ͻÿ� ������Ƽ�������� �����ؼ�
--����ȭ�� �����ȹ(execute plan)�� �����.�����ȹ�� ���� �����
-->��κ��� ������Ƽ���������� �ñ�°� ����.
-->order by �ӵ��� ���� ��� �ε����� �̸� sort
--> ���� �����Ͱ� �ַ� �˻��Ǹ� asc, ���ʵ����Ͱ� �ַ� �˻��Ǹ� desc

select * from sales where prod_id = 130;
create index idx_sales1 on sales(prod_id);
select prod_id,cust_id from sales where prod_id=130;
create index idx_sales2 on sales(prod_id,cust_id);



