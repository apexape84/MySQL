-- transaction
-- 데이터베이스에서 한번에 수행되는 작업의 단위이다.
-- 시작, 진행, 종료 단계를 거치게 되면서 만약 중간에 예기치 못한 상황 발생시 rollback(시작하기 이전단계로 돌아감)을 실행 
-- MySQL은 auto commit 이 default설정이라 해제해야 수행 가능함 

-- autocommit 해제
set autocommit = 0;

-- start transaction
start transaction;

rollback;

commit;
