-- 민트미역국과 같은 카테고리 코드를 가진 메뉴 조회

select
    category_code
from
	tbl_menu
where
	menu_name = '민트미역국';
    
select
	*
from
	tbl_menu
where
	category_code = 4;
    
-- 첫번째 쿼리로 카테고리 코드를 사용자인 내가 알아내서 수동으로 다음 쿼리에 값을 입력했음
    
-- subquery : 다른 쿼리에 사용할 데이터를 만들어주는 쿼리
select
	*
from
	tbl_menu
where
	category_code = (select category_code from tbl_menu where menu_name = '민트미역국');
    
-- 가장 많은 메뉴가 포함된 카테고리 조회
-- max()함수, min()함수 사용 
-- from절에 사용하는 서브쿼리는 (derived table, 파생 테이블)이라고 불리우며 반드시 별칭을 가지고 있어야 한다. 
select
	max(count)
from
(
	select
		count(*) as 'count'
	from
		tbl_menu
	group by
		category_code
) as countmenu;

select
	a.menu_code,
    a.menu_name,
    a.menu_price,
    a.category_code,
    a.orderable_status
    -- 의미 없음. 그냥 a.을 쓰는걸 보여주려고 함
from
	tbl_menu a
where
	menu_price > (
					select
						avg(menu_price)
					from
						tbl_menu
					where
						category_code = a.category_code
				 );
    

    
with menucte as (
	select
		menu_name,
        category_name
	from
		tbl_menu a
        join
        tbl_category b
        on a.category_code = b.category_code)
select
	*
from
	menucte
order by
	menu_name;