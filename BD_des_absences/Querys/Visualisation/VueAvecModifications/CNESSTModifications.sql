CREATE VIEW CNESSTModifications AS
SELECT DISTINCT cra.Cons�quence, cra.DateD�butCSQ, cra.DateFinCSQ, cra.DateRetourPr�vue, cd.[Date du prochain suivi m�dical], cpc.CodeDePaie, cd.Description, cra.Num�ro�v�nementParent AS Num�ro�v�nement, cra.DateHeureModification, cra.StatutDonn�e, cra.Matricule
FROM BDIP_ConsequenceRapportAccidentModifications cra

LEFT JOIN BDIP_RapportAccident ra ON cra.Num�ro�v�nementParent = ra.Num�ro�v�nement
LEFT JOIN BDIP_ConsequenceRapportAccident crac ON ra.Num�ro�v�nement = crac.Num�ro�v�nementParent
LEFT JOIN CodeDePaieCNESST cpc ON ra.R�gime = cpc.R�gime AND crac.Cons�quence = cpc.Cons�quence
LEFT JOIN BD_Consequences_Details cd ON cra.Num�ro�v�nementParent = cd.[N� de l'�v�nement] AND crac.DateD�butCSQ = cd.[Date de d�but]

WHERE cra.Cons�quence IS NOT NULL OR cra.DateD�butCSQ IS NOT NULL OR cra.DateFinCSQ IS NOT NULL OR cra.DateRetourPr�vue IS NOT NULL