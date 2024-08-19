CREATE VIEW PMSDRegime AS
SELECT DISTINCT p.NuméroÉvénement, p.Régime, p.TypeDossierMaternité, ra.DateFermeture, p.TravailleuseApteTravailler, p.OrientationDossier,
p.DateRéceptionCertificatVisantRetraitOuAffectationTemporaire, p.DatePrévueAccouchement, p.DateSuiviFermetureDossier36eSemaine, DATEADD(DAY, -196, p.DatePrévueAccouchement) AS Date12eSemaine,
DATEADD(DAY, -140, p.DatePrévueAccouchement) AS Date20eSemaine, DATEADD(DAY, -112, p.DatePrévueAccouchement) AS Date24eSemaine, DATEADD(DAY, -70, p.DatePrévueAccouchement) AS Date30eSemaine, p.DateCessationTravail,
p.Matricule, a.MatriculeResponsableDossier
FROM BDIP_PMSD p

LEFT JOIN BDIP_Absence a ON a.NuméroÉvénement = p.NuméroÉvénement
LEFT JOIN BDIP_RapportAccident ra ON p.NuméroÉvénement = ra.NuméroÉvénement

WHERE (p.StatutDossier = 'Ouvert' OR p.StatutDossier = 'Fermé') AND p.Régime ='Maternité sans danger' AND (ra.DateFermeture IS NULL OR ra.DateFermeture >= DATEADD(DAY, 45, GETDATE()))