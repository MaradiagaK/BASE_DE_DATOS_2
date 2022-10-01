SET SERVEROUTPUT ON;

----------------------------------------------------
--EJERCICIO #1, VISUALIZAR INICIALES DE UN NOMBRE 
----------------------------------------------------
DECLARE
    nombre VARCHAR2(10);
    apellido1 VARCHAR2(10);
    apellido2 VARCHAR2(10);
BEGIN
    nombre:='kelly';
    apellido1:='flores';
    apellido2:='maradiaga';
    DBMS_OUTPUT.PUT_LINE('NOMBRE: '||UPPER(nombre)||' '||UPPER(apellido1)||' '||UPPER(apellido2));
    DBMS_OUTPUT.PUT_LINE('INICIALES: ' || UPPER(SUBSTR(nombre, 1, 1))|| '.'
    ||UPPER(SUBSTR(apellido1, 1, 1))|| '.'||UPPER(SUBSTR(apellido2, 1, 1)));
END;

------------------------------------------------------
--EJERCICIO #2, DETERMINAR SI EL VALOR ES PAR O IMPAR 
------------------------------------------------------

DECLARE
    DIVISOR NUMBER;
    DIVIDENDO NUMBER;
    MODULO NUMBER;

BEGIN
    DIVISOR:=&DIVISOR;
    DIVIDENDO:=2;
    MODULO:=MOD(DIVISOR,DIVIDENDO);

    IF MODULO = 0 THEN 
        DBMS_OUTPUT.PUT_LINE('ES UN VALOR PAR');
    ELSE
        DBMS_OUTPUT.PUT_LINE('ES UN VALOR IMPAR');
    END IF;
END;


------------------------------------------------------
--EJERCICIO #3, DEVOLVER SALARIO MAXIMO DE DEPTO 100 
------------------------------------------------------

DECLARE
    nombre EMPLOYEES.FIRST_NAME%TYPE;
    salario_maximo EMPLOYEES.SALARY%TYPE; 
    
BEGIN
    SELECT MAX(SALARY) INTO salario_maximo FROM EMPLOYEES WHERE DEPARTMENT_ID=100;
    DBMS_OUTPUT.PUT_LINE('SALARIO MAXIMO: '||salario_maximo);
    --DBMS_OUTPUT.PUT_LINE('NOMBRE: '||salario_maximo.FIRST_NAME);  
END;

------------------------------------------------------------------------------
--CONSULTA 
------------------------------------------------------------------------------
SELECT MAX (SALARY) FROM (SELECT * FROM employees WHERE department_id = 100);

------------------------------------------------------
--EJERCICIO #4,  
------------------------------------------------------

DECLARE     
    COD_DEPARTAMENTO DEPARTMENTS.DEPARTMENT_ID%TYPE:=10;     
    NOMBRE_DEP DEPARTMENTS.DEPARTMENT_NAME%TYPE;     
    NUM_EMPLEADO NUMBER; 

BEGIN     
    SELECT DEPARTMENT_NAME INTO NOMBRE_DEP FROM DEPARTMENTS 
    WHERE DEPARTMENT_ID=COD_DEPARTAMENTO;        
    SELECT COUNT(*) INTO NUM_EMPLEADO FROM EMPLOYEES 
    WHERE DEPARTMENT_ID=COD_DEPARTAMENTO;    
    DBMS_OUTPUT.PUT_LINE(NOMBRE_DEP||' tiene '||NUM_EMPLEADO||' empleados'); 
END;

-----------------------------------------------------------------------------------
--EJERCICIO #5, MEDIANTE CONSULTAS RECUPERAR SALARIO MAXIMO Y MINIMO DE LA EMPRESA 
-----------------------------------------------------------------------------------

SELECT MIN (SALARY) SALARIO_MINIMO,  MAX (SALARY) SALARIO_MAXIMO,  
MAX (SALARY)-MIN (SALARY) DIFERENCIA FROM EMPLOYEES ;

