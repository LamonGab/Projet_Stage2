CREATE VIEW CNESSTHistorique AS
SELECT DISTINCT cra.Cons�quence, cra.DateD�butCSQ, cra.DateFinCSQ, cpc.CodeDePaie, cd.Description, ra.Num�ro�v�nement
FROM BDIP_RapportAccident ra

LEFT JOIN BDIP_ConsequenceRapportAccident cra ON ra.Num�ro�v�nement = cra.Num�ro�v�nementParent
LEFT JOIN CodeDePaieCNESST cpc ON ra.R�gime = cpc.R�gime AND cra.Cons�quence = cpc.Cons�quence
LEFT JOIN BD_Consequences_Details cd ON cra.Num�ro�v�nementParent = cd.[N� de l'�v�nement] AND cra.DateD�butCSQ = cd.[Date de d�but]

WHERE cra.DateFinCSQ < GETDATE()