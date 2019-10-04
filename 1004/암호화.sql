declare
    input_string    varchar2(200) := 'The Oracle';
    output_string   varchar2(200);
    
    encrypted_raw RAW (2000);
    decrypted_raw RAW (2000);
    
    num_key_bytes NUMBER := 256/8;
    key_bytes_raw RAW(32);
    
    encryption_type PLS_INTEGER;
    
begin
    encryption_type := dbms_crypto.encrypt_AES256 +
                        DBMS_CRYPTO.CHAIN_CBC +
                        DBMS_CRYPTO.PAD_PKCS5;
    dbms_output.put_line('원본 문자열 : '|| input_string);
 
    key_bytes_raw := dbms_crypto.randombytes(num_key_bytes);
    
    encrypted_raw := dbms_crypto.encrypt( src=> UTL_I18N.STRING_TO_RAW(
                                                input_string, 'AL32UTF8'),
                                            typ => encryption_type,
                                            key => key_bytes_raw
                                            );
    dbms_output.put_line('암호화된 raw 데이터 : '|| encrypted_raw);
    
    decrypted_raw := dbms_crypto.decrypt(src => encrypted_raw,
                                        typ => encryption_type,
                                        key => key_bytes_raw);
    output_string := UTL_I18N.RAW_TO_CHAR(decrypted_raw, 'AL32UTF8');
    DBMS_OUTPUT.PUT_LINE('복호화된 문자열: ' || output_string);
    
end;    

------------------------------------------------------------------------

declare
    input_string varchar2(200) := 'The Oracle';
    input_raw    raw(128);
    encrypted_raw raw(2000);
    
    key_string varchar2(8):='secret';
    raw_key raw(128):= UTL_RAW.CAST_TO_RAW(CONVERT(key_string,'AL32UTF8','US7ASCII'));
begin
    input_raw := UTL_I18N.STRING_TO_RAW(input_string,'AL32UTF8');
    DBMS_OUTPUT.PUT_LINE('------------hash 함수------------');
    encrypted_raw := DBMS_CRYPTO.HASH(  src=> input_raw,
                                        typ=>dbms_crypto.hash_sh1);
                                        
    dbms_output.put_line('해시값: ' || RAWTOHEX(encrypted_raw));
    
    dbms_output.put_line('--MAX--');
    encrypted_raw := dbms_crypto.mac(src=>input_raw,
                                    typ=>dbms_crypto.hmac_md5,
                                    key=>raw_key);
    dbms_output.put_line('mac : '|| RAWTOHEX(encrypted_raw));
end;    

