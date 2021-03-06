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

SET SERVEROUTPUT ON;
DECLARE
v_dname varchar(20);
v_did number(3);
v_manager number(4);
v_location number(4);
v_countEmp number(3); 
begin
select d.department_name,
d.department_id,
d.manager_id,
d.location_id,
count(e.employee_id)
into v_dname,v_did,v_manager,v_location,v_countEmp
 from departments d join employees e  
 on(d.department_id=e.department_id)
 group by d.department_name,
 d.department_id,d.manager_id,
 d.location_id
 having count(e.employee_id)=
 (select count(employee_id)
 from employees where department_id=50);
 DBMS_OUTPUT.put_line('La Informacion del departamento con mayor cantidad de empleados es la siguiente:'||chr(13)||
 'Identificacion: '||v_did||chr(13)||
 'Nombre: '||v_dname||chr(13)||
 'Jefe: '||v_manager||chr(13)||
 'Ubicacion: '||v_location);
end;

 DECLARE
 v_fname varchar2(20);
 v_lname varchar2(20);
 v_salary varchar2(20);
 v_bono number(5);
 begin
 select first_name,last_name,to_char(salary,'$9,999'),
 salary*(to_number(substr(salary,0,1))/100)
 into v_fname,v_lname,v_salary,v_bono
 from employees
 group by first_name,last_name,salary
 having min(salary) = (select min(salary) from employees);
 DBMS_OUTPUT.put_line('El salario del empleado '||v_fname||' '||v_lname||' es de: '||v_salary||chr(13)||
 'Por lo tanto su bono es de $'||v_bono);
 end;