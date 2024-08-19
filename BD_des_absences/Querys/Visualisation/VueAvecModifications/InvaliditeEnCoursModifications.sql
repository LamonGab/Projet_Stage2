CREATE VIEW InvaliditeEnCoursModifications AS
SELECT DISTINCT ca.Conséquence, ca.DateDébut, ca.DateFin, ca.DateRetourPrévue, cd.[Date du prochain suivi médical], cpi.CodeDePaie, cd.Description, a.NuméroÉvénement, a.DateHeureModification, a.StatutDonnée

FROM BDIP_AbsenceModifications a

LEFT JOIN BDIP_ConsequenceAbsenceModifications ca ON a.NuméroÉvénement = ca.NuméroÉvénementParent
LEFT JOIN InfocentreNormalisation.RH.Empl_Inter ei ON a.Matricule = ei.Matri
LEFT JOIN InfocentreNormalisation.RH.FactEmplConge fec ON a.Matricule = fec.Matricule
LEFT JOIN CodeDePaieInvalidite cpi ON a.Régime = cpi.Régime AND ca.Conséquence = cpi.Conséquence
LEFT JOIN BD_Consequences_Details cd ON ca.NuméroÉvénementParent = cd.[N° de l'événement] AND ca.DateDébut = cd.[Date de début]

WHERE --ca.DateDébut <= GETDATE() AND (ca.DateFin IS NULL OR ca.DateFin >= GETDATE()) AND a.EmployéÉligible = 'oui' AND a.DateDébutPremièreConséquence = ca.DateDébut AND
(ca.Conséquence IS NOT NULL OR ca.DateDébut IS NOT NULL OR ca.DateFin IS NOT NULL OR ca.DateRetourPrévue IS NOT NULL)