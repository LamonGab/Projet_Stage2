CREATE TABLE tempBDIP_Absence (
    CréationParUtilisateur NVARCHAR(255),
    DateDeCréationHeureUTC DATETIME,
    DateDeDébut DATE,
    DateDeDébutPremièreConséquence DATETIME,
    DateDeFermetureDossier DATE,
    DateDeFin DATE,
    DateDeFinConséquence DATE,
    DateDÉvénement DATE,
    DateDOuvertureDossier DATE,
    Date36eMoisAbsence DATE,
    DateRéelle104Semaines DATE,
    DateRéelleLimiteRechute DATE,
    DifférenceDateEmbauchePremièreAbsence INT,
    DuréeAbsenceSemaine NVARCHAR(50),
    EmployéAvecAbsentéismeÉlevé INT,
    Gestionnaire NVARCHAR(255),
    MaladieContractéeDansTravail INT,
    DiagnosticInvalidantSuiviMédicalAdéquatEtEmployéEnArrêtComplet NVARCHAR(50),
    EmployéÉligible NVARCHAR(50),
    PersonnelEncadrement NVARCHAR(50),
    MaladieInfectieuse INT,
    NuméroÉvénement NVARCHAR(50),
    NomSite NVARCHAR(255),
    NuméroSite NVARCHAR(50),
    PourcentageAbsentéisme NVARCHAR(50),
    QuartDeTravail NVARCHAR(255),
    RaisonFermetureDossier NVARCHAR(255),
    RaisonAbsence NVARCHAR(255),
    Régime NVARCHAR(255),
    MatriculeResponsableDossier NVARCHAR(50),
    NomComplet NVARCHAR(255),
    StatutEmployé NVARCHAR(255),
    StatutEmploiHabituel NVARCHAR(255),
    StatutDossier NVARCHAR(255),
    StresseurPrincipal NVARCHAR(255),
    StresseurSecondaire1 NVARCHAR(255),
    StresseurSecondaire2 NVARCHAR(255),
    SyndicatLocal NVARCHAR(255),
    SyndicatNational NVARCHAR(255),
    TotalConséquences NVARCHAR(255),
    TroublePersonnalité NVARCHAR(255),
    TypeÉvénement NVARCHAR(255),
    ÉvaluationMédicaleRequise NVARCHAR(255),
    NuméroÉtablissement NVARCHAR(50),
    NomÉtablissement NVARCHAR(255),
    NuméroDirection NVARCHAR(50),
    NomDirection NVARCHAR(255),
    NuméroService NVARCHAR(50),
    NomService NVARCHAR(255),
    NuméroUA NVARCHAR(50),
    NomUA NVARCHAR(255),
    Age INT,
    Matricule NVARCHAR(50),
    AutresDiagnosticsSuiviDossier NVARCHAR(255),
    CatégoriePersonnel NVARCHAR(255),
    DescriptionCategorieDiagnostic NVARCHAR(255),
    DescriptionRegroupementDiagnostic NVARCHAR(255),
    DescriptionTitreEmploi NVARCHAR(255),
    DescriptionMSSSTitreEmploi NVARCHAR(255),
    DiagnosticPrincipal NVARCHAR(255),
    DiagnosticPrincipalAnglais NVARCHAR(255),
    Nature NVARCHAR(255),
    Siege NVARCHAR(255),
    DateEmbauche DATE,
    CodeTitreEmploi NVARCHAR(50),
    CodeTitreEmploiMSSS NVARCHAR(50)
);

CREATE TABLE tempBDIP_AbsenteismeEleve(
	NuméroÉtablissement INT,
	NomÉtablissement NVARCHAR(50),
	NuméroDirection INT,
	NomDirection NVARCHAR(50),
	NuméroService INT,
	NomService NVARCHAR(50),
	NuméroUA INT,
	NomUA NVARCHAR(50),
	Matricule NVARCHAR(50),
	NuméroÉvénement INT,
	DateÉvénement DATE,
	StatutDossier NVARCHAR(50),
	CatégorieAbsentéisme NVARCHAR(50),
	DateDébutPériodeCalculPourcentageAbsentéisme DATE,
	DateFinPériodeCalculPourcentageAbsentéisme DATE,
	PourcentageAbsentéismeMoyen5DernièresAnnées NVARCHAR(50),
	SuiviMandatéParMSSS NVARCHAR(50),
	SuiviPlusDe12MoisDepuisInterventionInitiale NVARCHAR(50),
	SuiviPlusDe24MoisDepuisInterventionInitiale NVARCHAR(50),
	DifférenceAnnée2 NVARCHAR(50),
	DifférenceAnnée3 NVARCHAR(50),
	CodeTitreDEmploi NVARCHAR(50),
	DescriptionTitreDEmploi NVARCHAR(50),
	QuartTravail NVARCHAR(50),
	MoyenneDHeuresTravaillées NVARCHAR(50)
);

