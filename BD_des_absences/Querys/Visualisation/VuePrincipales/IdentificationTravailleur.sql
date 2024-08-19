CREATE VIEW IdentificationTravailleur AS
SELECT DISTINCT ei.Matri AS Matricule, e.Nom, e.Prenom, CAST(FORMAT(ei.UniteAdmCode, '000000') AS NVARCHAR(6)) + ' - ' + ua.Descr_Abrege AS UniteAdministative,
RIGHT(REPLICATE('0', 2) + ua.DireCode, 2) + ' - ' + d.Descr_Abrege AS Direction, CAST(ei.Temp_Code AS NVARCHAR) + ' - ' + te.Description AS TitreEmploi,
crt.SOUSCAT_MSSS + ' - ' + crt.DESCRIPTION_MSSS AS RegroupementTE, s.Description_Longue AS Site,
CASE
	WHEN ei.Statut = '1' THEN 'TC'
	WHEN ei.Statut = '2' THEN 'TCT'
	WHEN ei.Statut = '3' THEN 'TP'
	WHEN ei.Statut = '4' THEN 'TPT'
END AS Statut, cs.SYND_GREVE
FROM InfocentreNormalisation.RH.Empl_Inter ei

LEFT JOIN InfocentreNormalisation.RH.Employe e ON ei.Matri = e.Matri
LEFT JOIN InfocentreNormalisation.RH.Unite_Administ ua ON ei.UniteAdmCode = ua.UniteAdmCode
LEFT JOIN InfocentreNormalisation.RH.Direction d ON ua.DireCode = d.DireCode
LEFT JOIN InfocentreNormalisation.RH.Titre_Emploi te ON ei.Temp_Code = te.Temp_Code
LEFT JOIN InfocentreNormalisation.RH.Site s ON ua.SiteCode = s.SiteCode
LEFT JOIN InfocentreConfiguration.RH.TB_RH_ConfigRegroupementTE crt ON ei.Temp_Code = crt.TEMP_CODE
LEFT JOIN InfocentreConfiguration.RH.TB_RH_ConfigSyndicat cs ON e.SyndCode = cs.SYND_CODE