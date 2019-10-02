--임시테이블앞에 #이 붙음
--GTT(Global Temporary Table)에는 외래키를 만들 수 없다.
--GTT에 INDEX를 만들 수 있다.
create global temporary table ch14_tranc_gtt(
    ids         number,
    names       varchar2(50),
    birth_dt    DATE
    )
on commit delete rows;

insert into ch14_tranc_gtt values(1,'ss',sysdate);

select * from ch14_tranc_gtt;

commit;

