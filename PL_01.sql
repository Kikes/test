set SERVEROUTPUT ON;

/*DECLARE
  str_saludo VARCHAR(25) := 'First PL/SQL Program';
  str_salud2 VARCHAR(2);
BEGIN
  str_salud2 := 'test';
  DBMS_OUTPUT.PUT_LINE(str_saludo);
  EXCEPTION WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('ERROR OTHER EXP '||sqlcode);
  DBMS_OUTPUT.PUT_LINE('ERROR OTHER EXP '||sqlerror);
END;


DECLARE
  start_w_letter VARCHAR(25);
  include_letter_8 VARCHAR(25);
  include_special_chr_$_# VARCHAR2(25);
  no_more_than_30_characters_lm VARCHAR2(25);
  --select VARCHAR(25); --No palabras reservadas  
BEGIN
  str_salud2 := 'test';
  DBMS_OUTPUT.PUT_LINE(str_saludo);
  EXCEPTION WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('ERROR OTHER EXP '||sqlcode);
  DBMS_OUTPUT.PUT_LINE('ERROR OTHER EXP '||sqlerror);
END;


DECLARE
  v_hiredate    DATE;
  v_deptno      NUMBER(2) NOT NULL :=10;
  v_location    VARCHAR(25) := 'Atlanta';
  c_comm        CONSTANT NUMBER := 1400;
BEGIN
  v_hiredate := sysdate;
  DBMS_OUTPUT.PUT_LINE(v_hiredate);
  DBMS_OUTPUT.PUT_LINE(v_deptno);
  DBMS_OUTPUT.PUT_LINE(v_location);
  DBMS_OUTPUT.PUT_LINE(c_comm);
END;

DECLARE 
  v_event VARCHAR2(15);
BEGIN
  v_event := q'!! Father's day!!';
  DBMS_OUTPUT.PUT_LINE(v_event);
  v_event := q'[[ Father's day!]';
  DBMS_OUTPUT.PUT_LINE(v_event);
  v_event := q'{{ Father's day!}';
  DBMS_OUTPUT.PUT_LINE(v_event);
  v_event := q'<< Father's day!>';
  DBMS_OUTPUT.PUT_LINE(v_event);
  v_event := q'++ Father's day!+';
  DBMS_OUTPUT.PUT_LINE(v_event);
  v_event := q'-- Father's day!-';
  DBMS_OUTPUT.PUT_LINE(v_event);
  v_event := q'AA Father's day!A';
  DBMS_OUTPUT.PUT_LINE(v_event);
END;  

--Variables: almacenan un solo valor: VARCHAR2, NUMBER, DATE, BOOLEAN

DECLARE 
  v_emp_job         VARCHAR2(9);
  v_count_loop      BINARY_INTEGER        :=0;
  v_dept_total_sal  NUMBER(9,2)           :=1569854;
  v_orderdate       DATE                  := SYSDATE +7;
  c_tax_rate        CONSTANT NUMBER (3,2) := 8.259;
  v_valid           BOOLEAN NOT NULL       :=TRUE;
BEGIN
  DBMS_OUTPUT.PUT_LINE('v_emp_job '||v_emp_job);
  DBMS_OUTPUT.PUT_LINE('v_count_loop '||v_count_loop);
  DBMS_OUTPUT.PUT_LINE('v_dept_total_sal '||v_dept_total_sal);
  DBMS_OUTPUT.PUT_LINE('v_orderdate '||v_orderdate);
  DBMS_OUTPUT.PUT_LINE('c_tax_rate '||c_tax_rate);
  v_emp_job := 'test';
  DBMS_OUTPUT.PUT_LINE('v_valid '||v_emp_job);
  --v_valid :=FALSE;
  CASE v_valid WHEN TRUE THEN
    DBMS_OUTPUT.PUT_LINE('v_valid TRUE');  
  ELSE
    DBMS_OUTPUT.PUT_LINE('v_valid FALSE');
  END CASE;
END;

VARIABLE b_result NUMBER
VARIABLE b_result2 NUMBER
BEGIN
  SELECT (SALARY*12) + NVL(COMMISSION_PCT,0) INTO :b_result
  FROM employees WHERE employee_id = 148;
  SELECT 223 INTO :b_result2 FROM dual;
END;
/
PRINT b_result
PRINT b_result2*/

VARIABLE b_result3 NUMBER
DECLARE
  v_valid_identified VARCHAR2(25) := 'Identificador valido';
  v_emp_lname employees.last_name%TYPE;
  v_balance NUMBER(7,2);
  v_min_balance v_balance%TYPE;
  b_flag_if2else BOOLEAN := TRUE;
BEGIN
  SELECT (SALARY*12) + NVL(COMMISSION_PCT,0) INTO :b_result3
  FROM employees WHERE employee_id = 148;
  SELECT last_name INTO v_emp_lname
  FROM employees WHERE employee_id = 148;
  SYS.DBMS_OUTPUT.PUT_LINE(v_valid_identified);
  SYS.DBMS_OUTPUT.PUT_LINE('v_emp_lname '||v_emp_lname);
  v_min_balance := 2526821.25;
  EXCEPTION WHEN OTHERS THEN
   SYS.DBMS_OUTPUT.PUT_LINE('UPSS!! error cd: '||sqlcode);
   IF b_flag_if2else THEN 
    SYS.DBMS_OUTPUT.PUT_LINE('b_flag_if2else is TRUE, changing to FALSE..');
    b_flag_if2else := FALSE;
   END IF;
   IF b_flag_if2else THEN
    SYS.DBMS_OUTPUT.PUT_LINE('Never will be here');
   ELSE
    SYS.DBMS_OUTPUT.PUT_LINE('b_flag_if2else is FALSE');
  END IF;
END;
/
PRINT b_result3
