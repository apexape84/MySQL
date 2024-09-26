-- SELECT 절은 MySQL의 가장 기본적인 명령어로 특정 테이블에서 원하는 데이터를 조회할 수 있는 명령어이다.

select -- 조회해줘
	menu_name -- 무엇을?
from -- 어디서?    
	tbl_menu;
    --
-- tbl_menu 테이블에서 메뉴코드와 카테고리코드, 메뉴가격을 조회해줘
select
	menu_code,
    category_code,
    menu_price
from
	tbl_menu;
    
-- tbl_menu에서 모든 컬럼을 조회해줘
select
	*
from
	tbl_menu;
    
-- 현재시간 조회 <- 등록된 함수들이 있다.
select now();

-- concatA() : 합치기
select concat('조','문자열','평훈');

-- 컬럼의 별칭 지정하기
select concat('조','문자열','평훈') as 내이름;

-- 별칭에 공백을 포함할땐 ''를 사용
select concat('조','문자열','평훈') as '내 이름';