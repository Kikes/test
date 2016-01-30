/*DECLARE

  hire_date   employees.hire_date%TYPE;
  sysdate   employees.hire_date%TYPE;
  employee_id eployees.employee_id%TYPE := 176;

BEGIN
  SELECT hire_date, sysdate
  
EXCEPTION 
  WHEN TOO_MANY_ROWS THEN
  DBMS_OUPUT.PUT_LINE()
  WHEN NO_DATAFOUND THEN
  WHEN OTHER THEN
  
END;

SELECT MAX(EMPLOYEE_ID) FROM EMPLOYEES;
SELECT employees_seq.NEXTVAL FROM DUAL;
SELECT employees_seq.CURRVAL FROM DUAL;
SELECT * FROM employees WHERE employee_id = 215; 

BEGIN
  INSERT INTO employees
  (employee_id, first_name, last_name, email, 
    hire_date, job_id, salary)
  VALUES(employees_seq.NEXTVAL, 'Ruth', 'Corea',
  'RCORES',CURRENT_DATE,'AD_ASST',4000);
END;

DECLARE 
  sal_increase employees.salary%TYPE := 800;
BEGIN
  UPDATE  employees
  SET     salary = salary + sal_increase
  WHERE job_id = 'ST_CLERK';
END;

DROP TABLE COPY_EMP;
CREATE  TABLE COPY_EMP AS 

SELECT * FROM EMPLOYEES ;
SELECT * FROM COPY_EMP;
TRUNCATE TABLE COPY_EMP;

BEGIN
MERGE INTO COPY_EMP C
  USING EMPLOYEES E
  ON (E.EMPLOYEE_ID = C.EMPLOYEE_ID)
  WHEN MATCHED THEN
  UPDATE SET
      C.FIRST_NAME    = E.FIRST_NAME,
      C.LAST_NAME     = E.LAST_NAME,
      C.EMAIL         = E.EMAIL,
      C.PHONE_NUMBER  = E.PHONE_NUMBER,
      C.HIRE_DATE     = E.HIRE_DATE,
      C.JOB_ID        = E.JOB_ID,
      C.SALARY        = E.SALARY,
      C.COMMISSION_PCT = E.COMMISSION_PCT,
      C.MANAGER_ID = E.MANAGER_ID,
      C.DEPARTMENT_ID = E.DEPARTMENT_ID
  WHEN NOT MATCHED THEN
    INSERT VALUES (
      E.EMPLOYEE_ID,
      E.FIRST_NAME,
      E.LAST_NAME,
      E.EMAIL,
      E.PHONE_NUMBER,
      E.HIRE_DATE,
      E.JOB_ID,
      E.SALARY,
      E.COMMISSION_PCT,
      E.MANAGER_ID,
      E.DEPARTMENT_ID);
END;
select * from employees where EMPLOYEE_ID = 212;
DECLARE
    v_rows_deleted  VARCHAR2(30);
    v_empno employees.employee_ID%TYPE := 212;
BEGIN
  DELETE EMPLOYEES WHERE EMPLOYEE_ID = v_empno;
  v_rows_deleted := (SQL%ROWCOUNT||'Rows deleted');
  DBMS_OUTPUT.PUT_LINE ('msg: '||' '||v_rows_deleted);
  CASE WHEN SQL%ROWCOUNT <> 0 THEN 
    DBMS_OUTPUT.PUT_LINE ('doind commit');
  ELSE
    DBMS_OUTPUT.PUT_LINE ('not commit');
  END CASE;
  --COMMIT;
  EXCEPTION WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE ('Exception e: '||sqlcode);
END;

DECLARE
BEGIN
  MERGE INTO TABLEA A
  USING TABLEB 
  ON
  WHEN MATCH THEN
  UPDATE SET
  WHEN NOT MATCH THEN
  INSERT VALUES
END;

DECLARE
  v_myage number :=31;
BEGIN
  IF v_myage > 0 THEN
  DBMS_OUTPUT.PUT_LINE('AGE > 0');
  ELSE
    IF v_myage < 0 THEN
    DBMS_OUTPUT.PUT_LINE('AGE < 0');
    END IF;
  END IF;
END;*/

--HIRE_DATE < 1, ENERO 1997
--CUANTOS SE ELIMINARON
---SI MENOS DE 10 EMP 
---LOS QUE SE QUEDARON AUMENTAR EL SALARIO DEL 30%
---SE

