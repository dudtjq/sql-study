-- MERGE : 테이블 병합

/*
UPDATE 와 INSERT 를 한 번에 처리

한 테이블에 해당하는 데이터가 존재한다면 UPDATE를
없으면 INSERT로 처리
*/

CREATE TABLE emps_it AS(SELECT * FROM employees WHERE 1 = 2);

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES
    (106, '춘식', '김', 'CHOONSIK', sysdate, 'IT_PROG');
    
SELECT * FROM emps_it;    

SELECT * FROM employees 
WHERE job_id = 'IT_PROG';

MERGE INTO emps_it a -- 머지를 할 타겟 테이블
    USING -- 병합시킬 데이터 (데이블 이름, 서브쿼리 등등...)
    (SELECT * FROM employees 
     WHERE job_id = 'IT_PROG') b -- 병합하고자 하는 데이터를 서브쿼리로 표현
     ON -- 병합 시킬 데이터의 연결 조건
     (a.employee_id = b.employee_id) --employ_id 컬럼을 통해 양쪽 테이블의 데이터 존재 유무 확인
     WHEN MATCHED THEN -- 바로 위에 작성한 조건이 일치하는 경우(데이터가 서로 있는 경우)
     UPDATE SET
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
        
    /*
    DELETE만 단독으로 쓸 수는 없습니다.
    UPDATE 이후에 DELETE 작성이 가능합니다.
    UPDATE 된 대상을 DELETE 하도록 설계되어 있기 때문에
    삭제할 대상 컬럼들을 동일한 값으로 일단 UPDATE를 진행하고
    DELETE의 WHERE절에 아까 지정한 동일한 값을 지정해서 삭제합니다.
    */    
    
    DELETE 
        WHERE a.employee_id = b.employee_id    
        
WHEN NOT MATCHED THEN -- 조건이 일치 하지 않는 경우
    INSERT VALUES
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);
     
SELECT * FROM emps_it;     
     
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(102, '렉스', '박', 'LEXPARK', '01/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(101, '니나', '최', 'NINA', '20/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(103, '흥민', '손', 'HMSON', '20/04/06', 'AD_VP');
     
/*
employees 테이블을 매번 빈번하게 수정되는 테이블이라고 가정하자.
기존의 데이터는 email, phone, salary, comm_pct, man_id, dept_id을
업데이트 하도록 처리
새로 유입된 데이터는 그대로 추가.
*/
     
MERGE INTO emps_it a
    USING
        employees b
    ON
        (a.employee_id = b.employee_id)
WHEN MATCHED THEN
    UPDATE SET
        a.email = b.email,
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
        
WHEN NOT MATCHED THEN    
     INSERT VALUES
       (b.employee_id, b.first_name, b.last_name,
        b.email, b.phone_number, b.hire_date, b.job_id,
        b.salary, b.commission_pct, b.manager_id, b.department_id);
 
SELECT * FROM emps_it
     
ROLLBACK;
     
-------------------------------------------------------
DROP TABLE depts;
CREATE TABLE depts AS(SELECT * FROM departments);

INSERT INTO depts
    (department_id, department_name, manager_id, location_id)
VALUES
    (280, '개발', null, 1800);
INSERT INTO depts
    (department_id, department_name, manager_id, location_id)
VALUES
    (290, '회계부', null, 1800);
INSERT INTO depts
    (department_id, department_name, manager_id, location_id)
VALUES
    (300, '재정', 301, 1800);
INSERT INTO depts
    (department_id, department_name, manager_id, location_id)
VALUES
    (310, '인사', 302, 1800);
INSERT INTO depts
    (department_id, department_name, manager_id, location_id)
VALUES
    (320, '영업', 303, 1700);
ROLLBACK;
SELECT * FROM depts;
    
-- 문제 2
-- 2 - 1
UPDATE depts SET department_name = 'IT_BANK'
WHERE department_name = 'IT Support';
     
-- 2 - 2    
UPDATE depts SET manager_id = 301
WHERE department_id = 290;

-- 2 - 3
UPDATE depts SET department_name = 'IT help',
    manager_id = 303,
    location_id = 1800
WHERE department_name = 'IT Helpdesk';
     
-- 2 - 4   
UPDATE depts
SET manager_id = 301
WHERE department_id IN (290, 300, 310, 320);
     
-- 문제 3 
DELETE FROM depts WHERE department_id = (SELECT department_id FROM depts 
                                        WHERE depts.department_name = '영업');

DELETE FROM depts WHERE department_id = (SELECT department_id FROM depts 
                                        WHERE depts.department_name = 'NOC');     
     
-- 문제 4
DELETE FROM depts WHERE depts.department_id > 200;

-- 4 - 2
UPDATE depts SET depts.manager_id = 100
WHERE depts.manager_id IS NOT NULL;

-- 4 - 4
MERGE INTO depts a
    USING departments d
    ON (a.department_id = d.department_id)
WHEN MATCHED THEN
    UPDATE SET 
        a.department_name = d.department_name,
        a.manager_id = d.manager_id,
        a.location_id = d.location_id

WHEN NOT MATCHED THEN
    INSERT VALUES
        (d.department_id, d.department_name, d.manager_id, d.location_id);
     