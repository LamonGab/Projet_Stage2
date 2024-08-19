CREATE VIEW LimitationFonctionnelle AS
SELECT DISTINCT lf.Matricule, lf.Permanente, lf.[Date de d�but], lf.[Date de fin], lf.[L'employ�(e) est vis�(e) par un processus d'accommodement],
lf.[Statut de la demande (accommodement)], lf.Incapacit�, lf.[Limitation fonctionnelle]

FROM BD_Limitation_fonctionnelle lf

WHERE lf.[Date de fin] IS NULL OR lf.[Date de fin] >= GETDATE()