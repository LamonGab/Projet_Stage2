DROP TABLE IF EXISTS dbo.BDIP_DiagnosticAbsence


CREATE TABLE BDIP_DiagnosticAbsence (
	NuméroDirection INT,
	NomDirection NVARCHAR(50),
	NuméroService INT,
	NomService NVARCHAR(50),
	NuméroUA INT,
	NomUA NVARCHAR(50),
	NunméroÉvénement INT,
	DateÉvénement DATE,
	NuméroÉvénementParent INT,
	DateÉvénementParent DATE,
	Matricule NVARCHAR(50),
	Date DATE,
	DateConsolidation DATE,
	CodeDiagnostic NVARCHAR(50),
	StresseurPrincipal NVARCHAR(250),
	StresseurSecondaire1 NVARCHAR(250),
	StresseurSecondaire2 NVARCHAR(250),
	Diagnostic NVARCHAR(250),
	DiagnosticAnglais NVARCHAR(250)
);


BULK INSERT dbo.BDIP_DiagnosticAbsence
FROM 'D:\INFOCENTRE\RH_DB\EXE\CSV\Diagnostic_Absence.csv'
WITH (
    FIELDTERMINATOR = '\',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
	CODEPAGE = '65001'
);


SELECT DISTINCT * FROM dbo.BDIP_DiagnosticAbsence