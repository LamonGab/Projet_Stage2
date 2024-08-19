DROP TABLE IF EXISTS dbo.BDIP_RapportAccident


CREATE TABLE BDIP_RapportAccident (
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
	TypeDossier NVARCHAR(50),
	Régime NVARCHAR(50),
	DateÉvénement DATE,
	DateDéclaration DATE,
	DateDébutPremièreAbsence DATE,
	Date3eAnnéeCNESST DATE,
	DateRechute DATE,
	DateDernierJourTravaillé DATE,
	DateFermeture DATE,
	RaisonFermetureDossier NVARCHAR(250),
	StatutDossier NVARCHAR(50),
	CatégorieÉvénement NVARCHAR(100),
	SiteLieuAccident NVARCHAR(100),
	NomSite NVARCHAR(100),
	TitreEmploi NVARCHAR(50),
	QuartTravail NVARCHAR(50),
	StresseurPrincipal NVARCHAR(250),
	StresseurSecondaire1 NVARCHAR(250),
	StresseurSecondaire2 NVARCHAR(250),
	TroublePersonnalité NVARCHAR(150),
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