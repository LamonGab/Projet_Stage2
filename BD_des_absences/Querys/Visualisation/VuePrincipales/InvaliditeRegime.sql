CREATE VIEW InvaliditeRégime AS
SELECT DISTINCT a.NuméroÉvénement,
CASE
	WHEN a.Régime = 'IVAC' THEN 'Assurance salaire'
	WHEN a.Régime = 'IVAC 3e année et plus' THEN 'Assurance salaire 3e année et plus'
	ELSE a.Régime
END AS Régime, a.DateDébutPremièreConséquence, a.DateFermetureDossier, a.DateRéelle104Semaines,
CASE
	WHEN ae.Matricule IS NULL THEN 'Non'
	ELSE 'Oui'
END AS AbsentéismeÉlevé, a.Matricule, a.MatriculeResponsableDossier
FROM BDIP_Absence a

LEFT JOIN BDIP_ConsequenceAbsence ca ON a.NuméroÉvénement = ca.NuméroÉvénementParent
LEFT JOIN BD_Absenteisme_eleve ae ON a.Matricule = ae.Matricule

WHERE (a.StatutDossier = 'Ouvert' OR a.StatutDossier = 'Fermé') AND (a.DateFinConséquence IS NULL OR a.DateFinConséquence >= DATEADD(DAY, 45, GETDATE()))