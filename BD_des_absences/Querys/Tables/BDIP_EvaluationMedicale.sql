DROP TABLE IF EXISTS dbo.BDIP_EvaluationMedicale


CREATE TABLE BDIP_EvaluationMedicale (
	NuméroÉtablissement INT,
	NomÉtablissement NVARCHAR(50),
	NuméroDirection INT,
	NomDirection NVARCHAR(50),
	NuméroService INT,
	NomService NVARCHAR(50),
	NuméroUA INT,
	NomUA NVARCHAR(50),
	NuméroÉvénement INT,
	DateÉvénement DATE,
	Matricule NVARCHAR(50),
	TypeÉvaluation NVARCHAR(50),
	TypeMédecin NVARCHAR(50),
	TypeConsultation NVARCHAR(50),
	TypeÉvénement NVARCHAR(50),
	TypeÉvénementAssocié NVARCHAR(50),
	DateÉvénementAssocié DATE,
	ÉvaluationOuExpertise NVARCHAR(50),
	MandatEnvoyé NVARCHAR(50),
	MontantExamen NVARCHAR(50),
	EmployéPrésentÀÉvaluationMédicale NVARCHAR(50),
	DateVisite DATE,
	RaisonsValables NVARCHAR(50),
	MédecinRecommandeExpertise NVARCHAR(50),
	DateRéceptionRésultats DATE,
	RésultatAptitudeAuTravail NVARCHAR(250),
	Pronostic NVARCHAR(50),
	MédecinConsidèreApteÀTravailler NVARCHAR(50),
	LimitationMédicalementJustifiée NVARCHAR(50),
	MédecinConsidèreDesLimitationsFonctionnelles NVARCHAR(50),
	ConsentÀLEnvoiDuRapportDuMédecinDésignéAuMédecinTraitant NVARCHAR(50),
	MotifDateOuPériodePrévisibleDeConsolidationDeLaLésion NVARCHAR(50),
	MotifDiagnostic NVARCHAR(50),
	MotifExistenceOuÉvaluationDesLimitationsFonctionnellesDuTravailleur NVARCHAR(50),
	MotifExistenceOuPourcentageAtteintePermanenteIntégritéPhysiqueOuPsychiqueDuTravailleur NVARCHAR(50),
	MotifNatureNécessitéSuffisanceOuDuréeDesSoinsOuDesTraitementsAdministrésOuPrescrits NVARCHAR(50),
	ConcernantDateOuPériodePrévisibleConsolidationLésion NVARCHAR(50),
	ConcernantNatureNécessitéSuffisanceOuDuréeSoinsOuTraitementsAdministrésOuPrescrits NVARCHAR(50),
	ConcernantDiagnostic NVARCHAR(50),
	ConcernantExistenceOuPourcentageAtteintePermanenteIntégritéPhysiqueOuPsychiqueTravailleur NVARCHAR(50),
	ConcernantExistenceOuÉvaluationLimitationsFonctionnellesTravailleur NVARCHAR(50),
	DateConsolidation DATE,
	MotifPrésentPourDemandeAuBEM NVARCHAR(50),
	DemandeAuBEMDoitÊtreDébutée NVARCHAR(50),
	DateEnvoiMandat DATE,
	DateLimitePourRapportComplémentaire DATE,
	RapportComplémentaireReçu NVARCHAR(50),
	MédecinTraitantEnAccordAvecExpertise NVARCHAR(50),
	EmployéConsolidé NVARCHAR(50),
	NomPrénomMédecinTraitant NVARCHAR(100),
	NomPrénomMédecinExpertOuDésigné NVARCHAR(100)
);


BULK INSERT dbo.BDIP_EvaluationMedicale
FROM 'D:\INFOCENTRE\RH_DB\EXE\CSV\Evaluation_medicale.csv'
WITH (
    FIELDTERMINATOR = '\',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
	CODEPAGE = '65001'
);


SELECT * FROM dbo.BDIP_EvaluationMedicale