
-- 오토 커밋 활성화 여부 확인
SHOW AUTOCOMMIT;
-- 오토 커밋 온
SET AUTOCOMMIT ON;
-- 오토 커밋 오프
SET AUTOCOMMIT OFF;

SELECT * FROM emps;

DELETE FROM emps WHERE employee_id = 100;

INSERT INTO emps
    (emps.employee_id, emps.last_name, emps.email, emps.hire_date, emps.job_id)
VALUES
    (304, 'lee', 'lee1234@gmail', sysdate, 'test');

-- 보류중인 모든 데이터 변경사항을 취소(폐기)
-- 직전 커밋 단계로 회귀(돌아가기) 및 트랜잭션 종료
ROLLBACK;

-- 세이브 포인트 생성
-- 롤백할 포인트를 직접 이름을 붙여서 지정
-- ANSI 표준 문법은 아니기 떄문에 그렇게 권장하지는 않음
SAVEPOINT insert_park;

INSERT INTO emps
    (emps.employee_id, emps.last_name, emps.email, emps.hire_date, emps.job_id)
VALUES
    (305, 'park', 'park1234@gmail', sysdate, 'test');

ROLLBACK TO SAVEPOINT insert_park;

DELETE FROM emps WHERE emps.employee_id = 304;

-- 보류중인 모든데이터 변경사항을 영구적으로 저용하면서 트랜잭션 종료
-- 커밋 후에는 어떠한 방법을 사용하더라도 되돌릴 수 없다
COMMIT;









