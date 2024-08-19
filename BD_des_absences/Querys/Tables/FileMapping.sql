CREATE TABLE FileMapping (
    TableName NVARCHAR(128),
    FilePath NVARCHAR(260)
);

TRUNCATE TABLE FileMapping

INSERT INTO FileMapping (TableName, FilePath) VALUES ('BDIP_Absence', 'D:\INFOCENTRE\RH_DB\EXE\CSV\Absence.csv');
INSERT INTO FileMapping (TableName, FilePath) VALUES ('BDIP_AbsenteismeEleve', 'D:\INFOCENTRE\RH_DB\EXE\CSV\Absenteisme_eleve.csv');
INSERT INTO FileMapping (TableName, FilePath) VALUES ('BDIP_ConsequenceAbsence', 'D:\INFOCENTRE\RH_DB\EXE\CSV\Consequence_Absence.csv');
INSERT INTO FileMapping (TableName, FilePath) VALUES ('BDIP_ConsequenceRapportAccident', 'D:\INFOCENTRE\RH_DB\EXE\CSV\Consequence_Rapport_accident.csv');
INSERT INTO FileMapping (TableName, FilePath) VALUES ('BDIP_DeclarationIncidentAccident', 'D:\INFOCENTRE\RH_DB\EXE\CSV\Declaration_incident_Accident.csv');
INSERT INTO FileMapping (TableName, FilePath) VALUES ('BDIP_DiagnosticAbsence', 'D:\INFOCENTRE\RH_DB\EXE\CSV\Diagnostic_Absence.csv');
INSERT INTO FileMapping (TableName, FilePath) VALUES ('BDIP_DiagnosticRapportAccident', 'D:\INFOCENTRE\RH_DB\EXE\CSV\Diagnostic_Rapport_accident.csv');
INSERT INTO FileMapping (TableName, FilePath) VALUES ('BDIP_EvaluationMedicale', 'D:\INFOCENTRE\RH_DB\EXE\CSV\Evaluation_medicale.csv');
INSERT INTO FileMapping (TableName, FilePath) VALUES ('BDIP_LimitationFonctionnelle', 'D:\INFOCENTRE\RH_DB\EXE\CSV\Limitation_fonctionnelle.csv');
INSERT INTO FileMapping (TableName, FilePath) VALUES ('BDIP_PMSD', 'D:\INFOCENTRE\RH_DB\EXE\CSV\PMSD.csv');
INSERT INTO FileMapping (TableName, FilePath) VALUES ('BDIP_RapportAccident', 'D:\INFOCENTRE\RH_DB\EXE\CSV\Rapport_accident.csv');