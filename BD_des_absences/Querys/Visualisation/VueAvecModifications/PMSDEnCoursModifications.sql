CREATE VIEW PMSDEnCoursModifications AS
SELECT DISTINCT cra.Cons�quence, cra.DateD�butCSQ, cra.DateFinCSQ, cpp.CodeDePaie, cd.Description, p.Num�ro�v�nement, p.DateHeureModification, p.StatutDonn�e
FROM BDIP_PMSDModifications p

LEFT JOIN BDIP_RapportAccidentModifications ra ON p.Matricule = ra.Matricule
LEFT JOIN BDIP_ConsequenceRapportAccidentModifications cra ON ra.Num�ro�v�nement = cra.Num�ro�v�nementParent
LEFT JOIN CodeDePaiePMSD cpp ON ra.R�gime = cpp.R�gime AND cra.Cons�quence = cpp.Cons�quence
LEFT JOIN BD_Consequences_Details cd ON cra.Num�ro�v�nementParent = cd.[N� de l'�v�nement] AND cra.DateD�butCSQ = cd.[Date de d�but]

WHERE cra.DateD�butCSQ <= GETDATE() AND (cra.DateFinCSQ IS NULL OR cra.DateFinCSQ >= GETDATE()) AND (cra.Cons�quence IS NOT NULL OR cra.DateD�butCSQ IS NOT NULL OR cra.DateFinCSQ IS NOT NULL)