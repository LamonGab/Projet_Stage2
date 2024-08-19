DROP TABLE IF EXISTS dbo.BDIP_ConsequenceRapportAccident


CREATE TABLE BDIP_ConsequenceRapportAccident (
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
	DateD�butCSQ DATE,
	DateFinCSQ DATE,
	DateRetourPr�vue DATE,
	PerteTemps NVARCHAR(50),
	Rechute NVARCHAR(50),
	TypeCons�quence NVARCHAR(50)
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