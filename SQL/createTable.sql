CREATE TABLE Store(
    Store_ID char(4) NOT NULL PRIMARY KEY,
    Quantity int(4),
    Price char(6) NOT NULL
);

CREATE TABLE Equipment(
    Store_ID char(4) PRIMARY KEY,
    EName char(40) NOT NULL,
    Usecase varchar(2000) NOT NULL,
    UseDate Date ,
    LifeSpan float(2) NOT NULL,
    FOREIGN KEY (Store_ID) REFERENCES Store(Store_ID) on delete cascade on update cascade
); 

CREATE TABLE Drug(
    Store_ID char(4),
    Drug_Name char(40) NOT NULL , 
    Drug_Type char(10) NOT NULL , 
    Expire_Date Date NOT NULL,
    Properties varchar(200) NOT NULL,
    MFD_Date Date NOT NULL,
    Dossage int(3) NOT NULL,
    FOREIGN KEY (Store_ID) REFERENCES Store(Store_ID) on delete cascade on update cascade
); 

/*multivalue*/
CREATE TABLE DrugIngredient(
    Store_ID char(4),
    Ingredients char(30),
    FOREIGN KEY (Store_ID) REFERENCES Drug(Store_ID) on delete cascade on update cascade,
    CONSTRAINT pk_DrugIngredient PRIMARY KEY (Store_ID,Ingredients)
);

/*multivalue*/
CREATE TABLE Drug_Cannot(
    Store_ID char(4),
    Cannot_takes_with char(4),/*it had been char(40)*/
    FOREIGN KEY (Store_ID) REFERENCES Drug(Store_ID) on delete cascade  on update cascade,
    CONSTRAINT pk_Drug_Cannot PRIMARY KEY (Store_ID , Cannot_takes_with)
); 

CREATE TABLE Doctor(
    Doctor_ID char(6) PRIMARY KEY,
    SSN char(13) NOT NULL,
    Doctor_Name  char(30) NOT NULL,
    Doctor_Family_Name char(30) NOT NULL,
    WorkStartDate Date ,
    Salary int(6) NOT NULL,
    Gender char(1) NOT NULL ,
    PhoneNumber char(12)  NOT NULL
); 

/*multivalue*/
CREATE TABLE Doctor_specialization(
    Doctor_ID char(6),
    Docter_specializations char(30) ,
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID) on delete cascade on update cascade,
    CONSTRAINT pk_Doctor_Specialization PRIMARY KEY (Doctor_ID , Docter_specializations)
);

CREATE TABLE Pharmacist(
    Pharmacist_ID char(6) PRIMARY KEY,
    SSN char(13) NOT NULL,
    Pharmacist_Name char(30) NOT NULL,
    Pharmacist_Family_Name char(30) NOT NULL,
    WorkStartDate Date,
    Salary int(6) NOT NULL,
    Gender char(1)  NOT NULL,
    PhoneNumber char(12) NOT NULL
);

/*multivalue*/
CREATE TABLE Pharmacist_Qualification(
    Pharmacist_ID char(6) ,
    Qualifications char(30) ,
    FOREIGN KEY (Pharmacist_ID) REFERENCES Pharmacist(Pharmacist_ID) on delete cascade on update cascade, 
    CONSTRAINT pk_Pharmacist_Qualification PRIMARY KEY (Pharmacist_ID , Qualifications)
);

CREATE TABLE Nurse(
    Nurse_ID char(6) PRIMARY KEY,
    SSN char(13) NOT NULL,
    Nurse_Name char(30) NOT NULL,
    Nurse_Family_Name char(30) NOT NULL,
    WorkStartDate Date,
    Salary int(6) NOT NULL,
    Gender char(1) NOT NULL,
    PhoneNumber char(12) NOT NULL
);

/*multivalue*/
CREATE TABLE Nurse_Qualification(
    Nurse_ID char(6),
    Qualifications char(30) ,
    FOREIGN KEY (Nurse_ID) REFERENCES Nurse(Nurse_ID) on delete cascade on update cascade,
    CONSTRAINT pk_Nurse_Qualification PRIMARY KEY (Nurse_ID , Qualifications)
);

