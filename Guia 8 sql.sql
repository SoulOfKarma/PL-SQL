--caso 1
SET SERVEROUTPUT ON; 
DECLARE 
v_max_salary VARCHAR2(99);
v_min_salary VARCHAR2(99);
v_pro_salary VARCHAR2(99);
v_total_salary VARCHAR2(99);
v_date varchar2(10);
v_cant_emp number(3);
BEGIN
select
TO_CHAR(SYSDATE,'DD/MM/YYYY'),
TO_CHAR(MAX(salary),'$999,999,999'),
TO_CHAR(MIN(salary),'$999,999,999'),
TO_CHAR(SUM(salary),'$999,999,999'),
TO_CHAR(round(avg(salary)),'$999,999,999'),
count(employee_id)
into
v_date,
v_max_salary,
v_min_salary,
v_total_salary,
v_pro_salary,
v_cant_emp
from employees
GROUP BY TO_CHAR(SYSDATE,'DD/MM/YYYY');
DBMS_OUTPUT.PUT_LINE('                   INFORME DE LA EMPRESA '||v_date);
DBMS_OUTPUT.PUT_LINE('                 ------------------------------------ ');
DBMS_OUTPUT.PUT_LINE('  ');
DBMS_OUTPUT.PUT_LINE('Salario Maximo       Salario Promedio     Salario Minimo     Salario Total');
DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------------');
DBMS_OUTPUT.PUT_LINE(''||v_max_salary||'     '||v_pro_salary||'    '||v_min_salary||'          '||v_total_salary);
DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------------');
DBMS_OUTPUT.PUT_LINE('Los valores calculados estan efectuados sobre  '||v_cant_emp||' Empleados');
end;

--caso 2 incompleto
DECLARE
v_name varchar(20);
v_count number(3);
BEGIN
SELECT d.department_name,
COUNT(employee_id)
INTO
v_name,
v_count
FROM departments d JOIN 
employees e
ON(d.DEPARTMENT_ID=e.DEPARTMENT_ID)
GROUP BY d.DEPARTMENT_NAME
HAVING COUNT(e.EMPLOYEE_ID)=45 or COUNT(e.employee_id)=1;
DBMS_OUTPUT.put_line(v_name||' '||v_count);
END;

--caso 3
SELECT first_name||' '||LAST_NAME,
TRUNC((MONTHS_BETWEEN
(TO_CHAR(SYSDATE,'DD/MM/YYYY'),TO_CHAR(HIRE_DATE,'DD/MM/YYYY')))/12),
TO_CHAR(SALARY,'$999,999,999')
FROM EMPLOYEES;