DECLARE
  V_ID_EM_TO_LOOK EMPLOYEES.EMPLOYEE_ID%TYPE;
  V_ID_EM_FOUND   EMPLOYEES.EMPLOYEE_ID%TYPE;
  V_DT_HD_EM      EMPLOYEES.HIRE_DATE%TYPE;
BEGIN
  V_ID_EM_TO_LOOK := '&EMP_ID';
  SELECT EMPLOYEE_ID INTO V_ID_EM_FOUND FROM EMPLOYEES WHERE EMPLOYEE_ID = V_ID_EM_TO_LOOK;
  DBMS_OUTPUT.PUT_LINE('V_ID_EM_FOUND get: '|| V_ID_EM_FOUND);
  
  SELECT HIRE_DATE INTO V_DT_HD_EM FROM COPY_EMP WHERE EMPLOYEE_ID = V_ID_EM_FOUND;
  DELETE COPY_EMP WHERE HIRE_DATE <= V_DT_HD_EM;
  
  IF SQL%ROWCOUNT <> 0 THEN 
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT||' --> Rows deleted');
    UPDATE COPY_EMP SET SALARY = SALART+SALARY*.3 WHERE HIRE_DATE > V_DT_EM_FOUND;
    IF SQL%ROWCOUNT <> 0 THEN 
      DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT||' --> Rows updated salary');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Node updated salary');
    END IF;
  ELSE
    DBMS_OUTPUT.PUT_LINE('None rows deleted');
  END IF;
  
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('NO EMP_ID FOUND: '||V_ID_EM_TO_LOOK );
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ups something went grong!!');
END;


---FECHA CONTRACION ANSTE 1 ENERO DEL 97
----DELETE DEL EMP Y EN MI LUGAR SE QUEDA KIKE E INSERTAR EL SALARY
----EL NO EMPLEADO SE LLAMA Y CUANTO VA A GANAR Y SU COMISION Y TOTAL;
---FECHA CONTRACION DESPUES 1 ENERO DEL 97
----PONER LA ANTIGUEIDAD EN AÑOS MESES Y DIAS
----HACER EL UPDATE EN SALARYI AL 30%
----SI TRABA EN VENTAS SA_REP
---- Y SI SUPERA LOS 8000 MIS SALARIO AHORA ES DE XXX
---- SI TIENE COMISION PINTAR EL TOTAL SAL+COMS
---- SI NO... YO NO ME RIFO NO TENGO COMISION
---- SI < 8000
---- MI SALARIO ES BECARI PONER GANAS

--SI TRABAJA EN IT 
---TENGO UN BONO MENSIAL DE 40% DEL SALARIO BASE
---IF HAS COMSN:
--  PERO GNANO
---IF NOT 
---  IF BOSS IS
---     MY BOSS IS INSERT NEW PUESTO 
-- ELSE 


/*
id dinamico, evaluar fecha, 
 si es menor al 1 Ene 97, me van a despedir por que llevo mucho tiempo aqui, DELETE
 pero en mi lugar se que queda
 insertarme como empleado
 y el nuevo empleado se llama, nombre apellido, cuanto va a ganar, y salario +  mi comissión en total gano
 
 else mi nombre es, mi antigueda es de N años, N meses, N dias
   update 30% 
   if trabaja en ventas, yo trabajo en ventas 
     si despues del aumento supera los 8000 
       mi salario ahora es de $$$$
       si tiene comissión pintar salario mas commissión
     si no es mayor a 8000
       mi salario de becario y le tengo que echar ganas
   else if IT 
     yo trabajo en IT y tengo un bono mensual del 40% de mi salario base
       si tiene comisión
         pero como tengo comisión ahora gano
       si no tiene comisión
         si su jefe es 'Alexander Hundo?
           insertar un nuevo puesto de trabajo
           update mi reggistro y ponernos como IT manager 
   else
     yo trabajo en el dpto "tal" 
       si tiene comissión
         update a 0
         me quitaron mi comissión por que no soy vendedor, ahora me quedo ganando "salary"
*/

