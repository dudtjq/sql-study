
-- �׷� �Լ� AVG, MAX, MIN, SUM, COUNT
-- �׷�ȭ�� ���� �������� ������ �׷��� ���̺� ��ü�� ��
SELECT 
    AVG(salary),
    MAX(salary),
    MIN(salary),
    SUM(salary),
    COUNT(salary)
FROM employees;

SELECT COUNT(1) FROM employees; -- �� �� �������� ��
SELECT COUNT(first_name) FROM employees;
SELECT COUNT(commission_pct) FROM employees; -- null�� �ƴ� ���� ��
SELECT COUNT(manager_id) FROM employees; -- null�� �ƴ� ���� ��

-- �μ����� �׷�ȭ, �׷��Լ��� ���
SELECT 
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id;

-- ���� �� ��
-- �׷� �Լ��� �ܵ������� ���� ���� ��ü ���̺��� �׷��� ����� ������
-- �Ϲ� �÷��� ���ÿ� �׳� ��� �� ���� ���� �׷��� �ʿ�
SELECT 
    department_id,
    AVG(salary)
FROM employees; -- error

-- GROUP BY ���� ����Ҷ� GROUP���� ������ ���� �÷��� ��ȸ�� �Ұ�����
SELECT 
    job_id,
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id;-- ����

-- GROUP BY �� 2�� �̻� ��� ����
SELECT 
    job_id,
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id, job_id;

-- GROUP BY �� ���� �׷�ȭ �� �� ������ �� ��� HAVING�� ���
-- WHERE�� �Ϲ� ������, GROUP BY ���� ���� ����
SELECT 
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 100000;


SELECT
    job_id,
    COUNT(1)
FROM employees
GROUP BY job_id
HAVING COUNT(1) >= 5;

-- �μ� ���̵� 50�̻��� �͵��� �׷�ȭ ��Ű�� , �׷� �޿� ����� 5000
-- �̻� ��ȸ
SELECT
    department_id,
    AVG(salary) AS ���
FROM employees
WHERE department_id >= 50
GROUP BY department_id
HAVING AVG(salary) >= 5000
ORDER BY ��� DESC;

/*
���� 1.
1-1. ��� ���̺��� JOB_ID�� ��� ���� ���ϼ���.
1-2. ��� ���̺��� JOB_ID�� ������ ����� ���ϼ���. ������ ��� ������ �������� �����ϼ���.
*/

SELECT
    job_id,
    COUNT(1),
    AVG(salary) AS ��տ���
FROM employees
GROUP BY job_id
ORDER BY ��տ��� DESC;

/*
���� 2.
��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ���.
(TO_CHAR() �Լ��� ����ؼ� ������ ��ȯ�մϴ�. �׸��� �װ��� �׷�ȭ �մϴ�.)
*/

SELECT 
    TO_CHAR(hire_date, 'YY') AS �Ի�⵵,
    COUNT(1) AS �����
FROM employees
GROUP BY TO_CHAR(hire_date, 'YY')
ORDER BY �Ի�⵵;



/*
���� 3.
�޿��� 5000 �̻��� ������� �μ��� ��� �޿��� ����ϼ���. 
�� �μ� ��� �޿��� 7000�̻��� �μ��� ����ϼ���.
*/
    
SELECT 
    department_id,
    AVG(salary)
FROM employees
WHERE salary >= 5000
GROUP BY department_id
HAVING AVG(salary) >= 7000;


/*
���� 4.
��� ���̺��� commission_pct(Ŀ�̼�) �÷��� null�� �ƴ� �������
department_id(�μ���) salary(����)�� ���, �հ�, count�� ���մϴ�.
���� 1) ������ ����� Ŀ�̼��� �����Ų �����Դϴ�.
���� 2) ����� �Ҽ� 2° �ڸ����� ���� �ϼ���.
*/

SELECT
    department_id AS �μ���,
    TRUNC(AVG(salary + salary * commission_pct), 2) AS �������,
    SUM(salary + salary * commission_pct) AS �����հ�,
    COUNT(1)
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id;






























