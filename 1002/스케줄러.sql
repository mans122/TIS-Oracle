--���̺� ����
create table ch15_job_test(
    seq     number,
    insert_date Date);

select * from ch15_job_test;
--���ν��� ����
create or replace procedure ch15_job_test_proc
is
    vn_next_seq     number;
begin
    --���� ������ �����´�
    select nvl(max(seq),0)+1
    into vn_next_seq
    from ch15_job_test;
    
    --ch15_job_test���̺� insert
    insert into ch15_job_test values(vn_next_seq,sysdate);
    commit;
    
    exception when others then
        rollback;
        dbms_output.put_line(sqlerrm);
end;        

--�� ��ü���� �̿��� �����ٸ�

begin
    dbms_scheduler.create_job(
    job_name        =>'my_job1',
    job_type        =>'STORED_PROCEDURE',
    job_action      =>'ch15_job_test_proc',
    repeat_interval =>'FREQ=MINUTELY;INTERVAL=1', --1�п� 1��
    --repeat_interval =>'FREQ=DAILY;BYHOUR=19;
    comments        =>'����1 �ⰴü');
end;    

--enable ���ν��� ȣ���� ���� �� Ȱ��ȭ
begin
    dbms_scheduler.enable('my_job1');
end;    
--disable ������ �� ��Ȱ��ȭ
begin
    dbms_scheduler.disable('my_job1');
end;    