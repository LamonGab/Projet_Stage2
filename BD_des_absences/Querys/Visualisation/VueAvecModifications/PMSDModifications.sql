CREATE VIEW PMSDModifications AS
SELECT DISTINCT cra.Conséquence, cra.DateDébutCSQ, cra.DateFinCSQ, cpp.CodeDePaie, cd.Description, cra.NuméroÉvénementParent AS NuméroÉvénement, cra.DateHeureModification, cra.StatutDonnée, cra.Matricule
FROM BDIP_ConsequenceRapportAccidentModifications cra

LEFT JOIN BDIP_ConsequenceRapportAccident crac ON cra.NuméroÉvénementParent = crac.NuméroÉvénementParent
LEFT JOIN BDIP_RapportAccident ra ON ra.NuméroÉvénement = cra.NuméroÉvénementParent
LEFT JOIN BDIP_PMSD p ON p.Matricule = ra.Matricule
LEFT JOIN CodeDePaiePMSD cpp ON p.Régime = cpp.Régime AND cra.Conséquence = cpp.Conséquence
LEFT JOIN BD_Consequences_Details cd ON cra.NuméroÉvénementParent = cd.[N° de l'événement] AND cra.DateDébutCSQ = cd.[Date de début]

WHERE cra.Conséquence IS NOT NULL OR cra.DateDébutCSQ IS NOT NULL OR cra.DateFinCSQ IS NOT NULL