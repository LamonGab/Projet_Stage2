CREATE TABLE Modifications (
	NomTable NVARCHAR(50),
	NuméroÉvénement INT,
	DateHeureModification DATETIME DEFAULT GETDATE()
);