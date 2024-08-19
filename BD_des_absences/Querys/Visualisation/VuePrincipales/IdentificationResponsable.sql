CREATE VIEW IdentificationResponsable AS
SELECT DISTINCT a.MatriculeResponsableDossier, 
CASE
	WHEN a.MatriculeResponsableDossier = 'DSIAGP' THEN NULL
	WHEN a.MatriculeResponsableDossier = 'SAPAAGP' THEN NULL
	ELSE e.Nom
	END AS Nom,
CASE
	WHEN a.MatriculeResponsableDossier = 'DSIAGP' THEN 'DSIAGP' 
	WHEN a.MatriculeResponsableDossier = 'SAPAAGP' THEN 'SAPAAGP'
	ELSE e.Prenom
	END AS Prenom

FROM BDIP_Absence a

LEFT JOIN InfocentreNormalisation.RH.Employe e ON
	CASE
		WHEN ISNUMERIC(a.MatriculeResponsableDossier) = 1 THEN CAST(a.MatriculeResponsableDossier AS INT)
		ELSE NULL
	END = e.Matri

WHERE a.MatriculeResponsableDossier IS NOT NULL