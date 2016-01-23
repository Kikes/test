/*DECLARE
  str_saludo VARCHAR(25) := 'First PL/SQL Program';
  str_salud2 VARCHAR(2);
BEGIN
  str_salud2 := 'test';
  DBMS_OUTPUT.PUT_LINE(str_saludo);
  EXCEPTION WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('ERROR OTHER EXP '||sqlcode);
  DBMS_OUTPUT
END;
*/

--PEDIR NOMBRE COMPLETO
--<50 CHRS PINTAR EL TAMAÑP Y PINTAR UN MENSAJE
--Preguntar fecha de naciemiento
--Calcular no. de meses
--si en no. rebasa los 18 años
/*
set SERVEROUTPUT ON;
DECLARE
  v_full_nm VARCHAR(100);
  v_length_nm NUMBER(10,2);
  v_birth_day VARCHAR(10);
  v_no_months VARCHAR(100);
BEGIN 
  v_full_nm   := '&Full_Name';
  --v_full_nm := TRIM(' ' from v_full_nm);
  v_length_nm := length(v_full_nm);
  IF v_length_nm < 3 THEN
    DBMS_OUTPUT.PUT_LINE('Your nm is < ' || v_length_nm);
    v_birth_day := '&Birth_Date';
    --v_no_months := TRUNC((SYSDATE -  TO_DATE(v_birth_day,'DD/MM/YYYY'))/30);
    v_no_months := TRUNC(MONTHS_BETWEEN(SYSDATE,v_birth_day));
    IF v_no_months > 216 THEN
      DBMS_OUTPUT.PUT_LINE('Welcome to PL/SQL course');
    ELSE
      DBMS_OUTPUT.PUT_LINE('you are a child');
    END IF;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Your nm is to long' || v_length_nm);
  END IF;
  DBMS_OUTPUT.PUT_LINE('END Program: ');
END;


SELECT TRUNC((SYSDATE -  TO_DATE('05/08/1984','DD/MM/YYYY'))/30) FROM DUAL; 
SELECT MONTHS_BETWEEN (SYSDATE,'08/05/1984' ) FROM DUAL;
--select 12*18 from dual; 

declare
  v_chr VARCHAR2(100):= '1000';
  v_num NUMBER(10,2) :=  2;
  v_dt  DATE := SYSDATE;
  
  v_ch2dt VARCHAR2(100):= '05/08/1984';
  v_ch2num VARCHAR2(100) := '2';
  
begin
  
  DBMS_OUTPUT.PUT_LINE(v_dt);--to_char imp
  DBMS_OUTPUT.PUT_LINE(v_num);--to_char imp
  
  DBMS_OUTPUT.PUT_LINE(v_num + v_ch2num);--to_num imp
  DBMS_OUTPUT.PUT_LINE(v_num + to_number(v_ch2num));--to_num exp
  
  DBMS_OUTPUT.PUT_LINE((sysdate+1));--to_num imp
    
  --DBMS_OUTPUT.PUT_LINE(TO_DATE('05/08/1984','YY/MM/YYYY'));
  --DBMS_OUTPUT.PUT_LINE(TO_DATE('05/08/1984','YY/MM/YYYY'));
end;

DECLARE
  v_outer_variable VARCHAR2(20) := 'GLOBAL VARIABLE';
BEGIN
  DECLARE 
    v_inner_variable VARCHAR2(20) := 'LOCAL VARIABLE';
  BEGIN
    DBMS_OUTPUT.PUT_LINE(v_inner_variable);
    DBMS_OUTPUT.PUT_LINE(v_outer_variable);
    END;
  DBMS_OUTPUT.PUT_LINE(v_inner_variable);
  DBMS_OUTPUT.PUT_LINE(v_outer_variable);    
END;

<<o_label>>
DECLARE 
  v_father_name VARCHAR(20) := 'pATRICK';
  v_date_of_birth DATE  := '20-04-1972';
BEGIN
  <<i_label>>
  DECLARE 
  v_child_name VARCHAR2(20) := 'Mike';
  v_date_of_birth DATE := '12-12-2002';
  BEGIN
  DBMS_OUTPUT.PUT_LINE('Father''s Name: '||v_father_name);
  DBMS_OUTPUT.PUT_LINE('Date of Birth: '||o_label.v_date_of_birth );
  DBMS_OUTPUT.PUT_LINE('Child''s Name: '||v_child_name);
  DBMS_OUTPUT.PUT_LINE('Date of Birth: '||v_date_of_birth);
  o_label.v_date_of_birth := '05-08-1984'; 
  END;
  DBMS_OUTPUT.PUT_LINE('Date of Birth chg: '||v_date_of_birth);
END;

--leterale: Boolean, 'test', 1.5
--comentarios
--identificadores:
--delimitadores: +,. palabras reservadas;
*/
<<o_lobel>>
DECLARE 
  v_cahr     VARCHAR2(10); 
  v_gnumber   NUMBER (10,2);
  c_months    CONSTANT NUMBER(10,2) := 12;
  d_date      DATE := SYSDATE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('outer BLOCK');
    DBMS_OUTPUT.PUT_LINE('Using LPAD FUNCTION, '||LPAD('SH',10,'*'));
    v_gnumber := MOD(dbms_random.random,2);
    IF v_gnumber = 0 then 
      DBMS_OUTPUT.PUT_LINE('Mod function result is ZERO'||v_gnumber);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Mod function result is nor ZERO:'||v_gnumber);
    END IF;
    DBMS_OUTPUT.PUT_LINE('v_gnumber: '||v_gnumber);
  DECLARE
    v_cahr VARCHAR(10) := '26';
    v_lnumber NUMBER(10,2);
    
  BEGIN
    v_cahr := '5';
    DBMS_OUTPUT.PUT_LINE('Inner BLOCK');
    DBMS_OUTPUT.PUT_LINE('global variable: '||o_lobel.v_cahr);
    o_lobel.v_cahr := v_cahr + 50;
    DBMS_OUTPUT.PUT_LINE('global variable modify: '||v_cahr);
    DBMS_OUTPUT.PUT_LINE('local variable modify: '||v_cahr);
    v_cahr := v_cahr/0;
  END;
    
EXCEPTION WHEN ZERO_DIVIDE THEN
   DBMS_OUTPUT.PUT_LINE('ZERO_DIVIDE execption error: '||sqlcode||' msg: '||sqlerrm);
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('Other execption error: '||sqlcode|| ' msg: '||sqlerrm);
END;