SET SERVEROUTPUT ON;

DECLARE 
 cursor c_emp is select * from empleado;
    reg_emp c_emp%rowtype;
v_cant NUMBER (9);
v_number NUMBER(7);
v_porc NUMBER(2):= 0;
mes_pro NUMBER(1) :=5;
anio_proceso NUMBER(4) := 2016;
v_errdes VARCHAR2(255);
BEGIN

  open c_emp;
    loop
        fetch c_emp into reg_emp;
        exit when c_emp%notfound;
        
        DBMS_OUTPUT.PUT_line('Nombre :' || reg_emp.nombre_emp);

        v_number := 0;
        IF reg_emp.ID_CATEGORIA_EMP = 3 THEN 
         BEGIN
         select sum(pro.valor_arriendo) into v_cant
         from EMPLEADO emp JOIN PROPIEDAD pro
         ON(emp.NUMRUT_EMP=pro.NUMRUT_EMP)JOIN arriendo_propiedad arr
         ON(pro.NRO_PROPIEDAD=arr.NRO_PROPIEDAD)
         where emp.NUMRUT_EMP= reg_emp.NUMRUT_EMP AND((arr.FECINI_ARRIENDO < to_date('01/05/2016','dd/mm/yyyy')
         and nvl(arr.FECTER_ARRIENDO,to_date('01/06/2016','dd/mm/yyyy'))
         >(to_date('01/06/2016','dd/mm/yyyy')-1))
         or to_char(arr.FECINI_ARRIENDO,'YYYYMM') = '201605'
         or to_char(arr.FECTER_ARRIENDO,'YYYYMM') = '201605');
     
         SELECT PORC_COMISION INTO v_porc FROM PORCENTAJE_COMISION 
         WHERE v_cant > TOTAL_ARRIENDO_INF
         AND v_cant < TOTAL_ARRIENDO_SUP;
         v_number :=  ((v_cant * v_porc)/100); 

        EXCEPTION
         WHEN NO_DATA_FOUND THEN
         v_errdes := SQLERRM;
         DBMS_OUTPUT.PUT_LINE('No tiene *******  ' || reg_emp.NUMRUT_EMP);
         INSERT INTO ERROR_CALC_REMUN(CORREL_ERROR,RUTINA_ERROR,DESCRIP_ERROR)
         VALUES(seq_error.nextval,'No se encuentra registro','CODIGO: '||' MENSAJE:'|| v_errdes);
         v_porc := 0;
         when others then
         DBMS_OUTPUT.PUT_LINE('ERRRRORRRRRRR *******....:):):):):):):)  ' ||reg_emp.NUMRUT_EMP);                           
         v_porc := 0;
   
        END;
 
        END IF;
 /*  DBMS_OUTPUT.PUT_LINE(
    RPAD(reg_emp.NUMRUT_EMP,12,' ')
    ||RPAD(v_number,10,' ')
    ||RPAD(reg_emp.SUELDO_EMP,10,' ')
    ||RPAD(ROUND(reg_emp.SUELDO_EMP*0.085),10,' ')
    ||RPAD(ROUND(reg_emp.SUELDO_EMP*0.097),10,' ')
    ||RPAD(ROUND(reg_emp.SUELDO_EMP*0.1345),10,' ')
    ||RPAD(ROUND(reg_emp.SUELDO_EMP*0.0655),10,' ')
    ||RPAD(reg_emp.ID_CATEGORIA_EMP,10,' ')
    ||RPAD(v_cant,10,' '));
    */
    INSERT INTO HABERES VALUES
    (reg_emp.NUMRUT_EMP,
    mes_pro,
    anio_proceso,
    reg_emp.SUELDO_EMP,
    v_number,
    ROUND(reg_emp.SUELDO_EMP*0.085),
    ROUND(reg_emp.SUELDO_EMP*0.097));
    INSERT INTO DESCUENTOS VALUES
    (reg_emp.NUMRUT_EMP,
    mes_pro,
    anio_proceso,
    ROUND(reg_emp.SUELDO_EMP*0.1345),
    ROUND(reg_emp.SUELDO_EMP*0.0655));
  END LOOP;

 
 EXCEPTION
 WHEN NO_DATA_FOUND THEN
 DBMS_OUTPUT.PUT_LINE(' 1');
 WHEN TOO_MANY_ROWS THEN
 DBMS_OUTPUT.PUT_LINE(' 1');
 WHEN OTHERS THEN
 DBMS_OUTPUT.PUT_LINE(' 1');
 
close c_emp;
END;
/*
SELECT * FROM DESCUENTOS;
SELECT * FROM HABERES;
SELECT * FROM ERROR_CALC_REMUN;
TRUNCATE TABLE HABERES;
TRUNCATE TABLE DESCUENTOS;*/
