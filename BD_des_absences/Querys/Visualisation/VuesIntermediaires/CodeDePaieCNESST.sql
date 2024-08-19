CREATE VIEW CodeDePaieCNESST AS
WITH CalculCTE AS (
	SELECT
		ra.Num�ro�v�nement,
		CASE
			WHEN ra.R�gime = 'CNESST' AND cra.Cons�quence = 'Arr�t de travail' AND ra.DateD�butPremi�reAbsence = cra.DateD�butCSQ THEN 'DateD�butPremi�reAbsence = DateD�butCSQ'
			ELSE NULL
		END AS Condition
	FROM BDIP_RapportAccident ra

	LEFT JOIN BDIP_ConsequenceRapportAccident cra ON ra.Num�ro�v�nement = cra.Num�ro�v�nementParent
)
SELECT ra.R�gime, cra.Cons�quence, cc.Condition,
CASE
	WHEN ra.R�gime = 'CNESST - Dossier Refus�' THEN NULL
	WHEN ra.R�gime = 'CNESST - Autre employeur'	AND cra.Cons�quence = 'Arr�t de travail' THEN 'CSST'
	WHEN ra.R�gime = 'CNESST - Non pay�' THEN NULL
	WHEN ra.R�gime = 'Rechute, r�cidive, aggravation CNESST' AND cra.Cons�quence = 'Arr�t de travail' THEN 'CSST'
	WHEN ra.R�gime = 'Rechute, r�cidive, aggravation CNESST' AND cra.Cons�quence = 'Assignation temporaire/travaux l�gers' THEN 'Heures travaill�es: ATsst' + char(13) + char(10) + 'Heures non travaill�es: Assi'
	WHEN ra.R�gime = 'Rechute, r�cidive, aggravation CNESST' AND cra.Cons�quence = 'Rechute' THEN 'CSST'
	WHEN ra.R�gime = 'Rechute, r�cidive, aggravation CNESST' AND cra.Cons�quence = 'Retour progressif'  THEN 'Heures travaill�es: RpSST' + char(13) + char(10) + 'Heures non travaill�es: Assi'
	WHEN ra.R�gime = 'Rechute, r�cidive, aggravation CNESST' AND cra.Cons�quence = 'Maladie intercurrente' THEN 'CSST'
	WHEN ra.R�gime = 'RRA en CNESST- Dossier refus�' THEN NULL
	WHEN ra.R�gime = 'CNESST' AND cra.Cons�quence = 'Arr�t de travail' AND cc.Condition = 'DateD�butPremi�reAbsence = DateD�butCSQ' THEN 'SST1J et SST14, voir information inscrite dans la fiche d''absence du travailleur/euse' + char(13) + char(10) + '� partir de la 15e journ�e: CSST'
	WHEN ra.R�gime = 'CNESST' AND cra.Cons�quence = 'Arr�t de travail' AND cc.Condition IS NULL THEN 'CSST'
	WHEN ra.R�gime = 'CNESST' AND cra.Cons�quence = 'Assignation temporaire/travaux l�gers' THEN 'Heures travaill�es: ATsst' + char(13) + char(10) + 'Heures non travaill�es: Assi'
	WHEN ra.R�gime = 'CNESST' AND cra.Cons�quence = 'Rechute' THEN 'CSST'
	WHEN ra.R�gime = 'CNESST' AND cra.Cons�quence = 'Retour progressif' THEN 'Heures travaill�es: RpSST' + char(13) + char(10) + 'Heures non travaill�es: Assi'
	WHEN ra.R�gime = 'CNESST' AND cra.Cons�quence = 'Maladie intercurrente' THEN 'CSST'
	WHEN ra.R�gime = 'CNESST - 3e ann�e' AND cra.Cons�quence = 'Arr�t de travail' THEN 'CSST3'
	WHEN ra.R�gime = 'CNESST - 3e ann�e' AND cra.Cons�quence = 'Assignation temporaire/travaux l�gers' THEN 'Heures travaill�es: ATsst' + char(13) + char(10) + 'Heures non travaill�es: CSST3'
	WHEN ra.R�gime = 'CNESST - 3e ann�e' AND cra.Cons�quence = 'Rechute' THEN 'CSST3'
	WHEN ra.R�gime = 'CNESST - 3e ann�e' AND cra.Cons�quence = 'Retour progressif' THEN 'Heures travaill�es: RpSST' + char(13) + char(10) + 'Heures non travaill�es: CSST3'
	WHEN ra.R�gime = 'CNESST - 3e ann�e' AND cra.Cons�quence = 'Maladie intercurrente' THEN 'CSST3'
	WHEN ra.R�gime = 'CNESST - Sans perte de temps' THEN NULL
	ELSE NULL
END AS CodeDePaie
FROM BDIP_RapportAccident ra

LEFT JOIN BDIP_ConsequenceRapportAccident cra ON ra.Num�ro�v�nement = cra.Num�ro�v�nementParent
LEFT JOIN CalculCTE cc ON ra.Num�ro�v�nement = cc.Num�ro�v�nement