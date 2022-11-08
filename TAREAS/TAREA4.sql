--------------------------------------------------------------------
--EJERCICIO #1
--------------------------------------------------------------------

CREATE OR REPLACE TRIGGER TR_E1 BEFORE
DELETE ON EMPLOYEES FOR EACH ROW
BEGIN
    IF
        :OLD.JOB_ID LIKE '%CLERK' THEN
        RAISE_APPLICATION_ERROR(-20010,'ESTE REGISTRO NO SE PUEDE BORRAR');
    END IF;
END;
--------------------------------------------
DELETE FROM EMPLOYEES WHERE EMPLOYEE_ID=150;

--------------------------------------------------------------------
--EJERCICIO #2
--------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TR_E2 BEFORE
INSERT ON DEPARTMENTS FOR EACH ROW
DECLARE
BEGIN
    UPDATE DEPARTMENT_ID
    SET MANAGER_ID=NULL-:NEW.CANTIDAD WHERE MANAGER_ID=:NEW.CODIGOPRODUCTO;
END;
--------------------------------------------------------------------
--EJERCICIO #3
--------------------------------------------------------------------

CREATE OR REPLACE TRIGGER TG_E3
AFTER INSERT OR UPDATE OR DELETE ON EMPLEADOS
FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN 
    IF INSERTING THEN
        INSERT INTO LOG_SALARIO VALUES (SQ_LOG_SALARIO.NEXTVAL, 'INSERT REALIZADO CON EXITO, 
        EL NUEVO VALOR ES: '||:NEW.SALARIO_ACTUAL||'NOMBRE: '||:NEW.NOMBRE,
        SYSTIMESTAMP, USER, 'INSERT');
        END IF;
    IF UPDATING THEN
        INSERT INTO LOG_SALARIO  VALUES (SQ_LOG_SALARIO.NEXTVAL, 'UPDATE REALIZADO CON EXITO,
        ANTIGUO NOMBRE: '||:OLD.SALARIO_ANTERIOR||'NUEVO NOMBRE: '||:NEW.NOMBRE,
        SYSTIMESTAMP, USER, 'UPDATING');
        END IF;
    COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
END;



