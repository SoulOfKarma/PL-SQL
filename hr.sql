DECLARE
v_fname employees.first_name%type;
v_lname employees.last_name%type;
v_hire_date varchar2(40);
begin
 select first_name,last_name,
 to_char(hire_date,'dd "de" MONTH "Del" yyyy')
 into v_fname,v_lname,v_hire_date
 from employees
 where EMPLOYEE_ID = 100;
 DBMS_OUTPUT.put_line('ASD '||v_fname||' '||v_lname||' '|| v_hire_date);
 end;
 
 DECLARE
 v_total_emp number(3):=0;
 v_depto varchar2(30);
 begin
 select d.department_name,count(e.employee_id)
 into v_depto,v_total_emp
 from departments d join employees e  
 on(d.department_id=e.department_id)
 where e.department_id = 50
 group by d.department_name;
 DBMS_OUTPUT.put_line('En el departamento '||v_depto||' trabajan '||v_total_emp||' empleados');
 end;
 
 DECLARE
 v_fname varchar2(20);
 v_lname varchar2(20);
 begin
 select first_name,last_name
 into v_fname,v_lname
 from employees
 group by first_name,last_name
 having min(salary) = (select min(salary) from employees);
 DBMS_OUTPUT.put_line('El empleado '||v_fname||' '||v_lname||' es el empleado con el salario mas bajo');
 end;
  
 DECLARE 
 v_comision number(5);
 begin
 select 
 ROUND(avg(salary*NVL(COMMISSION_PCT,0)),0)
 into v_comision
 from employees;
 DBMS_OUTPUT.put_line('El promedio es $'||v_comision);
end;

