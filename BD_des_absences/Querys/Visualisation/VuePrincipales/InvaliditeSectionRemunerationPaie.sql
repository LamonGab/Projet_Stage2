CREATE VIEW InvaliditeSectionRemunerationPaie AS
SELECT fec.Carence, fec.Moyenne, fec.DtPFin
FROM BDIP_Absence a

LEFT JOIN InfocentreNormalisation.RH.FactEmplConge fec ON a.Matricule = fec.Matricule
LEFT JOIN InfocentreNormalisation.RH.DimConge dc ON fec.CongeCode = dc.TypeConge

WHERE fec.DtHrAnnulation IS NULL AND dc.TypeConge <>2 AND fec.DtDeb <= GETDATE() AND (fec.DtFin IS NULL OR fec.DtFin >= GETDATE())