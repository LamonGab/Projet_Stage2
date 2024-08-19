DROP TABLE IF EXISTS dbo.BDIP_DiagnosticRapportAccident


CREATE TABLE BDIP_DiagnosticRapportAccident (
	NuméroDirection INT,
	NomDirection NVARCHAR(50),
	NuméroService INT,
	NomService NVARCHAR(50),
	NuméroUA INT,
	NomUA NVARCHAR(50),
	NuméroÉvénement INT,
	DateÉvénement DATE,
	NuméroÉvénementParent INT,
	DateÉvénementParent DATE,
	Matricule NVARCHAR(50),
	DateDx DATE,
	DateConsolidation DATE,
	CodeDiagnostic NVARCHAR(50),
	StresseurPrincipal NVARCHAR(250),
	StresseurSecondaire1 NVARCHAR(250),
	StresseurSecondaire2 NVARCHAR(250),
	NuméroÉtablissement INT,
	Diagnostic NVARCHAR(250),
	DiagnosticAnglais NVARCHAR(250)
);


BULK INSERT dbo.BDIP_DiagnosticRapportAccident
FROM 'D:\INFOCENTRE\RH_DB\EXE\CSV\Diagnostic_Rapport_accident.csv'
WITH (
    FIELDTERMINATOR = '\',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
	CODEPAGE = '65001'
);


SELECT * FROM dbo.BDIP_DiagnosticRapportAccident