CREATE VIEW CNESSTRégime AS
SELECT DISTINCT ra.NuméroÉvénement, ra.Régime, ra.DateÉvénement, ra.DateDébutPremièreAbsence, ra.DateDernierJourTravaillé, ra.DateFermeture,
ra.RaisonFermetureDossier, ra.Date3eAnnéeCNESST, ra.Matricule, a.MatriculeResponsableDossier
FROM BDIP_RapportAccident ra

LEFT JOIN BDIP_Absence a ON ra.NuméroÉvénement = a.NuméroÉvénement

WHERE (ra.StatutDossier = 'Ouvert' OR ra.StatutDossier = 'Fermé') AND ra.TypeDossier = 'Avec perte de temps' AND (ra.DateFermeture IS NULL OR ra.DateFermeture >= DATEADD(DAY, 45, GETDATE()))
AND ra.Régime != 'Maternité sans danger'