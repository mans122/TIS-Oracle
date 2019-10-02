 --����� ���� ���̺� �Լ�
 create or replace type ch14_num_nt is table of number;

--ch14_num_nt �÷����� ��ȯ�ϴ� �Լ� �ۼ� 
create or replace function fn_ch14_table1 (p_n number)
    return ch14_num_nt
is
    --�÷��� ���� ����(�÷��� Ÿ���̹Ƿ� �ʱ�ȭ�� �Ѵ�.)
    vnt_return ch14_num_nt := ch14_num_nt();
begin
    --1���� �Է¸Ű������� p_n��ŭ ���� �ֱ�
    for i in 1..p_n
    loop
        vnt_return.EXTEND;
        vnt_return(i) := i;
    end loop;
    
    return vnt_return;
end;    

select fn_ch14_table1(20) from dual;

select * from table(fn_ch14_table1(20));