DECLARE
  V_DT_PIV          EMPLOYEES.HIRE_DATE%TYPE := '01/01/03';
  V_DT_HD_EM        EMPLOYEES.HIRE_DATE%TYPE;
  V_ID_EM_TO_LOOK   EMPLOYEES.EMPLOYEE_ID%TYPE;
  V_ID_EM_FOUND     EMPLOYEES.EMPLOYEE_ID%TYPE;
  V_ID_EM_NEWONE    EMPLOYEES.EMPLOYEE_ID%TYPE;
 
  V_REM_JOB_ID      EMPLOYEES.JOB_ID%TYPE;
  V_REM_SALARY     EMPLOYEES.SALARY%TYPE;
  V_REM_COMMISSION_PCY EMPLOYEES.COMMISSION_PCT%TYPE;
  V_REM_MANAGER_ID  EMPLOYEES.MANAGER_ID%TYPE;
  V_REM_DEPARTMENT_ID EMPLOYEES.DEPARTMENT_ID%TYPE;
  
  V_NEW_SALARY     EMPLOYEES.SALARY%TYPE;
  V_NEW_COMMISSION_PCY EMPLOYEES.COMMISSION_PCT%TYPE;
  V_STR_TMP        VARCHAR2(100);
  
  V_NO_DD         NUMBER(10,2);
  V_NO_MM         NUMBER(10,2);
  V_NO_YY         NUMBER(10,2);
BEGIN
  V_ID_EM_TO_LOOK := '&EMP_ID';
  SELECT EMPLOYEE_ID, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID 
  INTO V_ID_EM_FOUND, V_REM_JOB_ID, V_REM_COMMISSION_PCY, V_REM_MANAGER_ID, V_REM_DEPARTMENT_ID 
  FROM EMPLOYEES WHERE EMPLOYEE_ID = V_ID_EM_TO_LOOK;
  DBMS_OUTPUT.PUT_LINE('V_ID_EM_FOUND get: '|| V_ID_EM_FOUND);
  
  SELECT HIRE_DATE INTO V_DT_HD_EM FROM COPY_EMP WHERE EMPLOYEE_ID = V_ID_EM_FOUND;
  IF HIRE_DATE < V_DT_PIV THEN
    V_ID_EM_NEWONE := EMPLOYEE_ID.NEXTVAL;
    INSERT INTO COPY_EMP (FIRST_NAME,LAST_NAME,EMAIL,HONE_NUMBER,HIRE_DATE,JOB_ID,SALARY, 
      COMMISSION_PCT, MANAGER_ID,DEPARTMENT_ID)
      VALUES (V_ID_EM_NEWONE,'&FIRST_NAME','&LAST_NAME','&EMAIL','&HOME_NUMBER',
      TO_CHAR(SYSDATE,'DD/MM/YY'),V_REM_JOB_ID,V_REM_SALARY,V_REM_COMMISSION_PCY,V_REM_MANAGER_ID,V_REM_DEPARTMENT_ID); 
    DELETE COPY_EMP WHERE ENPLOYEE_ID = V_ID_EM_FOUND;
    SELECT SALARY, COMMISSION_PCT, FIRST_NAME||LAST_NAME 
    INTO V_NEW_SALARY, V_NEW_COMMISSION_PCY, V_STR_TMP FROM COPY_EMP WHERE EMPLOYEE_ID = V_ID_EM_NEWONE;
    DBMS_OUTPUT.PUT_LINE('EMP_ID: '||V_ID_EM_FOUND||' will be hire but I will replace him: ');
    DBMS_OUTPUT.PUT_LINE('EMP_ID: '||V_ID_EM_NEWONE||' ist NAME is: '||V_STR_TMP
                          ||' its SALARY '||V_NEW_SALARY
                          ||' and finally its COMSN is '||V_NEW_COMMISSION_PCY);  
  ELSE
    SELECT 
      TRUNC(SYSDATE-HIRE_DATE), 
      TRUNC(MONTHS_BETWEEN (TO_DATE(SYSDATE,'DD/MM/YY'),TO_DATE(HIRE_DATE,'DD/MM/YY'))),
      TRUNC(MONTHS_BETWEEN (TO_DATE(SYSDATE,'DD/MM/YY'),TO_DATE(HIRE_DATE,'DD/MM/YY'))/12)
    INTO 
      V_NO_DD,
      V_NO_MM,
      V_NO_YY 
    FROM EMPLOYEES 
    WHERE EMPLOYEE_ID = 100;
    
  END IF;
  
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('NO EMP_ID FOUND: '||V_ID_EM_TO_LOOK );
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ups something went grong!!');
END;



select * FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;
select * FROM EMPLOYEES ORDER BY EMPLOYEE_ID DESC;