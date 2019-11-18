CREATE TABLE Store(
    Store_ID char(4) NOT NULL PRIMARY KEY,
    Quantity int(4),
    Price char(6) NOT NULL
);

CREATE TABLE Equipment(
    Store_ID char(4) PRIMARY KEY,
    EName char(40) ,
    Usecase varchar(2000),
    UseDate Date,
    LifeSpan float(2) ,
    FOREIGN KEY (Store_ID) REFERENCES Store(Store_ID) on delete cascade on update cascade
); 

CREATE TABLE Drug(
    Store_ID char(4),
    Drug_Name char(40) NOT NULL , 
    Drug_Type char(10) NOT NULL , 
    Expire_Date Date NOT NULL,
    Properties varchar(200),
    MFD_Date Date ,
    Dossage int(3) ,
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
    Cannot_takes_with char(40),
    FOREIGN KEY (Store_ID) REFERENCES Drug(Store_ID) on delete cascade  on update cascade,
    CONSTRAINT pk_Drug_Cannot PRIMARY KEY (Store_ID , Cannot_takes_with)
); 

CREATE TABLE Doctor(
    Doctor_ID char(6) PRIMARY KEY,
    SSN char(13) NOT NULL,
    Doctor_Name  char(30) NOT NULL,
    Doctor_Family_Name char(30),
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
    Pharmacist_Family_Name char(30),
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
    Nurse_Family_Name char(30),
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
    Pharmacist_ID char(6) ,
    DATE_STAMP date ,
    FOREIGN KEY (Pharmacist_ID) REFERENCES Pharmacist(Pharmacist_ID) on delete cascade on update cascade
);

CREATE TABLE Prescription_Item(
    Prescription_ID char(6) ,
    MedReceipt_List char(40) ,
    FOREIGN KEY (Prescription_ID) REFERENCES Prescription(Prescription_ID) on delete cascade on update cascade, 
    FOREIGN KEY (MedReceipt_List) REFERENCES Store(Store_ID) on delete cascade on update cascade,
    CONSTRAINT pk_Prescription_Item PRIMARY KEY (Prescription_ID , MedReceipt_List)
);


CREATE TABLE ListOfProcedure(
    ListOfMedProcedure_ID char(6) PRIMARY KEY,
    Nurse_ID char(6) ,
    DATE_STAMP date ,
    FOREIGN KEY (Nurse_ID) REFERENCES Nurse(Nurse_ID) on delete cascade on update cascade
);

CREATE TABLE Medprocedure(
    Medprocedure_ID char(6) PRIMARY KEY,
    Medprocedure_Name char(30) ,
    Medprocedure_Description varchar(2000),
    Price float(6) 
);

CREATE TABLE ListOfProcedure_ID(
    ListOfMedProcedure_ID char(6) ,
    MedProcedure_ID_List char(6) ,
    FOREIGN KEY (MedProcedure_ID_List) REFERENCES Medprocedure(Medprocedure_ID) on delete cascade on update cascade,
    CONSTRAINT pk_ListOfProcedure_ID PRIMARY KEY (ListOfMedProcedure_ID , MedProcedure_ID_List)
);

/*multivalue*/
CREATE TABLE Medprocedure_ID_Item(
    Medprocedure_ID char(6) ,
    ItemRequirement char(40) ,
    FOREIGN KEY (Medprocedure_ID) REFERENCES Medprocedure(Medprocedure_ID) on delete cascade on update cascade,
    FOREIGN KEY (ItemRequirement) REFERENCES Store(Store_ID) on delete cascade on update cascade,
    CONSTRAINT pk_Medprocedure_ID_Item PRIMARY KEY (Medprocedure_ID , ItemRequirement)
);

