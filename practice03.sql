use employee;
-- EMPLOYEE 테이블에서 직원들의 주민번호를 조회하여
-- 사원명, 생년, 생월, 생일을 각각 분리하여 조회
-- 단, 컬럼의 별칭은 사원명, 생년, 생월, 생일로 한다.

select EMP_NAME, substring(EMP_NO,1,2) as 년,substring(EMP_NO,3,2) as 월,substring(EMP_NO,5,2) as 일
from employee;

-- 날짜 데이터에서 사용할 수 있다.
-- 직원들의 입사일에도 입사년도, 입사월, 입사날짜를 분리 조회
select EMP_NAME, substring(HIRE_DATE,1,4) as 년,substring(HIRE_DATE,6,2) as 월,substring(HIRE_DATE,9,2) as 일
from employee;

-- WHERE 절에서 함수 사용도 가능하다.
-- 여직원들의 모든 컬럼 정보를 조회

select *
from employee
where substring(EMP_NO,8,1)=2;

-- 함수 중첩 사용 가능 : 함수안에서 함수를 사용할 수 있음
-- EMPLOYEE 테이블에서 사원명, 주민번호 조회
-- 단, 주민번호는 생년월일만 보이게 하고, '-'다음의 값은
-- '*'로 바꿔서 출력

select EMP_NAME, insert(EMP_NO,8,7,repeat('*',7)) as EMP_NO
from employee;

-- EMPLOYEE 테이블에서 사원명, 이메일,
-- @이후를 제외한 아이디 조회

select EMP_NAME, substring_index(EMAIL,'@',1) as ID
from employee;

-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사후 6개월이
-- 되는 날짜를 조회

select EMP_NAME, HIRE_DATE, adddate(HIRE_DATE,interval 6 month) as OJT제한일
from employee;

-- EMPLOYEE 테이블에서 근무 년수가 20년 이상인 직원 조회

select EMP_NAME, timestampdiff(year,HIRE_DATE,date(now())) as 년,timestampdiff(month,HIRE_DATE,date(now()))%12 as 개월 
from employee
where adddate(HIRE_DATE,interval 20 year)<date(now());


-- EMPLOYEE 테이블에서 사원명, 입사일, 
-- 입사한 월의 근무일수를 조회하세요
select EMP_NAME, HIRE_DATE,datediff(last_day(HIRE_DATE),HIRE_DATE)+1 as 입사월근무일수
from employee;

select EMP_NAME, dayofweek(HIRE_DATE)
from employee;

select EMP_NAME, dayname(HIRE_DATE) as 입사요일
	,dayofweek(HIRE_DATE) as 요일번호
    ,HIRE_DATE
    ,floor((datediff(last_day(HIRE_DATE),HIRE_DATE)+1)/7)*5+1 as 입사월근무일수
    ,(datediff(last_day(HIRE_DATE),HIRE_DATE))%7 as 남은날
    ,if((datediff(last_day(HIRE_DATE),HIRE_DATE))%7+dayofweek(HIRE_DATE)>7
		,(datediff(last_day(HIRE_DATE),HIRE_DATE))%7-2
		,(datediff(last_day(HIRE_DATE),HIRE_DATE))%7) as 근무
    
from employee;

select EMP_NAME, dayname(HIRE_DATE) as 입사요일
    ,HIRE_DATE
    ,floor((datediff(last_day(HIRE_DATE),HIRE_DATE)+1)/7)*5+1+
		if((datediff(last_day(HIRE_DATE),HIRE_DATE))%7+dayofweek(HIRE_DATE)>7
		,(datediff(last_day(HIRE_DATE),HIRE_DATE))%7-2
		,(datediff(last_day(HIRE_DATE),HIRE_DATE))%7) as 입사월근무일수

from employee;

-- EMPLOYEE 테이블에서 직원의 이름, 입사일, 근무년수를 조회
-- 단, 근무년수는 현재년도 - 입사년도로 조회
select EMP_NAME
	,timestampdiff(year,HIRE_DATE,date(now())) as 년
    ,timestampdiff(month,HIRE_DATE,date(now()))%12 as 개월 
from employee
where HIRE_DATE;

-- EMPLOYEE 테이블에서 사번이 홀수인 직원들의 정보 모두 조회 (mod)

select *
from employee
where EMP_ID%2=1;

select *
from employee
where mod(EMP_ID,2)=1;