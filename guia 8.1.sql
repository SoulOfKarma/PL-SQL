SET SERVEROUTPUT ON
DECLARE
vemp_id number(3);
vemp_name varchar2(30);
vemp_amp varchar2(30);
v_cantemp number(3);
v_asignacion varchar2(30);
BEGIN
select employee_id,
first_name,
last_name,
(SELECT COUNT(DISTINCT EMPLOYEE_ID) FROM employees WHERE MANAGER_ID=z.EMPLOYEE_ID) ,
TO_CHAR((SELECT 
COUNT(DISTINCT EMPLOYEE_ID) 
FROM employees 
WHERE MANAGER_ID=z.EMPLOYEE_ID)*1000,'$999,999,999')
into 
vemp_id ,
vemp_name ,
vemp_amp ,
v_cantemp ,
v_asignacion 
from employees z
where ROWNUM <2
group by employee_id,
first_name,
last_name
order by 4 desc;
DBMS_OUTPUT.put_line('                    INFORME PAGO ASIGNACION JEFE CON MAS EMPLEADOS');
DBMS_OUTPUT.PUT_LINE(RPAD('                    ',66,'-'));
DBMS_OUTPUT.PUT_LINE('ID. JEFE: '||vemp_id||'  NOMBRE: '||vemp_name||' '||vemp_amp );
DBMS_OUTPUT.PUT_LINE(' ');
DBMS_OUTPUT.PUT_LINE(' EMPLEADOS A SU CARGO                             VALOR ASIGNACION');
DBMS_OUTPUT.PUT_LINE(RPAD(' ',66,'-'));
DBMS_OUTPUT.PUT_LINE(RPAD(' ',19,' ')||v_cantemp||RPAD(' ',32,' ')||v_asignacion);
end;


