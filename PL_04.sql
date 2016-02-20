DECLARE 
  TYPE t_rec IS RECORD
    (v_sal number(8),
     v_minsal number(8) default 1000,
     v_hire_date employees.hire_date%type,
     v_rec1 employees%rowtype);
  v_myrec t_rec;
BEGIN 
  v_myrec.v_sal := v_myrec.v_minsal +500;
  v_myrec.v_hire_date := sysdate;
  SELECT * INTO v_myrec.v_rec1
    FROM employees WHERE employee_id = 100;
    DBMS_OUTPUT.PUT_LINE(v_myrec.v_rec1.first_name || ' ' || v_myrec.v_rec1.last_name || ' ' ||
    to_char(v_myrec.v_hire_date) || ' ' || to_char(v_myrec.v_sal));
END;    
/*DECLARE
  CURSOR C_EMPLEADITOS IS SELECT EMPLOYEE_ID, LAST_NAME FROM EMPLOYEES;
BEGIN
  
  FOR i IN C_EMPLEADITOS LOOP 
    DBMS_OUTPUT.PUT_LINE('!!');
  END LOOP;
END;

DECLARE
  v_countryid locations.country_id%TYPE := 'CA';
  v_loc_id    locations.location_id%TYPE;
  v_new_city  locations.city%TYPE := 'Montreal';
BEGIN
  SELECT MAX(location_id) INTO v_loc_id 
  FROM locations
  WHERE country_id = v_countryid;
  
  FOR i IN 1..3 LOOP 
    INSERT INTO locations(location_id, city, country_id)
    VALUES((v_loc_id + i), v_new_city, v_countryid);
    END LOOP;
END;

DECLARE
  v_countryid locations.country_id%TYPE   :='CA';
  v_loc_id    locations.location_id%TYPE;  
  v_new_city  locations.city%TYPE         :='Montrial';
  v_counter   NUMBER   :=1;
BEGIN
  SELECT MAX(location_id)INTO v_loc_id FROM locations
  WHERE country_id = v_countryid;
  WHILE v_counter <= 3 LOOP
    INSERT INTO locations(location_id, city, country_id)
    VALUES((v_loc_id + v_counter), v_new_city, v_countryid);
    v_counter := v_counter +1;
    EXIT WHEN v_counter = 3;
  END LOOP;
END;

DECLARE
  v_countryid locations.country_id%TYPE := 'CA';
  v_loc_id    locations.location_id%TYPE;
  v_counter   NUMBER(2) :=1;
  v_new_city  locations.city%TYPE := 'Montreal';
BEGIN
  SELECT MAX(location_id) INTO v_loc_id FROM locations
  WHERE country_id = v_countryid;
  LOOP
  EXIT WHEN v_counter > 3;
    INSERT INTO locations(location_id, city, country_id)
    VALUES ((v_loc_id + v_counter), v_new_city, v_countryid);
    v_counter := v_counter +1;
    END LOOP;
END;*/