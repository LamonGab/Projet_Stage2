CREATE VIEW InvaliditeSectionRemuneration AS
SELECT fec.Carence, fec.Moyenne
FROM BDIP_Absence a

LEFT JOIN InfocentreNormalisation.RH.FactEmplConge fec ON a.Matricule = fec.Matricule

WHERE fec.DtHrAnnulation IS NULL AND fec.DtDeb <= GETDATE() AND (fec.DtFin IS NULL OR fec.DtFin >= GETDATE())