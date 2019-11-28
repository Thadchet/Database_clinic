SELECT * FROM nurse ;

select Patient_ID , Doctor_ID , Diagnostc from diagnose natural join patient ;
select * from Doctor join nurse ;


/*Query1*/
select * from prescription natural join pharmacist where prescription.Pharmacist_ID = Pharmacist_ID ;
select  Pharmacist_Name , Pharmacist_Family_Name ,count(Pharmacist_ID) from prescription natural join pharmacist group by Pharmacist_ID having count(Pharmacist_ID) > 2;
/*Query2*/
select * from diagnose ;

/*Query3*/
create view medprice as
select patient_ID ,bill_id, medprocedure_price from Bill 
		natural join check_bill natural join listofprocedure_id natural join medprocedure   ; 
create view prescription_price as
select Patient_ID , Bill_ID , Store_ID , (Price*Quantities) as pre_price from bill 
		natural join check_bill natural join prescription natural join prescription_item natural join store ;
create view prescription_price_withgroupBy as
	select patient_id , bill_id , sum(pre_price) as prescription_price from prescription_price group by pre_price;
select * from medprice ;
select patient_id , (medprocedure_price + prescription_price ) as total_price from medprice natural join prescription_price_withgroupby ;

drop view prescription_price_withgroupBy ;
