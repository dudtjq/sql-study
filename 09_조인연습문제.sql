/*
���� 1.
-EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
-EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ�
���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� �ּ����� �ۼ�)
*/


SELECT 
    *
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id; -- 106

SELECT 
    *
FROM employees e
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id; -- 107

SELECT 
    *
FROM employees e
RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id; -- 122

SELECT 
    *
FROM employees e
FULL OUTER JOIN departments d
ON e.department_id = d.department_id; -- 123

/*
���� 2.
-EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
����)employee_id�� 200�� ����� �̸�, department_name�� ����ϼ���
����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�
*/

SELECT 
    e.first_name || ' ' || e.last_name    
FROM employees e
INNER JOIN departments
ON e.department_id = d.department_id
WHERE e.employee_id = 200;


/*
���� 3.
-EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
HINT) � �÷����� ���� ����Ǿ� �ִ��� Ȯ��
*/


/*
���� 4.
--JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.
*/


/*
���� 5.
--Steven King�� �μ����� ����ϼ���.
*/


/*
���� 6.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���
*/