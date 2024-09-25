-- DML (Data Manipulation Language)

-- 삽입 (INSERT)
-- 새로운 행 추가. 테이블의 행 갯수가 증가 
-- 해당 컬럼이 autoincrement가 있거나, null을 허용하면 미입력가능

insert into tbl_menu values(null,'바나나해장국',8500,4,'Y');
    
-- 해당 테이블의 컬럼이 어떤 구조로 되어있는지 조회, 전달인자 확인할때 
describe tbl_menu;

-- insert into : 전달인자 종류는 아는데 순서를 모를때 지정해서 입력 
insert into tbl_menu
(orderable_status,menu_name, menu_code, menu_price, category_code)
values
('Y','파인애플탕',null,5500,4);

insert into tbl_menu values(24,'초콜렛밥',1000, 4, 'Y');

-- 여러개 입력
insert tbl_menu
values(null,'참치맛아이스크림',1600,12,'Y'),
	(null,'해장국맛 아이스크림',1900,12,'Y'),
    (null,'멸치맛아이스크림',1200,12,'Y');
    
select
	menu_code,
    category_code
from
	tbl_menu
where
	menu_name = '파인애플탕';
    
update tbl_menu
set category_code = 7
where menu_name = '파인애플탕';

update tbl_menu
set
	category_code = 24
where
	menu_code = (
					select
						cte.menu_code
					from(
						select
							menu_code
						from
							tbl_menu
						where
							menu_name = '파인애플탕'
						) cte
                );
                
delete from tbl_menu
order by menu_price
limit 2;

delete from
	tbl_menu
where
	menu_name = '파인애플탕';
    
-- autoincrement 있는 키값은, 같은번호 입력시 삽입 불가, 미입력시 
insert into tbl_menu values(24,'초콜렛밥',1000, 4, 'Y');

-- null 입력시 마지막 자동생성 번호(삭제했던번호 포함)다음번호로 생성되어 삽입
insert into tbl_menu values(null,'포도씨유파스타',10000, 4, 'Y');

delete from
	tbl_menu
where menu_name = '초콜렛밥';
insert into tbl_menu values(23,'초콜렛밥',1000, 4, 'Y');

insert into tbl_menu values(null,'포도씨유파스타',10000, 4, 'Y');

insert into tbl_menu values(24, '소주', 6000, 10, 'Y');

-- replace는 대체함
replace into tbl_menu values(24, '소주', 8000, 10, 'Y');
    
select * from	tbl_menu;





