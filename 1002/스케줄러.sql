--테이블 생성
create table ch15_job_test(
    seq     number,
    insert_date Date);

select * from ch15_job_test;
--프로시저 생성
create or replace procedure ch15_job_test_proc
is
    vn_next_seq     number;
begin
    --다음 순번을 가져온다
    select nvl(max(seq),0)+1
    into vn_next_seq
    from ch15_job_test;
    
    --ch15_job_test테이블에 insert
    insert into ch15_job_test values(vn_next_seq,sysdate);
    commit;
    
    exception when others then
        rollback;
        dbms_output.put_line(sqlerrm);
end;        

--잡 객체만을 이용한 스케줄링

begin
    dbms_scheduler.create_job(
    job_name        =>'my_job1',
    job_type        =>'STORED_PROCEDURE',
    job_action      =>'ch15_job_test_proc',
    repeat_interval =>'FREQ=MINUTELY;INTERVAL=1', --1분에 1번
    --repeat_interval =>'FREQ=DAILY;BYHOUR=19;
    comments        =>'버전1 잡객체');
end;    

--enable 프로시저 호출을 통한 잡 활성화
begin
    dbms_scheduler.enable('my_job1');
end;    
--disable 을통한 잡 비활성화
begin
    dbms_scheduler.disable('my_job1');
end;    