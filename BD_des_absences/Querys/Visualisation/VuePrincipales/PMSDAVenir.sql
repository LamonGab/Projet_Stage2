CREATE VIEW PMSDAVenir AS
SELECT DISTINCT cra.Matricule, cra.Conséquence, cra.DateDébutCSQ, cra.DateFinCSQ, cpp.CodeDePaie, cd.Description, p.NuméroÉvénement
FROM BDIP_PMSD p

LEFT JOIN BDIP_RapportAccident ra ON p.Matricule = ra.Matricule
LEFT JOIN BDIP_ConsequenceRapportAccident cra ON ra.NuméroÉvénement = cra.NuméroÉvénementParent
LEFT JOIN CodeDePaiePMSD cpp ON ra.Régime = cpp.Régime AND cra.Conséquence = cpp.Conséquence
LEFT JOIN BD_Consequences_Details cd ON cra.NuméroÉvénementParent = cd.[N° de l'événement] AND cra.DateDébutCSQ = cd.[Date de début]

WHERE cra.DateDébutCSQ > GETDATE()