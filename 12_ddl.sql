-- DDL (Data Definition Language)
-- CREATE
-- 테이블을 생성하기 위한 구문 
-- IF NOT EXISTS
-- column_name data_type(length) [NOT NULL][DEFAULT VALUE][AUTO_INCREMENT]
use menudb;
create table if not exists tb1(
	pk int primary key,
    fk int,
    col1 varchar(255),
    check(col1 in ('Y','N'))
    )engine=innodb;
    
-- engine=innodb 라는 스토리지 저장엔진으로 

insert into tb1 values (null,10,'y');
insert into tb1 values (1,null,'g');
delete from tb1 where pk=1;
insert into tb1 values (1,10,'y');
select pk from tb1;

create table if not exists tb2(
	pk int primary key auto_increment,
    fk int,
    col1 varchar(255),
    check(col1 in ('Y','N'))
    )engine=innodb;
    
-- 테이블 삭제
drop table tb2;

describe tb2;

insert into tb1 values (null,10,'y');
insert into tb1 values (null,20,'y');

-- alter
-- 테이블에 추가/변경/수정/삭제 하는 모든것을 해줌

alter table tb2
add col2 int not null;
alter table tb2
drop column col2;
alter table tb2
change fk change_fk int not null;

alter table tb2
modify pk int;

alter table tb2
drop primary key;

create table if not exists tb6(
	pk int primary key auto_increment,
    fk int,
    col1 varchar(255),
    check(col1 in ('Y','N'))
    )engine=innodb;
    
drop table if exists tb4, tb5;

-- truncate // delete
-- delete 구문을 작성하면 전체 행 삭제

insert into tb6 values (null,10,'y');
insert into tb6 values (null,20,'y');
insert into tb6 values (null,30,'y');
insert into tb6 values (null,40,'y');

describe tb6;

select * from tb6;