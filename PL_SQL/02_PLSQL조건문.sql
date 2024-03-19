set serveroutput on;

DECLARE -- 변수를 선언하는 구간(선언부)

    emp_num NUMBER; -- 변수 선언
    
BEGIN -- 코드를 실행하는 구간(실행부)

    emp_num := 10; -- 대입 연산자 :=
    DBMS_OUTPUT.put_line(emp_num);
    DBMS_OUTPUT.put_line('Hello Worid!');
    
END;

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
    AND ROWNUM = 1; -- 첫째 값만 구해서 변수에 저장
    
    IF
        v_salary <= 5000
    THEN 
        DBMS_OUTPUT.PUT_LINE('급여가 좀 낮음');
    ELSIF
        v_salary <= 9000
    THEN 
        DBMS_OUTPUT.PUT_LINE('급여가 중간임');
    ELSE    
        DBMS_OUTPUT.PUT_LINE('급여가 높음');
    END IF;    
        
END;

-- CASE 문

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
    AND ROWNUM = 1; -- 첫째 값만 구해서 변수에 저장
    
    CASE 
        WHEN v_salary <= 5000 THEN
             DBMS_OUTPUT.PUT_LINE('급여가 좀 낮음');
        WHEN v_salary <= 9000 THEN 
            DBMS_OUTPUT.PUT_LINE('급여가 중간임');
        ELSE
            DBMS_OUTPUT.PUT_LINE('급여가 높음');
        END CASE;    
END;

-- 중첩 IF 문

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
    AND ROWNUM = 1; -- 첫째 값만 구해서 변수에 저장
    
    IF v_commission  > 0 THEN
        IF v_commission > 0.15 THEN
          DBMS_OUTPUT.PUT_LINE('커미션이 15% 이상입니다.');
          DBMS_OUTPUT.PUT_LINE(v_salary * v_commission);
        END IF; 
        
    ELSE 
        DBMS_OUTPUT.PUT_LINE('커미션이 없습니다.');
    END IF; 
        
END;










