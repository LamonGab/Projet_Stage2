CREATE VIEW CodeDePaiePMSD AS
SELECT p.Régime, cra.Conséquence,
CASE
	WHEN p.Régime = 'Maternité sans danger' AND cra.Conséquence = 'PMSD - Réaffectation temporaire' THEN 'Heures travaillées: ReaTE' + char(13) + char(10) + 'Heures non travaillées: RetPA'
	WHEN p.Régime = 'Maternité sans danger' AND cra.Conséquence = 'PMSD - Retrait préventif' THEN '5 premiers jours selon l''horaire prévu: RP5jr' + char(13) + char(10) + '14 jours suivants: RP14j' + char(13) + char(10) + 'À partir de la 15e journée: Rprev'
	ELSE NULL
END AS CodeDePaie
FROM BDIP_PMSD p

LEFT JOIN BDIP_ConsequenceRapportAccident cra ON p.NuméroÉvénement = cra.NuméroÉvénementParent