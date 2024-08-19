CREATE VIEW PMSDHistorique AS
SELECT DISTINCT cra.Cons�quence, cra.DateD�butCSQ, cra.DateFinCSQ, cpp.CodeDePaie, cd.Description, p.Num�ro�v�nement
FROM BDIP_PMSD p 

LEFT JOIN BDIP_RapportAccident ra ON p.Matricule = ra.Matricule
LEFT JOIN BDIP_ConsequenceRapportAccident cra ON ra.Num�ro�v�nement = cra.Num�ro�v�nementParent
LEFT JOIN CodeDePaiePMSD cpp ON p.R�gime = cpp.R�gime AND cra.Cons�quence = cpp.Cons�quence
LEFT JOIN BD_Consequences_Details cd ON cra.Num�ro�v�nementParent = cd.[N� de l'�v�nement] AND cra.DateD�butCSQ = cd.[Date de d�but]

WHERE cra.DateFinCSQ < GETDATE()