CREATE VIEW InvaliditeModifications AS
SELECT DISTINCT ca.Conséquence, ca.DateDébut, ca.DateFin, ca.DateRetourPrévue, cd.[Date du prochain suivi médical], cpi.CodeDePaie, cd.Description, ca.NuméroÉvénementParent AS NuméroÉvénement, ca.DateHeureModification, ca.StatutDonnée, ca.Matricule
FROM BDIP_ConsequenceAbsenceModifications ca

LEFT JOIN InfocentreNormalisation.RH.Empl_Inter ei ON ca.Matricule = ei.Matri
LEFT JOIN InfocentreNormalisation.RH.FactEmplConge fec ON ca.Matricule = fec.Matricule
LEFT JOIN CodeDePaieInvalidite cpi ON ca.Conséquence = cpi.Conséquence
LEFT JOIN BD_Consequences_Details cd ON ca.NuméroÉvénementParent = cd.[N° de l'événement] AND ca.DateDébut = cd.[Date de début]

WHERE ca.Conséquence IS NOT NULL OR ca.DateDébut IS NOT NULL OR ca.DateFin IS NOT NULL OR ca.DateRetourPrévue IS NOT NULL