CREATE TABLE Prescription(
    Prescription_ID char(6) PRIMARY KEY,
    Pharmacist_ID char(6) NOT NULL,
    DATE_STAMP date NOT NULL,
    FOREIGN KEY (Pharmacist_ID) REFERENCES Pharmacist(Pharmacist_ID) /* this should not be cascade?*/
);

/*multivalue*/
CREATE TABLE Prescription_Item(/*it same as UseIn tabls ??*/
    Prescription_ID char(6),
    Store_ID char(4),
    Quantity int(4) NOT NULL,/*add Quantity*/
    FOREIGN KEY (Prescription_ID) REFERENCES Prescription(Prescription_ID) on delete cascade on update cascade, 
    FOREIGN KEY (Store_ID) REFERENCES Store(Store_ID) ,/* this should not be cascade?*/
    CONSTRAINT pk_Prescription_Item PRIMARY KEY (Prescription_ID , Store_ID)
);


CREATE TABLE Medprocedure(
    Medprocedure_ID char(6) PRIMARY KEY,
    Medprocedure_Name char(30) NOT NULL,
    Medprocedure_Description varchar(2000) NOT NULL,
    Price float(6) NOT NULL
);

/*multivalue*/
CREATE TABLE Medprocedure_Item(/*it same as UseIn tabls ??*/
    Medprocedure_ID char(6) ,
    Store_ID char(4) ,
    FOREIGN KEY (Medprocedure_ID) REFERENCES Medprocedure(Medprocedure_ID) on delete cascade on update cascade,
    FOREIGN KEY (Store_ID) REFERENCES Store(Store_ID),  /* this should not be cascade?*/
    CONSTRAINT pk_Medprocedure_ID_Item PRIMARY KEY (Medprocedure_ID , Store_ID)
);


CREATE TABLE ListOfProcedure(
    ListOfMedProcedure_ID char(6) PRIMARY KEY,
    Nurse_ID char(6) ,
    DATE_STAMP date NOT NULL,
    FOREIGN KEY (Nurse_ID) REFERENCES Nurse(Nurse_ID) /* this should not be cascade?*/
);

/*multivalue*/
CREATE TABLE ListOfProcedure_ID(
    ListOfMedProcedure_ID char(6) ,
    Medprocedure_ID char(6) ,
    FOREIGN KEY (ListOfMedProcedure_ID) REFERENCES ListOfProcedure(ListOfMedProcedure_ID) on delete cascade on update cascade, /*add foreign key*/
    FOREIGN KEY (MedProcedure_ID) REFERENCES Medprocedure(Medprocedure_ID) , /* this should not be cascade?*/
    CONSTRAINT pk_ListOfProcedure_ID PRIMARY KEY (ListOfMedProcedure_ID , MedProcedure_ID)
);


CREATE TABLE UsedInMedProcedure(
    Store_ID char(6) ,
    Medprocedure_ID char(6) ,
    FOREIGN KEY (Store_ID) REFERENCES Store(Store_ID) , /* this should not be cascade?*/
    FOREIGN KEY (Medprocedure_ID) REFERENCES Medprocedure(Medprocedure_ID) , /* this should not be cascade?*/
    CONSTRAINT pk_UsedInMedProcedure PRIMARY KEY (Store_ID , Medprocedure_ID)
);
 
CREATE TABLE UsedInPrescription(
    Store_ID char(6) ,
    Prescription_ID char(6) ,
    FOREIGN KEY (Store_ID) REFERENCES Store(Store_ID) , /* this should not be cascade?*/
    FOREIGN KEY (Prescription_ID) REFERENCES Prescription(Prescription_ID) , /* this should not be cascade?*/
    CONSTRAINT pk_UsedInMPrescription PRIMARY KEY (Store_ID , Prescription_ID)
);

