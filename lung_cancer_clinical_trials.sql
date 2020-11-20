DROP TABLE IF EXISTS Lung_Cancer;
DROP TABLE IF EXISTS Clinical_Trials;
DROP TABLE IF EXISTS Patients;
DROP TABLE IF EXISTS Carcinogen;
DROP TABLE IF EXISTS SNPs;
DROP TABLE IF EXISTS Drug_Procedure;
DROP TABLE IF EXISTS Company;
DROP TABLE IF EXISTS Gene;
DROP TABLE IF EXISTS Has;
DROP TABLE IF EXISTS Exposes;
DROP TABLE IF EXISTS Developed;
DROP TABLE IF EXISTS Interacts;
DROP TABLE IF EXISTS Used_In;



/*  The primary key is cancer_ID and each cancer_ID must have a unique value that is not null */

CREATE TABLE Lung_Cancer(
	cancer_ID CHAR(4) NOT NULL,
	cancer_name VARCHAR(50),
	description VARCHAR(50),
	PRIMARY KEY(cancer_ID));

/* if a cancer is deleted or updated from the Lung_Cancer table, the associated rows in the Clinical_Trials table will also be updated or set the CT_ID attribute to null. */

CREATE TABLE Clinical_Trials(
	CT_ID CHAR(5),
	name VARCHAR(50),
	description VARCHAR(250),
	phase VARCHAR(10),
	cancer_ID CHAR(4) NOT NULL,
	PRIMARY KEY(CT_ID),
	FOREIGN KEY(cancer_ID) REFERENCES Lung_Cancer(cancer_ID));

