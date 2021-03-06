--Guia 8 Parte 1
/* CREATE OR REPLACE FUNCTION FN_BONO_ANTIGUEDAD (rut EMPLEADO.RUT_EMPLEADO%TYPE) RETURN NUMBER IS
 sal EMPLEADO.SUELDO_BASE%TYPE;
 PORC_COMI NUMBER(5,5);
 AUX NUMBER(5);
 
 BEGIN 
   SELECT ((TO_CHAR(SYSDATE,'YYYY'))- (TO_CHAR(fecha_contrato,'YYYY'))) 
   INTO AUX
   FROM EMPLEADO 
   WHERE RUT_EMPLEADO=rut;
   
   select PORC_BONIF INTO PORC_COMI
   from PORCENTAJE_ANTIGUEDAD
   WHERE AUX >= TOTAL_ANNOS_INF
   AND AUX <= TOTAL_ANNOS_SUP ;
 
   SELECT SUELDO_BASE*PORC_COMI INTO sal 
   FROM EMPLEADO 
   WHERE RUT_EMPLEADO=rut;
   
   RETURN sal;
   
 END FN_BONO_ANTIGUEDAD;
SELECT RUT_EMPLEADO,fecha_contrato, FN_BONO_ANTIGUEDAD(RUT_EMPLEADO) FROM EMPLEADO;
*/

--Guia 9 Parte 2


CREATE OR REPLACE FUNCTION FN_CALC_COMISION
(rut EMPLEADO.RUT_EMPLEADO%TYPE)RETURN NUMBER IS
total NUMBER(8);
BEGIN
SELECT ROUND(NVL(MONTO_TOTAL),0)INTO total
FROM VENTAS_MES 
WHERE RUT_EMPLEADO=rut;
RETURN total;
END FN_CALC_COMISION;

SELECT RUT_EMPLEADO,SUM(FN_CALC_COMISION(RUT_EMPLEADO))
FROM VENTAS_MES
GROUP BY RUT_EMPLEADO;
