CREATE VIEW CodeDePaiePMSD AS
SELECT p.R�gime, cra.Cons�quence,
CASE
	WHEN p.R�gime = 'Maternit� sans danger' AND cra.Cons�quence = 'PMSD - R�affectation temporaire' THEN 'Heures travaill�es: ReaTE' + char(13) + char(10) + 'Heures non travaill�es: RetPA'
	WHEN p.R�gime = 'Maternit� sans danger' AND cra.Cons�quence = 'PMSD - Retrait pr�ventif' THEN '5 premiers jours selon l''horaire pr�vu: RP5jr' + char(13) + char(10) + '14 jours suivants: RP14j' + char(13) + char(10) + '� partir de la 15e journ�e: Rprev'
	ELSE NULL
END AS CodeDePaie
FROM BDIP_PMSD p

LEFT JOIN BDIP_ConsequenceRapportAccident cra ON p.Num�ro�v�nement = cra.Num�ro�v�nementParent