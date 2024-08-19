DROP TABLE IF EXISTS dbo.BDIP_AbsenteismeEleve;


CREATE TABLE BDIP_AbsenteismeEleve (
	Num�ro�tablissement INT,
	Nom�tablissement NVARCHAR(50),
	Num�roDirection INT,
	NomDirection NVARCHAR(50),
	Num�roService INT,
	NomService NVARCHAR(50),
	Num�roUA INT,
	NomUA NVARCHAR(50),
	Matricule NVARCHAR(50),
	Num�ro�v�nement INT,
	Date�v�nement DATE,
	StatutDossier NVARCHAR(50),
	Cat�gorieAbsent�isme NVARCHAR(50),
	DateD�butP�riodeCalculPourcentageAbsent�isme DATE,
	DateFinP�riodeCalculPourcentageAbsent�isme DATE,
	PourcentageAbsent�ismeMoyen5Derni�resAnn�es NVARCHAR(50),
	SuiviMandat�ParMSSS NVARCHAR(50),
	SuiviPlusDe12MoisDepuisInterventionInitiale NVARCHAR(50),
	SuiviPlusDe24MoisDepuisInterventionInitiale NVARCHAR(50),
	Diff�renceAnn�e2 NVARCHAR(50),
	Diff�renceAnn�e3 NVARCHAR(50),
	CodeTitreDEmploi NVARCHAR(50),
	DescriptionTitreDEmploi NVARCHAR(50),
	QuartTravail NVARCHAR(50),
	MoyenneDHeuresTravaill�es NVARCHAR(50)
);


BULK INSERT dbo.BDIP_AbsenteismeEleve
FROM 'D:\INFOCENTRE\RH_DB\EXE\CSV\Absenteisme_eleve.csv'
WITH (
    FIELDTERMINATOR = '\',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
	CODEPAGE = '65001'
);


SELECT DISTINCT * FROM dbo.BDIP_AbsenteismeEleve