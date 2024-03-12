
SELECT * FROM info;
SELECT * FROM auth;

-- 이너(내부) 조인
SELECT
    * 
FROM info i
INNER JOIN auth a
ON i.auth_id = a.auth_id;

-- 오라클 전용 문법(오라클 전용 문법이라 앞으로는 작성 하지 않음 )
SELECT * 
FROM info i, auth a
WHERE i.auth_id = a.auth_id;

-- auth_id 컬럼을 그냥 쓰면 모호하다 라고 뜬다
-- 그 이유는 양쪽에 모두 존재하는 컬럼이니까
-- 컬럼에 테이블 이름을 붙이던지, 별칭을 사용하여
-- 확실하게 지목하기
SELECT 
    a.auth_id, i.title, i.content, a.name
FROM info i
JOIN auth a -- JOIN,이라고만 쓰면 기본 INNER JOIN
ON i.auth_id = a.auth_id;

-- 필요한 데이터만 조회하겠다 (일반 조건) 라고 하면
-- WHERE 구문을 통해 조건을 걸어주면 됨
SELECT 
    a.auth_id, i.title, i.content, a.name
FROM info i
JOIN auth a 
ON i.auth_id = a.auth_id
WHERE a.name = '이순신';

-- 아우터(외부) 조인
SELECT * 
FROM info i LEFT JOIN auth a
ON i.auth_id = a.auth_id;

SELECT *
FROM info i, auth a
WHERE i.auth_id = a.auth_id(+);






















