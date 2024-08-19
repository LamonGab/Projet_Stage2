DROP TABLE IF EXISTS dbo.BDIP_AbsenteismeEleve;


CREATE TABLE BDIP_AbsenteismeEleve (
	NuméroÉtablissement INT,
	NomÉtablissement NVARCHAR(50),
	NuméroDirection INT,
	NomDirection NVARCHAR(50),
	NuméroService INT,
	NomService NVARCHAR(50),
	NuméroUA INT,
	NomUA NVARCHAR(50),
	Matricule NVARCHAR(50),
	NuméroÉvénement INT,
	DateÉvénement DATE,
	StatutDossier NVARCHAR(50),
	CatégorieAbsentéisme NVARCHAR(50),
	DateDébutPériodeCalculPourcentageAbsentéisme DATE,
	DateFinPériodeCalculPourcentageAbsentéisme DATE,
	PourcentageAbsentéismeMoyen5DernièresAnnées NVARCHAR(50),
	SuiviMandatéParMSSS NVARCHAR(50),
	SuiviPlusDe12MoisDepuisInterventionInitiale NVARCHAR(50),
	SuiviPlusDe24MoisDepuisInterventionInitiale NVARCHAR(50),
	DifférenceAnnée2 NVARCHAR(50),
	DifférenceAnnée3 NVARCHAR(50),
	CodeTitreDEmploi NVARCHAR(50),
	DescriptionTitreDEmploi NVARCHAR(50),
	QuartTravail NVARCHAR(50),
	MoyenneDHeuresTravaillées NVARCHAR(50)
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