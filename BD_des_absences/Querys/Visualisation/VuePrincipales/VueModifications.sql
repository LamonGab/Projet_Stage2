CREATE VIEW VueModifications AS
SELECT m.Num�ro�v�nement, m.StatutDonn�e, m.DateHeureModification,
CASE
	WHEN m.Num�ro�v�nement = ra.Num�ro�v�nement THEN ra.Matricule
	WHEN m.Num�ro�v�nement = p.Num�ro�v�nement THEN p.Matricule
	WHEN m.Num�ro�v�nement = a.Num�ro�v�nement THEN a.Matricule
	ELSE NULL
END AS Matricule

FROM Modifications m

LEFT JOIN BDIP_RapportAccident ra ON m.Num�ro�v�nement = ra.Num�ro�v�nement
LEFT JOIN BDIP_PMSD p ON m.Num�ro�v�nement = p.Num�ro�v�nement
LEFT JOIN BDIP_Absence a ON m.Num�ro�v�nement = a.Num�ro�v�nement