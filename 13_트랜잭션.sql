
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














