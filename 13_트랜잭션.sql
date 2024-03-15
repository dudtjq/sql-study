
-- ���� Ŀ�� Ȱ��ȭ ���� Ȯ��
SHOW AUTOCOMMIT;
-- ���� Ŀ�� ��
SET AUTOCOMMIT ON;
-- ���� Ŀ�� ����
SET AUTOCOMMIT OFF;

SELECT * FROM emps;

DELETE FROM emps WHERE employee_id = 100;

INSERT INTO emps
    (emps.employee_id, emps.last_name, emps.email, emps.hire_date, emps.job_id)
VALUES
    (304, 'lee', 'lee1234@gmail', sysdate, 'test');

-- �������� ��� ������ ��������� ���(���)
-- ���� Ŀ�� �ܰ�� ȸ��(���ư���) �� Ʈ����� ����
ROLLBACK;

-- ���̺� ����Ʈ ����
-- �ѹ��� ����Ʈ�� ���� �̸��� �ٿ��� ����
-- ANSI ǥ�� ������ �ƴϱ� ������ �׷��� ���������� ����
SAVEPOINT insert_park;

INSERT INTO emps
    (emps.employee_id, emps.last_name, emps.email, emps.hire_date, emps.job_id)
VALUES
    (305, 'park', 'park1234@gmail', sysdate, 'test');

ROLLBACK TO SAVEPOINT insert_park;

DELETE FROM emps WHERE emps.employee_id = 304;

-- �������� ��絥���� ��������� ���������� �����ϸ鼭 Ʈ����� ����
-- Ŀ�� �Ŀ��� ��� ����� ����ϴ��� �ǵ��� �� ����
COMMIT;









