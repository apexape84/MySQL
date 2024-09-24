-- join
-- 두 개 이상의 테이블을 관련있는 컬럼을 통해 결합(관계를 맺는)데 사용된다.
-- 두 개 이상의 테이블은 결합을 하기 위해서는 반드시 연관있는 컬럼이 존재해야하며
--  연관있는 컬럼을 통해서 join이 된 테이블 들의 컬럼을 모두 사용 할 수 있다.
-- as(alias) 별칭
-- sql문(쿼리문)의 컬럼 또는 테이블에 별칭을 달 수 있다. 만약 별칭에 특수기호나 띄어쓰기가 없다면 as와 ''는 생략이 가능하다.

select
	menu_code as '코드',
	menu_name '이름',
    menu_price 가격
from
	tbl_menu;
    
    select
	menu.menu_code as '코 드',
	menu.menu_name '이름',
    menu.menu_price 가격
from
	tbl_menu menu;
    
-- join의 종류

-- inner join
-- 두 테이블의 교집합을 반환하는 join의 유형
-- inner join 에서 inner는 생략 가능
-- on 키워드를 사용한 join 방법
-- 컬럼명이 같거나 다를경우 on 으로 서로 연관있는 컬럼에 대한 조건 작성 

-- 메뉴의 이름과 카테고리의 이름을 조회

select
	a.menu_name,
    b.category_name
from
	tbl_menu a
    join
    tbl_category b on a.category_code=b.category_code;
    
-- using을 사용한 join
-- 서로다른 두 테이블에서 공유하고 있는 컬럼명이 동일한 경우 using을 사용해서 연관있는 컬럼을 join할 수 있다.

select
	a.menu_name,
    b.category_name
from
	tbl_menu a
    join
    tbl_category b
    using (category_code);
    
    
-- left join
-- 첫 번째 테이블의 모든 레코드와 두번째 테이블에서 일치하는 레코드를 반환하는 join 유형 

select
	a.category_name,
    b.menu_name
from
	tbl_category a left join tbl_menu b
    on a.category_code=b.category_code
    
order by 
		 b.menu_name is not null,
         a.category_code;

-- right join
-- 두 번째(오른쪽) 테이블의 모든 레코드와 첫 번째(왼쪽) 테이블에서 일치하는 레코드를 반환하는 SQL join 유형 

select
	a.menu_name,
    b.category_name
from
	tbl_menu a right join tbl_category b
    using(category_code);
    
-- cross join
-- inner join 은 교집합 
-- cross join은 가능한 모든 조합을 반환하는 합집합 

select
	a.manu_menu,
    b.category_name
from
	tbl_menu a cross join tbl_category b;
    
-- self join

select
	a.category_name,
    b.category_name
from
	tbl_category a join tbl_category b
    on
    a.ref_category_code = b.category_code;
    
select
	category_name,
    ref_category_code
from
	tbl_category
    
-- 서로 다른 테이블 간의 데이터를 조회하고 싶을 때는 join을 사용한다 
-- join을 수행하는 단계를 고려 할 때는 
-- 1. 테이블과 테이블이 연관이 되어 있는 지 확인 
-- 2. 연관이 되어 있다고 하면, 어떤 컬럼으로 연결이 되어 있는 지 확인 
-- 3. 어떤 테이블을 기준으로 join을 수행할 것인지(inner, left, right, cross, self)