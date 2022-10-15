---------------------------------------------------------------------
---------------------------------------------------------------------
--TAREA 3, EJERCICIO 1.A
SET SERVEROUTPUT ON

DECLARE
    CURSOR C1 IS SELECT FIRST_NAME , LAST_NAME, SALARY FROM EMPLOYEES;
BEGIN
    FOR I IN C1 LOOP
    IF I.FIRST_NAME='Peter' AND I.LAST_NAME='Tucker' THEN
            RAISE_APPLICATION_ERROR(-20001, 'NO SE PUEDE VER EL SUELDO DEL JEFE.');
         END IF;
        dbms_output.put_line(I.FIRST_NAME||' '||I.LAST_NAME||': '||I.SALARY);
         
    END LOOP;
END;

---------------------------------------------------------------------
---------------------------------------------------------------------
--TAREA 3, EJERCICIO 1.B

DECLARE
    CURSOR C1(DEPART NUMBER) IS SELECT * FROM EMPLOYEES
    WHERE DEPARTMENT_ID = DEPART;
    CANT_EMPL NUMBER:=0;
    CANT_DEP NUMBER;
BEGIN
    FOR I IN C1(&DEPART) LOOP
        --DBMS_OUTPUT.PUT_LINE(I.DEPARTMENT_ID);
        CANT_EMPL:=CANT_EMPL+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('CANTIDAD DE EMPLEADOS: '||CANT_EMPL);
END;

---------------------------------------------------------------------
---------------------------------------------------------------------
--TAREA 3, EJERCICIO 1.C

DECLARE
    CURSOR C1 IS SELECT LAST_NAME, FIRST_NAME, SALARY FROM EMPLOYEES;
    AUMENTO EMPLOYEES.SALARY%TYPE;
    NUEVO_SUELDO EMPLOYEES.SALARY%TYPE;
BEGIN
    AUMENTO:=0;
    NUEVO_SUELDO:=0;
    FOR I IN C1 LOOP
        IF I.SALARY>=8000 THEN
            AUMENTO:=0.02*I.SALARY;
            NUEVO_SUELDO:=AUMENTO+I.SALARY;
        ELSE
            AUMENTO:=0.03*I.SALARY;
            NUEVO_SUELDO:=I.SALARY+AUMENTO;
        END IF;
    
        DBMS_OUTPUT.PUT_LINE(
        'EMPLEADO : '||I.LAST_NAME||' '||I.FIRST_NAME ||chr(10)||
        'SUELDO : '||I.SALARY||CHR(10)||
        'SUELDO CON AUMENTO : '||NUEVO_SUELDO||CHR(10)||
        '-----------------------------------'
        );
    END LOOP;
END;

---------------------------------------------------------------------
---------------------------------------------------------------------
--TAREA 3, EJERCICIO 2.A

CREATE OR REPLACE FUNCTION CREGION (NOMBRE VARCHAR2)
    RETURN NUMBER IS
    REGIONES NUMBER;
    NREGION VARCHAR2(100);
BEGIN

    SELECT REGION_NAME INTO NREGION FROM REGIONS
    WHERE REGION_NAME=UPPER(NOMBRE);
    RAISE_APPLICATION_ERROR(-20002,'REGION EXISTENTE');
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        SELECT MAX(REGION_ID)+1 INTO REGIONES FROM REGIONS;
        INSERT INTO REGIONS (REGION_ID,REGION_NAME) VALUES
        (REGIONES,UPPER(NOMBRE));
    RETURN REGIONES;
END;

------------------------------------------------------------
DECLARE
    NREGION NUMBER;
BEGIN
    NREGION:=CREGION('NORMANDIA');
    DBMS_OUTPUT.PUT_LINE('NUMERO :'||NREGION);
END;

---------------------------------------------------------------------
---------------------------------------------------------------------
--TAREA 3, EJERCICIO 3.A
 CREATE OR REPLACE PROCEDURE CALCULADORA 
(   NUM1        IN NUMBER,
    NUM2        IN NUMBER,
    OPERACION   IN NUMBER,
    RESULTADO   OUT NUMBER)
IS
BEGIN
    CASE 
        WHEN OPERACION=1 THEN
            RESULTADO:= NUM1+NUM2;
        WHEN OPERACION=2 THEN
            RESULTADO:= NUM1-NUM2;
        WHEN OPERACION=3 THEN
            RESULTADO:= NUM1*NUM2;    
        WHEN OPERACION=4 THEN
        IF NUM2=0 THEN
            RAISE_APPLICATION_ERROR(-20001,'NO SE PUEDE DIVIDIR ENTRE CERO');
        END IF;
        RESULTADO:= NUM1/NUM2;
            
        ELSE RAISE_APPLICATION_ERROR(-20000,'OPERACION INCORRECTA'); 
    END CASE;
    DBMS_OUTPUT.PUT_line('RESULTADO:'||RESULTADO);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_line('NO EXISTE EL EMPLEADO');
END;
----------------------------------------------------------------------------------
DECLARE
    A NUMBER;
    B NUMBER;
    C NUMBER;
    R NUMBER;
BEGIN
    A:=50;
    B:=5;
    C:=1;
    R:=0;
    CALCULADORA(A,B,C,R);
END;
