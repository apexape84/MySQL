-- 1.부서코드가 노옹철 사원과 같은 소속의 직원 명단 조회
use employee;
select EMP_NAME,DEPT_CODE
from employee
where DEPT_CODE =(
	select DEPT_CODE
    from employee
    where EMP_NAME = '노옹철');
    
-- 2.전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의
-- 사번, 이름, 직급코드, 급여를 조회하세요

select EMP_ID,EMP_NAME,j.JOB_NAME,SALARY
from employee e join job j using(JOB_CODE)
where SALARY >= (
	select avg(SALARY)
    from employee);
  
-- 3.노옹철 사원의 급여보다 많이 받는 직원의
-- 사번, 이름, 부서, 직급, 급여를 조회하세요

select EMP_ID, EMP_NAME, d.DEPT_TITLE, JOB_NAME, SALARY
from employee e join job j using(JOB_CODE) left join department d on (e.DEPT_CODE=d.DEPT_ID)
where SALARY > (
	select SALARY
    from employee
    where EMP_NAME = '노옹철');

-- 4.가장 적은 급여를 받는 직원의
-- 사번, 이름, 직급, 부서, 급여, 입사일을 조회하세요 (MIN)

select EMP_ID, EMP_NAME, d.DEPT_TITLE, j.JOB_NAME, SALARY, HIRE_DATE
from employee e join job j using(JOB_CODE) left join department d on (e.DEPT_CODE=d.DEPT_ID)
where SALARY = (
	select min(SALARY)
    from employee);

-- 서브쿼리는 SELECT, FROM, WHERE, HAVING, ORDER BY절에도 사용할 수 있다.


-- 5.부서별 최고 급여를 받는 직원의 이름, 직급, 부서, 급여 조회
-- 힌트 : where 절에 subquery
use employee;
select EMP_NAME, d.DEPT_TITLE, j.JOB_NAME, SALARY,DEPT_CODE
from employee e join job j using(JOB_CODE) left join department d on (e.DEPT_CODE=d.DEPT_ID);

-- 이 코드는 송중기가 390000이 되면 총무부에 두명이 선택됨 
select e.EMP_ID, EMP_NAME, d.DEPT_TITLE, j.JOB_NAME, SALARY
from employee e 
	join job j using(JOB_CODE) 
    left join department d on (e.DEPT_CODE=d.DEPT_ID)
where SALARY in (
	select max(SALARY)
	from employee
	group by DEPT_CODE);    
    
    
-- 이 코드는 부서가 없는 이오리가 누락됨 
select EMP_NAME, d.DEPT_TITLE, j.JOB_NAME, SALARY
from employee e join job j using(JOB_CODE) left join department d on (e.DEPT_CODE=d.DEPT_ID),
	(
	select DEPT_CODE, max(SALARY) as maxsalary
	from employee
	group by DEPT_CODE
    ) as newtable
where e.SALARY=newtable.maxsalary and (newtable.DEPT_CODE=e.DEPT_CODE);

-- 이 코드는 null부서 인원이 여럿나올 수 있음
select EMP_NAME, d.DEPT_TITLE, j.JOB_NAME, SALARY
from employee e join job j using(JOB_CODE) left join department d on (e.DEPT_CODE=d.DEPT_ID),
	(
	select DEPT_CODE, max(SALARY) as maxsalary
	from employee
	group by DEPT_CODE
    ) as newtable
where e.SALARY = newtable.maxsalary and (newtable.DEPT_CODE=e.DEPT_CODE or newtable.DEPT_CODE is null);

-- 이 코드는 송중기가 390000이 되면 총무부에 두명이 선택됨, 그저 cte사용 했을뿐
with empcte as (
	select EMP_NAME, d.DEPT_TITLE, j.JOB_NAME, SALARY,DEPT_CODE
	from employee e join job j using(JOB_CODE) 
		left join department d on (e.DEPT_CODE=d.DEPT_ID))
select *
from empcte
where SALARY in (
	select max(SALARY)
	from empcte
	group by DEPT_CODE);  

