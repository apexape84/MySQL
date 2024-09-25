-- order by
-- order by 절은 select 절과 함께 사용하며 결과집합을 특정 열이나 열들의 값에 따라서 정렬하는데 사용된다.

-- tbl_mennu 테이블에서 메뉴코드, 메뉴이름, 메뉴가격을 메뉴가격 오름차순으로 조회해줘

select
	menu_code,
    menu_name,
    menu_price
from
	tbl_menu
order by
	menu_price asc; -- 내림차순은 desc
    
-- tbl_menu 테이블에서 메뉴코드, 메뉴이름 오름차순, 메뉴가격 내림차순 으로 조회
select
	menu_code,
    menu_name,
    menu_price
from
	tbl_menu
order by
	menu_price desc,
    menu_name asc; 
-- 먼저작성한 정렬을 우선함

select
	menu_code,
    menu_price,
    menu_code * menu_price as 연산결과
from
	tbl_menu
order by
	연산결과 desc;
    
-- field() : 첫번째 인자를 기준으로 일치하는 다른 인자의 위치를 반환
select field('a', 'b', 'c', 'a','b','a');

-- tbl_menu 테이블에서 메뉴이름과 판매상태를 판매상태 Y를 우선으로 조회

select
	menu_name,
    orderable_status
from
	tbl_menu
order by
	field(orderable_status,'Z','Y','N');
    
-- 오름차순에서 null을 뒤로 보내고 싶을때
select
	*
from
	tbl_category
order by
	ref_category_code;
-- null값이 오름차순에서 처음으로 나옴

select
	*
from
	tbl_category
order by
	ref_category_code is null;
	