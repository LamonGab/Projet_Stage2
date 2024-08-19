DROP TABLE IF EXISTS dbo.BDIP_EvaluationMedicale


CREATE TABLE BDIP_EvaluationMedicale (
	Num�ro�tablissement INT,
	Nom�tablissement NVARCHAR(50),
	Num�roDirection INT,
	NomDirection NVARCHAR(50),
	Num�roService INT,
	NomService NVARCHAR(50),
	Num�roUA INT,
	NomUA NVARCHAR(50),
	Num�ro�v�nement INT,
	Date�v�nement DATE,
	Matricule NVARCHAR(50),
	Type�valuation NVARCHAR(50),
	TypeM�decin NVARCHAR(50),
	TypeConsultation NVARCHAR(50),
	Type�v�nement NVARCHAR(50),
	Type�v�nementAssoci� NVARCHAR(50),
	Date�v�nementAssoci� DATE,
	�valuationOuExpertise NVARCHAR(50),
	MandatEnvoy� NVARCHAR(50),
	MontantExamen NVARCHAR(50),
	Employ�Pr�sent��valuationM�dicale NVARCHAR(50),
	DateVisite DATE,
	RaisonsValables NVARCHAR(50),
	M�decinRecommandeExpertise NVARCHAR(50),
	DateR�ceptionR�sultats DATE,
	R�sultatAptitudeAuTravail NVARCHAR(250),
	Pronostic NVARCHAR(50),
	M�decinConsid�reApte�Travailler NVARCHAR(50),
	LimitationM�dicalementJustifi�e NVARCHAR(50),
	M�decinConsid�reDesLimitationsFonctionnelles NVARCHAR(50),
	Consent�LEnvoiDuRapportDuM�decinD�sign�AuM�decinTraitant NVARCHAR(50),
	MotifDateOuP�riodePr�visibleDeConsolidationDeLaL�sion NVARCHAR(50),
	MotifDiagnostic NVARCHAR(50),
	MotifExistenceOu�valuationDesLimitationsFonctionnellesDuTravailleur NVARCHAR(50),
	MotifExistenceOuPourcentageAtteintePermanenteInt�grit�PhysiqueOuPsychiqueDuTravailleur NVARCHAR(50),
	MotifNatureN�cessit�SuffisanceOuDur�eDesSoinsOuDesTraitementsAdministr�sOuPrescrits NVARCHAR(50),
	ConcernantDateOuP�riodePr�visibleConsolidationL�sion NVARCHAR(50),
	ConcernantNatureN�cessit�SuffisanceOuDur�eSoinsOuTraitementsAdministr�sOuPrescrits NVARCHAR(50),
	ConcernantDiagnostic NVARCHAR(50),
	ConcernantExistenceOuPourcentageAtteintePermanenteInt�grit�PhysiqueOuPsychiqueTravailleur NVARCHAR(50),
	ConcernantExistenceOu�valuationLimitationsFonctionnellesTravailleur NVARCHAR(50),
	DateConsolidation DATE,
	MotifPr�sentPourDemandeAuBEM NVARCHAR(50),
	DemandeAuBEMDoit�treD�but�e NVARCHAR(50),
	DateEnvoiMandat DATE,
	DateLimitePourRapportCompl�mentaire DATE,
	RapportCompl�mentaireRe�u NVARCHAR(50),
	M�decinTraitantEnAccordAvecExpertise NVARCHAR(50),
	Employ�Consolid� NVARCHAR(50),
	NomPr�nomM�decinTraitant NVARCHAR(100),
	NomPr�nomM�decinExpertOuD�sign� NVARCHAR(100)
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