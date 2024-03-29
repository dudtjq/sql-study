
-- 테이블 생성과 제약조건
-- : 테이블에 부적절한 데이터가 입력되는 것을 방지하기 위해 규칙을 설정하는 것.

-- 테이블 열레벨 제약조건 (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: 테이블의 고유 식별 컬럼입니다. (주요 키)
-- UNIQUE: 유일한 값을 갖게 하는 컬럼 (중복값 방지)
-- NOT NULL: null을 허용하지 않음. (필수값)
-- FOREIGN KEY: 참조하는 테이블의 PRIMARY KEY를 저장하는 컬럼
-- CHECK: 정의된 형식만 저장되도록 허용.

-- 컬럼 레벨 제약 조건 (컬럼 선언마다 제약조건 지정)
CREATE TABLE dept2(
    dept_no NUMBER(2) CONSTRAINT dept2_dept_no_pk PRIMARY KEY, -- 제약조건 식별자는 생략이 가능(생략시 오라클이 알아서 이름을 지음)
    dept_name VARCHAR2(14) NOT NULL CONSTRAINT dept2_deptname_uk UNIQUE,
    loca NUMBER(4) CONSTRAINT dept2_loca_locid_fk REFERENCES locations(location_id),
    dept_bonus NUMBER(10) CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 10000),
    dept_gender VARCHAR2(1) CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'))
) ;

DROP TABLE dept2;

-- 테이블 레벨 제약 조건(모든 열 선언 후 제약 조건을 취하는 방식)
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

-- 외래 키(FOREIGN KEY)가 부모테이블(참조테이블)에 없다면 INSERT 불가능
INSERT INTO dept2
VALUES(10, '개발부', 6542, 90000, 'M');-- 에러 -> 6542번 지역은 없음

ROLLBACK;

INSERT INTO dept2
VALUES(20, '영업부', 1900, 90000, 'M');


UPDATE dept2 
SET loca = 4000
WHERE dept_no = 10; -- 에러 (외래 키 제약조건 위반)

UPDATE dept2 
SET dept_no = 20
WHERE dept_no = 10; -- 에러 (주요 키 제약조건 위반 )

UPDATE dept2 
SET dept_bonus = 900
WHERE dept_no = 10; -- 에러 (체크 제약조건 위반)


-- 테이블 생성 이후 제약조건 추가 및 변경, 삭제
-- 제약 조건은 추가와 삭제만 가능하다 변경은 x
-- 변경하려면 삭제 후 새로운 내용으로 추가 해야함
CREATE TABLE dept2(
    dept_no NUMBER(2), 
    dept_name VARCHAR2(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1)
);

-- pk 추가
ALTER TABLE dept2 ADD CONSTRAINT dept2_deptno_pk PRIMARY KEY(dept_no);

-- fk 추가
ALTER TABLE dept2 ADD CONSTRAINT dept2_loca_locid_fk
FOREIGN KEY(loca) REFERENCES locations(location_id);

-- check 추가
ALTER TABLE dept2 ADD CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 10000);

-- unique 추가
ALTER TABLE dept2 ADD CONSTRAINT dept2_deptname_uk UNIQUE(dept_name);

-- NOT NULL 은 열 수정형태로 변경함
ALTER TABLE dept2 MODIFY dept_bonus NUMBER(10) NOT NULL;

-- 제약 조건 확인 
SELECT * FROM user_constraints
WHERE table_name = 'DEPT2';

-- 제약 조건 삭제(제약 조건의 이름으로 -> 이름을 직접 짓지 않았다면 오라클이 부여한 이름을 제시)
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

COMMIT;

SELECT 
    m.m_name, m.m_num,
    loc.street_address, loc.location_id
FROM members m
JOIN locations loc
ON m.loca = loc.location_id
ORDER BY m.m_num;





































