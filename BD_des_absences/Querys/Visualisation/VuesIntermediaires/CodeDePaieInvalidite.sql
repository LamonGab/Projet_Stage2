CREATE VIEW CodeDePaieInvalidite AS
WITH CalculCTE AS (
	SELECT
		a.Num�ro�v�nement,
		CASE
			WHEN a.R�gime = 'Assurance salaire' AND ca.Cons�quence = 'Absence' AND a.DateD�butPremi�reCons�quence = ca.DateD�but AND a.Employ��ligible = 'non' THEN 'DateDeD�butPremi�reCons�quence = DateD�but AND Employ��ligible = non'
			WHEN a.R�gime = 'Assurance salaire' AND ca.Cons�quence = 'Absence' AND a.DateD�butPremi�reCons�quence = ca.DateD�but THEN 'DateDeD�butPremi�reCons�quence = DateD�but'
			WHEN a.R�gime = 'Assurance salaire grossesse' AND ca.Cons�quence = 'Absence' AND a.DateD�butPremi�reCons�quence = ca.DateD�but THEN 'DateDeD�butPremi�reCons�quence = DateD�but'
			WHEN a.R�gime = 'SAAQ' AND ca.Cons�quence = 'Absence' AND a.DateD�butPremi�reCons�quence = ca.DateD�but THEN 'DateDeD�butPremi�reCons�quence = DateD�but'
			WHEN a.R�gime = 'Assurance salaire 3e ann�e et plus' AND (ca.Cons�quence = 'Absence' OR ca.Cons�quence = 'Assignation temporaire/travaux l�gers' OR ca.Cons�quence = 'Rechute' OR ca.Cons�quence = 'Retour progressif') AND a.Employ��ligible = 'non' THEN 'Employ��ligible = non'
			ELSE NULL
		END AS Condition
	FROM BDIP_Absence a

	LEFT JOIN BDIP_ConsequenceAbsence ca ON a.Num�ro�v�nement = ca.Num�ro�v�nementParent
)
SELECT a.R�gime, ca.Cons�quence, cc.Condition,
CASE
	WHEN a.R�gime = 'Absence courte dur�e' AND ca.Cons�quence = 'Absence' THEN 'Mal'
	WHEN a.R�gime = 'Assurance salaire' AND ca.Cons�quence = 'Absence' AND cc.Condition = 'DateDeD�butPremi�reCons�quence = DateD�but' THEN 'Durant le d�lais de carence: Mal' + char(13) + char(10) + 'Apr�s le d�lais de carence: Assal'
	WHEN a.R�gime = 'Assurance salaire' AND ca.Cons�quence = 'Absence' AND cc.Condition = 'DateDeD�butPremi�reCons�quence = DateD�but AND Employ��ligible = non' THEN 'Durant le d�lais de carence: Mal' + char(13) + char(10) + 'Apr�s le d�lais de carence: AssNP'
	WHEN a.R�gime = 'Assurance salaire' AND ca.Cons�quence = 'Absence' AND cc.Condition IS NULL THEN 'Assal'
	WHEN a.R�gime = 'Assurance salaire' AND ca.Cons�quence = 'Assignation temporaire/travaux l�gers' THEN 'Heures travaill�es: Atass' + char(13) + char(10) + 'Heures non travaill�es: Assal'
	WHEN a.R�gime = 'Assurance salaire' AND ca.Cons�quence = 'Rechute' THEN 'Assal'
	WHEN a.R�gime = 'Assurance salaire' AND ca.Cons�quence = 'Retour progressif' THEN 'Heures travaill�es: RpAss' + char(13) + char(10) + 'Heures non travaill�es: Assal'
	WHEN a.R�gime = 'Assurance salaire 3e ann�e et plus' AND ca.Cons�quence = 'Absence' AND cc.Condition IS NULL THEN 'AM3an'
	WHEN a.R�gime = 'Assurance salaire 3e ann�e et plus' AND ca.Cons�quence = 'Absence' AND cc.Condition = 'Employ��ligible = non' THEN 'As3NA'
	WHEN a.R�gime = 'Assurance salaire 3e ann�e et plus' AND ca.Cons�quence = 'Assignation temporaire/travaux l�gers' THEN 'Heures travaill�es: Atass' + char(13) + char(10) + 'Heures non travaill�es: AM3an'
	WHEN a.R�gime = 'Assurance salaire 3e ann�e et plus' AND ca.Cons�quence = 'Assignation temporaire/travaux l�gers' AND cc.Condition = 'Employ��ligible = non' THEN 'Heures travaill�es: Atass' + char(13) + char(10) + 'Heures non travaill�es: AM3an'
	WHEN a.R�gime = 'Assurance salaire 3e ann�e et plus' AND ca.Cons�quence = 'Rechute' AND cc.Condition IS NULL THEN 'AM3an'
	WHEN a.R�gime = 'Assurance salaire 3e ann�e et plus' AND ca.Cons�quence = 'Rechute' AND cc.Condition = 'Employ��ligible = non' THEN 'As3NA'
	WHEN a.R�gime = 'Assurance salaire 3e ann�e et plus' AND ca.Cons�quence = 'Retour progressif' AND cc.Condition IS NULL THEN 'Heures travaill�es: RpAss' + char(13) + char(10) + 'Heures non travaill�es: AM3an'
	WHEN a.R�gime = 'Assurance salaire 3e ann�e et plus' AND ca.Cons�quence = 'Retour progressif' AND cc.Condition = 'Employ��ligible = non' THEN 'Heures travaill�es: RpAss' + char(13) + char(10) + 'Heures non travaill�es: As3NA'
	WHEN a.R�gime = 'Assurance salaire grossesse' AND ca.Cons�quence = 'Absence' AND cc.Condition = 'DateDeD�butPremi�reCons�quence = DateD�but' THEN 'Durant le d�lais de carence: Mal' + char(13) + char(10) + 'Apr�s le d�lais de carence: AsGro'
	WHEN a.R�gime = 'Assurance salaire grossesse' AND ca.Cons�quence = 'Absence' AND cc.Condition IS NULL THEN 'AsGro'
	WHEN a.R�gime = 'Assurance salaire grossesse' AND ca.Cons�quence = 'Assignation temporaire/travaux l�gers' THEN 'Heures travaill�es: Atass' + char(13) + char(10) + 'Heures non travaill�es: AsGro'
	WHEN a.R�gime = 'Assurance salaire grossesse' AND ca.Cons�quence = 'Rechute' THEN 'AsGro'
	WHEN a.R�gime = 'Assurance salaire grossesse' AND ca.Cons�quence = 'Retour progressif' THEN 'Heures travaill�es: RpAss' + char(13) + char(10) + 'Heures non travaill�es: AsGro'
	WHEN a.R�gime = 'Assurance salaire non admissible' AND ca.Cons�quence = 'Absence' THEN 'AssNA'
	WHEN a.R�gime = 'Assurance salaire non admissible' AND ca.Cons�quence = 'Assignation temporaire/travaux l�gers' THEN 'Heures travaill�es: Atass' + char(13) + char(10) + 'Heures non travaill�es: AssNA'
	WHEN a.R�gime = 'Assurance salaire non admissible' AND ca.Cons�quence = 'Rechute' THEN 'AssNA'
	WHEN a.R�gime = 'Assurance salaire non admissible' AND ca.Cons�quence = 'Retour progressif' THEN 'Heures travaill�es: RpAss' + char(13) + char(10) + 'Heures non travaill�es: AssNA'
	WHEN a.R�gime = 'Assurance salaire non pay�e' AND ca.Cons�quence = 'Absence' THEN 'AssNP'
	WHEN a.R�gime = 'Assurance salaire non pay�e' AND ca.Cons�quence = 'Assignation temporaire/travaux l�gers' THEN 'Heures travaill�es: Atass' + char(13) + char(10) + 'Heures non travaill�es: AssNP'
	WHEN a.R�gime = 'Assurance salaire non pay�e' AND ca.Cons�quence = 'Rechute' THEN 'AssNP'
	WHEN a.R�gime = 'Assurance salaire non pay�e' AND ca.Cons�quence = 'Retour progressif' THEN 'Heures travaill�es: RpAss' + char(13) + char(10) + 'Heures non travaill�es: AssNP'
	WHEN a.R�gime = 'IVAC' THEN NULL
	WHEN a.R�gime = 'IVAC 3e ann�e et plus' THEN NULL
	WHEN a.R�gime = 'RRQ' AND ca.Cons�quence = 'Absence' THEN 'Assal'
	WHEN a.R�gime = 'SAAQ' AND ca.Cons�quence = 'Absence' AND cc.Condition = 'DateDeD�butPremi�reCons�quence = DateD�but' THEN 'Durant le d�lais de carence: Mal' + char(13) + char(10) + 'Apr�s le d�lais de carence: SAAQ'
	WHEN a.R�gime = 'SAAQ' AND ca.Cons�quence = 'Absence' AND cc.Condition IS NULL THEN 'SAAQ'
	WHEN a.R�gime = 'SAAQ' AND ca.Cons�quence = 'Rechute' THEN 'SAAQ'
	WHEN a.R�gime = 'SAAQ' AND ca.Cons�quence = 'Stage SAAQ' THEN 'Heures travaill�es: SAAQT' + char(13) + char(10) + 'Heures non travaill�es: SAAQ'
	WHEN a.R�gime = 'SAAQ 3e ann�e et plus' AND ca.Cons�quence = 'Absence' THEN 'SAAQ'
	WHEN a.R�gime = 'SAAQ 3e ann�e et plus' AND ca.Cons�quence = 'Rechute' THEN 'SAAQ'
	WHEN a.R�gime = 'SAAQ 3e ann�e et plus' AND ca.Cons�quence = 'Stage SAAQ' THEN 'Heures travaill�es: SAAQT' + char(13) + char(10) + 'Heures non travaill�es: SAAQ'
	ELSE NULL
END AS CodeDePaie
FROM BDIP_Absence a

LEFT JOIN BDIP_ConsequenceAbsence ca ON a.Num�ro�v�nement = ca.Num�ro�v�nementParent
LEFT JOIN CalculCTE cc ON a.Num�ro�v�nement = cc.Num�ro�v�nement