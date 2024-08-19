CREATE VIEW CNESSTAVenirModifications AS
SELECT DISTINCT cra.Cons�quence, cra.DateD�butCSQ, cra.DateFinCSQ, ca.DateRetourPr�vue, cd.[Date du prochain suivi m�dical], cpc.CodeDePaie, cd.Description, ra.Num�ro�v�nement, ra.DateHeureModification, ra.StatutDonn�e
FROM BDIP_RapportAccidentModifications ra

LEFT JOIN BDIP_ConsequenceRapportAccidentModifications cra ON ra.Num�ro�v�nement = cra.Num�ro�v�nementParent
LEFT JOIN BDIP_AbsenceModifications a ON ra.Num�ro�v�nement = a.Num�ro�v�nement
LEFT JOIN BDIP_ConsequenceAbsenceModifications ca ON a.Num�ro�v�nement = ca.Num�ro�v�nementParent
LEFT JOIN CodeDePaieCNESST cpc ON ra.R�gime = cpc.R�gime AND cra.Cons�quence = cpc.Cons�quence
LEFT JOIN BD_Consequences_Details cd ON cra.Num�ro�v�nementParent = cd.[N� de l'�v�nement] AND cra.DateD�butCSQ = cd.[Date de d�but]

WHERE cra.DateD�butCSQ > GETDATE() AND (cra.Cons�quence IS NOT NULL OR cra.DateD�butCSQ IS NOT NULL OR cra.DateFinCSQ IS NOT NULL OR ca.DateRetourPr�vue IS NOT NULL)