CREATE TABLE UsedInMedProcedure(
    Store_ID char(6) ,
    Medprocedure_ID char(6) ,
    FOREIGN KEY (Store_ID) REFERENCES Store(Store_ID) on delete cascade on update cascade,
    FOREIGN KEY (Medprocedure_ID) REFERENCES Medprocedure(Medprocedure_ID) on delete cascade on update cascade,
    CONSTRAINT pk_UsedInMedProcedure PRIMARY KEY (Store_ID , Medprocedure_ID)
);
 
CREATE TABLE UsedInPrescription(
    Store_ID char(6) ,
    Prescription_ID char(6) ,
    FOREIGN KEY (Store_ID) REFERENCES Store(Store_ID) on delete cascade on update cascade,
    FOREIGN KEY (Prescription_ID) REFERENCES Prescription(Prescription_ID) on delete cascade on update cascade, 
    CONSTRAINT pk_UsedInMPrescription PRIMARY KEY (Store_ID , Prescription_ID)
);

CREATE TABLE Patient(
	Patient_ID char(6) PRIMARY KEY,
    SSN char(13) NOT NULL,
    Patient_First_Name char(30) NOT NULL,
    Patient_Family_Name char(30) ,
    DateOfBirth Date NOT NULL,
    Gender char(1) NOT NULL,
    PhoneNumber char(12) ,
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
    constraint pkHistory primary key (Patient_ID , DATE_STAMP)
);

CREATE TABLE Bill(
	Patient_ID char(6) ,
    Bill_ID char(7) ,
    Bill_Time TIMESTAMP not null,
    foreign key (Patient_ID) REFERENCES Patient(Patient_ID) on delete cascade on update cascade,
    constraint pkBill primary key (Patient_ID , Bill_ID)
);
CREATE TABLE Check_bill(
	Bill_ID char(7) ,
    ListOfMedProcedure_ID char(6) ,
    Prescription_ID char(7) ,
    constraint pkCheck_bill primary key (Bill_ID , ListOfMedProcedure_ID , Prescription_ID)
);

CREATE TABLE Appointment(
	Appointment_ID char(3) primary key ,
    Appointment_DateTime timestamp not null,
    Doctor_ID char(6) not null,
    Patient_ID char(6) not null,
    Appointment_Description varchar(2000) ,
    foreign key (Patient_ID) REFERENCES Patient(Patient_ID) on delete cascade on update cascade,
    foreign key (Doctor_ID) REFERENCES Doctor(Doctor_ID) on delete cascade on update cascade 
); 

CREATE TABLE Diagnose(
	Patient_ID char(6) ,
    Doctor_ID char(6) ,
    DATE_STAMP Date ,
    Diagnostc varchar(2000) ,
    foreign key (Patient_ID) REFERENCES Patient(Patient_ID) on delete cascade on update cascade,
    foreign key (Doctor_ID) REFERENCES Doctor(Doctor_ID) on delete cascade on update cascade,
    constraint pkAppointment primary key (Patient_ID , Doctor_ID)
);

CREATE TABLE Medicate(
	Doctor_ID char(6) ,
    Prescription_ID char(6) ,
    Patient_ID char(13) ,
    foreign key (Prescription_ID) REFERENCES Prescription(Prescription_ID) on delete cascade on update cascade,
    foreign key (Doctor_ID) REFERENCES Doctor(Doctor_ID) on delete cascade on update cascade,
    foreign key (Patient_ID) REFERENCES Patient(Patient_ID) on delete cascade on update cascade,
    constraint pk_Medicate primary key (Patient_ID , Doctor_ID , Prescription_ID)
);

CREATE TABLE relation_Procedure(
	Doctor_ID char(6) ,
    ListOfMedProcedure_ID char(6) ,
    Patient_ID char(6) ,
    foreign key (ListOfMedProcedure_ID) REFERENCES listofprocedure(ListOfMedProcedure_ID) on delete cascade,
    foreign key (Doctor_ID) REFERENCES Doctor(Doctor_ID) on delete cascade on update cascade,
    foreign key (Patient_ID) REFERENCES Patient(Patient_ID) on delete cascade on update cascade
    
);

