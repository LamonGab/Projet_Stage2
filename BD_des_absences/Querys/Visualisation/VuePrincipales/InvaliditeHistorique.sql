CREATE VIEW InvaliditeHistorique AS
SELECT DISTINCT a.Régime, ca.Conséquence, ca.DateDébut, ca.DateFin, cpi.CodeDePaie, cd.Description, a.NuméroÉvénement
FROM BDIP_Absence a

LEFT JOIN BDIP_ConsequenceAbsence ca ON a.NuméroÉvénement = ca.NuméroÉvénementParent
LEFT JOIN CodeDePaieInvalidite cpi ON a.Régime = cpi.Régime AND ca.Conséquence = cpi.Conséquence
LEFT JOIN BD_Consequences_Details cd ON ca.NuméroÉvénementParent = cd.[N° de l'événement] AND ca.DateDébut = cd.[Date de début]

WHERE ca.DateFin < GETDATE() AND a.EmployéÉligible = 'oui'