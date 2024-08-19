CREATE VIEW InvaliditeEnCours AS
SELECT DISTINCT ca.Cons�quence, ca.DateD�but, ca.DateFin, ca.DateRetourPr�vue, cd.[Date du prochain suivi m�dical], cpi.CodeDePaie, cd.Description, a.Num�ro�v�nement

FROM BDIP_Absence a

LEFT JOIN BDIP_ConsequenceAbsence ca ON a.Num�ro�v�nement = ca.Num�ro�v�nementParent
LEFT JOIN Paie pa ON a.R�gime = pa.R�gime AND ca.Cons�quence = pa.Cons�quence
LEFT JOIN InfocentreNormalisation.RH.Empl_Inter ei ON a.Matricule = ei.Matri
LEFT JOIN InfocentreNormalisation.RH.FactEmplConge fec ON a.Matricule = fec.Matricule
LEFT JOIN CodeDePaieInvalidite cpi ON a.R�gime = cpi.R�gime AND ca.Cons�quence = cpi.Cons�quence
LEFT JOIN BD_Consequences_Details cd ON ca.Num�ro�v�nementParent = cd.[N� de l'�v�nement] AND ca.DateD�but = cd.[Date de d�but]

WHERE ca.DateD�but <= GETDATE() AND (ca.DateFin IS NULL OR ca.DateFin >= GETDATE()) AND a.Employ��ligible = 'oui' AND a.DateD�butPremi�reCons�quence = ca.DateD�but