CREATE TABLE Patient(
	Patient_ID char(6) PRIMARY KEY,
    SSN char(13) NOT NULL,
    Patient_First_Name char(30) NOT NULL,
    Patient_Family_Name char(30) NOT NULL,
    DateOfBirth Date NOT NULL,
    Gender char(1) NOT NULL,
    PhoneNumber char(12) NOT NULL,
    BloodGroup char(3) NOT NULL
);

CREATE TABLE Patient_History(
	Patient_ID char(6) ,
    DATE_STAMP Date ,
    Weight float(3) NOT NULL,
    Height float(3) NOT NULL,
    TemperatureBody float(2) NOT NULL,
    SBP int(3) NOT NULL, 
    DBP int(3) NOT NULL,
    HR int(3) NOT NULL,
    SicknessDescription varchar(2000) NOT NULL ,
    constraint pk_History primary key (Patient_ID , DATE_STAMP)
);

CREATE TABLE Bill(
    Bill_ID char(7) primary key ,
	Patient_ID char(6) ,
    Time_Stamp TIMESTAMP not null,/*change attribute name*/
    foreign key (Patient_ID) REFERENCES Patient(Patient_ID) , /* this should not be cascade?*/
);
CREATE TABLE Check_bill(
	Bill_ID char(7) ,
    ListOfMedProcedure_ID char(6) ,
    Prescription_ID char(7) ,
    FOREIGN KEY (Bill_ID) REFERENCES Bill(Bill_ID) , /* this should not be cascade?*/
    FOREIGN KEY (ListOfMedProcedure_ID) REFERENCES ListOfProcedure(ListOfMedProcedure_ID) , /* this should not be cascade?*/
    FOREIGN KEY (Prescription_ID) REFERENCES Prescription(Prescription_ID) , /* this should not be cascade?*/
    constraint pk_Check_bill primary key (Bill_ID , ListOfMedProcedure_ID , Prescription_ID)
);

CREATE TABLE Appointment(
	Appointment_ID char(3) primary key ,
    Appointment_DateTime timestamp not null,
    Doctor_ID char(6) not null,
    Patient_ID char(6) not null,
    Appointment_Description varchar(2000) ,
    foreign key (Patient_ID) REFERENCES Patient(Patient_ID) ,/* this should not be cascade?*/
    foreign key (Doctor_ID) REFERENCES Doctor(Doctor_ID) /* this should not be cascade?*/
); 

CREATE TABLE Diagnose(
	Patient_ID char(6) ,
    Doctor_ID char(6) ,
    DATE_STAMP Date ,
    Diagnostc varchar(2000) ,
    foreign key (Patient_ID) REFERENCES Patient(Patient_ID) ,/* this should not be cascade?*/
    foreign key (Doctor_ID) REFERENCES Doctor(Doctor_ID) ,/* this should not be cascade?*/
    constraint pk_Diagnose primary key (Patient_ID , Doctor_ID, DATE_STAMP)
);

CREATE TABLE Medicate(
	Doctor_ID char(6) ,
    Prescription_ID char(6) ,
    Patient_ID char(13) ,
    foreign key (Prescription_ID) REFERENCES Prescription(Prescription_ID) ,/* this should not be cascade?*/
    foreign key (Doctor_ID) REFERENCES Doctor(Doctor_ID) ,/* this should not be cascade?*/
    foreign key (Patient_ID) REFERENCES Patient(Patient_ID) ,/* this should not be cascade?*/
    constraint pk_Medicate primary key (Patient_ID , Doctor_ID , Prescription_ID)
);

CREATE TABLE relation_Procedure(
	Doctor_ID char(6) ,
    ListOfMedProcedure_ID char(6) ,
    Patient_ID char(6) ,
    foreign key (ListOfMedProcedure_ID) REFERENCES listofprocedure(ListOfMedProcedure_ID) ,/* this should not be cascade?*/
    foreign key (Doctor_ID) REFERENCES Doctor(Doctor_ID) ,/* this should not be cascade?*/
    foreign key (Patient_ID) REFERENCES Patient(Patient_ID) ,/* this should not be cascade?*/
    constraint pk_Procedure primary key (Patient_ID , Doctor_ID , ListOfMedProcedure_ID)
);

