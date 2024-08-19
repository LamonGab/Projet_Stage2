DROP TABLE IF EXISTS dbo.BDIP_DiagnosticRapportAccident


CREATE TABLE BDIP_DiagnosticRapportAccident (
	Num�roDirection INT,
	NomDirection NVARCHAR(50),
	Num�roService INT,
	NomService NVARCHAR(50),
	Num�roUA INT,
	NomUA NVARCHAR(50),
	Num�ro�v�nement INT,
	Date�v�nement DATE,
	Num�ro�v�nementParent INT,
	Date�v�nementParent DATE,
	Matricule NVARCHAR(50),
	DateDx DATE,
	DateConsolidation DATE,
	CodeDiagnostic NVARCHAR(50),
	StresseurPrincipal NVARCHAR(250),
	StresseurSecondaire1 NVARCHAR(250),
	StresseurSecondaire2 NVARCHAR(250),
	Num�ro�tablissement INT,
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