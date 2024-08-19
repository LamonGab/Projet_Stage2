CREATE VIEW InvaliditeAVenir AS
SELECT DISTINCT ca.Cons�quence, ca.DateD�but, ca.DateFin, ca.DateRetourPr�vue, cd.[Date du prochain suivi m�dical], cpi.CodeDePaie, cd.Description, a.Num�ro�v�nement
FROM BDIP_Absence a

LEFT JOIN BDIP_ConsequenceAbsence ca ON a.Num�ro�v�nement = ca.Num�ro�v�nementParent
LEFT JOIN CodeDePaieInvalidite cpi ON a.R�gime = cpi.R�gime AND ca.Cons�quence = cpi.Cons�quence
LEFT JOIN BD_Consequences_Details cd ON ca.Num�ro�v�nementParent = cd.[N� de l'�v�nement] AND ca.DateD�but = cd.[Date de d�but]

WHERE ca.DateD�but > GETDATE() AND a.Employ��ligible = 'oui'