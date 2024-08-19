DROP TABLE IF EXISTS dbo.BDIP_ConsequenceRapportAccident


CREATE TABLE BDIP_ConsequenceRapportAccident (
	NuméroÉtablissement INT,
	NomÉtablissement NVARCHAR(50),
	NuméroDirection INT,
	NomDirection NVARCHAR(50),
	NuméroService INT,
	NomService NVARCHAR(50),
	NuméroUA INT,
	NomUA NVARCHAR(50),
	Matricule NVARCHAR(50),
	NuméroÉvénementParent INT,
	Conséquence NVARCHAR(50),
	ConséquenceDOrigine NVARCHAR(50),
	DateDébutCSQ DATE,
	DateFinCSQ DATE,
	DateRetourPrévue DATE,
	PerteTemps NVARCHAR(50),
	Rechute NVARCHAR(50),
	TypeConséquence NVARCHAR(50)
);


BULK INSERT dbo.BDIP_ConsequenceRapportAccident
FROM 'D:\INFOCENTRE\RH_DB\EXE\CSV\Consequence_Rapport_accident.csv'
WITH (
    FIELDTERMINATOR = '\',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
	CODEPAGE = '65001'
);


SELECT * FROM dbo.BDIP_ConsequenceRapportAccident