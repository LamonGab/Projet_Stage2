DROP TABLE IF EXISTS dbo.BDIP_ConsequenceAbsence;


CREATE TABLE BDIP_ConsequenceAbsence (
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
	DateDébut DATE,
	DateFin DATE,
	DateRetourPrévue DATE,
	PerteTemps NVARCHAR(50),
	Rechute NVARCHAR(50),
	TypeConséquence NVARCHAR(50)
);


BULK INSERT dbo.BDIP_ConsequenceAbsence
FROM 'D:\INFOCENTRE\RH_DB\EXE\CSV\Consequence_Absence.csv'
WITH (
    FIELDTERMINATOR = '\',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
	CODEPAGE = '65001'
);


SELECT DISTINCT * FROM dbo.BDIP_ConsequenceAbsence