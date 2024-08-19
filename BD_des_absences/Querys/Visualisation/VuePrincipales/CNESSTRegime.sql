CREATE VIEW CNESSTR�gime AS
SELECT DISTINCT ra.Num�ro�v�nement, ra.R�gime, ra.Date�v�nement, ra.DateD�butPremi�reAbsence, ra.DateDernierJourTravaill�, ra.DateFermeture,
ra.RaisonFermetureDossier, ra.Date3eAnn�eCNESST, ra.Matricule, a.MatriculeResponsableDossier
FROM BDIP_RapportAccident ra

LEFT JOIN BDIP_Absence a ON ra.Num�ro�v�nement = a.Num�ro�v�nement

WHERE (ra.StatutDossier = 'Ouvert' OR ra.StatutDossier = 'Ferm�') AND ra.TypeDossier = 'Avec perte de temps' AND (ra.DateFermeture IS NULL OR ra.DateFermeture >= DATEADD(DAY, 45, GETDATE()))
AND ra.R�gime != 'Maternit� sans danger'