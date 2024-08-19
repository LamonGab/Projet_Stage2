CREATE VIEW VueModifications AS
SELECT m.NuméroÉvénement, m.StatutDonnée, m.DateHeureModification,
CASE
	WHEN m.NuméroÉvénement = ra.NuméroÉvénement THEN ra.Matricule
	WHEN m.NuméroÉvénement = p.NuméroÉvénement THEN p.Matricule
	WHEN m.NuméroÉvénement = a.NuméroÉvénement THEN a.Matricule
	ELSE NULL
END AS Matricule

FROM Modifications m

LEFT JOIN BDIP_RapportAccident ra ON m.NuméroÉvénement = ra.NuméroÉvénement
LEFT JOIN BDIP_PMSD p ON m.NuméroÉvénement = p.NuméroÉvénement
LEFT JOIN BDIP_Absence a ON m.NuméroÉvénement = a.NuméroÉvénement