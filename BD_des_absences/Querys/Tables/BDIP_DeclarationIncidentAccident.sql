DROP TABLE IF EXISTS dbo.BDIP_DeclarationIncidentAccident


CREATE TABLE BDIP_DeclarationIncidentAccident (
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
	Matricule NVARCHAR(50),
	AssociéÀ NVARCHAR(255),
	StatutDéclaration NVARCHAR(50),
	DéclarationAvecOuSansPerteDeTemps NVARCHAR(50),
	PériodeFinancière NVARCHAR(50),
	DateDéclaration DATE,
	DateRéceptionDéclaration DATE,
	ExpositionSangOuAutresLiquidesBiologiquesOuChimiques NVARCHAR(50),
	DateDéclarationÉvénementAuGestionnaire DATE,
	DateAnalyseParGestionnaire DATE,
	GestionnaireConfirmeDescriptionÉvénement NVARCHAR(50),
	TempsSupplémentairePendantAccident NVARCHAR(50),
	QuartTravail NVARCHAR(50),
	DébutOuFinQuartTravail NVARCHAR(50),
	TravailUrgent NVARCHAR(50),
	RisquePotentielPourClientèle NVARCHAR(50),
	AgentCausalPrincipal NVARCHAR(250),
	AgentCausalSecondaire1 NVARCHAR(250),
	AgentCausalSecondaire2 NVARCHAR(250),
	AgentCausalSecondaire3 NVARCHAR(250),
	AgentCausalSecondaire4 NVARCHAR(250),
	AgentCausalSecondaire5 NVARCHAR(250),
	AnalysePréliminaireRéaliséeParGestionnaire NVARCHAR(50),
	EnquêteEtAnalyseDoitÊtreRéaliséeParLaPrévention NVARCHAR(50),
	Nature1 NVARCHAR(50),
	Siège1 NVARCHAR(50),
	CôtéDuCorps1 NVARCHAR(50),
	Nature2 NVARCHAR(50),
	Siège2 NVARCHAR(50),
	CôtéDuCorps2 NVARCHAR(50),
	Nature3 NVARCHAR(50),
	Siège3 NVARCHAR(50),
	CôtéDuCorps3 NVARCHAR(50),
	GenreDAccident NVARCHAR(250),
	IncidentAccidentProduitSurAffectation NVARCHAR(50),
	TélétravailDurantÉvénement NVARCHAR(50),
	NomSite NVARCHAR(100),
	CodeTitreEmploi NVARCHAR(50),
	SyndicatEmployé NVARCHAR(50),
	StatutEmployé NVARCHAR(50),
	CatégoriePersonnel NVARCHAR(50),
	DescriptionTitreEmploi NVARCHAR(255),
	DescriptionMSSSTitreEmploi NVARCHAR(255),
	DateEmbauche DATE,
	CodeGenreAccident NVARCHAR(500)
);


BULK INSERT dbo.BDIP_DeclarationIncidentAccident
FROM 'D:\INFOCENTRE\RH_DB\EXE\CSV\Declaration_incident_Accident.csv'
WITH (
    FIELDTERMINATOR = '\',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
	CODEPAGE = '65001'
);


SELECT * FROM dbo.BDIP_DeclarationIncidentAccident