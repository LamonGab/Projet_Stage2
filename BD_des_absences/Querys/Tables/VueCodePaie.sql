DROP VIEW IF EXISTS CodeDePaieCalcule

CREATE VIEW CodeDePaieCalcule AS
WITH CalculCTE AS (
	SELECT
		a.Num�ro�v�nement,
		CASE
			WHEN a.R�gime = 'Assurance salaire' AND ca.Cons�quence = 'Absence' AND a.DateD�butPremi�reCons�quence = ca.DateD�but AND a.Employ��ligible = 'non' THEN 'DateDeD�butPremi�reCons�quence = DateD�but AND Employ��ligible = non'
			WHEN (a.R�gime = 'Assurance salaire' AND ca.Cons�quence = 'Absence' OR a.R�gime = 'Assurance salaire grossesse' AND ca.Cons�quence = 'Absence' OR a.R�gime = 'SAAQ' AND ca.Cons�quence = 'Absence') AND a.DateD�butPremi�reCons�quence = ca.DateD�but THEN 'DateDeD�butPremi�reCons�quence = DateD�but'
			WHEN a.R�gime = 'Assurance salaire 3e ann�e et plus' AND (ca.Cons�quence = 'Absence' OR ca.Cons�quence = 'Assignation temporaire/travaux l�gers' OR ca.Cons�quence = 'Rechute' OR ca.Cons�quence = 'Retour progressif') AND a.Employ��ligible = 'non' THEN 'Employ��ligible = non'
			WHEN ra.R�gime = 'CNESST' AND cra.Cons�quence = 'Arr�t de travail' AND ra.DateD�butPremi�reAbsence = cra.DateD�butCSQ THEN 'DateD�butPremi�reAbsence = DateD�butCSQ'
			ELSE NULL
		END AS Condition
	FROM BDIP_Absence a

	LEFT JOIN BDIP_ConsequenceAbsence ca ON a.Num�ro�v�nement = ca.Num�ro�v�nementParent
	LEFT JOIN BDIP_RapportAccident ra ON a.Matricule = ra.Matricule
	LEFT JOIN BDIP_ConsequenceRapportAccident cra ON ra.Num�ro�v�nement = cra.Num�ro�v�nementParent
)
SELECT a.R�gime AS R�gimeAbsence, ca.Cons�quence AS Cons�quenceAbsence, cc.Condition, ra.R�gime AS R�gimeRapportAccident, cra.Cons�quence AS Cons�quenceRapportAccident,
p.R�gime AS R�gimePMSD,
CASE
	WHEN a.R�gime = 'Absence courte dur�e' AND ca.Cons�quence = 'Absence' AND cc.Condition IS NULL THEN 'Mal'
	WHEN a.R�gime = 'Assurance salaire' AND ca.Cons�quence = 'Absence' AND cc.Condition = 'DateDeD�butPremi�reCons�quence = DateD�but' THEN 'Durant le d�lais de carence: Mal' + char(13) + char(10) + 'Apr�s le d�lais de carence: Assal'
	WHEN a.R�gime = 'Assurance salaire' AND ca.Cons�quence = 'Absence' AND cc.Condition = 'DateDeD�butPremi�reCons�quence = DateD�but AND Employ��ligible = non' THEN 'Durant le d�lais de carence: Mal' + char(13) + char(10) + 'Apr�s le d�lais de carence: AssNP'
	WHEN a.R�gime = 'Assurance salaire' AND ca.Cons�quence = 'Absence' AND cc.Condition IS NULL THEN 'Assal'
	WHEN a.R�gime = 'Assurance salaire' AND ca.Cons�quence = 'Assignation temporaire/travaux l�gers' AND cc.Condition IS NULL THEN 'Heures travaill�es: Atass' + char(13) + char(10) + 'Heures non travaill�es: Assal'
	WHEN a.R�gime = 'Assurance salaire' AND ca.Cons�quence = 'Rechute' AND cc.Condition IS NULL THEN 'Assal'
	WHEN a.R�gime = 'Assurance salaire' AND ca.Cons�quence = 'Retour progressif' AND cc.Condition IS NULL THEN 'Heures travaill�es: RpAss' + char(13) + char(10) + 'Heures non travaill�es: Assal'
	WHEN a.R�gime = 'Assurance salaire 3e ann�e et plus' AND ca.Cons�quence = 'Absence' AND cc.Condition IS NULL THEN 'AM3an'
	WHEN a.R�gime = 'Assurance salaire 3e ann�e et plus' AND ca.Cons�quence = 'Absence' AND cc.Condition = 'Employ��ligible = non' THEN 'As3NA'
	WHEN a.R�gime = 'Assurance salaire 3e ann�e et plus' AND ca.Cons�quence = 'Assignation temporaire/travaux l�gers' AND cc.Condition IS NULL THEN 'Heures travaill�es: Atass' + char(13) + char(10) + 'Heures non travaill�es: AM3an'
	WHEN a.R�gime = 'Assurance salaire 3e ann�e et plus' AND ca.Cons�quence = 'Assignation temporaire/travaux l�gers' AND cc.Condition = 'Employ��ligible = non' THEN 'Heures travaill�es: Atass' + char(13) + char(10) + 'Heures non travaill�es: AM3an'
	WHEN a.R�gime = 'Assurance salaire 3e ann�e et plus' AND ca.Cons�quence = 'Rechute' AND cc.Condition IS NULL THEN 'AM3an'
	WHEN a.R�gime = 'Assurance salaire 3e ann�e et plus' AND ca.Cons�quence = 'Rechute' AND cc.Condition = 'Employ��ligible = non' THEN 'As3NA'
	WHEN a.R�gime = 'Assurance salaire 3e ann�e et plus' AND ca.Cons�quence = 'Retour progressif' AND cc.Condition IS NULL THEN 'Heures travaill�es: RpAss' + char(13) + char(10) + 'Heures non travaill�es: AM3an'
	WHEN a.R�gime = 'Assurance salaire 3e ann�e et plus' AND ca.Cons�quence = 'Retour progressif' AND cc.Condition = 'Employ��ligible = non' THEN 'Heures travaill�es: RpAss' + char(13) + char(10) + 'Heures non travaill�es: As3NA'
	WHEN a.R�gime = 'Assurance salaire grossesse' AND ca.Cons�quence = 'Absence' AND cc.Condition = 'DateDeD�butPremi�reCons�quence = DateD�but' THEN 'Durant le d�lais de carence: Mal' + char(13) + char(10) + 'Apr�s le d�lais de carence: AsGro'
	WHEN a.R�gime = 'Assurance salaire grossesse' AND ca.Cons�quence = 'Absence' AND cc.Condition IS NULL THEN 'AsGro'
	WHEN a.R�gime = 'Assurance salaire grossesse' AND ca.Cons�quence = 'Assignation temporaire/travaux l�gers' AND cc.Condition IS NULL THEN 'Heures travaill�es: Atass' + char(13) + char(10) + 'Heures non travaill�es: AsGro'
	WHEN a.R�gime = 'Assurance salaire grossesse' AND ca.Cons�quence = 'Rechute' AND cc.Condition IS NULL THEN 'AsGro'
	WHEN a.R�gime = 'Assurance salaire grossesse' AND ca.Cons�quence = 'Retour progressif' AND cc.Condition IS NULL THEN 'Heures travaill�es: RpAss' + char(13) + char(10) + 'Heures non travaill�es: AsGro'
	WHEN a.R�gime = 'Assurance salaire non admissible' AND ca.Cons�quence = 'Absence' AND cc.Condition IS NULL THEN 'AssNA'
	WHEN a.R�gime = 'Assurance salaire non admissible' AND ca.Cons�quence = 'Assignation temporaire/travaux l�gers' AND cc.Condition IS NULL THEN 'Heures travaill�es: Atass' + char(13) + char(10) + 'Heures non travaill�es: AssNA'
	WHEN a.R�gime = 'Assurance salaire non admissible' AND ca.Cons�quence = 'Rechute' AND cc.Condition IS NULL THEN 'AssNA'
	WHEN a.R�gime = 'Assurance salaire non admissible' AND ca.Cons�quence = 'Retour progressif' AND cc.Condition IS NULL THEN 'Heures travaill�es: RpAss' + char(13) + char(10) + 'Heures non travaill�es: AssNA'
	WHEN a.R�gime = 'Assurance salaire non pay�e' AND ca.Cons�quence = 'Absence' AND cc.Condition IS NULL THEN 'AssNP'
	WHEN a.R�gime = 'Assurance salaire non pay�e' AND ca.Cons�quence = 'Assignation temporaire/travaux l�gers' AND cc.Condition IS NULL THEN 'Heures travaill�es: Atass' + char(13) + char(10) + 'Heures non travaill�es: AssNP'
	WHEN a.R�gime = 'Assurance salaire non pay�e' AND ca.Cons�quence = 'Rechute' AND cc.Condition IS NULL THEN 'AssNP'
	WHEN a.R�gime = 'Assurance salaire non pay�e' AND ca.Cons�quence = 'Retour progressif' AND cc.Condition IS NULL THEN 'Heures travaill�es: RpAss' + char(13) + char(10) + 'Heures non travaill�es: AssNP'
	WHEN a.R�gime = 'IVAC' THEN NULL
	WHEN a.R�gime = 'IVAC 3e ann�e et plus' THEN NULL
	WHEN a.R�gime = 'RRQ' AND ca.Cons�quence = 'Absence' AND cc.Condition IS NULL THEN 'Assal'
	WHEN a.R�gime = 'SAAQ' AND ca.Cons�quence = 'Absence' AND cc.Condition = 'DateDeD�butPremi�reCons�quence = DateD�but' THEN 'Durant le d�lais de carence: Mal' + char(13) + char(10) + 'Apr�s le d�lais de carence: SAAQ'
	WHEN a.R�gime = 'SAAQ' AND ca.Cons�quence = 'Absence' AND cc.Condition IS NULL THEN 'SAAQ'
	WHEN a.R�gime = 'SAAQ' AND ca.Cons�quence = 'Rechute' AND cc.Condition IS NULL THEN 'SAAQ'
	WHEN a.R�gime = 'SAAQ' AND ca.Cons�quence = 'Stage SAAQ' AND cc.Condition IS NULL THEN 'Heures travaill�es: SAAQT' + char(13) + char(10) + 'Heures non travaill�es: SAAQ'
	WHEN a.R�gime = 'SAAQ 3e ann�e et plus' AND ca.Cons�quence = 'Absence' AND cc.Condition IS NULL THEN 'SAAQ'
	WHEN a.R�gime = 'SAAQ 3e ann�e et plus' AND ca.Cons�quence = 'Rechute' AND cc.Condition IS NULL THEN 'SAAQ'
	WHEN a.R�gime = 'SAAQ 3e ann�e et plus' AND ca.Cons�quence = 'Stage SAAQ' AND cc.Condition IS NULL THEN 'Heures travaill�es: SAAQT' + char(13) + char(10) + 'Heures non travaill�es: SAAQ'
	WHEN ra.R�gime = 'CNESST - Dossier Refus�' THEN NULL
	WHEN ra.R�gime = 'CNESST - Autre employeur'	AND cra.Cons�quence = 'Arr�t de travail' AND cc.Condition IS NULL THEN 'CSST'
	WHEN ra.R�gime = 'CNESST - Non pay�' THEN NULL
	WHEN ra.R�gime = 'Rechute, r�cidive, aggravation CNESST' AND cra.Cons�quence = 'Arr�t de travail' AND cc.Condition IS NULL THEN 'CSST'
	WHEN ra.R�gime = 'Rechute, r�cidive, aggravation CNESST' AND cra.Cons�quence = 'Assignation temporaire/travaux l�gers' AND cc.Condition IS NULL THEN 'Heures travaill�es: ATsst' + char(13) + char(10) + 'Heures non travaill�es: Assi'
	WHEN ra.R�gime = 'Rechute, r�cidive, aggravation CNESST' AND cra.Cons�quence = 'Rechute' AND cc.Condition IS NULL THEN 'CSST'
	WHEN ra.R�gime = 'Rechute, r�cidive, aggravation CNESST' AND cra.Cons�quence = 'Retour progressif' AND cc.Condition IS NULL THEN 'Heures travaill�es: RpSST' + char(13) + char(10) + 'Heures non travaill�es: Assi'
	WHEN ra.R�gime = 'Rechute, r�cidive, aggravation CNESST' AND cra.Cons�quence = 'Maladie intercurrente' AND cc.Condition IS NULL THEN 'CSST'
	WHEN ra.R�gime = 'RRA en CNESST- Dossier refus�' THEN NULL
	WHEN ra.R�gime = 'CNESST' AND cra.Cons�quence = 'Arr�t de travail' AND cc.Condition = 'DateD�butPremi�reAbsence = DateD�butCSQ' THEN 'SST1J et SST14, voir information inscrite dans la fiche d''absence du travailleur/euse' + char(13) + char(10) + '� partir de la 15e journ�e: CSST'
	WHEN ra.R�gime = 'CNESST' AND cra.Cons�quence = 'Arr�t de travail' AND cc.Condition IS NULL THEN 'CSST'
	WHEN ra.R�gime = 'CNESST' AND cra.Cons�quence = 'Assignation temporaire/travaux l�gers' AND cc.Condition IS NULL THEN 'Heures travaill�es: ATsst' + char(13) + char(10) + 'Heures non travaill�es: Assi'
	WHEN ra.R�gime = 'CNESST' AND cra.Cons�quence = 'Rechute' AND cc.Condition IS NULL THEN 'CSST'
	WHEN ra.R�gime = 'CNESST' AND cra.Cons�quence = 'Retour progressif' AND cc.Condition IS NULL THEN 'Heures travaill�es: RpSST' + char(13) + char(10) + 'Heures non travaill�es: Assi'
	WHEN ra.R�gime = 'CNESST' AND cra.Cons�quence = 'Maladie intercurrente' AND cc.Condition IS NULL THEN 'CSST'
	WHEN ra.R�gime = 'CNESST - 3e ann�e' AND cra.Cons�quence = 'Arr�t de travail' AND cc.Condition IS NULL THEN 'CSST3'
	WHEN ra.R�gime = 'CNESST - 3e ann�e' AND cra.Cons�quence = 'Assignation temporaire/travaux l�gers' AND cc.Condition IS NULL THEN 'Heures travaill�es: ATsst' + char(13) + char(10) + 'Heures non travaill�es: CSST3'
	WHEN ra.R�gime = 'CNESST - 3e ann�e' AND cra.Cons�quence = 'Rechute' AND cc.Condition IS NULL THEN 'CSST3'
	WHEN ra.R�gime = 'CNESST - 3e ann�e' AND cra.Cons�quence = 'Retour progressif' AND cc.Condition IS NULL THEN 'Heures travaill�es: RpSST' + char(13) + char(10) + 'Heures non travaill�es: CSST3'
	WHEN ra.R�gime = 'CNESST - 3e ann�e' AND cra.Cons�quence = 'Maladie intercurrente' AND cc.Condition IS NULL THEN 'CSST3'
	WHEN ra.R�gime = 'CNESST - Sans perte de temps' THEN NULL
	WHEN p.R�gime = 'Maternit� sans danger' AND cra.Cons�quence = 'PMSD - R�affectation temporaire' AND cc.Condition IS NULL THEN 'Heures travaill�es: ReaTE' + char(13) + char(10) + 'Heures non travaill�es: RetPA'
	WHEN p.R�gime = 'Maternit� sans danger' AND cra.Cons�quence = 'PMSD - Retrait pr�ventif' AND cc.Condition IS NULL THEN '5 premiers jours selon l''horaire pr�vu: RP5jr' + char(13) + char(10) + '14 jours suivants: RP14j' + char(13) + char(10) + '� partir de la 15e journ�e: Rprev'
END AS CodeDePaie
FROM BDIP_Absence a

LEFT JOIN BDIP_ConsequenceAbsence ca ON a.Num�ro�v�nement = ca.Num�ro�v�nementParent
LEFT JOIN BDIP_RapportAccident ra ON a.Matricule = ra.Matricule
LEFT JOIN BDIP_ConsequenceRapportAccident cra ON ra.Num�ro�v�nement = cra.Num�ro�v�nementParent
LEFT JOIN InfocentreNormalisation.RH.Empl_Inter ei ON a.Matricule = ei.Matri
LEFT JOIN InfocentreNormalisation.RH.FactEmplConge fec ON a.Matricule = fec.Matricule
LEFT JOIN CalculCTE cc ON a.Num�ro�v�nement = cc.Num�ro�v�nement
LEFT JOIN BDIP_PMSD p ON a.Matricule = p.Matricule