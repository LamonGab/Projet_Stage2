CREATE VIEW CNESSTAVenirModifications AS
SELECT DISTINCT cra.Conséquence, cra.DateDébutCSQ, cra.DateFinCSQ, ca.DateRetourPrévue, cd.[Date du prochain suivi médical], cpc.CodeDePaie, cd.Description, ra.NuméroÉvénement, ra.DateHeureModification, ra.StatutDonnée
FROM BDIP_RapportAccidentModifications ra

LEFT JOIN BDIP_ConsequenceRapportAccidentModifications cra ON ra.NuméroÉvénement = cra.NuméroÉvénementParent
LEFT JOIN BDIP_AbsenceModifications a ON ra.NuméroÉvénement = a.NuméroÉvénement
LEFT JOIN BDIP_ConsequenceAbsenceModifications ca ON a.NuméroÉvénement = ca.NuméroÉvénementParent
LEFT JOIN CodeDePaieCNESST cpc ON ra.Régime = cpc.Régime AND cra.Conséquence = cpc.Conséquence
LEFT JOIN BD_Consequences_Details cd ON cra.NuméroÉvénementParent = cd.[N° de l'événement] AND cra.DateDébutCSQ = cd.[Date de début]

WHERE cra.DateDébutCSQ > GETDATE() AND (cra.Conséquence IS NOT NULL OR cra.DateDébutCSQ IS NOT NULL OR cra.DateFinCSQ IS NOT NULL OR ca.DateRetourPrévue IS NOT NULL)