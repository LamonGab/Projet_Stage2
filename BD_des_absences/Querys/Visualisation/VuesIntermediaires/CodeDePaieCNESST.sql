CREATE VIEW CodeDePaieCNESST AS
WITH CalculCTE AS (
	SELECT
		ra.NuméroÉvénement,
		CASE
			WHEN ra.Régime = 'CNESST' AND cra.Conséquence = 'Arrêt de travail' AND ra.DateDébutPremièreAbsence = cra.DateDébutCSQ THEN 'DateDébutPremièreAbsence = DateDébutCSQ'
			ELSE NULL
		END AS Condition
	FROM BDIP_RapportAccident ra

	LEFT JOIN BDIP_ConsequenceRapportAccident cra ON ra.NuméroÉvénement = cra.NuméroÉvénementParent
)
SELECT ra.Régime, cra.Conséquence, cc.Condition,
CASE
	WHEN ra.Régime = 'CNESST - Dossier Refusé' THEN NULL
	WHEN ra.Régime = 'CNESST - Autre employeur'	AND cra.Conséquence = 'Arrêt de travail' THEN 'CSST'
	WHEN ra.Régime = 'CNESST - Non payé' THEN NULL
	WHEN ra.Régime = 'Rechute, récidive, aggravation CNESST' AND cra.Conséquence = 'Arrêt de travail' THEN 'CSST'
	WHEN ra.Régime = 'Rechute, récidive, aggravation CNESST' AND cra.Conséquence = 'Assignation temporaire/travaux légers' THEN 'Heures travaillées: ATsst' + char(13) + char(10) + 'Heures non travaillées: Assi'
	WHEN ra.Régime = 'Rechute, récidive, aggravation CNESST' AND cra.Conséquence = 'Rechute' THEN 'CSST'
	WHEN ra.Régime = 'Rechute, récidive, aggravation CNESST' AND cra.Conséquence = 'Retour progressif'  THEN 'Heures travaillées: RpSST' + char(13) + char(10) + 'Heures non travaillées: Assi'
	WHEN ra.Régime = 'Rechute, récidive, aggravation CNESST' AND cra.Conséquence = 'Maladie intercurrente' THEN 'CSST'
	WHEN ra.Régime = 'RRA en CNESST- Dossier refusé' THEN NULL
	WHEN ra.Régime = 'CNESST' AND cra.Conséquence = 'Arrêt de travail' AND cc.Condition = 'DateDébutPremièreAbsence = DateDébutCSQ' THEN 'SST1J et SST14, voir information inscrite dans la fiche d''absence du travailleur/euse' + char(13) + char(10) + 'À partir de la 15e journée: CSST'
	WHEN ra.Régime = 'CNESST' AND cra.Conséquence = 'Arrêt de travail' AND cc.Condition IS NULL THEN 'CSST'
	WHEN ra.Régime = 'CNESST' AND cra.Conséquence = 'Assignation temporaire/travaux légers' THEN 'Heures travaillées: ATsst' + char(13) + char(10) + 'Heures non travaillées: Assi'
	WHEN ra.Régime = 'CNESST' AND cra.Conséquence = 'Rechute' THEN 'CSST'
	WHEN ra.Régime = 'CNESST' AND cra.Conséquence = 'Retour progressif' THEN 'Heures travaillées: RpSST' + char(13) + char(10) + 'Heures non travaillées: Assi'
	WHEN ra.Régime = 'CNESST' AND cra.Conséquence = 'Maladie intercurrente' THEN 'CSST'
	WHEN ra.Régime = 'CNESST - 3e année' AND cra.Conséquence = 'Arrêt de travail' THEN 'CSST3'
	WHEN ra.Régime = 'CNESST - 3e année' AND cra.Conséquence = 'Assignation temporaire/travaux légers' THEN 'Heures travaillées: ATsst' + char(13) + char(10) + 'Heures non travaillées: CSST3'
	WHEN ra.Régime = 'CNESST - 3e année' AND cra.Conséquence = 'Rechute' THEN 'CSST3'
	WHEN ra.Régime = 'CNESST - 3e année' AND cra.Conséquence = 'Retour progressif' THEN 'Heures travaillées: RpSST' + char(13) + char(10) + 'Heures non travaillées: CSST3'
	WHEN ra.Régime = 'CNESST - 3e année' AND cra.Conséquence = 'Maladie intercurrente' THEN 'CSST3'
	WHEN ra.Régime = 'CNESST - Sans perte de temps' THEN NULL
	ELSE NULL
END AS CodeDePaie
FROM BDIP_RapportAccident ra

LEFT JOIN BDIP_ConsequenceRapportAccident cra ON ra.NuméroÉvénement = cra.NuméroÉvénementParent
LEFT JOIN CalculCTE cc ON ra.NuméroÉvénement = cc.NuméroÉvénement