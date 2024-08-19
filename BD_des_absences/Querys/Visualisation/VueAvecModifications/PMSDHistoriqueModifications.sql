CREATE VIEW PMSDHistoriqueModifications AS
SELECT DISTINCT cra.Conséquence, cra.DateDébutCSQ, cra.DateFinCSQ, cpp.CodeDePaie, cd.Description, p.NuméroÉvénement, p.DateHeureModification, p.StatutDonnée
FROM BDIP_PMSDModifications p

LEFT JOIN BDIP_RapportAccidentModifications	 ra ON p.Matricule = ra.Matricule
LEFT JOIN BDIP_ConsequenceRapportAccidentModifications cra ON ra.NuméroÉvénement = cra.NuméroÉvénementParent
LEFT JOIN CodeDePaiePMSD cpp ON p.Régime = cpp.Régime AND cra.Conséquence = cpp.Conséquence
LEFT JOIN BD_Consequences_Details cd ON cra.NuméroÉvénementParent = cd.[N° de l'événement] AND cra.DateDébutCSQ = cd.[Date de début]

WHERE cra.DateFinCSQ < GETDATE() AND (cra.Conséquence IS NOT NULL OR cra.DateDébutCSQ IS NOT NULL OR cra.DateFinCSQ IS NOT NULL)