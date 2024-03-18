
-- WHILE ��
DECLARE

    v_total NUMBER := 0;
    v_count NUMBER := 1; -- begin

BEGIN

    WHILE v_count <= 10 -- end
    LOOP
        v_total := v_total + v_count;
        v_count := v_count +1; -- step
    END LOOP;
    dbms_output.put_line(v_total);
END;

-- Ż�⹮ (EXIT)

DECLARE

    v_total NUMBER := 0;
    v_count NUMBER := 1; -- begin

BEGIN
    WHILE v_count <= 10 -- end
    LOOP
        EXIT  WHEN v_count = 5;
        v_total := v_total + v_count;
        v_count := v_count +1; -- step
    END LOOP;
    dbms_output.put_line(v_total);
END;

-- FOR ��
DECLARE
    
    v_num NUMBER := 7;

BEGIN

    FOR i IN 1..9 -- .�� �ΰ� �ۼ��Ͽ� ������ ǥ��
    LOOP
        dbms_output.put_line(v_num || ' x ' || i || ' = ' || v_num * i);
    END LOOP;

END;

-- CONTINUE��

DECLARE
    
    v_num NUMBER := 7;

BEGIN

    FOR i IN 1..9 -- .�� �ΰ� �ۼ��Ͽ� ������ ǥ��
    LOOP
        CONTINUE WHEN MOD(i , 2) = 0;
        dbms_output.put_line(v_num || ' x ' || i || ' = ' || v_num * i);
    END LOOP;

END;

------------------------------------------------------------------

-- 1. ��� �������� ����ϴ� �͸� ����� ���弼��. (2 ~ 9��)
-- ¦���ܸ� ����� �ּ���. (2, 4, 6, 8)
-- ����� ����Ŭ ������ �߿��� �������� �˾Ƴ��� �����ڰ� �����. (% ����~)




BEGIN
    FOR v_num IN 2..9
        LOOP
        CONTINUE WHEN MOD(v_num , 2) != 0;
        FOR i IN 1..9 
            LOOP  
                dbms_output.put_line(v_num || ' x ' || i || ' = ' || v_num * i);
            END LOOP;
    END LOOP;
END;

-- 2. INSERT�� 300�� �����ϴ� �͸� ����� ó���ϼ���.
-- board��� �̸��� ���̺��� ���弼��. (bno, writer, title �÷��� �����մϴ�.)
-- bno�� SEQUENCE�� �÷� �ֽð�, writer�� title�� ��ȣ�� �ٿ��� INSERT ������ �ּ���.
-- ex) 1, test1, title1 -> 2 test2 title2 -> 3 test3 title3 ....



CREATE TABLE board(
    bno NUMBER PRIMARY KEY,
    writer VARCHAR2(30),
    title VARCHAR(30)
);

DROP TABLE board;
DROP SEQUENCE bno_seq;

CREATE SEQUENCE bno_seq 
    START WITH 1 -- ���۰� (�⺻���� ������ �� �ּҰ�, ������ �� �ִ밪)
    INCREMENT BY 1 -- ������(����� ����, ������ ����, �⺻�� 1)
    MAXVALUE 300 -- �ִ밪 (�⺻�� ������ �� 1027, ������ �� -1)
    MINVALUE 1
    NOCACHE -- ĳ�� �޸� ��� ����(CACHE)
    NOCYCLE;
    
DECLARE
    v_count NUMBER := 1;
BEGIN
   WHILE v_count <= 300 -- end
    LOOP
       INSERT INTO board
       VALUES(bno_seq.nextval, 'test' || v_count, 'title' || v_count);
       v_count := v_count + 1;
    END LOOP;
END;    
 SELECT * FROM board;






