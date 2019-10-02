declare
    type av_type is table of varchar2(40)
                    index by pls_integer; --pl/sql���� �����ϴ� ������Ÿ��
                    
    vav_test av_type;
    
begin
    
    vav_test(10):= '10�� ���� ��';
    vav_test(20):= '20�� ���� ��';
    
    dbms_output.put_line(vav_test(10));
    dbms_output.put_line(vav_test(20));
end;

--varray

declare
    type va_type is varray(5) of varchar2(20);
    --varray ���� ����
    vva_test va_type;

    vn_cnt number:=0;
begin
    --�����ڸ� ����� �� �Ҵ�
    vva_test:=va_type('fisrt','second','third','','');
    
    loop
        vn_cnt := vn_cnt+1;
        if vn_cnt > 5 then
            exit;
        end if;            
        dbms_output.put_line(vva_test(vn_cnt));
    end loop;
    
    vva_test(2) := 'TEST';
    vva_test(4) := 'FOURTH';
    
    vn_cnt:=0;
    loop
        vn_cnt := vn_cnt+1;
        if vn_cnt > 5 then
            exit;
        end if;            
        dbms_output.put_line(vva_test(vn_cnt));
    end loop;
end;    

--��ø���̺�

declare
    --��ø���̺� ����
    type nt_typ is table of varchar2(10);
    
    --���� ����
    vnt_test nt_typ;
begin
    --�����ڸ� ����� �� �Ҵ�
    vnt_test := nt_typ('first','second','third');
    
    --�� ���
    dbms_output.put_line(vnt_test(1));
    dbms_output.put_line(vnt_test(2));
    dbms_output.put_line(vnt_test(3));
END;    

