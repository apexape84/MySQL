-- 1. 학생이름과 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 하고, 정렬은 이름으로 오름차순 표시하도록 한다.

select STUDENT_NAME '학생 이름', STUDENT_ADDRESS '주소지'
from tb_student
order by STUDENT_NAME;

-- 2. 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.

select STUDENT_NAME, STUDENT_SSN
from tb_student
where ABSENCE_YN = 'y'
order by datediff(str_to_date(substring(STUDENT_SSN,1,6),'%y%m%d'),date(now())) desc;

-- 3. 주소지가 강원도나 경기도인 학생들 중 2020년대 학번을 가진 학생들의 이름과 학번, 주소를 이름의 오름차순으로 화면에 출력하시오.
-- 단, 출력헤더에는 "학생이름","학번", "거주지 주소" 가 출력되도록 한다.
select substring(STUDENT_ADDRESS,1,2), count(*)
from tb_student
group by substring(STUDENT_ADDRESS,1,2);
-- 전체 학생중 강원이 1명, 경기가 133명인 것을 확인
-- 경기도이나 경기도가 생략된 주소등 많음

select STUDENT_NAME 학생이름, STUDENT_NO 학번, STUDENT_ADDRESS '거주지 주소', ENTRANCE_DATE
from tb_student
where ENTRANCE_DATE < '2020-01-01' and ( STUDENT_ADDRESS like '경기%' or STUDENT_ADDRESS like '강원%')
order by STUDENT_ADDRESS;
-- 전체 학생중 경기의 20년 이전학번 학생수 47명


select STUDENT_NAME 학생이름, STUDENT_NO 학번, STUDENT_ADDRESS '거주지 주소', ENTRANCE_DATE
from tb_student
where ENTRANCE_DATE > '2020-01-01' and ( STUDENT_ADDRESS like '경기%' or STUDENT_ADDRESS like '강원%')
order by STUDENT_NAME;
-- 전체 학생중 경기의 20년 이후학번 학생수 86명 강원 1명


-- 4.현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인할 수 있는 SQL 문장을 작성하시오.
-- (법학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아 내도록 하자)

select PROFESSOR_NAME, PROFESSOR_SSN
from tb_professor
where DEPARTMENT_NO =
	(select DEPARTMENT_NO
	from tb_department
	where DEPARTMENT_NAME = '법학과')
order by PROFESSOR_SSN;

-- 5. 2022 년 2학기에 C3118100 과목을 수강한 학생들의 학점을 조회하려고 한다.
-- 학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을 작성해보시오.

select STUDENT_NO, POINT
from tb_student join tb_grade using(STUDENT_NO)
where CLASS_NO = 'C3118100'and TERM_NO = '202202'
order by point desc, point asc;

-- 6.학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 출력하는 SQL 문을 작성하시오.

select STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
from tb_student join tb_department using ( DEPARTMENT_NO)
order by STUDENT_NAME asc;

-- 7.춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력하는 SQL 문장을 작성하시오.
select CLASS_NAME, DEPARTMENT_NAME
from tb_class join tb_department using(DEPARTMENT_NO)
order by DEPARTMENT_NAME;

-- 8.과목별 교수 이름을 찾으려고 한다. 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.
select CLASS_NAME, PROFESSOR_NAME
from tb_class left join tb_class_professor using(CLASS_NO) left join tb_professor using(PROFESSOR_NO);
-- 과목갯수는 1000개이나 교수가 배정되지 않은 과목이 있음, left join을 하지 않으면 776개

-- 9.8 번의 결과 중 ‘인문사회’ 계열에 속한 과목의 교수 이름을 찾으려고 한다.
-- 이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.

select c.CLASS_NAME, p.PROFESSOR_NAME
from tb_class c left join tb_class_professor cp using(CLASS_NO)
		left join tb_professor p using(PROFESSOR_NO)
        left join tb_department d using (DEPARTMENT_NO)
where d.DEPARTMENT_NO in
	(select  DEPARTMENT_NO
	from tb_department
	where CATEGORY = '인문사회');
    
-- 10 ‘음악학과’ 학생들의 평점을 구하려고 한다. 음악학과 학생들의 "학번", "학생 이름", "전체 평점"을 출력하는
--  SQL 문장을 작성하시오. (단, 평점은 소수점 1 자리까지만 반올림하여 표시한다.)

select STUDENT_NO '학번', STUDENT_NAME '학생 이름' , round(avg(POINT),1) '전체평점'
from tb_student join tb_grade using(STUDENT_NO) join tb_department using (DEPARTMENT_NO)
where DEPARTMENT_NO in
	(select  DEPARTMENT_NO
	from tb_department
	where DEPARTMENT_NAME = '음악학과')
group by STUDENT_NO, STUDENT_NAME
order by 전체평점 desc;

-- 학점이 조금 바뀌었습니다. 아래는 테이블 검정한 코드 입니다.

select STUDENT_NO, STUDENT_NAME, POINT
from tb_student left join tb_grade using(STUDENT_NO) join tb_department using (DEPARTMENT_NO)
where STUDENT_NO='A612052';
    
 select  DEPARTMENT_NO
	from tb_department
	where DEPARTMENT_NAME = '음악학과';   
    
