-- where 특정 조건에 일치하는 행(레코드)만 선택을 할때 사용됨
select
	*
from
	tbl_menu
where
	orderable_status = 'Y';
    
    
-- 이름 가격 판매상태, 가격이 13000원인 메뉴만
select
	menu_name,
    menu_price,
    orderable_status
from
	tbl_menu
where
	orderable_status <> 'Y';
    
-- 가격이 20000원인 메뉴만
select
	*
from
	tbl_menu
where
	menu_price > 20000;
    
-- 가격이 10000~20000원인 메뉴만
select
	*
from
	tbl_menu
where
	menu_price < 20000 and menu_price >= 10000
    
order by menu_price desc;

-- and / or 연산자  where와 같이 사용


-- 판매상태가 Y 또는 카테고리 코드가 10 메뉴만
select
	*
from
	tbl_menu
where
	category_code = 10 or orderable_status = 'Y'
    
order by category_code;

-- between, not

-- 가격이 10000~20000원인 메뉴만
select
	*
from
	tbl_menu
    
where
	menu_price not between 10000 and 20000	
    
order by menu_price desc;

-- like, %
-- 메뉴테이블에서 이름과 가격을 선택, 메뉴이름에 마늘이 포함된 메뉴만 조회
select
	menu_name, menu_price
from
	tbl_menu
where
	menu_name like '%마늘%';
    
-- 메뉴테이블에서 전체 선택, 가격 5000원 초과, 카테고리코드 10, 메뉴이름에 갈치가 포함된 메뉴만 조회
select
	*
from
	tbl_menu
where
	category_code=10 and menu_price>5000 and menu_name like '%갈치%';
    
-- in 연산자 활용
-- 메뉴테이블에서 이름, 카테고리 선택
-- 카테고리 코드가 4,5,6 조회

select
	menu_name, category_code
from
	tbl_menu
where
	category_code in (4, 5, 6) ;
    
    
-- in, null 활용
-- 모든 데이터 선택
-- null값을 포함한것 제외
select
	*
from
	tbl_category
where
	ref_category_code is not null;