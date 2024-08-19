CREATE VIEW PMSDRegime AS
SELECT DISTINCT p.Num�ro�v�nement, p.R�gime, p.TypeDossierMaternit�, ra.DateFermeture, p.TravailleuseApteTravailler, p.OrientationDossier,
p.DateR�ceptionCertificatVisantRetraitOuAffectationTemporaire, p.DatePr�vueAccouchement, p.DateSuiviFermetureDossier36eSemaine, DATEADD(DAY, -196, p.DatePr�vueAccouchement) AS Date12eSemaine,
DATEADD(DAY, -140, p.DatePr�vueAccouchement) AS Date20eSemaine, DATEADD(DAY, -112, p.DatePr�vueAccouchement) AS Date24eSemaine, DATEADD(DAY, -70, p.DatePr�vueAccouchement) AS Date30eSemaine, p.DateCessationTravail,
p.Matricule, a.MatriculeResponsableDossier
FROM BDIP_PMSD p

LEFT JOIN BDIP_Absence a ON a.Num�ro�v�nement = p.Num�ro�v�nement
LEFT JOIN BDIP_RapportAccident ra ON p.Num�ro�v�nement = ra.Num�ro�v�nement

WHERE (p.StatutDossier = 'Ouvert' OR p.StatutDossier = 'Ferm�') AND p.R�gime ='Maternit� sans danger' AND (ra.DateFermeture IS NULL OR ra.DateFermeture >= DATEADD(DAY, 45, GETDATE()))