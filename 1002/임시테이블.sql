--�ӽ����̺�տ� #�� ����
--GTT(Global Temporary Table)���� �ܷ�Ű�� ���� �� ����.
--GTT�� INDEX�� ���� �� �ִ�.
create global temporary table ch14_tranc_gtt(
    ids         number,
    names       varchar2(50),
    birth_dt    DATE
    )
on commit delete rows;

insert into ch14_tranc_gtt values(1,'ss',sysdate);

select * from ch14_tranc_gtt;

commit;

