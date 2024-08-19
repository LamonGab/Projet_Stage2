DROP TABLE IF EXISTS dbo.BDIP_PMSD


CREATE TABLE BDIP_PMSD (
	Num�ro�tablissement INT,
	Nom�tablissement NVARCHAR(50),
	Num�roDirection INT,
	NomDirection NVARCHAR(50),
	Num�roService INT,
	NomService NVARCHAR(50),
	Num�roUA INT,
	NomUA NVARCHAR(50),
	Date�v�nement DATE,
	Num�ro�v�nement INT,
	Matricule NVARCHAR(50),
	StatutDossier NVARCHAR(50),
	R�gime NVARCHAR(50),
	CodeTitreEmploi INT,
	DescriptionTitreEmploi NVARCHAR(250),
	DescriptionMSSSTitreEmploi NVARCHAR(250),
	DateR�ceptionCertificatVisantRetraitOuAffectationTemporaire DATE,
	DateCessationTravail DATE,
	TypeDossierMaternit� NVARCHAR(50),
	TravailleuseApteTravailler NVARCHAR(50),
	OrientationDossier NVARCHAR(50),
	DatePr�vueAccouchement DATE,
	DatePr�vueFinAllaitement DATE,
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