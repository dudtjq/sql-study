/*
���ν����� divisor_proc
���� �ϳ��� ���޹޾� �ش� ���� ����� ������ ����ϴ� ���ν����� �����մϴ�.
*/

CREATE OR REPLACE PROCEDURE divisor_proc
    (v_num IN NUMBER)
IS 
    v_cut NUMBER := 0;
BEGIN
    
    FOR i IN 1..v_num
    LOOP
       IF MOD(v_num , 2) = 0 THEN 
        v_cut := v_cut + 1;
        END IF;
    END LOOP;
    dbms_output.put_line('����� ���� : ' || v_cut || '��');
END;

EXEC divisor_proc(8);


/*
�μ���ȣ, �μ���, �۾� flag(I: insert, U:update, D:delete)�� �Ű������� �޾� 
depts ���̺� 
���� INSERT, UPDATE, DELETE �ϴ� depts_proc �� �̸��� ���ν����� ������.
�׸��� ���������� commit, ���ܶ�� �ѹ� ó���ϵ��� ó���ϼ���.
*/

SELECT * FROM depts;

CREATE OR REPLACE PROCEDURE depts_proc
    (depts_deptm IN depts_department_id%TYPE,
     depts_deptn IN depts_department_name%TYPE,
     depts_flag IN VARCHAR2
    )
IS
    v_cnt NUMBER := 0;
BEGIN
    
    SELECT 
        COUNT(1)
    INTO
        v_cnt
    FROM depts
    WHERE department_id = depts_deptm;
    
    IF depts_flag = 'I' THEN
        INSERT INTO depts
        (department_id, department_name)
        VALUES(depts_deptm, depts_deptn);
    ELSIF depts_flag = 'U' THEN
        UPDATE depts
        SET department_name = depts_deptn
        WHERE department_id = depts_deptm;
    ELSIF depts_flag = 'D' THEN
        dbms_output.put_line('�����ϰ��� �ϴ� �μ��� ���� ���� �ʽ��ϴ�.');
        RETURN;
        DELETE FROM depts
        WHERE department_id = depts_deptm;
        
    ELSE
        dbms_output.put_line('�ش� flag�� ���� ������ �غ���� �ʾҽ��ϴ�.');
     END IF;
     
     COMMIT;
     
     EXCEPTION 
        WHEN OTHERS THEN
            dbms_output.put_line('���ܰ� �߻��Ͽ����ϴ�.');
            dbms_output.put_line('SQL ERROR CODE : ' || SQLCODE);
            dbms_output.put_line('SQL ERROR MSG : ' || SQLERRM);
            ROLLBACK;
END;

EXEC depts_proc(400, '���ߺ�', 'I');


/*
employee_id�� ���޹޾� employees�� �����ϸ�,
�ټӳ���� out�ϴ� ���ν����� �ۼ��ϼ���. (�͸��Ͽ��� ���ν����� ����)
���ٸ� exceptionó���ϼ���
*/

CREATE OR REPLACE PROCEDURE emp_hire_date
    (
        p_emp_id IN employees.employee_id%TYPE,
        p_year OUT NUMBER
    )

IS
    v_hire_date DATE;
BEGIN
    SELECT
        employees.hire_date
    INTO 
        v_hire_date
    FROM employees
    WHERE employee_id = p_emp_id;
    
    p_year := TRUNC((sysdate - v_hire_date) / 365);
    
     EXCEPTION
     WHEN OTHERS THEN
            dbms_output.put_line(p_emp_id ||'��(��) ���� ������ �Դϴ�.');
            p_year := 0;
END;

DECLARE
    v_year NUMBER;
BEGIN
    emp_hire_date(100, v_year);
    IF v_year > 0 THEN
    dbms_output.put_line('�ټӳ�� : ' || v_year || '��');
    END IF;
END;















