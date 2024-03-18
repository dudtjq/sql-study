SET SERVEROUTPUT on; -- ��¹� Ȱ��ȭ

DECLARE

    v_salary NUMBER := 0;
    v_department_id NUMBER := 0;
    
BEGIN

    v_department_id := ROUND(DBMS_RANDOM.VALUE(10, 110), -1);
    
    SELECT
        salary
    INTO 
        v_salary
    FROM employees 
    WHERE department_id = v_department_id
    AND ROWNUM = 1; -- ù° ���� ���ؼ� ������ ����
    
    IF
        v_salary <= 5000
    THEN 
        DBMS_OUTPUT.PUT_LINE('�޿��� �� ����');
    ELSIF
        v_salary <= 9000
    THEN 
        DBMS_OUTPUT.PUT_LINE('�޿��� �߰���');
    ELSE    
        DBMS_OUTPUT.PUT_LINE('�޿��� ����');
    END IF;    
        
END;

-- CASE ��

DECLARE

    v_salary NUMBER := 0;
    v_department_id NUMBER := 0;
    
BEGIN

    v_department_id := ROUND(DBMS_RANDOM.VALUE(10, 110), -1);
    
    SELECT
        salary
    INTO 
        v_salary
    FROM employees 
    WHERE department_id = v_department_id
    AND ROWNUM = 1; -- ù° ���� ���ؼ� ������ ����
    
    CASE 
        WHEN v_salary <= 5000 THEN
             DBMS_OUTPUT.PUT_LINE('�޿��� �� ����');
        WHEN v_salary <= 9000 THEN 
            DBMS_OUTPUT.PUT_LINE('�޿��� �߰���');
        ELSE
            DBMS_OUTPUT.PUT_LINE('�޿��� ����');
        END CASE;    
END;

-- ��ø IF ��

DECLARE

    v_salary NUMBER := 0;
    v_department_id NUMBER := 0;
    v_commission NUMBER := 0;
    
BEGIN

    v_department_id := ROUND(DBMS_RANDOM.VALUE(10, 110), -1);
    
    SELECT
        salary, commission_pct
    INTO 
        v_salary, v_commission
    FROM employees 
    WHERE department_id = v_department_id
    AND ROWNUM = 1; -- ù° ���� ���ؼ� ������ ����
    
    IF v_commission  > 0 THEN
        IF v_commission > 0.15 THEN
          DBMS_OUTPUT.PUT_LINE('Ŀ�̼��� 15% �̻��Դϴ�.');
          DBMS_OUTPUT.PUT_LINE(v_salary * v_commission);
        END IF; 
        
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Ŀ�̼��� �����ϴ�.');
    END IF; 
        
END;










