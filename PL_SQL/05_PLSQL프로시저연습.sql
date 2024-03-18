/*
프로시저명 divisor_proc
숫자 하나를 전달받아 해당 값의 약수의 개수를 출력하는 프로시저를 선언합니다.
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
    dbms_output.put_line('약수의 갯수 : ' || v_cut || '개');
END;

EXEC divisor_proc(8);


/*
부서번호, 부서명, 작업 flag(I: insert, U:update, D:delete)을 매개변수로 받아 
depts 테이블에 
각각 INSERT, UPDATE, DELETE 하는 depts_proc 란 이름의 프로시저를 만들어보자.
그리고 정상종료라면 commit, 예외라면 롤백 처리하도록 처리하세요.
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
        dbms_output.put_line('삭제하고자 하는 부서가 존재 하지 않습니다.');
        RETURN;
        DELETE FROM depts
        WHERE department_id = depts_deptm;
        
    ELSE
        dbms_output.put_line('해당 flag에 대한 동작이 준비되지 않았습니다.');
     END IF;
     
     COMMIT;
     
     EXCEPTION 
        WHEN OTHERS THEN
            dbms_output.put_line('예외가 발생하였습니다.');
            dbms_output.put_line('SQL ERROR CODE : ' || SQLCODE);
            dbms_output.put_line('SQL ERROR MSG : ' || SQLERRM);
            ROLLBACK;
END;

EXEC depts_proc(400, '개발부', 'I');


/*
employee_id를 전달받아 employees에 존재하면,
근속년수를 out하는 프로시저를 작성하세요. (익명블록에서 프로시저를 실행)
없다면 exception처리하세요
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
            dbms_output.put_line(p_emp_id ||'은(는) 없는 데이터 입니다.');
            p_year := 0;
END;

DECLARE
    v_year NUMBER;
BEGIN
    emp_hire_date(100, v_year);
    IF v_year > 0 THEN
    dbms_output.put_line('근속년수 : ' || v_year || '년');
    END IF;
END;















