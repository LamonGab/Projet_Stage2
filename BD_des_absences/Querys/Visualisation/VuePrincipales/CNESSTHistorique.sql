CREATE VIEW CNESSTHistorique AS
SELECT DISTINCT cra.Conséquence, cra.DateDébutCSQ, cra.DateFinCSQ, cpc.CodeDePaie, cd.Description, ra.NuméroÉvénement
FROM BDIP_RapportAccident ra

LEFT JOIN BDIP_ConsequenceRapportAccident cra ON ra.NuméroÉvénement = cra.NuméroÉvénementParent
LEFT JOIN CodeDePaieCNESST cpc ON ra.Régime = cpc.Régime AND cra.Conséquence = cpc.Conséquence
LEFT JOIN BD_Consequences_Details cd ON cra.NuméroÉvénementParent = cd.[N° de l'événement] AND cra.DateDébutCSQ = cd.[Date de début]

WHERE cra.DateFinCSQ < GETDATE()