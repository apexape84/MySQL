-- set연산자는 두개 이상의 select문 결과 집합을 결합하는데 사용한다.
-- 결합하는 결과 집합의 컬럼이 일치해야 함. 

-- union
-- 두개 이상의 select문의 결과를 결합하되 중복된 레코드는 제거 

select
	*
from
	tbl_menu
where
	category_code = 10;
    
select
	*
from
	tbl_menu
where
	menu_price < 9000;

-- 합치기


select
	*
from
	tbl_menu
where
	category_code = 10
    
union
    
select
	*
from
	tbl_menu
where
	menu_price < 9000;
    
-- union all 중복을 제거하지 않음

select
	*
from
	tbl_menu
where
	category_code = 10
    
union all
    
select
	*
from
	tbl_menu
where
	menu_price < 9000;
    
-- intersect
-- 두 쿼리문의 결과중 공통되는 레코드만 반환 

select
	*
from
	tbl_menu a
    inner join
    (
		select
			*
		from
			tbl_menu
		where
			menu_price<9000
	) b
	on(a.menu_code=b.menu_code)
where
	a.category_code = 10;
    
-- in 연산자를 사용한 intersect 
select
	*
from
	tbl_menu
where
	category_code = 10
    and
    menu_code in (
					select
						menu_code
					from
						tbl_menu
					where
						menu_price <9000
				);
                
select *
from tbl_menu
where
	menu_price < 9000 and category_code=10;
    
-- minus
-- 첫번째 select문의 결과에서 두번째 select 문의 결과가 제외된 레코드를 반환
-- mysql에서는 지원하지 않음

select
	*
from
	tbl_menu a
    left join(
		select
			*
		from
			tbl_menu
		where
			menu_price < 9000
	) b on(a.menu_code = b.menu_code)
where
	a.category_code=10
    and
		b.menu_code is null;
        
select * from tbl_menu;
        
