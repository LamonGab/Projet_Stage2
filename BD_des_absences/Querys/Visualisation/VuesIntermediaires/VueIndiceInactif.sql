CREATE VIEW VueIndiceInactif AS
SELECT 
CASE
	WHEN a.StatutDossier = 'Fermé' AND a.DateFermetureDossier <= GETDATE() THEN 'Inactif'
	WHEN a.StatutDossier IS NULL AND a.DateFermetureDossier IS NULL THEN NULL
	ELSE 'Actif'
END AS IndiceInactif
FROM BDIP_Absence a
