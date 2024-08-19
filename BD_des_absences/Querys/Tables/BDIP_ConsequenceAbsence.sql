DROP TABLE IF EXISTS dbo.BDIP_ConsequenceAbsence;


CREATE TABLE BDIP_ConsequenceAbsence (
	Num�ro�tablissement INT,
	Nom�tablissement NVARCHAR(50),
	Num�roDirection INT,
	NomDirection NVARCHAR(50),
	Num�roService INT,
	NomService NVARCHAR(50),
	Num�roUA INT,
	NomUA NVARCHAR(50),
	Matricule NVARCHAR(50),
	Num�ro�v�nementParent INT,
	Cons�quence NVARCHAR(50),
	Cons�quenceDOrigine NVARCHAR(50),
	DateD�but DATE,
	DateFin DATE,
	DateRetourPr�vue DATE,
	PerteTemps NVARCHAR(50),
	Rechute NVARCHAR(50),
	TypeCons�quence NVARCHAR(50)
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