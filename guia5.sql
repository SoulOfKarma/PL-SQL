SET SERVEROUTPUT ON;
DECLARE
CURSOR cur_alumnos_ASIG IS 
SELECT COD_ALUMNO,APPAT_ALUMNO||' '||PNOMBRE_ALUMNO nombrealumno
FROM ALUMNO;
CURSOR cur_asig_prog(cod_alum NUMBER) IS 
SELECT asi.NOMBRE asignatura,prom.SITUACION_ASIG situac FROM PROMEDIO_ASIG_ALUMNO prom JOIN
ASIGNATURA asi ON(prom.COD_ASIGNATURA=asi.COD_ASIGNATURA)
WHERE prom.COD_ALUMNO = cod_alum
ORDER BY asi.nombre;
v_number NUMBER(3):=0;
BEGIN
DBMS_OUTPUT.PUT_LINE('     Listado Situacion De Asignaturas de los ALumnos ');
DBMS_OUTPUT.PUT_LINE(RPAD(' ',58,'-'));
DBMS_OUTPUT.NEW_LINE();
DBMS_OUTPUT.PUT_LINE(RPAD(' ORDEN',10,' ')
||RPAD(' ALUMNO',18,' ')
||RPAD(' ASIGNATURA',20,' ')
||RPAD(' SITUACION',10,' '));
DBMS_OUTPUT.PUT_LINE(RPAD(' ',50,'-'));
 FOR reg_alumnos IN cur_alumnos_ASIG LOOP
   FOR reg_prom_asi IN cur_asig_prog(reg_alumnos.COD_ALUMNO)LOOP
     DBMS_OUTPUT.PUT_LINE('   '||RPAD(v_number+1,5,' ')
     ||RPAD(reg_alumnos.nombrealumno,20,' ')
     ||RPAD(reg_prom_asi.asignatura,25,' ')
     ||RPAD(reg_prom_asi.situac,1,' '));
     v_number := v_number+1;
     END LOOP;
  
 END LOOP;
END;

