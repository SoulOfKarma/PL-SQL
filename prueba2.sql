SET SERVEROUTPUT ON;
DECLARE 
CURSOR c_emp IS 
SELECT NUMRUT_EMP,SUELDO_EMP FROM EMPLEADO;
CURSOR c_pro_arr(NROPRO NUMBER) IS
SELECT SUM(p.VALOR_ARRIENDO)conta FROM PROPIEDAD p 
JOIN ARRIENDO_PROPIEDAD arr
ON(p.NRO_PROPIEDAD=arr.NRO_PROPIEDAD)
WHERE p.NUMRUT_EMP=NROPRO;
v_number NUMBER(7);
BEGIN
 FOR reg_emp IN c_emp LOOP
  v_number := 0;
  FOR reg_pro_arr IN c_pro_arr(reg_emp.NUMRUT_EMP)LOOP
  IF reg_pro_arr.conta  BETWEEN 1 AND 200000 THEN
  v_number := reg_pro_arr.conta * 0.10;
  ELSIF reg_pro_arr.conta BETWEEN 200001 AND 300000 THEN
  v_number := reg_pro_arr.conta * 0.15;
   ELSIF reg_pro_arr.conta BETWEEN 300001 AND 500000 THEN
  v_number := reg_pro_arr.conta * 0.20;
   ELSIF reg_pro_arr.conta BETWEEN 500001 AND 850000 THEN
  v_number := reg_pro_arr.conta * 0.25;
   ELSIF reg_pro_arr.conta BETWEEN 850001 AND 1000000 THEN
  v_number := reg_pro_arr.conta * 0.30;
   ELSIF reg_pro_arr.conta BETWEEN 1000001 AND 2000000 THEN
  v_number := reg_pro_arr.conta * 0.35;
  END IF;
  DBMS_OUTPUT.PUT_LINE(
  RPAD(reg_emp.NUMRUT_EMP,12,' ')
  ||RPAD(v_number,10,' ')
  ||RPAD(reg_emp.SUELDO_EMP,10,' ')
  ||RPAD(ROUND(reg_emp.SUELDO_EMP*0.085),10,' ')
  ||RPAD(ROUND(reg_emp.SUELDO_EMP*0.097),10,' ')
  ||RPAD(ROUND(reg_emp.SUELDO_EMP*0.1345),10,' ')
  ||RPAD(ROUND(reg_emp.SUELDO_EMP*0.0655),10,' '));
  END LOOP; 
 END LOOP;
 EXCEPTION
 WHEN NO_DATA_FOUND THEN
 DBMS_OUTPUT.PUT_LINE(' ');
 WHEN TOO_MANY_ROWS THEN
 DBMS_OUTPUT.PUT_LINE(' ');
 WHEN OTHERS THEN
 DBMS_OUTPUT.PUT_LINE(' ');
END;