CREATE TABLE tempBDIP_ConsequenceAbsence (
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

CREATE TABLE tempBDIP_ConsequenceRapportAccident (
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

CREATE TABLE tempBDIP_DeclarationIncidentAccident (
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

CREATE TABLE tempBDIP_DiagnosticAbsence (
	NuméroDirection INT,
	NomDirection NVARCHAR(50),
	NuméroService INT,
	NomService NVARCHAR(50),
	NuméroUA INT,
	NomUA NVARCHAR(50),
	NunméroÉvénement INT,
	DateÉvénement DATE,
	NuméroÉvénementParent INT,
	DateÉvénementParent DATE,
	Matricule NVARCHAR(50),
	Date DATE,
	DateConsolidation DATE,
	CodeDiagnostic NVARCHAR(50),
	StresseurPrincipal NVARCHAR(250),
	StresseurSecondaire1 NVARCHAR(250),
	StresseurSecondaire2 NVARCHAR(250),
	Diagnostic NVARCHAR(250),
	DiagnosticAnglais NVARCHAR(250)
);

CREATE TABLE tempBDIP_DiagnosticRapportAccident (
	NuméroDirection INT,
	NomDirection NVARCHAR(50),
	NuméroService INT,
	NomService NVARCHAR(50),
	NuméroUA INT,
	NomUA NVARCHAR(50),
	NuméroÉvénement INT,
	DateÉvénement DATE,
	NuméroÉvénementParent INT,
	DateÉvénementParent DATE,
	Matricule NVARCHAR(50),
	DateDx DATE,
	DateConsolidation DATE,
	CodeDiagnostic NVARCHAR(50),
	StresseurPrincipal NVARCHAR(250),
	StresseurSecondaire1 NVARCHAR(250),
	StresseurSecondaire2 NVARCHAR(250),
	NuméroÉtablissement INT,
	Diagnostic NVARCHAR(250),
	DiagnosticAnglais NVARCHAR(250)
);

CREATE TABLE tempBDIP_EvaluationMedicale (
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

CREATE TABLE tempBDIP_LimitationFonctionnelle (
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

CREATE TABLE tempBDIP_PMSD (
	NuméroÉtablissement INT,
	NomÉtablissement NVARCHAR(50),
	NuméroDirection INT,
	NomDirection NVARCHAR(50),
	NuméroService INT,
	NomService NVARCHAR(50),
	NuméroUA INT,
	NomUA NVARCHAR(50),
	DateÉvénement DATE,
	NuméroÉvénement INT,
	Matricule NVARCHAR(50),
	StatutDossier NVARCHAR(50),
	Régime NVARCHAR(50),
	CodeTitreEmploi INT,
	DescriptionTitreEmploi NVARCHAR(250),
	DescriptionMSSSTitreEmploi NVARCHAR(250),
	DateRéceptionCertificatVisantRetraitOuAffectationTemporaire DATE,
	DateCessationTravail DATE,
	TypeDossierMaternité NVARCHAR(50),
	TravailleuseApteTravailler NVARCHAR(50),
	OrientationDossier NVARCHAR(50),
	DatePrévueAccouchement DATE,
	DatePrévueFinAllaitement DATE,
	DateSuiviFermetureDossier36eSemaine DATE,
	InterruptionGrossesse NVARCHAR(50),
	DateApproximative20eSemaineGrossesse DATE,
	InterruptionGrossesseAvant20eSemaine NVARCHAR(50),
	TravailleusePoursuitProcessusAssuranceSalaire NVARCHAR(50),
	CodeDiagnosticPrincipal NVARCHAR(50)
);

CREATE TABLE tempBDIP_RapportAccident (
	NuméroÉtablissement INT,
	NomÉtablissement NVARCHAR(50),
	NuméroDirection INT,
	NomDirection NVARCHAR(50),
	NuméroService INT,
	NomService NVARCHAR(50),
	NuméroUA INT,
	NomUA NVARCHAR(50),
	Matricule NVARCHAR(50),
	NuméroÉvénement INT,
	TypeDossier NVARCHAR(50),
	Régime NVARCHAR(50),
	DateÉvénement DATE,
	DateDéclaration DATE,
	DateDébutPremièreAbsence DATE,
	Date3eAnnéeCNESST DATE,
	DateRechute DATE,
	DateDernierJourTravaillé DATE,
	DateFermeture DATE,
	RaisonFermetureDossier NVARCHAR(250),
	StatutDossier NVARCHAR(50),
	CatégorieÉvénement NVARCHAR(100),
	SiteLieuAccident NVARCHAR(100),
	NomSite NVARCHAR(100),
	TitreEmploi NVARCHAR(50),
	QuartTravail NVARCHAR(50),
	StresseurPrincipal NVARCHAR(250),
	StresseurSecondaire1 NVARCHAR(250),
	StresseurSecondaire2 NVARCHAR(250),
	TroublePersonnalité NVARCHAR(150),
	CodeDiagnosticPrincipal NVARCHAR(50),
	DiagnosticPrincipal NVARCHAR(250),
	TitreEmploiMSSS NVARCHAR(250),
	DateEmbauche DATE,
	CodeTitreEmploi NVARCHAR(50),
	CodeTitreEmploiMSSS NVARCHAR(50)
);