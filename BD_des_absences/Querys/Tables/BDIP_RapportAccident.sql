DROP TABLE IF EXISTS dbo.BDIP_RapportAccident


CREATE TABLE BDIP_RapportAccident (
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
	TypeDossier NVARCHAR(50),
	R�gime NVARCHAR(50),
	Date�v�nement DATE,
	DateD�claration DATE,
	DateD�butPremi�reAbsence DATE,
	Date3eAnn�eCNESST DATE,
	DateRechute DATE,
	DateDernierJourTravaill� DATE,
	DateFermeture DATE,
	RaisonFermetureDossier NVARCHAR(250),
	StatutDossier NVARCHAR(50),
	Cat�gorie�v�nement NVARCHAR(100),
	SiteLieuAccident NVARCHAR(100),
	NomSite NVARCHAR(100),
	TitreEmploi NVARCHAR(50),
	QuartTravail NVARCHAR(50),
	StresseurPrincipal NVARCHAR(250),
	StresseurSecondaire1 NVARCHAR(250),
	StresseurSecondaire2 NVARCHAR(250),
	TroublePersonnalit� NVARCHAR(150),
	CodeDiagnosticPrincipal NVARCHAR(50),
	DiagnosticPrincipal NVARCHAR(250),
	TitreEmploiMSSS NVARCHAR(250),
	DateEmbauche DATE,
	CodeTitreEmploi NVARCHAR(50),
	CodeTitreEmploiMSSS NVARCHAR(50)
);


BULK INSERT dbo.BDIP_RapportAccident
FROM 'D:\INFOCENTRE\RH_DB\EXE\CSV\Rapport_accident.csv'
WITH (
    FIELDTERMINATOR = '\',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
	CODEPAGE = '65001'
);


SELECT * FROM dbo.BDIP_RapportAccident