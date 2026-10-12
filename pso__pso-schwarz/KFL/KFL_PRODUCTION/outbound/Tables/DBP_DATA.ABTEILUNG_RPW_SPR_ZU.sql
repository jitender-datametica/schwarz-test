--==============================================================
-- Table: abteilung_rpw_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abteilung_rpw_spr_zu
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.abteilung_rpw_spr_zu (
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
abteilung_id STRING(20) NOT NULL
OPTIONS(description='Eindeutiger Fachschluessel zur Referenzierung einer Abteilung aus der DWH Tabelle l_abteilung_rpw.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr fuer jede DWH Sprache = 1;'),
abteilung_rpw_bez STRING(40)
OPTIONS(description='Sprachabhaengige Bezeichnung fuer die RPW Abteillung. Es wird fuer jede DWH Sprache = 1 ein Eintrag erstellt.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (system_id, mandant_id, abteilung_id, spr_id) NOT ENFORCED
)
OPTIONS(description='RPW - Sprachabhaengige Bezeichnung der RPW Abteilungen. Es wird fuer jede DWH Sprache = 1 ein Eintrag hinterlegt. Defaultwert ist die deutsche Bezeichnung.');