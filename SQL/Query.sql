SELECT * FROM nurse ;

select * from storteste ;
select * from equipment;
select * from drug;

select * from Doctor;
select * from patient;
select * from medicate;

Delete from nurse where Nurse_ID = "000001" ;
delete from equipment where Store_ID = '3' ;
delete from store where Store_ID = '1' ;
delete from drug where Store_ID = '1' ;

delete from doctor where Doctor_ID = '000001' ;

update store 
set Store_ID = '99'
where Store_ID = '1' ;

select * from appointment ;