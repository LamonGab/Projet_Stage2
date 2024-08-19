DROP TABLE IF EXISTS dbo.BDIP_LimitationFonctionnelle


CREATE TABLE BDIP_LimitationFonctionnelle (
	Num�ro�tablissement INT,
	Nom�tablissement NVARCHAR(50),
	Num�roDirection INT,
	NomDirection NVARCHAR(50),
	Num�roService INT,
	NomService NVARCHAR(50),
	Num�roUA INT,
	NomUA NVARCHAR(50),
	Nunm�ro�v�nement INT,
	Date�v�nement DATE,
	Type�v�nement NVARCHAR(50),
	Matricule NVARCHAR(50),
	ProvenancePi�ceJustificative NVARCHAR(50),
	Permanente NVARCHAR(50),
	DateD�but DATE,
	DateFin DATE,
	Origine NVARCHAR(50),
	LimitationM�dicalementJustifi�eAvecCertitude NVARCHAR(50),
	�valuationM�dicaleRequise NVARCHAR(50),
	M�decinsTraitantEtD�sign�DAccordSurLaLimitation NVARCHAR(50),
	Employ�Vis�ParProcessusAccommodement NVARCHAR(50),
	TypeLimitation NVARCHAR(50),
	Classe NVARCHAR(50),
	StatutTraitementDeLaRestrictionM�dicale NVARCHAR(50),
	GestionnairePeutAccommoderTemporairementEmploy�SurPosteActuel NVARCHAR(50),
	PosteCompatibleAvecRestrictionsDisponibleDans�tablissement NVARCHAR(50),
	DateSuivi DATE,
	StatutDemandeAccommodement NVARCHAR(50),
	DateD�butRechercheAccommodement DATE,
	DateFinRechercheAccommodement DATE,
	DateInscription�quipeSp�ciale DATE,
	DateRetrait�quipeSp�ciale DATE,
	Employ�OuInstancePayanteAccepteAccommodementPropos� NVARCHAR(50),
	InstancePayante NVARCHAR(50),
	Num�ro�v�nementParent INT,
	Date�v�nementParent DATE
);


BULK INSERT dbo.BDIP_LimitationFonctionnelle
FROM 'D:\INFOCENTRE\RH_DB\EXE\CSV\Limitation_fonctionnelle.csv'
WITH (
    FIELDTERMINATOR = '\',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
	CODEPAGE = '65001'
);


SELECT * FROM dbo.BDIP_LimitationFonctionnelle