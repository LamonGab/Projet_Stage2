DROP VIEW IF EXISTS CodeDePaieCalcule

CREATE VIEW CodeDePaieCalcule AS
WITH CalculCTE AS (
	SELECT
		a.NuméroÉvénement,
		CASE
			WHEN a.Régime = 'Assurance salaire' AND ca.Conséquence = 'Absence' AND a.DateDébutPremièreConséquence = ca.DateDébut AND a.EmployéÉligible = 'non' THEN 'DateDeDébutPremièreConséquence = DateDébut AND EmployéÉligible = non'
			WHEN (a.Régime = 'Assurance salaire' AND ca.Conséquence = 'Absence' OR a.Régime = 'Assurance salaire grossesse' AND ca.Conséquence = 'Absence' OR a.Régime = 'SAAQ' AND ca.Conséquence = 'Absence') AND a.DateDébutPremièreConséquence = ca.DateDébut THEN 'DateDeDébutPremièreConséquence = DateDébut'
			WHEN a.Régime = 'Assurance salaire 3e année et plus' AND (ca.Conséquence = 'Absence' OR ca.Conséquence = 'Assignation temporaire/travaux légers' OR ca.Conséquence = 'Rechute' OR ca.Conséquence = 'Retour progressif') AND a.EmployéÉligible = 'non' THEN 'EmployéÉligible = non'
			WHEN ra.Régime = 'CNESST' AND cra.Conséquence = 'Arrêt de travail' AND ra.DateDébutPremièreAbsence = cra.DateDébutCSQ THEN 'DateDébutPremièreAbsence = DateDébutCSQ'
			ELSE NULL
		END AS Condition
	FROM BDIP_Absence a

	LEFT JOIN BDIP_ConsequenceAbsence ca ON a.NuméroÉvénement = ca.NuméroÉvénementParent
	LEFT JOIN BDIP_RapportAccident ra ON a.Matricule = ra.Matricule
	LEFT JOIN BDIP_ConsequenceRapportAccident cra ON ra.NuméroÉvénement = cra.NuméroÉvénementParent
)
SELECT a.Régime AS RégimeAbsence, ca.Conséquence AS ConséquenceAbsence, cc.Condition, ra.Régime AS RégimeRapportAccident, cra.Conséquence AS ConséquenceRapportAccident,
p.Régime AS RégimePMSD,
CASE
	WHEN a.Régime = 'Absence courte durée' AND ca.Conséquence = 'Absence' AND cc.Condition IS NULL THEN 'Mal'
	WHEN a.Régime = 'Assurance salaire' AND ca.Conséquence = 'Absence' AND cc.Condition = 'DateDeDébutPremièreConséquence = DateDébut' THEN 'Durant le délais de carence: Mal' + char(13) + char(10) + 'Après le délais de carence: Assal'
	WHEN a.Régime = 'Assurance salaire' AND ca.Conséquence = 'Absence' AND cc.Condition = 'DateDeDébutPremièreConséquence = DateDébut AND EmployéÉligible = non' THEN 'Durant le délais de carence: Mal' + char(13) + char(10) + 'Après le délais de carence: AssNP'
	WHEN a.Régime = 'Assurance salaire' AND ca.Conséquence = 'Absence' AND cc.Condition IS NULL THEN 'Assal'
	WHEN a.Régime = 'Assurance salaire' AND ca.Conséquence = 'Assignation temporaire/travaux légers' AND cc.Condition IS NULL THEN 'Heures travaillées: Atass' + char(13) + char(10) + 'Heures non travaillées: Assal'
	WHEN a.Régime = 'Assurance salaire' AND ca.Conséquence = 'Rechute' AND cc.Condition IS NULL THEN 'Assal'
	WHEN a.Régime = 'Assurance salaire' AND ca.Conséquence = 'Retour progressif' AND cc.Condition IS NULL THEN 'Heures travaillées: RpAss' + char(13) + char(10) + 'Heures non travaillées: Assal'
	WHEN a.Régime = 'Assurance salaire 3e année et plus' AND ca.Conséquence = 'Absence' AND cc.Condition IS NULL THEN 'AM3an'
	WHEN a.Régime = 'Assurance salaire 3e année et plus' AND ca.Conséquence = 'Absence' AND cc.Condition = 'EmployéÉligible = non' THEN 'As3NA'
	WHEN a.Régime = 'Assurance salaire 3e année et plus' AND ca.Conséquence = 'Assignation temporaire/travaux légers' AND cc.Condition IS NULL THEN 'Heures travaillées: Atass' + char(13) + char(10) + 'Heures non travaillées: AM3an'
	WHEN a.Régime = 'Assurance salaire 3e année et plus' AND ca.Conséquence = 'Assignation temporaire/travaux légers' AND cc.Condition = 'EmployéÉligible = non' THEN 'Heures travaillées: Atass' + char(13) + char(10) + 'Heures non travaillées: AM3an'
	WHEN a.Régime = 'Assurance salaire 3e année et plus' AND ca.Conséquence = 'Rechute' AND cc.Condition IS NULL THEN 'AM3an'
	WHEN a.Régime = 'Assurance salaire 3e année et plus' AND ca.Conséquence = 'Rechute' AND cc.Condition = 'EmployéÉligible = non' THEN 'As3NA'
	WHEN a.Régime = 'Assurance salaire 3e année et plus' AND ca.Conséquence = 'Retour progressif' AND cc.Condition IS NULL THEN 'Heures travaillées: RpAss' + char(13) + char(10) + 'Heures non travaillées: AM3an'
	WHEN a.Régime = 'Assurance salaire 3e année et plus' AND ca.Conséquence = 'Retour progressif' AND cc.Condition = 'EmployéÉligible = non' THEN 'Heures travaillées: RpAss' + char(13) + char(10) + 'Heures non travaillées: As3NA'
	WHEN a.Régime = 'Assurance salaire grossesse' AND ca.Conséquence = 'Absence' AND cc.Condition = 'DateDeDébutPremièreConséquence = DateDébut' THEN 'Durant le délais de carence: Mal' + char(13) + char(10) + 'Après le délais de carence: AsGro'
	WHEN a.Régime = 'Assurance salaire grossesse' AND ca.Conséquence = 'Absence' AND cc.Condition IS NULL THEN 'AsGro'
	WHEN a.Régime = 'Assurance salaire grossesse' AND ca.Conséquence = 'Assignation temporaire/travaux légers' AND cc.Condition IS NULL THEN 'Heures travaillées: Atass' + char(13) + char(10) + 'Heures non travaillées: AsGro'
	WHEN a.Régime = 'Assurance salaire grossesse' AND ca.Conséquence = 'Rechute' AND cc.Condition IS NULL THEN 'AsGro'
	WHEN a.Régime = 'Assurance salaire grossesse' AND ca.Conséquence = 'Retour progressif' AND cc.Condition IS NULL THEN 'Heures travaillées: RpAss' + char(13) + char(10) + 'Heures non travaillées: AsGro'
	WHEN a.Régime = 'Assurance salaire non admissible' AND ca.Conséquence = 'Absence' AND cc.Condition IS NULL THEN 'AssNA'
	WHEN a.Régime = 'Assurance salaire non admissible' AND ca.Conséquence = 'Assignation temporaire/travaux légers' AND cc.Condition IS NULL THEN 'Heures travaillées: Atass' + char(13) + char(10) + 'Heures non travaillées: AssNA'
	WHEN a.Régime = 'Assurance salaire non admissible' AND ca.Conséquence = 'Rechute' AND cc.Condition IS NULL THEN 'AssNA'
	WHEN a.Régime = 'Assurance salaire non admissible' AND ca.Conséquence = 'Retour progressif' AND cc.Condition IS NULL THEN 'Heures travaillées: RpAss' + char(13) + char(10) + 'Heures non travaillées: AssNA'
	WHEN a.Régime = 'Assurance salaire non payée' AND ca.Conséquence = 'Absence' AND cc.Condition IS NULL THEN 'AssNP'
	WHEN a.Régime = 'Assurance salaire non payée' AND ca.Conséquence = 'Assignation temporaire/travaux légers' AND cc.Condition IS NULL THEN 'Heures travaillées: Atass' + char(13) + char(10) + 'Heures non travaillées: AssNP'
	WHEN a.Régime = 'Assurance salaire non payée' AND ca.Conséquence = 'Rechute' AND cc.Condition IS NULL THEN 'AssNP'
	WHEN a.Régime = 'Assurance salaire non payée' AND ca.Conséquence = 'Retour progressif' AND cc.Condition IS NULL THEN 'Heures travaillées: RpAss' + char(13) + char(10) + 'Heures non travaillées: AssNP'
	WHEN a.Régime = 'IVAC' THEN NULL
	WHEN a.Régime = 'IVAC 3e année et plus' THEN NULL
	WHEN a.Régime = 'RRQ' AND ca.Conséquence = 'Absence' AND cc.Condition IS NULL THEN 'Assal'
	WHEN a.Régime = 'SAAQ' AND ca.Conséquence = 'Absence' AND cc.Condition = 'DateDeDébutPremièreConséquence = DateDébut' THEN 'Durant le délais de carence: Mal' + char(13) + char(10) + 'Après le délais de carence: SAAQ'
	WHEN a.Régime = 'SAAQ' AND ca.Conséquence = 'Absence' AND cc.Condition IS NULL THEN 'SAAQ'
	WHEN a.Régime = 'SAAQ' AND ca.Conséquence = 'Rechute' AND cc.Condition IS NULL THEN 'SAAQ'
	WHEN a.Régime = 'SAAQ' AND ca.Conséquence = 'Stage SAAQ' AND cc.Condition IS NULL THEN 'Heures travaillées: SAAQT' + char(13) + char(10) + 'Heures non travaillées: SAAQ'
	WHEN a.Régime = 'SAAQ 3e année et plus' AND ca.Conséquence = 'Absence' AND cc.Condition IS NULL THEN 'SAAQ'
	WHEN a.Régime = 'SAAQ 3e année et plus' AND ca.Conséquence = 'Rechute' AND cc.Condition IS NULL THEN 'SAAQ'
	WHEN a.Régime = 'SAAQ 3e année et plus' AND ca.Conséquence = 'Stage SAAQ' AND cc.Condition IS NULL THEN 'Heures travaillées: SAAQT' + char(13) + char(10) + 'Heures non travaillées: SAAQ'
	WHEN ra.Régime = 'CNESST - Dossier Refusé' THEN NULL
	WHEN ra.Régime = 'CNESST - Autre employeur'	AND cra.Conséquence = 'Arrêt de travail' AND cc.Condition IS NULL THEN 'CSST'
	WHEN ra.Régime = 'CNESST - Non payé' THEN NULL
	WHEN ra.Régime = 'Rechute, récidive, aggravation CNESST' AND cra.Conséquence = 'Arrêt de travail' AND cc.Condition IS NULL THEN 'CSST'
	WHEN ra.Régime = 'Rechute, récidive, aggravation CNESST' AND cra.Conséquence = 'Assignation temporaire/travaux légers' AND cc.Condition IS NULL THEN 'Heures travaillées: ATsst' + char(13) + char(10) + 'Heures non travaillées: Assi'
	WHEN ra.Régime = 'Rechute, récidive, aggravation CNESST' AND cra.Conséquence = 'Rechute' AND cc.Condition IS NULL THEN 'CSST'
	WHEN ra.Régime = 'Rechute, récidive, aggravation CNESST' AND cra.Conséquence = 'Retour progressif' AND cc.Condition IS NULL THEN 'Heures travaillées: RpSST' + char(13) + char(10) + 'Heures non travaillées: Assi'
	WHEN ra.Régime = 'Rechute, récidive, aggravation CNESST' AND cra.Conséquence = 'Maladie intercurrente' AND cc.Condition IS NULL THEN 'CSST'
	WHEN ra.Régime = 'RRA en CNESST- Dossier refusé' THEN NULL
	WHEN ra.Régime = 'CNESST' AND cra.Conséquence = 'Arrêt de travail' AND cc.Condition = 'DateDébutPremièreAbsence = DateDébutCSQ' THEN 'SST1J et SST14, voir information inscrite dans la fiche d''absence du travailleur/euse' + char(13) + char(10) + 'À partir de la 15e journée: CSST'
	WHEN ra.Régime = 'CNESST' AND cra.Conséquence = 'Arrêt de travail' AND cc.Condition IS NULL THEN 'CSST'
	WHEN ra.Régime = 'CNESST' AND cra.Conséquence = 'Assignation temporaire/travaux légers' AND cc.Condition IS NULL THEN 'Heures travaillées: ATsst' + char(13) + char(10) + 'Heures non travaillées: Assi'
	WHEN ra.Régime = 'CNESST' AND cra.Conséquence = 'Rechute' AND cc.Condition IS NULL THEN 'CSST'
	WHEN ra.Régime = 'CNESST' AND cra.Conséquence = 'Retour progressif' AND cc.Condition IS NULL THEN 'Heures travaillées: RpSST' + char(13) + char(10) + 'Heures non travaillées: Assi'
	WHEN ra.Régime = 'CNESST' AND cra.Conséquence = 'Maladie intercurrente' AND cc.Condition IS NULL THEN 'CSST'
	WHEN ra.Régime = 'CNESST - 3e année' AND cra.Conséquence = 'Arrêt de travail' AND cc.Condition IS NULL THEN 'CSST3'
	WHEN ra.Régime = 'CNESST - 3e année' AND cra.Conséquence = 'Assignation temporaire/travaux légers' AND cc.Condition IS NULL THEN 'Heures travaillées: ATsst' + char(13) + char(10) + 'Heures non travaillées: CSST3'
	WHEN ra.Régime = 'CNESST - 3e année' AND cra.Conséquence = 'Rechute' AND cc.Condition IS NULL THEN 'CSST3'
	WHEN ra.Régime = 'CNESST - 3e année' AND cra.Conséquence = 'Retour progressif' AND cc.Condition IS NULL THEN 'Heures travaillées: RpSST' + char(13) + char(10) + 'Heures non travaillées: CSST3'
	WHEN ra.Régime = 'CNESST - 3e année' AND cra.Conséquence = 'Maladie intercurrente' AND cc.Condition IS NULL THEN 'CSST3'
	WHEN ra.Régime = 'CNESST - Sans perte de temps' THEN NULL
	WHEN p.Régime = 'Maternité sans danger' AND cra.Conséquence = 'PMSD - Réaffectation temporaire' AND cc.Condition IS NULL THEN 'Heures travaillées: ReaTE' + char(13) + char(10) + 'Heures non travaillées: RetPA'
	WHEN p.Régime = 'Maternité sans danger' AND cra.Conséquence = 'PMSD - Retrait préventif' AND cc.Condition IS NULL THEN '5 premiers jours selon l''horaire prévu: RP5jr' + char(13) + char(10) + '14 jours suivants: RP14j' + char(13) + char(10) + 'À partir de la 15e journée: Rprev'
END AS CodeDePaie
FROM BDIP_Absence a

LEFT JOIN BDIP_ConsequenceAbsence ca ON a.NuméroÉvénement = ca.NuméroÉvénementParent
LEFT JOIN BDIP_RapportAccident ra ON a.Matricule = ra.Matricule
LEFT JOIN BDIP_ConsequenceRapportAccident cra ON ra.NuméroÉvénement = cra.NuméroÉvénementParent
LEFT JOIN InfocentreNormalisation.RH.Empl_Inter ei ON a.Matricule = ei.Matri
LEFT JOIN InfocentreNormalisation.RH.FactEmplConge fec ON a.Matricule = fec.Matricule
LEFT JOIN CalculCTE cc ON a.NuméroÉvénement = cc.NuméroÉvénement
LEFT JOIN BDIP_PMSD p ON a.Matricule = p.Matricule