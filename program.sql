--Test
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
  INTO V_ID_EM_FOUND, V_REM_JOB_ID, V_REM_SALARY, V_REM_COMMISSION_PCY, V_REM_MANAGER_ID, V_REM_DEPARTMENT_ID 
  FROM EMPLOYEES WHERE EMPLOYEE_ID = V_ID_EM_TO_LOOK;
  DBMS_OUTPUT.PUT_LINE('V_ID_EM_FOUND get: '|| V_ID_EM_FOUND);
  
  SELECT HIRE_DATE INTO V_DT_HD_EM FROM COPY_EMP WHERE EMPLOYEE_ID = V_ID_EM_FOUND;
  IF V_DT_HD_EM < V_DT_PIV THEN
    V_ID_EM_NEWONE := employees_seq.NEXTVAL;
    INSERT INTO COPY_EMP (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY, 
      COMMISSION_PCT, MANAGER_ID,DEPARTMENT_ID)
      VALUES (V_ID_EM_NEWONE,'&FIRST_NAME','&LAST_NAME','&EMAIL','&PHONE_NUMBER',
      TO_CHAR(SYSDATE,'DD/MM/YY'),V_REM_JOB_ID,V_REM_SALARY,V_REM_COMMISSION_PCY,V_REM_MANAGER_ID,V_REM_DEPARTMENT_ID); 
    DELETE COPY_EMP WHERE EMPLOYEE_ID = V_ID_EM_FOUND;
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