select *
from tb_student left join tb_grade using(STUDENT_NO)
where STUDENT_NO='A612052';


-- 11. 학번이 `A313047` 인 학생이 학교에 나오고 있지 않다. 지도 교수에게 내용을 전달하기 위한 학과 이름, 학생 이름과 지도 교수 이름이 필요하다.
-- 이때 사용할 SQL 문을 작성하시오. 단, 출력헤더는 ‚’학과이름‛, ‚학생이름‛, ‚지도교수이름‛으로 출력되도록 한다.

select DEPARTMENT_NAME, STUDENT_NAME, PROFESSOR_NAME
from tb_student join tb_department using(DEPARTMENT_NO) join tb_professor on (PROFESSOR_NO = COACH_PROFESSOR_NO)
where STUDENT_NO = 'A313047';

-- 12 2022년도에 인간관계론 과목을 수강한 학생을 찾아 학생이름과 수강학기를 표시하는 SQL 문장을 작성하시오.

select STUDENT_NAME, TERM_NO
from tb_student s join tb_grade g using(STUDENT_NO) join tb_class c using(CLASS_NO)
where c.class_NO in
	(select  class_NO
	from tb_class
	where CLASS_NAME = '인간관계론')
    and substring(TERM_NO,3,2)='22';
    
-- 13.예체능 계열 과목 중 과목 담당교수를 한명도 배정받지 못한 과목을 찾아 그 과목 이름과 학과 이름을 출력하는 SQL 문장을 작성하시오.
use chundb;
select CLASS_NAME, DEPARTMENT_NAME
from tb_class left join tb_class_professor tb using(CLASS_NO) left join tb_department d using(DEPARTMENT_NO)
where tb.PROFESSOR_NO is null and d.CATEGORY=('예체능')
order by CLASS_NAME;

-- 14. 12. 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다. 학생이름과 지도교수 이름을 찾고 맡길 지도 교수가 없는 학생일 경우
-- "지도교수 미지정”으로 표시하도록 하는 SQL 문을 작성하시오. 단, 출력헤더는 “학생이름”, “지도교수”로 표시하며 고학번 학생이 먼저 표시되도록 한다.

select STUDENT_NAME 학생이름, if(COACH_PROFESSOR_NO is null,'지도교수 미지정',p.PROFESSOR_NAME) 지도교수
from tb_student s left join tb_professor p on (COACH_PROFESSOR_NO=PROFESSOR_NO)
where s.DEPARTMENT_NO=(    
	select  DEPARTMENT_NO
	from tb_department
	where DEPARTMENT_NAME = '서반아어학과');   
    
---------------------------------------------------------------------------------------------------
-- 작업중
    
-- 15 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 그 학생의 학번, 이름, 학과 이름, 평점을 출력하는 SQL 문을 작성하시오.

select s.STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME,ABSENCE_YN, Truncate(avg(POINT),1)
from tb_student s left join tb_department using(DEPARTMENT_NO) left join tb_grade using(STUDENT_NO)
where ABSENCE_YN = 'n'
group by s.STUDENT_NO
having floor(avg(point)) >= 4.0 ;
    
-- 16.환경조경학과 전공과목들의 과목 별 평점을 파악할 수 있는 SQL 문을 작성하시오.
select CLASS_NO, CLASS_NAME, round(avg(POINT),1) 학점평균
from tb_class c join tb_grade using(CLASS_NO)
where c.DEPARTMENT_NO=(    
	select  DEPARTMENT_NO
	from tb_department
	where DEPARTMENT_NAME = '환경조경학과') and CLASS_TYPE like '전공%'
group by CLASS_NO;

-- 17.춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는 SQL 문을 작성하시오.
select STUDENT_NAME 이름, STUDENT_ADDRESS 주소
from tb_student
where DEPARTMENT_NO=(    
	select  DEPARTMENT_NO
	from tb_student
	where STUDENT_NAME = '최경희')
order by STUDENT_NAME;


-- 18.국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL 문을 작성하시오.

select STUDENT_NO, STUDENT_NAME 이름
from tb_student join tb_grade using(STUDENT_NO)
where DEPARTMENT_NO=(    
	select  DEPARTMENT_NO
	from tb_department
	where DEPARTMENT_NAME = '국어국문학과')
group by STUDENT_NO
order by avg(POINT) desc
limit 1;

-- 19.춘 기술대학교의 "환경조경학과"가 속한 같은 계열 학과들의 학과 별 전공과목 평점을 파악하기 위한 적절한 SQL 문을 찾아내시오.
-- 단, 출력헤더는 "계열 학과명", "전공평점"으로 표시되도록 하고, 평점은 소수점 한 자리까지만 반올림하여 표시되도록 한다.
    
select DEPARTMENT_NAME '계열 학과명' , round(avg(POINT),1) '전공평점'
from tb_class c join tb_grade g using(CLASS_NO) join tb_department d using (DEPARTMENT_NO)
where CATEGORY=(    
	select  CATEGORY
	from tb_department
	where DEPARTMENT_NAME = '환경조경학과')
group by DEPARTMENT_NO
order by DEPARTMENT_NAME;
