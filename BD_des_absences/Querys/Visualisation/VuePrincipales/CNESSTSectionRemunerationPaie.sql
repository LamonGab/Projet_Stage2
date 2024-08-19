CREATE VIEW CNESSTSectionRemunerationPaie AS
SELECT fec.Moyenne, fec.DtPfin
FROM BDIP_Absence a
LEFT JOIN InfocentreNormalisation.RH.FactEmplConge fec ON a.Matricule = fec.Matricule
LEFT JOIN InfocentreNormalisation.RH.DimConge dc ON fec.CongeCode = dc.CongeCode

WHERE fec.DtHrAnnulation IS NULL AND dc.TypeConge <>2 AND fec.DtDeb <= GETDATE() AND (fec.DtFin IS NULL OR fec.DtFin >= GETDATE())