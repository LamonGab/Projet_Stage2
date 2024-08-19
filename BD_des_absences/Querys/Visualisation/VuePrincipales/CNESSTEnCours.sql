CREATE VIEW CNESSTEnCours AS
SELECT DISTINCT cra.Conséquence, cra.DateDébutCSQ, cra.DateFinCSQ, ca.DateRetourPrévue, cd.[Date du prochain suivi médical], cpc.CodeDePaie, cd.Description, ra.NuméroÉvénement
FROM BDIP_RapportAccident ra

LEFT JOIN BDIP_ConsequenceRapportAccident cra ON ra.NuméroÉvénement = cra.NuméroÉvénementParent
LEFT JOIN BDIP_Absence a ON ra.NuméroÉvénement = a.NuméroÉvénement
LEFT JOIN BDIP_ConsequenceAbsence ca ON a.NuméroÉvénement = ca.NuméroÉvénementParent
LEFT JOIN CodeDePaieCNESST cpc ON ra.Régime = cpc.Régime AND cra.Conséquence = cpc.Conséquence
LEFT JOIN BD_Consequences_Details cd ON cra.NuméroÉvénementParent = cd.[N° de l'événement] AND cra.DateDébutCSQ = cd.[Date de début]

WHERE cra.DateDébutCSQ <= GETDATE() AND (cra.DateFinCSQ IS NULL OR cra.DateFinCSQ >= GETDATE())