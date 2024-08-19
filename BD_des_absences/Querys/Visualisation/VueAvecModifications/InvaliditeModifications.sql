CREATE VIEW InvaliditeModifications AS
SELECT DISTINCT ca.Cons�quence, ca.DateD�but, ca.DateFin, ca.DateRetourPr�vue, cd.[Date du prochain suivi m�dical], cpi.CodeDePaie, cd.Description, ca.Num�ro�v�nementParent AS Num�ro�v�nement, ca.DateHeureModification, ca.StatutDonn�e, ca.Matricule
FROM BDIP_ConsequenceAbsenceModifications ca

LEFT JOIN InfocentreNormalisation.RH.Empl_Inter ei ON ca.Matricule = ei.Matri
LEFT JOIN InfocentreNormalisation.RH.FactEmplConge fec ON ca.Matricule = fec.Matricule
LEFT JOIN CodeDePaieInvalidite cpi ON ca.Cons�quence = cpi.Cons�quence
LEFT JOIN BD_Consequences_Details cd ON ca.Num�ro�v�nementParent = cd.[N� de l'�v�nement] AND ca.DateD�but = cd.[Date de d�but]

WHERE ca.Cons�quence IS NOT NULL OR ca.DateD�but IS NOT NULL OR ca.DateFin IS NOT NULL OR ca.DateRetourPr�vue IS NOT NULL