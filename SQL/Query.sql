SELECT * FROM nurse ;

select Patient_ID , Doctor_ID , Diagnostc from diagnose natural join patient ;
select * from Doctor join nurse ;


/*Query1*/
select  Pharmacist_Name , Pharmacist_Family_Name ,count(Pharmacist_ID) as num_of_prescription_by_pharmacist from prescription natural join pharmacist group by Pharmacist_ID having count(Pharmacist_ID) > 3;
/*Query2*/
select * from diagnose ;

/*Query3*/
create view medprice as
select patient_ID ,bill_id, medprocedure_price from Bill 
		natural join check_bill natural join listofprocedure_id natural join medprocedure ;
        
create view prescription_price as
select Patient_ID , Bill_ID , Store_ID , (Price*Quantities) as pre_price from bill 
		natural join check_bill natural join prescription natural join prescription_item natural join store ;
        
create view prescription_price_withgroupBy as
	select patient_id , sum(pre_price) as prescription_price from prescription_price group by patient_id;
    
create view med_price_withgroupBy as
	select patient_id , sum(medprocedure_price) as med_price from medprice group by patient_id ;

create view total_pricemed_pricepre as
	select patient_id , med_price , prescription_price from med_price_withgroupBy natural join prescription_price_withgroupBy;

select patient_id , med_price, prescription_price, (med_price+prescription_price) as total_price from total_pricemed_pricepre;

