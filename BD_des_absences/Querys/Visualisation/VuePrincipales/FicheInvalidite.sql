CREATE VIEW FicheInvalidite AS
SELECT DISTINCT a.Matricule, ca.DateDébut, ca.DateFin, ca.DateRetourPrévue, a.DateRéelle104Semaines, a.MatriculeResponsableDossier,
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
ca.Conséquence, cd.[Date du prochain suivi médical]

FROM BDIP_Absence a

LEFT JOIN BDIP_ConsequenceAbsence ca ON a.NuméroÉvénement = ca.NuméroÉvénementParent
LEFT JOIN InfocentreNormalisation.RH.Employe e ON
	CASE
		WHEN ISNUMERIC(a.MatriculeResponsableDossier) = 1 THEN CAST(a.MatriculeResponsableDossier AS INT)
		ELSE NULL
	END = e.Matri
LEFT JOIN BD_Consequences_Details cd ON ca.NuméroÉvénementParent = cd.[N° de l'événement] AND ca.DateDébut = cd.[Date de début]