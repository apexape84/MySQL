-- disticnt : 중복값 제외
-- 컬럼에 있는 값들의 종류를 쉽게 파악 가능

-- 단일컬럼 중복 제거
select
	distinct category_code
from
	tbl_menu
order by
	category_code;
    
-- 다중 컬럼 중복 제거
select distinct
	category_code,orderable_status
from
	tbl_menu;