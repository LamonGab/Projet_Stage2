CREATE VIEW CodeDePaieInvalidite AS
WITH CalculCTE AS (
	SELECT
		a.NuméroÉvénement,
		CASE
			WHEN a.Régime = 'Assurance salaire' AND ca.Conséquence = 'Absence' AND a.DateDébutPremièreConséquence = ca.DateDébut AND a.EmployéÉligible = 'non' THEN 'DateDeDébutPremièreConséquence = DateDébut AND EmployéÉligible = non'
			WHEN a.Régime = 'Assurance salaire' AND ca.Conséquence = 'Absence' AND a.DateDébutPremièreConséquence = ca.DateDébut THEN 'DateDeDébutPremièreConséquence = DateDébut'
			WHEN a.Régime = 'Assurance salaire grossesse' AND ca.Conséquence = 'Absence' AND a.DateDébutPremièreConséquence = ca.DateDébut THEN 'DateDeDébutPremièreConséquence = DateDébut'
			WHEN a.Régime = 'SAAQ' AND ca.Conséquence = 'Absence' AND a.DateDébutPremièreConséquence = ca.DateDébut THEN 'DateDeDébutPremièreConséquence = DateDébut'
			WHEN a.Régime = 'Assurance salaire 3e année et plus' AND (ca.Conséquence = 'Absence' OR ca.Conséquence = 'Assignation temporaire/travaux légers' OR ca.Conséquence = 'Rechute' OR ca.Conséquence = 'Retour progressif') AND a.EmployéÉligible = 'non' THEN 'EmployéÉligible = non'
			ELSE NULL
		END AS Condition
	FROM BDIP_Absence a

	LEFT JOIN BDIP_ConsequenceAbsence ca ON a.NuméroÉvénement = ca.NuméroÉvénementParent
)
SELECT a.Régime, ca.Conséquence, cc.Condition,
CASE
	WHEN a.Régime = 'Absence courte durée' AND ca.Conséquence = 'Absence' THEN 'Mal'
	WHEN a.Régime = 'Assurance salaire' AND ca.Conséquence = 'Absence' AND cc.Condition = 'DateDeDébutPremièreConséquence = DateDébut' THEN 'Durant le délais de carence: Mal' + char(13) + char(10) + 'Après le délais de carence: Assal'
	WHEN a.Régime = 'Assurance salaire' AND ca.Conséquence = 'Absence' AND cc.Condition = 'DateDeDébutPremièreConséquence = DateDébut AND EmployéÉligible = non' THEN 'Durant le délais de carence: Mal' + char(13) + char(10) + 'Après le délais de carence: AssNP'
	WHEN a.Régime = 'Assurance salaire' AND ca.Conséquence = 'Absence' AND cc.Condition IS NULL THEN 'Assal'
	WHEN a.Régime = 'Assurance salaire' AND ca.Conséquence = 'Assignation temporaire/travaux légers' THEN 'Heures travaillées: Atass' + char(13) + char(10) + 'Heures non travaillées: Assal'
	WHEN a.Régime = 'Assurance salaire' AND ca.Conséquence = 'Rechute' THEN 'Assal'
	WHEN a.Régime = 'Assurance salaire' AND ca.Conséquence = 'Retour progressif' THEN 'Heures travaillées: RpAss' + char(13) + char(10) + 'Heures non travaillées: Assal'
	WHEN a.Régime = 'Assurance salaire 3e année et plus' AND ca.Conséquence = 'Absence' AND cc.Condition IS NULL THEN 'AM3an'
	WHEN a.Régime = 'Assurance salaire 3e année et plus' AND ca.Conséquence = 'Absence' AND cc.Condition = 'EmployéÉligible = non' THEN 'As3NA'
	WHEN a.Régime = 'Assurance salaire 3e année et plus' AND ca.Conséquence = 'Assignation temporaire/travaux légers' THEN 'Heures travaillées: Atass' + char(13) + char(10) + 'Heures non travaillées: AM3an'
	WHEN a.Régime = 'Assurance salaire 3e année et plus' AND ca.Conséquence = 'Assignation temporaire/travaux légers' AND cc.Condition = 'EmployéÉligible = non' THEN 'Heures travaillées: Atass' + char(13) + char(10) + 'Heures non travaillées: AM3an'
	WHEN a.Régime = 'Assurance salaire 3e année et plus' AND ca.Conséquence = 'Rechute' AND cc.Condition IS NULL THEN 'AM3an'
	WHEN a.Régime = 'Assurance salaire 3e année et plus' AND ca.Conséquence = 'Rechute' AND cc.Condition = 'EmployéÉligible = non' THEN 'As3NA'
	WHEN a.Régime = 'Assurance salaire 3e année et plus' AND ca.Conséquence = 'Retour progressif' AND cc.Condition IS NULL THEN 'Heures travaillées: RpAss' + char(13) + char(10) + 'Heures non travaillées: AM3an'
	WHEN a.Régime = 'Assurance salaire 3e année et plus' AND ca.Conséquence = 'Retour progressif' AND cc.Condition = 'EmployéÉligible = non' THEN 'Heures travaillées: RpAss' + char(13) + char(10) + 'Heures non travaillées: As3NA'
	WHEN a.Régime = 'Assurance salaire grossesse' AND ca.Conséquence = 'Absence' AND cc.Condition = 'DateDeDébutPremièreConséquence = DateDébut' THEN 'Durant le délais de carence: Mal' + char(13) + char(10) + 'Après le délais de carence: AsGro'
	WHEN a.Régime = 'Assurance salaire grossesse' AND ca.Conséquence = 'Absence' AND cc.Condition IS NULL THEN 'AsGro'
	WHEN a.Régime = 'Assurance salaire grossesse' AND ca.Conséquence = 'Assignation temporaire/travaux légers' THEN 'Heures travaillées: Atass' + char(13) + char(10) + 'Heures non travaillées: AsGro'
	WHEN a.Régime = 'Assurance salaire grossesse' AND ca.Conséquence = 'Rechute' THEN 'AsGro'
	WHEN a.Régime = 'Assurance salaire grossesse' AND ca.Conséquence = 'Retour progressif' THEN 'Heures travaillées: RpAss' + char(13) + char(10) + 'Heures non travaillées: AsGro'
	WHEN a.Régime = 'Assurance salaire non admissible' AND ca.Conséquence = 'Absence' THEN 'AssNA'
	WHEN a.Régime = 'Assurance salaire non admissible' AND ca.Conséquence = 'Assignation temporaire/travaux légers' THEN 'Heures travaillées: Atass' + char(13) + char(10) + 'Heures non travaillées: AssNA'
	WHEN a.Régime = 'Assurance salaire non admissible' AND ca.Conséquence = 'Rechute' THEN 'AssNA'
	WHEN a.Régime = 'Assurance salaire non admissible' AND ca.Conséquence = 'Retour progressif' THEN 'Heures travaillées: RpAss' + char(13) + char(10) + 'Heures non travaillées: AssNA'
	WHEN a.Régime = 'Assurance salaire non payée' AND ca.Conséquence = 'Absence' THEN 'AssNP'
	WHEN a.Régime = 'Assurance salaire non payée' AND ca.Conséquence = 'Assignation temporaire/travaux légers' THEN 'Heures travaillées: Atass' + char(13) + char(10) + 'Heures non travaillées: AssNP'
	WHEN a.Régime = 'Assurance salaire non payée' AND ca.Conséquence = 'Rechute' THEN 'AssNP'
	WHEN a.Régime = 'Assurance salaire non payée' AND ca.Conséquence = 'Retour progressif' THEN 'Heures travaillées: RpAss' + char(13) + char(10) + 'Heures non travaillées: AssNP'
	WHEN a.Régime = 'IVAC' THEN NULL
	WHEN a.Régime = 'IVAC 3e année et plus' THEN NULL
	WHEN a.Régime = 'RRQ' AND ca.Conséquence = 'Absence' THEN 'Assal'
	WHEN a.Régime = 'SAAQ' AND ca.Conséquence = 'Absence' AND cc.Condition = 'DateDeDébutPremièreConséquence = DateDébut' THEN 'Durant le délais de carence: Mal' + char(13) + char(10) + 'Après le délais de carence: SAAQ'
	WHEN a.Régime = 'SAAQ' AND ca.Conséquence = 'Absence' AND cc.Condition IS NULL THEN 'SAAQ'
	WHEN a.Régime = 'SAAQ' AND ca.Conséquence = 'Rechute' THEN 'SAAQ'
	WHEN a.Régime = 'SAAQ' AND ca.Conséquence = 'Stage SAAQ' THEN 'Heures travaillées: SAAQT' + char(13) + char(10) + 'Heures non travaillées: SAAQ'
	WHEN a.Régime = 'SAAQ 3e année et plus' AND ca.Conséquence = 'Absence' THEN 'SAAQ'
	WHEN a.Régime = 'SAAQ 3e année et plus' AND ca.Conséquence = 'Rechute' THEN 'SAAQ'
	WHEN a.Régime = 'SAAQ 3e année et plus' AND ca.Conséquence = 'Stage SAAQ' THEN 'Heures travaillées: SAAQT' + char(13) + char(10) + 'Heures non travaillées: SAAQ'
	ELSE NULL
END AS CodeDePaie
FROM BDIP_Absence a

LEFT JOIN BDIP_ConsequenceAbsence ca ON a.NuméroÉvénement = ca.NuméroÉvénementParent
LEFT JOIN CalculCTE cc ON a.NuméroÉvénement = cc.NuméroÉvénement