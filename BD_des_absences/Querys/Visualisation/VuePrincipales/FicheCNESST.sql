CREATE VIEW FicheCNESST AS
SELECT DISTINCT ra.Matricule, ra.Date�v�nement, ra.DateDernierJourTravaill�, ra.R�gime, a.MatriculeResponsableDossier,
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
cra.DateD�butCSQ, cra.DateFinCSQ, cra.Cons�quence, cd.[Date du prochain suivi m�dical], a.DateR�elle104Semaines

FROM BDIP_Absence a

LEFT JOIN InfocentreNormalisation.RH.Employe e ON
	CASE
		WHEN ISNUMERIC(a.MatriculeResponsableDossier) = 1 THEN CAST(a.MatriculeResponsableDossier AS INT)
		ELSE NULL
	END = e.Matri
LEFT JOIN BDIP_RapportAccident ra ON ra.Matricule = a.Matricule
LEFT JOIN BDIP_ConsequenceRapportAccident cra ON cra.Num�ro�v�nementParent = ra.Num�ro�v�nement
LEFT JOIN BD_Consequences_Details cd ON cra.Num�ro�v�nementParent = cd.[N� de l'�v�nement] AND cra.DateD�butCSQ = cd.[Date de d�but]