CREATE VIEW CNESSTModifications AS
SELECT DISTINCT cra.Conséquence, cra.DateDébutCSQ, cra.DateFinCSQ, cra.DateRetourPrévue, cd.[Date du prochain suivi médical], cpc.CodeDePaie, cd.Description, cra.NuméroÉvénementParent AS NuméroÉvénement, cra.DateHeureModification, cra.StatutDonnée, cra.Matricule
FROM BDIP_ConsequenceRapportAccidentModifications cra

LEFT JOIN BDIP_RapportAccident ra ON cra.NuméroÉvénementParent = ra.NuméroÉvénement
LEFT JOIN BDIP_ConsequenceRapportAccident crac ON ra.NuméroÉvénement = crac.NuméroÉvénementParent
LEFT JOIN CodeDePaieCNESST cpc ON ra.Régime = cpc.Régime AND crac.Conséquence = cpc.Conséquence
LEFT JOIN BD_Consequences_Details cd ON cra.NuméroÉvénementParent = cd.[N° de l'événement] AND crac.DateDébutCSQ = cd.[Date de début]

WHERE cra.Conséquence IS NOT NULL OR cra.DateDébutCSQ IS NOT NULL OR cra.DateFinCSQ IS NOT NULL OR cra.DateRetourPrévue IS NOT NULL