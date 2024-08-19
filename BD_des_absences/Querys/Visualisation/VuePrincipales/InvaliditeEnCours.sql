CREATE VIEW InvaliditeEnCours AS
SELECT DISTINCT ca.Conséquence, ca.DateDébut, ca.DateFin, ca.DateRetourPrévue, cd.[Date du prochain suivi médical], cpi.CodeDePaie, cd.Description, a.NuméroÉvénement

FROM BDIP_Absence a

LEFT JOIN BDIP_ConsequenceAbsence ca ON a.NuméroÉvénement = ca.NuméroÉvénementParent
LEFT JOIN Paie pa ON a.Régime = pa.Régime AND ca.Conséquence = pa.Conséquence
LEFT JOIN InfocentreNormalisation.RH.Empl_Inter ei ON a.Matricule = ei.Matri
LEFT JOIN InfocentreNormalisation.RH.FactEmplConge fec ON a.Matricule = fec.Matricule
LEFT JOIN CodeDePaieInvalidite cpi ON a.Régime = cpi.Régime AND ca.Conséquence = cpi.Conséquence
LEFT JOIN BD_Consequences_Details cd ON ca.NuméroÉvénementParent = cd.[N° de l'événement] AND ca.DateDébut = cd.[Date de début]

WHERE ca.DateDébut <= GETDATE() AND (ca.DateFin IS NULL OR ca.DateFin >= GETDATE()) AND a.EmployéÉligible = 'oui' AND a.DateDébutPremièreConséquence = ca.DateDébut