/* Patient_ID has a not null constraint because it uniquely identifies the patients. CT_ID has a not null constraint because all patients must participate in a clinical trial. Delete and update cascade are on for the foreign key so that patients will be updated/deleted with clinical trials. */
CREATE TABLE Patients(
	patient_ID CHAR(7),
	age INT(3),
	sex CHAR(1),
	race VARCHAR(10),
	start_date DATE,
	CT_ID CHAR(5) NOT NULL,
	PRIMARY KEY(patient_ID),
	FOREIGN KEY(CT_ID) REFERENCES Clinical_Trials(CT_ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE);

/*this table doesn't have any reference key.*/
CREATE TABLE Company(
	company_ID CHAR(7),
	name VARCHAR(50),
	phone_number VARCHAR(12),
	street_number INT(4),
	street_name VARCHAR(30),
	city VARCHAR(25),
	State VARCHAR(20),
	Zip_code INT(5),
	PRIMARY KEY (company_ID));

/* The primary key is DP_ID and the name of the drug or procedure can not be null and must be unique. */
CREATE TABLE Drug_Procedure(
	DP_ID CHAR(6),
	name VARCHAR(25) NOT NULL,
	generic_name VARCHAR(25),
	type VARCHAR(9),
	description VARCHAR(50),
	PRIMARY KEY (DP_ID));

/*company_ID must a not null constraint because it must be unique.*/
Create table Developed( 
	company_ID CHAR(7),
	DP_ID CHAR(6),
	PRIMARY KEY(company_ID, DP_ID),
	FOREIGN KEY(company_ID) REFERENCES Company(company_ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY(DP_ID) REFERENCES Drug_Procedure(DP_ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE);


/* The gene_ID is the primary key and the name of the gene can  not be null and must be unique.  */
CREATE TABLE Gene(
	gene_ID CHAR(4),
	name VARCHAR(10)  NOT NULL,
	chromosome_name VARCHAR(13),
	start_position INT(10),
	end_position INT(10),
	strand VARCHAR(8),
	PRIMARY KEY(gene_ID));

/* The Interacts table contains a composite key containing gene_ID and DP_ID. Gene_ID is a foreign key from the gene table while DP_ID is a foregin key from the Drug_Procedure table. Both will participate in on delete cascade and on update cascade when an event occurs  */
CREATE TABLE Interacts(
	Gene_ID CHAR(4),
	DP_ID CHAR(6),
	association VARCHAR(50),
	PRIMARY KEY (gene_ID, DP_ID),
	FOREIGN KEY (gene_ID) REFERENCES Gene(gene_ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY(DP_ID) REFERENCES Drug_Procedure(DP_ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE);

/* The Used_In table contains a composite key containing CT_ID and DP_ID. CT_ID is a foreign key from the Clinical_Trials table while DP_ID is a foregin key from the Drug_Procedure table. Both will participate in on delete cascade and on update cascade when an event occurs  */
CREATE TABLE Used_In(
	CT_ID CHAR(5),
	DP_ID VARCHAR(6),
	PRIMARY KEY (CT_ID, DP_ID),
	FOREIGN KEY(CT_ID) REFERENCES Clinical_Trials(CT_ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY(DP_ID) REFERENCES Drug_Procedure(DP_ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE);

/*  The primary key is variation_name and each variation_name must have a unique value that is not null */
CREATE TABLE SNPs(
	V_ID CHAR(4),
	variant_name VARCHAR(50),
	associated_cancer VARCHAR(50),
	clinical_significance VARCHAR(20),
	gene VARCHAR(6),
	PRIMARY KEY(V_ID));

/* if a patient is deleted or updated, the associated rows will also be updated or deleted. Also, if a carcinogen is deleted or updated, the associated rows will also be updated or deleted */
CREATE TABLE Has(
	patient_ID CHAR(7),
	V_ID VARCHAR(4),
	PRIMARY KEY(patient_ID, V_ID),
	FOREIGN KEY(patient_ID) REFERENCES Patients(patient_ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY(V_ID) REFERENCES SNPs(V_ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE);

/*  The primary key is name and each name must have a unique value that is not null */
CREATE TABLE Carcinogen(
	name VARCHAR(20),
	description VARCHAR(50),
	PRIMARY KEY(name));

/* if a patient is deleted or updated, the associated rows will also be updated or deleted. Also, if a carcinogen is deleted or updated, the associated rows will also be updated or deleted */
CREATE TABLE Exposes(
	patient_ID CHAR(7),
	name VARCHAR(20),
	frequency VARCHAR(6),
	PRIMARY KEY(patient_ID, name),
	FOREIGN KEY(patient_ID) REFERENCES Patients(patient_ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY(name) REFERENCES Carcinogen(name) 
	ON DELETE CASCADE
	ON UPDATE CASCADE);


/* insert statements */

insert into Lung_Cancer 
	(cancer_ID,cancer_name,description)
	values 
	('LC01','Small cell carcinoma','Small cell lung cancer'),
	('LC02','Combined small cell carcinoma','Small cell lung cancer'),
	('LC03','Adenocarcinoma','Non_small cell lung cancer'),
	('LC04','Squamous cell','Non_small cell lung cancer'),
	('LC05','Large_cell undifferentiated carcinoma','Non_small cell lung cancer'),
	('LC06','Large cell neuroendocrine carcinoma','Rare form of lung cancer'),
	('LC07','Salivary gland_type lung carcinoma','Rare form of lung cancer'),
	('LC08','Lung carcinoids','Rare form of lung cancer'),
	('LC09','Mesothelioma','Rare form of lung cancer'),
	('LC10','sarcomatoid carcinoma of the lung','Rare form of lung cancer'),
	('LC11','malignant granular cell lung tumors','Rare form of lung cancer');


insert into Clinical_Trials 
	(CT_ID,name,description,phase,cancer_ID)
	values 
	('CT001','Small cell carcinoma treatment for smoker by Bevacizumab','Small cell carcinoma',1,'LC01'),
	('CT002','Lobectomy and Osimertinib for Treatment after return of cancer','Large-cell undifferentiated carcinoma',2,'LC05'),
	('CT003','Erlotinib and angiogenesis drug Atezolizumab for Small cell carcinoma in women 60 years old and above','non_Small cell carcinoma',3,'LC01'),
	('CT004','Use of Nivolumab after 2 previous treatment of chemotherapy with cisplatin for Treatment for stage 2','Adenocarcinoma',3,'LC03'),
	('CT005','Ramucirumab Capmatinib and Selpercatinib  for Treatment for relapsed patients','Large_cell undifferentiated carcinoma',2,'LC05'),
	('CT006','Necitumumab used to target EGFR gene while male asian patients undergo chemotherapy for Treatment','Squamous cell',1,'LC04'),
	('CT007','Dabrafenib and radiation therapy to determine cause of drug in development of combined small cell carcinoma and metastasis to squamous cell skin cancer','Combined small cell carcinoma',2,'LC02'),
	('CT008','Radiation Therapy and Larotrectinib for young adults  age group (18 - 29)','Large_cell undifferentiated carcinoma',3,'LC05'),
	('CT009','Entrectinib used when individuals are negative for ALK, KRAS and EGFR mutations and under 50 years old','Adenocarcinoma',3,'LC03'),
	('CT010','Crizotinib used after chemo stopped working for patients with adenocarinoma under 30 years old who are non-smokers','Adenocarcinoma',3,'LC04');


insert into Patients 
	(patient_ID, age, sex, race, start_date, CT_ID)
	values
	('PID_001' , 36 , 'f' , 'white' , '2020-03-25' , 'CT001'),
	('PID_008' , 38 , 'm' , 'asian' , '2020-03-27' , 'CT001'),
	('PID_012' , 42 , 'm' , 'white' , '2020-03-22' , 'CT001'),
	('PID_006' , 48 , 'f' , 'black' , '2020-06-25' , 'CT002'),
	('PID_019' , 27 , 'f' , 'asian' , '2020-06-03' , 'CT002'),
	('PID_032' , 38 , 'm' , 'white' , '2020-06-18' , 'CT002'),
	('PID_040' , 51 , 'f' , 'white' , '2020-06-09' , 'CT002'),
	('PID_004' , 61 , 'f' , 'white' , '2020-08-16' , 'CT003'),
	('PID_005' , 73 , 'f' , 'black' , '2020-08-18' , 'CT003'),
	('PID_014' , 62 , 'f' , 'black' , '2020-08-14' , 'CT003'),
	('PID_017' , 64 , 'f' , 'asian' , '2020-08-21' , 'CT003'),
	('PID_035' , 71 , 'f' , 'white' , '2020-08-06' , 'CT003'),
	('PID_003' , 44 , 'f' , 'black' , '2020-07-30' , 'CT004'),
	('PID_024' , 35 , 'm' , 'white' , '2020-07-15' , 'CT004'),
	('PID_025' , 46 , 'm' , 'asian' , '2020-07-27' , 'CT004'),
	('PID_028' , 23 , 'f' , 'asian' , '2020-07-24' , 'CT004'),
	('PID_030' , 67 , 'f' , 'black' , '2020-07-11' , 'CT004'),
	('PID_002' , 44 , 'f' , 'white' , '2020-11-18' , 'CT005'),
	('PID_022' , 56 , 'm' , 'white' , '2020-11-02' , 'CT005'),
	('PID_031' , 65 , 'f' , 'white' , '2020-11-15' , 'CT005'),
	('PID_036' , 27 , 'm' , 'black' , '2020-11-21' , 'CT005'),
	('PID_018' , 34 , 'm' , 'asian' , '2020-09-22' , 'CT006'),
	('PID_023' , 41 , 'm' , 'asian' , '2020-09-04' , 'CT006'),
	('PID_029' , 29 , 'm' , 'asian' , '2020-09-07' , 'CT006'),
	('PID_007' , 56 , 'f' , 'white' , '2020-02-02' , 'CT007'),
	('PID_013' , 42 , 'm' , 'white' , '2020-02-05' , 'CT007'),
	('PID_033' , 32 , 'm' , 'asian' , '2020-02-14' , 'CT007'),
	('PID_038' , 33 , 'f' , 'white' , '2020-02-21' , 'CT007'),
	('PID_010' , 27 , 'f' , 'white' , '2020-01-01' , 'CT008'),
	('PID_009' , 19 , 'f' , 'black' , '2020-01-15' , 'CT008'),
	('PID_011' , 25 , 'm' , 'black' , '2020-01-17' , 'CT008'),
	('PID_021' , 22 , 'm' , 'white' , '2020-01-23' , 'CT008'),
	('PID_026' , 24 , 'm' , 'white' , '2020-01-26' , 'CT008'),
	('PID_027' , 49 , 'm' , 'white' , '2020-03-03' , 'CT009'),
	('PID_034' , 33 , 'f' , 'asian' , '2020-03-04' , 'CT009'),
	('PID_037' , 37 , 'f' , 'white' , '2020-03-06' , 'CT009'),
	('PID_016' , 41 , 'm' , 'black' , '2020-03-01' , 'CT009'),
	('PID_041' , 44 , 'f' , 'asian' , '2020-03-02' , 'CT009'),
	('PID_015' , 20 , 'f' , 'black' , '2020-05-01' , 'CT010'),
	('PID_020' , 29 , 'm' , 'black' , '2020-05-02' , 'CT010'),
	('PID_039' , 24 , 'f' , 'asian' , '2020-05-13' , 'CT010'),
	('PID_042' , 28 , 'm' , 'asian' , '2020-05-26' , 'CT010'),
	('PID_043' , 24 , 'f' , 'white' , '2020-05-03' , 'CT010');

insert into SNPs 
	(V_ID,variant_name,associated_cancer,clinical_significance,gene)
	values 
	('V001','NM_002524.5(NRAS):c.183A>T (p.Gln61His)','Adenocarcinoma','Pathogenic','NRAS'),
	('V002','NM_002524.5(NRAS):c.35G>C (p.Gly12Ala)','Small Cell','Pathogenic','NRAS'),
	('V003','NM_000639.2(FASLG):c.-157-687C=','Small Cell','Risk factor','FASLG'),
	('V004','NM_022552.5(DNMT3A):c.2645G>C (p.Arg882Pro)','Adenocarcinoma','Likely pathogenic','DNMT3A'),
	('V005','NM_006164.5(NFE2L2):c.235G>A (p.Glu79Lys)','Squamous cell','Likely pathogenic','NFE2L2'),
	('V006','NM_004304.5(ALK):c.3522C>A (p.Phe1174Leu)','Combined small cell carcinoma','Likely pathogenic','ALK'),
	('V007','NM_001282386.1(IDH1):c.394C>G (p.Arg132Gly)','Adenocarcinoma','Likely pathogenic','IDH1'),
	('V008','NM_001904.4(CTNNB1):c.98C>A (p.Ser33Tyr)','Large-cell undifferentiated carcinoma','Pathogenic','CTNNB1'),
	('V009','NM_004431.5(EPHA2):c.1171G>C (p.Gly391Arg)','Squamous cell','Pathogenic','EPHA2'),
	('V010','NM_000546.6(TP53):c.1010G>A (p.Arg337His)','Small Cell','Pathogenic','TP53');

insert into Has
	(patient_ID, V_ID)
	values
	('PID_001' , 'V003'),
	('PID_001' , 'V002'),
	('PID_008' , 'V002'),
	('PID_012' , 'V010'),
	('PID_006' , 'V008'),
	('PID_006' , 'V002'),
	('PID_032' , 'V008'),
	('PID_004' , 'V003'),
	('PID_005' , 'V002'),
	('PID_014' , 'V002'),
	('PID_035' , 'V003'),
	('PID_003' , 'V001'),
	('PID_024' , 'V001'),
	('PID_028' , 'V001'),
	('PID_028' , 'V007'),
	('PID_002' , 'V001'),
	('PID_002' , 'V006'),
	('PID_022' , 'V008'),
	('PID_007' , 'V005'),
	('PID_013' , 'V006'),
	('PID_033' , 'V009'),
	('PID_038' , 'V006'),
	('PID_038' , 'V005'),
	('PID_038' , 'V009'),
	('PID_011' , 'V008'),
	('PID_026' , 'V008'),
	('PID_027' , 'V001'),
	('PID_027' , 'V007'),
	('PID_034' , 'V007'),
	('PID_037' , 'V007'),
	('PID_016' , 'V001'),
	('PID_041' , 'V007'),
	('PID_039' , 'V007'),
	('PID_043' , 'V001');

insert into Carcinogen
	(name, description)
	values
	('Smoking' , 'First hand smoking of tobacco'),
	('Secondhand Smoke' , 'Breathing in secondhand smoke'),
	('Radon' , 'Breathing in naturally occurring gas from rocks and dirt'),
	('Asbestos' , 'Exposure to asbestos'),
	('Arsenic' , 'Drinking arsenic contaminated water'),
	('Diesel Exhaust' , 'Breathing in diesel exhaust'),
	('Radiation' , 'Exposure of Chest area to radiation'),
	('Silica' , 'Breathing in silica dust'),
	('Chromium' , 'Breathing in chromium'),
	('Coal' , 'Breathing in coal or coal products');

insert into Exposes
	(patient_ID, name, frequency)
	values
	('PID_001' , 'Smoking' , 'High'),
	('PID_008' , 'Smoking' , 'High'),
	('PID_012' , 'Smoking' , 'High'),
	('PID_032' , 'Coal' , 'High'),
	('PID_004' , 'Secondhand Smoke' , 'Medium'),
	('PID_005' , 'Secondhand Smoke' , 'Medium'),
	('PID_014' , 'Radon' , 'High'),
	('PID_017' , 'Secondhand Smoke' , 'Low'),
	('PID_035' , 'Asbestos' , 'Low'),
	('PID_024' , 'Coal' , 'Medium'),
	('PID_024' , 'Smoking' , 'Medium'), 
	('PID_025' , 'Diesel Exhaust' , 'Medium'),
	('PID_028' , 'Silica' , 'Low'),
	('PID_030' , 'Arsenic' , 'High'),
	('PID_002' , 'Smoking' , 'Medium'),
	('PID_002' , 'Radiation' , 'High'),
	('PID_022' , 'Radiation' , 'High'),
	('PID_002' , 'Asbestos' , 'Medium'),
	('PID_031' , 'Radiation' , 'High'),
	('PID_018' , 'Silica' , 'Medium'),
	('PID_023' , 'Secondhand Smoke' , 'Low'),
	('PID_010' , 'Smoking' , 'High'),
	('PID_021' , 'Secondhand Smoke' , 'High'),
	('PID_027' , 'Diesel Exhaust' , 'Medium'),
	('PID_037' , 'Secondhand Smoke' , 'Low'),
	('PID_041' , 'Coal' , 'Medium'),
	('PID_015' , 'Radon' , 'Medium'),
	('PID_020' , 'Coal' , 'Medium'),
	('PID_039' , 'Coal' , 'Low'),
	('PID_042' , 'Arsenic' , 'Medium'),
	('PID_043' , 'Coal' , 'Medium');

insert into Drug_Procedure
	(DP_ID, name, generic_name, type, description)
	values
	('DP_001','Nivolumab','Opdivo', 'Drug', 'Blocks PD-1'),
	('DP_002', 'Bevacizumab', 'Avastin', 'Drug', 'Targets VEGF'),
	('DP_003', 'Ramucirumab', 'Cyramza', 'Drug', 'Targets VEGF'),
	('DP_004', 'Lobectomy', 'NA', 'Procedure', 'Removal of an entire lobe of the lung'),
	('DP_005', 'Erlotinib', 'Tarceva', 'Drug', 'EGFR inhibitor'),
	('DP_006', 'Chemotherapy', 'NA', 'Procedure', 'Remove entire lobe of the lung'),
	('DP_007', 'Atezolizumab', 'Tcentriq', 'Drug', 'Target PD-L1'),
	('DP_008', 'Radiation Therapy', 'NA', 'Procedure', 'High energy x-rays or other particles'),
	('DP_009', 'Osimertinib', 'Targisso', 'Drug', 'EGFR inhibitor against T790M mutation'),
	('DP_010', 'Necitumumab', 'Portrazza', 'Drug', 'EGFR inhibitor'),
	('DP_011', 'Entrectinib', 'Rozlytrek', 'Drug', 'Target ROS1 gene change'),
	('DP_012', 'Crizotinib', 'Xalkori', 'Drug', 'ALK or ROS1 inhibitor'),
	('DP_013','Dabrafenib', 'Tafinlar', 'Drug', 'BRAF inhibitor'),
	('DP_014', 'Selpercatinib', 'Retervmo', 'Drug', 'RET inhibitor'),
	('DP_015', 'Capmatinib', 'Tabrecta', 'Drug', 'MET inhibitor'),
	('DP_016', 'Larotrectinib', 'Vitrakvi', 'Drug', 'NTRK inhibitor'),
	('DP_017', 'Alpelisib', 'Piqray', 'Drug', 'Targets PIK3Ca mutation');

insert into Used_In
	(CT_ID, DP_ID)
	values
	('CT001' , 'DP_002'),
	('CT002' , 'DP_009'),
	('CT003' , 'DP_005'),
	('CT003' , 'DP_007'),
	('CT004' , 'DP_001'),
	('CT005' , 'DP_003'),
	('CT005' , 'DP_014'),
	('CT005' , 'DP_015'),
	('CT006' , 'DP_010'),
	('CT007' , 'DP_013'),
	('CT008' , 'DP_016'),
	('CT009' , 'DP_011'),
	('CT010' , 'DP_012');


insert into Company 
	(company_ID,name,phone_number,street_number,street_name,city,State,Zip_code)
	values
	('Comp_01', 'Sunshinetech', '240-686-3429', '621', 'Fox Road', 'Germantown', 'Maryland', '20875'),
	('Comp_02', 'BeachScience', '652-863-6315', '812', 'Sunflower Ave', 'West Point', 'Pennsylvania', '95255'),
	('Comp_03', 'BiomedTech', '909-875-3652', '1234','Zebra Blvd', 'Raleigh', 'North Carolina', '27606'),
	('Comp_04', 'Lifescience', '421-873-925', '8953', 'Eggplant Road', 'Princeton', 'New Jersey', '08542'),
	('Comp_05', 'Pharmtech', '874-027-0462', '5690', 'Tiger Blvd', 'San Diego', 'California', '92102'),
	('Comp_06', 'SpringScience', '672-389-6529', '1348', 'Pineapple Ave', 'Long Island', 'New York', '11003'),
	('Comp_07', 'JerseyTech', '411-096-7640', '5921', 'Lion Road', 'Edison', 'New Jersey', '08817'),
	('Comp_08', 'SealTech', '865-942-6452', '2158', 'Blueberry Blvd', 'Foster City', 'California', '94404'),
	('Comp_09', 'AntitumorTech', '572-372-9642', '8936', 'Butterfly Ave', 'Boston', 'Massachusetts', '02116'),
	('Comp_10', 'MabScience', '692-972-5729', '3926', 'Organe Road', 'Chicago', 'Illinois', '60608'),
	('Comp_11', 'WaterScience', '839-642-7248', '7263', 'Greatwall Blvd', 'Seattle', 'Washington', '98108');

insert into Developed
	(company_ID, DP_ID)
	values
	('Comp_01' , 'DP_004'),
	('Comp_01' , 'DP_006'),
	('Comp_01' , 'DP_008'),
	('Comp_02' , 'DP_011'),
	('Comp_02' , 'DP_012'),
	('Comp_03' , 'DP_013'),
	('Comp_03' , 'DP_003'),
	('Comp_04' , 'DP_015'),
	('Comp_05' , 'DP_005'),
	('Comp_05' , 'DP_009'),
	('Comp_06' , 'DP_014'),
	('Comp_06' , 'DP_012'),
	('Comp_07' , 'DP_017'),
	('Comp_07' , 'DP_010'),
	('Comp_08' , 'DP_016'),
	('Comp_09' , 'DP_001'),
	('Comp_09' , 'DP_005'),
	('Comp_10' , 'DP_001'),
	('Comp_10' , 'DP_007'),
	('Comp_11' , 'DP_002'),
	('Comp_11' , 'DP_003'),
	('Comp_11' , 'DP_010');

insert into Gene
	(gene_ID, name, chromosome_name, start_position, end_position, strand)
	values
	('1956' , 'EGFR' , 'Chromosome7' , 55019017 , 55211628 , 'positive'),
	('4233' , 'MET' , 'Chromosome7' , 116672196 , 116798386 , 'positive'),
	('4914' , 'NTRK1' , 'Chromosome1' , 156815750 , 156881850 , 'positive'),
	('5979' , 'RET' , 'Chromosome10' , 43077069 , 43130351 , 'positive'),
	('0673' , 'BRAF' , 'Chromosome7' , 140713328 , 140924929 , 'negative'),
	('6098' , 'ROS1' , 'Chromosome6' , 117287353 , 117426065 , 'negative'),
	('0238' , 'ALK' , 'Chromosome2' , 29190992 , 29921589 , 'negative'),
	('3845' , 'KRAS' , 'Chromosome12' , 25205246 , 25250929 , 'negative'),
	('7157' , 'TP53' , 'Chromosome17' , 7668402 , 7687550 , 'negative'),
	('5290' , 'PIK3CA' , 'Chromosome3' , 179148114 , 179240093 , 'positive');

insert into Interacts 
	(gene_ID, DP_ID, association)
	values
	('1956' , 'DP_009' , 'EGFR inhibitor'),
	('1956' , 'DP_010' , 'Blocks EGFR'),
	('4233' , 'DP_015' , 'Blocks MET'),
	('4914' , 'DP_016' , 'Blocks NTRK'),
	('5979' , 'DP_014' , 'Inhibits RET proteins'),
	('0673' , 'DP_013' , 'Blocks BRAF'),
	('6098' , 'DP_011' , 'Inhibits TRK protein'),
	('6098' , 'DP_012' , 'Inhibitor of receptor tyrosine kinase'),
	('0238' , 'DP_012' , 'Inhibitor of receptor tyrosine kinase'),
	('3845' , 'DP_013' , 'Blocks BRAF'),
	('7157' , 'DP_005' , 'Reduction in overexpression of mutated p53'),
	('5290' , 'DP_017' , 'Inhibits PI3k protein');
