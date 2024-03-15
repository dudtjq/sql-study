
-- ���̺� ������ ��������
-- : ���̺� �������� �����Ͱ� �ԷµǴ� ���� �����ϱ� ���� ��Ģ�� �����ϴ� ��.

-- ���̺� ������ �������� (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: ���̺��� ���� �ĺ� �÷��Դϴ�. (�ֿ� Ű)
-- UNIQUE: ������ ���� ���� �ϴ� �÷� (�ߺ��� ����)
-- NOT NULL: null�� ������� ����. (�ʼ���)
-- FOREIGN KEY: �����ϴ� ���̺��� PRIMARY KEY�� �����ϴ� �÷�
-- CHECK: ���ǵ� ���ĸ� ����ǵ��� ���.

-- �÷� ���� ���� ���� (�÷� ���𸶴� �������� ����)
CREATE TABLE dept2(
    dept_no NUMBER(2) CONSTRAINT dept2_dept_no_pk PRIMARY KEY, -- �������� �ĺ��ڴ� ������ ����(������ ����Ŭ�� �˾Ƽ� �̸��� ����)
    dept_name VARCHAR2(14) NOT NULL CONSTRAINT dept2_deptname_uk UNIQUE,
    loca NUMBER(4) CONSTRAINT dept2_loca_locid_fk REFERENCES locations(location_id),
    dept_bonus NUMBER(10) CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 10000),
    dept_gender VARCHAR2(1) CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'))
) ;

DROP TABLE dept2;

-- ���̺� ���� ���� ����(��� �� ���� �� ���� ������ ���ϴ� ���)
CREATE TABLE dept2(
    dept_no NUMBER(2), 
    dept_name VARCHAR2(14) CONSTRAINT dept2_name_notnull NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1),

    CONSTRAINT dept2_dept_no_pk PRIMARY KEY(dept_no),
    CONSTRAINT dept2_deptname_uk UNIQUE(dept_name),
    CONSTRAINT dept2_loca_locid_fk FOREIGN KEY(loca) REFERENCES locations(location_id),
    CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 10000),
    CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'))
) ;

-- �ܷ� Ű(FOREIGN KEY)�� �θ����̺�(�������̺�)�� ���ٸ� INSERT �Ұ���
INSERT INTO dept2
VALUES(10, '���ߺ�', 6542, 90000, 'M');-- ���� -> 6542�� ������ ����

ROLLBACK;

INSERT INTO dept2
VALUES(20, '������', 1900, 90000, 'M');


UPDATE dept2 
SET loca = 4000
WHERE dept_no = 10; -- ���� (�ܷ� Ű �������� ����)

UPDATE dept2 
SET dept_no = 20
WHERE dept_no = 10; -- ���� (�ֿ� Ű �������� ���� )

UPDATE dept2 
SET dept_bonus = 900
WHERE dept_no = 10; -- ���� (üũ �������� ����)


-- ���̺� ���� ���� �������� �߰� �� ����, ����
-- ���� ������ �߰��� ������ �����ϴ� ������ x
-- �����Ϸ��� ���� �� ���ο� �������� �߰� �ؾ���
CREATE TABLE dept2(
    dept_no NUMBER(2), 
    dept_name VARCHAR2(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1)
);

-- pk �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_deptno_pk PRIMARY KEY(dept_no);

-- fk �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_loca_locid_fk
FOREIGN KEY(loca) REFERENCES locations(location_id);

-- check �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 10000);

-- unique �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_deptname_uk UNIQUE(dept_name);

-- NOT NULL �� �� �������·� ������
ALTER TABLE dept2 MODIFY dept_bonus NUMBER(10) NOT NULL;

-- ���� ���� Ȯ�� 
SELECT * FROM user_constraints
WHERE table_name = 'DEPT2';

-- ���� ���� ����(���� ������ �̸����� -> �̸��� ���� ���� �ʾҴٸ� ����Ŭ�� �ο��� �̸��� ����)
ALTER TABLE dept2 DROP CONSTRAINT dept2_deptno_pk;


--------------------------------------------------------

CREATE TABLE members (
    m_name VARCHAR2(10) CONSTRAINT m_name_notnull NOT NULL,
    m_num NUMBER(3) CONSTRAINT m_num_no_pk PRIMARY KEY,
    reg_date DATE NOT NULL CONSTRAINT m_date_uk UNIQUE,
    gender VARCHAR2(1) CONSTRAINT m_gender_ck CHECK(gender IN('M', 'F')),
    loca NUMBER(4) CONSTRAINT m_loca_locid_fk REFERENCES locations(location_id)
 );

INSERT INTO members
VALUES('AAA', 1, '2018-07-01', 'M', 1800);

INSERT INTO members
VALUES('BBB', 2, '2018-07-02', 'F', 1900);

INSERT INTO members
VALUES('CCC', 3, '2018-07-03', 'M', 2000);

INSERT INTO members
VALUES('DDD', 4, sysdate, 'M', 2000);

SELECT * FROM members;

SELECT 
    m.m_name, m.m_num,
    loc.street_address, loc.location_id
FROM members m
JOIN locations loc
ON m.loca = loc.location_id
ORDER BY m.m_num;





































