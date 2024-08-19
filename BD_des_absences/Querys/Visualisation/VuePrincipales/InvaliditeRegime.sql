CREATE VIEW InvaliditeR�gime AS
SELECT DISTINCT a.Num�ro�v�nement,
CASE
	WHEN a.R�gime = 'IVAC' THEN 'Assurance salaire'
	WHEN a.R�gime = 'IVAC 3e ann�e et plus' THEN 'Assurance salaire 3e ann�e et plus'
	ELSE a.R�gime
END AS R�gime, a.DateD�butPremi�reCons�quence, a.DateFermetureDossier, a.DateR�elle104Semaines,
CASE
	WHEN ae.Matricule IS NULL THEN 'Non'
	ELSE 'Oui'
END AS Absent�isme�lev�, a.Matricule, a.MatriculeResponsableDossier
FROM BDIP_Absence a

LEFT JOIN BDIP_ConsequenceAbsence ca ON a.Num�ro�v�nement = ca.Num�ro�v�nementParent
LEFT JOIN BD_Absenteisme_eleve ae ON a.Matricule = ae.Matricule

WHERE (a.StatutDossier = 'Ouvert' OR a.StatutDossier = 'Ferm�') AND (a.DateFinCons�quence IS NULL OR a.DateFinCons�quence >= DATEADD(DAY, 45, GETDATE()))