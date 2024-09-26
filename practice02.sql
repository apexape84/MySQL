use employee;

-- 1. 직급이 대리이면서 아시아 지역에 근무하는 직원 조회
-- 사번, 이름, 직급명, 부서명, 근무지역명, 급여를 조회하세요
-- (조회시에는 모든 컬럼에 테이블 별칭을 사용하는 것이 좋다.)
-- (사용 테이블 : job, department, location, employee)
-- 사번, 이름 - EMPLOYEE (EMP_ID,EMP_NAME
-- 직급명, 부서명 - job 대리 JOB_CODE,    JOB_NAME  = j6, DEPARTMENT
-- 근무지역명 - dep DEPT_ID,DEPT_TITLE,LOCATION_ID  from employee d code
-- loc LOCAL_CODE,NATIONAL_CODE,    LOCAL_NAME


select
	e.EMP_ID, e.EMP_NAME, d.DEPT_TITLE, j.JOB_NAME, l.LOCAL_NAME,e.SALARY

from
	employee e join department d on (e.DEPT_CODE=d.DEPT_ID)
    join job j using(JOB_CODE)
    join location l on(d.LOCATION_ID=l.LOCAL_CODE)
    
where
	JOB_CODE='J6' and l.LOCAL_NAME like 'asia_' ;

-- 2. 주민번호가 70년대 생이면서 성별이 여자이고, 
--    성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
-- (사용 테이블 : employee, department, job)

select
	e.EMP_NAME, e.EMP_NO, d.DEPT_TITLE, j.JOB_NAME
from
	employee e join department d on (e.DEPT_CODE=d.DEPT_ID)
    join job j using(JOB_CODE)
    
where
	e.EMP_NAME like '전%' and e.EMP_NO like '7%-2%';

-- 3. 이름에 '형'자가 들어가는 직원들의
-- 사번, 사원명, 직급명을 조회하시오.
-- (사용 테이블 : employee, job)

select
	e.EMP_ID, e.EMP_NAME, j.JOB_NAME

from
	employee e join job j using(JOB_CODE)
        
where
	e.EMP_NAME like '%형%' ;

-- 4. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
-- (사용 테이블 : employee, department, job)

select
	e.EMP_NAME,  j.JOB_NAME, d.DEPT_ID, d.DEPT_TITLE
from
	employee e join department d on (e.DEPT_CODE=d.DEPT_ID)
    join job j using(JOB_CODE)
    
where
	d.DEPT_ID in ('d5','d6','d7');


-- 5. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
-- (사용 테이블 : employee, department, location)


select
	e.EMP_NAME, e.BONUS, d.DEPT_TITLE, l.LOCAL_NAME

from
	employee e left join department d on (e.DEPT_CODE=d.DEPT_ID)
    join job j using(JOB_CODE)
    join location l on(d.LOCATION_ID=l.LOCAL_CODE)
    
where
	e.BONUS is not null;

-- 6. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.
-- (사용 테이블 : employee, job, department, location)

select
	e.EMP_NAME, j.JOB_NAME, d.DEPT_TITLE, l.LOCAL_NAME

from
	employee e left join department d on (e.DEPT_CODE=d.DEPT_ID)
    join job j using(JOB_CODE)
    join location l on(d.LOCATION_ID=l.LOCAL_CODE)
    
where
	E.DEPT_CODE='D2';

-- 7. 본인 급여 등급의 최소급여(MIN_SAL)를 초과하여 급여를 받는 직원들의
--    사원명, 직급명, 급여, 보너스포함 연봉을 조회하시오.
--    연봉에 보너스포인트를 적용하시오.
-- (사용 테이블 : employee, job, sal_grade)

select
	e.EMP_NAME, j.JOB_NAME, e.SALARY, if (e.BONUS is null, e.SALARY * 12 , e.SALARY * 12*(1+ e.BONUS/100)) as 보너스포함

from
	employee e join job j using(JOB_CODE) join sal_grade s using (SAL_LEVEL)
    
where
	e.SALARY > s.MIN_SAL;
    
-- union이용 해결
select
	e.EMP_NAME, j.JOB_NAME, e.SALARY, e.SALARY * 12*(1+ e.BONUS/100) as 보너스포함

from
	employee e join job j using(JOB_CODE) join sal_grade s using (SAL_LEVEL)
    
where
	e.SALARY > s.MIN_SAL
    and
    e.bonus is not null 
    
union

select
	e.EMP_NAME, j.JOB_NAME, e.SALARY, e.SALARY * 12 as 보너스포함

from
	employee e join job j using(JOB_CODE) join sal_grade s using (SAL_LEVEL)
    
where
	e.SALARY > s.MIN_SAL
    and
    e.bonus is null;
    
-- order by 보너스포함 desc;
    
-- 8. 한국(KO)과 일본(JP)에 근무하는 직원들의 
--    사원명, 부서명, 지역명, 국가명을 조회하시오.

select
	e.EMP_NAME, d.DEPT_TITLE, l.LOCAL_NAME,NATIONAL_NAME
    
from
	employee e left join department d on (e.DEPT_CODE=d.DEPT_ID)
    join location l on(d.LOCATION_ID=l.LOCAL_CODE)
    join nation using(NATIONAL_CODE)
    
where
	NATIONAL_CODE in ('ko','jp');
