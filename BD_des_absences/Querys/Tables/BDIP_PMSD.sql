DROP TABLE IF EXISTS dbo.BDIP_PMSD


CREATE TABLE BDIP_PMSD (
	NuméroÉtablissement INT,
	NomÉtablissement NVARCHAR(50),
	NuméroDirection INT,
	NomDirection NVARCHAR(50),
	NuméroService INT,
	NomService NVARCHAR(50),
	NuméroUA INT,
	NomUA NVARCHAR(50),
	DateÉvénement DATE,
	NuméroÉvénement INT,
	Matricule NVARCHAR(50),
	StatutDossier NVARCHAR(50),
	Régime NVARCHAR(50),
	CodeTitreEmploi INT,
	DescriptionTitreEmploi NVARCHAR(250),
	DescriptionMSSSTitreEmploi NVARCHAR(250),
	DateRéceptionCertificatVisantRetraitOuAffectationTemporaire DATE,
	DateCessationTravail DATE,
	TypeDossierMaternité NVARCHAR(50),
	TravailleuseApteTravailler NVARCHAR(50),
	OrientationDossier NVARCHAR(50),
	DatePrévueAccouchement DATE,
	DatePrévueFinAllaitement DATE,
	DateSuiviFermetureDossier36eSemaine DATE,
	InterruptionGrossesse NVARCHAR(50),
	DateApproximative20eSemaineGrossesse DATE,
	InterruptionGrossesseAvant20eSemaine NVARCHAR(50),
	TravailleusePoursuitProcessusAssuranceSalaire NVARCHAR(50),
	CodeDiagnosticPrincipal NVARCHAR(50)
);


BULK INSERT dbo.BDIP_PMSD
FROM 'D:\INFOCENTRE\RH_DB\EXE\CSV\PMSD.csv'
WITH (
    FIELDTERMINATOR = '\',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
	CODEPAGE = '65001'
);


SELECT * FROM dbo.BDIP_PMSD