-- group by
-- 결과집합을 특정 열의 값에따라 그룹화 하는 것에 사용한다.

-- having 절은 group by 절과 함께 사용이 되며 그룹에 대한 조건을 정의할때 사용(where은 단일행)

-- 메뉴가 존재하는 카테고리 그룹 조회

select
	category_code
from
	tbl_menu
group by
	category_code;
    
-- 위 그룹에 포함된 행의 수
select
	category_code as '카테고리코드',
    count(*) as '그룹에 포함된 행의 수'
from
	tbl_menu
group by
	category_code;
    
-- sum() : 합계 
-- 그룹이 메뉴가각 합계 조회

select
	category_code,
	sum(menu_price)
from
	tbl_menu
group by
	category_code;
    
-- avg()
select
	category_code,
	avg(menu_price)
from
	tbl_menu
group by
	category_code;
    
-- 두개 이상의 그룹 생성하기 
select
	menu_price,
    category_code
from
	tbl_menu
group by
	menu_price,
    category_code;
    
-- having 절을 사용해서 카테고리 코드 5번 8번까지 존재하는 카테고리 코드 조회

select
    category_code
from
	tbl_menu
group by
    category_code
having
	category_code between 5 and 8;
    
-- with rollup
select
	menu_price,
    category_code,
    sum(menu_price)
from
	tbl_menu
group by
	menu_price,
    category_code
with rollup;