replace INTO EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,SAL_LEVEL,SALARY,BONUS,MANAGER_ID,HIRE_DATE,ENT_DATE,ENT_YN) VALUES 
('201','송종기','631156-1548654','song_jk@greedy.com','01045686656','d9','J2','S1',2550000,null,'200',STR_TO_DATE('01/09/01','%y/%m/%d'),null,'N');
replace INTO EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,SAL_LEVEL,SALARY,BONUS,MANAGER_ID,HIRE_DATE,ENT_DATE,ENT_YN) VALUES 
('201','송종기','631156-1548654','song_jk@greedy.com','01045686656','D9','J2','S1',6000000,null,'200',STR_TO_DATE('01/09/01','%y/%m/%d'),null,'N');
-- 여기서부터 난이도 극상

-- 6.관리자에 해당하는 직원에 대한 정보와 관리자가 아닌 직원의 
-- 정보를 추출하여 조회
-- 사번, 이름, 부서명, 직급, '관리자' AS 구분 / '직원' AS 구분
-- 힌트 : is not null, union(혹은 then, else), distinct

select e.EMP_ID, EMP_NAME, d.DEPT_TITLE, j.JOB_NAME, if(EMP_ID in (
	select MANAGER_ID
	from employee
	group by MANAGER_ID),concat('관리자'),concat('직원')) as '구분'
from employee e join job j using(JOB_CODE) left join department d on (e.DEPT_CODE=d.DEPT_ID)
order by 구분;


-- 7.자기 직급의 평균 급여를 받고 있는 직원의
-- 사번, 이름, 직급코드, 급여를 조회하세요
-- 단, 급여와 급여 평균은 만원단위로 계산하세요
-- 힌트 : round(컬럼명, -5)

select EMP_ID, EMP_NAME, j.JOB_NAME, SALARY
from employee e join job j using(JOB_CODE)
where SALARY in(
	select round(avg(SALARY),-5)
	from employee
	group by JOB_CODE);

-- 8.퇴사한 여직원과 같은 부서, 같은 직급에 해당하는
-- 사원의 이름, 직급, 부서, 입사일을 조회

select e.EMP_NAME, d.DEPT_TITLE, j.JOB_NAME, HIRE_DATE
from employee e join job j using(JOB_CODE) left join department d on (e.DEPT_CODE=d.DEPT_ID),
	(
    select EMP_NAME,DEPT_CODE,JOB_CODE
    from employee as b
    where ENT_DATE is not null and b.EMP_NO like '%-2%'
    )as 퇴사자
where e.DEPT_CODE = 퇴사자.DEPT_CODE and e.JOB_CODE=퇴사자.JOB_CODE and ENT_DATE is null;
    
-- 9.급여 평균 3위 안에 드는 부서의 
-- 부서 코드와 부서명, 평균급여를 조회하세요
-- limit 사용


select DEPT_CODE, d.DEPT_TITLE, avg(SALARY)
from employee e join job j using(JOB_CODE) left join department d on (e.DEPT_CODE=d.DEPT_ID)
group by DEPT_CODE
limit 3;

select EMP_NAME, d.DEPT_TITLE, j.JOB_NAME, SALARY,DEPT_CODE
from employee e join job j using(JOB_CODE) left join department d on (e.DEPT_CODE=d.DEPT_ID);

-- 10.직원 정보에서 급여를 가장 많이 받는 순으로 이름, 급여, 순위 조회
-- 힌트 : DENSE_RANK() OVER or RANK() OVER

select rank() over(order by SALARY desc)as 급여순위, EMP_NAME, SALARY
from employee e join job j using(JOB_CODE) left join department d on (e.DEPT_CODE=d.DEPT_ID)
limit 5;

-- 11.부서별 급여 합계가 전체 급여의 총 합의 20%보다 많은
-- 부서의 부서명과, 부서별 급여 합계 조회
-- 힌트 : SUM(E2.SALARY) * 0.2

select DEPT_TITLE, sum(SALARY) as depsum
from employee e left join department d on (e.DEPT_CODE=d.DEPT_ID)
group by DEPT_TITLE
having depsum > 0.2*
	(select sum(SALARY)
	from employee
	group by null);