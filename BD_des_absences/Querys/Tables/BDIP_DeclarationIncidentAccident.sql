DROP TABLE IF EXISTS dbo.BDIP_DeclarationIncidentAccident


CREATE TABLE BDIP_DeclarationIncidentAccident (
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
	Matricule NVARCHAR(50),
	Associ�� NVARCHAR(255),
	StatutD�claration NVARCHAR(50),
	D�clarationAvecOuSansPerteDeTemps NVARCHAR(50),
	P�riodeFinanci�re NVARCHAR(50),
	DateD�claration DATE,
	DateR�ceptionD�claration DATE,
	ExpositionSangOuAutresLiquidesBiologiquesOuChimiques NVARCHAR(50),
	DateD�claration�v�nementAuGestionnaire DATE,
	DateAnalyseParGestionnaire DATE,
	GestionnaireConfirmeDescription�v�nement NVARCHAR(50),
	TempsSuppl�mentairePendantAccident NVARCHAR(50),
	QuartTravail NVARCHAR(50),
	D�butOuFinQuartTravail NVARCHAR(50),
	TravailUrgent NVARCHAR(50),
	RisquePotentielPourClient�le NVARCHAR(50),
	AgentCausalPrincipal NVARCHAR(250),
	AgentCausalSecondaire1 NVARCHAR(250),
	AgentCausalSecondaire2 NVARCHAR(250),
	AgentCausalSecondaire3 NVARCHAR(250),
	AgentCausalSecondaire4 NVARCHAR(250),
	AgentCausalSecondaire5 NVARCHAR(250),
	AnalysePr�liminaireR�alis�eParGestionnaire NVARCHAR(50),
	Enqu�teEtAnalyseDoit�treR�alis�eParLaPr�vention NVARCHAR(50),
	Nature1 NVARCHAR(50),
	Si�ge1 NVARCHAR(50),
	C�t�DuCorps1 NVARCHAR(50),
	Nature2 NVARCHAR(50),
	Si�ge2 NVARCHAR(50),
	C�t�DuCorps2 NVARCHAR(50),
	Nature3 NVARCHAR(50),
	Si�ge3 NVARCHAR(50),
	C�t�DuCorps3 NVARCHAR(50),
	GenreDAccident NVARCHAR(250),
	IncidentAccidentProduitSurAffectation NVARCHAR(50),
	T�l�travailDurant�v�nement NVARCHAR(50),
	NomSite NVARCHAR(100),
	CodeTitreEmploi NVARCHAR(50),
	SyndicatEmploy� NVARCHAR(50),
	StatutEmploy� NVARCHAR(50),
	Cat�goriePersonnel NVARCHAR(50),
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