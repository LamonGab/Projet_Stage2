CREATE VIEW PMSDModifications AS
SELECT DISTINCT cra.Cons�quence, cra.DateD�butCSQ, cra.DateFinCSQ, cpp.CodeDePaie, cd.Description, cra.Num�ro�v�nementParent AS Num�ro�v�nement, cra.DateHeureModification, cra.StatutDonn�e, cra.Matricule
FROM BDIP_ConsequenceRapportAccidentModifications cra

LEFT JOIN BDIP_ConsequenceRapportAccident crac ON cra.Num�ro�v�nementParent = crac.Num�ro�v�nementParent
LEFT JOIN BDIP_RapportAccident ra ON ra.Num�ro�v�nement = cra.Num�ro�v�nementParent
LEFT JOIN BDIP_PMSD p ON p.Matricule = ra.Matricule
LEFT JOIN CodeDePaiePMSD cpp ON p.R�gime = cpp.R�gime AND cra.Cons�quence = cpp.Cons�quence
LEFT JOIN BD_Consequences_Details cd ON cra.Num�ro�v�nementParent = cd.[N� de l'�v�nement] AND cra.DateD�butCSQ = cd.[Date de d�but]

WHERE cra.Cons�quence IS NOT NULL OR cra.DateD�butCSQ IS NOT NULL OR cra.DateFinCSQ IS NOT NULL