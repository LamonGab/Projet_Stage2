CREATE VIEW AbsenteismeEleve AS
SELECT DISTINCT ae.Matricule, ae.[Responsable du dossier], ae.[Statut du dossier]

FROM BD_Absenteisme_eleve ae

WHERE ae.[Statut du dossier] <>'Fermé'