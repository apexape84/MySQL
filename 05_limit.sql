-- limit
-- select 조회 결과에 반환할 행 갯수제한alter

select
	*
from
	tbl_menu
where
	menu_price>5000
order by
	menu_price desc
limit 5;

-- limit[offset,] row_count
-- offset : 시작 할 행의 번호(인덱스체계)
-- row count 출력할 행의 갯수

select
	menu_code,menu_name,menu_price
from
	tbl_menu
order by
	menu_price desc
limit 1,4;