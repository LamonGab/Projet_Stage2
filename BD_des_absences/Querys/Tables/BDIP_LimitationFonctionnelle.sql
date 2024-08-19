DROP TABLE IF EXISTS dbo.BDIP_LimitationFonctionnelle


CREATE TABLE BDIP_LimitationFonctionnelle (
	NuméroÉtablissement INT,
	NomÉtablissement NVARCHAR(50),
	NuméroDirection INT,
	NomDirection NVARCHAR(50),
	NuméroService INT,
	NomService NVARCHAR(50),
	NuméroUA INT,
	NomUA NVARCHAR(50),
	NunméroÉvénement INT,
	DateÉvénement DATE,
	TypeÉvénement NVARCHAR(50),
	Matricule NVARCHAR(50),
	ProvenancePièceJustificative NVARCHAR(50),
	Permanente NVARCHAR(50),
	DateDébut DATE,
	DateFin DATE,
	Origine NVARCHAR(50),
	LimitationMédicalementJustifiéeAvecCertitude NVARCHAR(50),
	ÉvaluationMédicaleRequise NVARCHAR(50),
	MédecinsTraitantEtDésignéDAccordSurLaLimitation NVARCHAR(50),
	EmployéViséParProcessusAccommodement NVARCHAR(50),
	TypeLimitation NVARCHAR(50),
	Classe NVARCHAR(50),
	StatutTraitementDeLaRestrictionMédicale NVARCHAR(50),
	GestionnairePeutAccommoderTemporairementEmployéSurPosteActuel NVARCHAR(50),
	PosteCompatibleAvecRestrictionsDisponibleDansÉtablissement NVARCHAR(50),
	DateSuivi DATE,
	StatutDemandeAccommodement NVARCHAR(50),
	DateDébutRechercheAccommodement DATE,
	DateFinRechercheAccommodement DATE,
	DateInscriptionÉquipeSpéciale DATE,
	DateRetraitÉquipeSpéciale DATE,
	EmployéOuInstancePayanteAccepteAccommodementProposé NVARCHAR(50),
	InstancePayante NVARCHAR(50),
	NuméroÉvénementParent INT,
	DateÉvénementParent DATE
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