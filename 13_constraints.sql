-- constraints (제약조건)
-- 

drop table if exists user_notnull;
create table if not exists user_notnull(
	user_no int primary key auto_increment,
    user_id varchar(30) not null,
    user_pwd varchar(40) not null,
    user_name varchar(30) not null,
    gender varchar(3),
    phone varchar(30) not null,
    email varchar(50)
    )engine=innodb;
    
    insert into user_notnull
    values
    (1, user01, 
    
    
    describe user_notnull;
    
