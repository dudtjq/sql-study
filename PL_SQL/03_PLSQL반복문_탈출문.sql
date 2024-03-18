
-- WHILE 문
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

-- 탈출문 (EXIT)

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

-- FOR 문
DECLARE
    
    v_num NUMBER := 7;

BEGIN

    FOR i IN 1..9 -- .을 두개 작성하여 범위를 표현
    LOOP
        dbms_output.put_line(v_num || ' x ' || i || ' = ' || v_num * i);
    END LOOP;

END;

-- CONTINUE문

DECLARE
    
    v_num NUMBER := 7;

BEGIN

    FOR i IN 1..9 -- .을 두개 작성하여 범위를 표현
    LOOP
        CONTINUE WHEN MOD(i , 2) = 0;
        dbms_output.put_line(v_num || ' x ' || i || ' = ' || v_num * i);
    END LOOP;

END;

------------------------------------------------------------------

-- 1. 모든 구구단을 출력하는 익명 블록을 만드세요. (2 ~ 9단)
-- 짝수단만 출력해 주세요. (2, 4, 6, 8)
-- 참고로 오라클 연산자 중에는 나머지를 알아내는 연산자가 없어요. (% 없음~)




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

-- 2. INSERT를 300번 실행하는 익명 블록을 처리하세요.
-- board라는 이름의 테이블을 만드세요. (bno, writer, title 컬럼이 존재합니다.)
-- bno는 SEQUENCE로 올려 주시고, writer와 title에 번호를 붙여서 INSERT 진행해 주세요.
-- ex) 1, test1, title1 -> 2 test2 title2 -> 3 test3 title3 ....



CREATE TABLE board(
    bno NUMBER PRIMARY KEY,
    writer VARCHAR2(30),
    title VARCHAR(30)
);

DROP TABLE board;
DROP SEQUENCE bno_seq;

CREATE SEQUENCE bno_seq 
    START WITH 1 -- 시작값 (기본값은 증가할 때 최소값, 감소할 때 최대값)
    INCREMENT BY 1 -- 증가값(양수면 증가, 음수면 감수, 기본값 1)
    MAXVALUE 300 -- 최대값 (기본값 증가일 때 1027, 감소일 때 -1)
    MINVALUE 1
    NOCACHE -- 캐시 메모리 사용 여부(CACHE)
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






