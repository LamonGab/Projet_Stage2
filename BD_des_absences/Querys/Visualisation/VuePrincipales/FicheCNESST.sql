CREATE VIEW FicheCNESST AS
SELECT DISTINCT ra.Matricule, ra.DateÉvénement, ra.DateDernierJourTravaillé, ra.Régime, a.MatriculeResponsableDossier,
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
cra.DateDébutCSQ, cra.DateFinCSQ, cra.Conséquence, cd.[Date du prochain suivi médical], a.DateRéelle104Semaines

FROM BDIP_Absence a

LEFT JOIN InfocentreNormalisation.RH.Employe e ON
	CASE
		WHEN ISNUMERIC(a.MatriculeResponsableDossier) = 1 THEN CAST(a.MatriculeResponsableDossier AS INT)
		ELSE NULL
	END = e.Matri
LEFT JOIN BDIP_RapportAccident ra ON ra.Matricule = a.Matricule
LEFT JOIN BDIP_ConsequenceRapportAccident cra ON cra.NuméroÉvénementParent = ra.NuméroÉvénement
LEFT JOIN BD_Consequences_Details cd ON cra.NuméroÉvénementParent = cd.[N° de l'événement] AND cra.DateDébutCSQ = cd.[Date de début]