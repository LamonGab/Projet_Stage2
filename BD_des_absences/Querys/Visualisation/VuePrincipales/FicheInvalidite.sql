CREATE VIEW FicheInvalidite AS
SELECT DISTINCT a.Matricule, ca.DateD�but, ca.DateFin, ca.DateRetourPr�vue, a.DateR�elle104Semaines, a.MatriculeResponsableDossier,
CASE
	WHEN a.MatriculeResponsableDossier = 'DSIAGP' THEN NULL
	WHEN a.MatriculeResponsableDossier = 'SAPAAGP' THEN NULL
	ELSE e.Nom
	END AS NomResponsable,
CASE
	WHEN a.MatriculeResponsableDossier = 'DSIAGP' THEN 'DSIAGP' 
	WHEN a.MatriculeResponsableDossier = 'SAPAAGP' THEN 'SAPAAGP'
	ELSE e.Prenom
	END AS PrenomResponsable,
ca.Cons�quence, cd.[Date du prochain suivi m�dical]

FROM BDIP_Absence a

LEFT JOIN BDIP_ConsequenceAbsence ca ON a.Num�ro�v�nement = ca.Num�ro�v�nementParent
LEFT JOIN InfocentreNormalisation.RH.Employe e ON
	CASE
		WHEN ISNUMERIC(a.MatriculeResponsableDossier) = 1 THEN CAST(a.MatriculeResponsableDossier AS INT)
		ELSE NULL
	END = e.Matri
LEFT JOIN BD_Consequences_Details cd ON ca.Num�ro�v�nementParent = cd.[N� de l'�v�nement] AND ca.DateD�but = cd.[Date de d�but]