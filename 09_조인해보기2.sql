
SELECT * FROM info;
SELECT * FROM auth;

-- �̳�(����) ����
SELECT
    * 
FROM info i
INNER JOIN auth a
ON i.auth_id = a.auth_id;

-- ����Ŭ ���� ����(����Ŭ ���� �����̶� �����δ� �ۼ� ���� ���� )
SELECT * 
FROM info i, auth a
WHERE i.auth_id = a.auth_id;

-- auth_id �÷��� �׳� ���� ��ȣ�ϴ� ��� ���
-- �� ������ ���ʿ� ��� �����ϴ� �÷��̴ϱ�
-- �÷��� ���̺� �̸��� ���̴���, ��Ī�� ����Ͽ�
-- Ȯ���ϰ� �����ϱ�
SELECT 
    a.auth_id, i.title, i.content, a.name
FROM info i
JOIN auth a -- JOIN,�̶�� ���� �⺻ INNER JOIN
ON i.auth_id = a.auth_id;

-- �ʿ��� �����͸� ��ȸ�ϰڴ� (�Ϲ� ����) ��� �ϸ�
-- WHERE ������ ���� ������ �ɾ��ָ� ��
SELECT 
    a.auth_id, i.title, i.content, a.name
FROM info i
JOIN auth a 
ON i.auth_id = a.auth_id
WHERE a.name = '�̼���';

-- �ƿ���(�ܺ�) ����
SELECT * 
FROM info i LEFT JOIN auth a
ON i.auth_id = a.auth_id;

SELECT *
FROM info i, auth a
WHERE i.auth_id = a.auth_id(+);






















