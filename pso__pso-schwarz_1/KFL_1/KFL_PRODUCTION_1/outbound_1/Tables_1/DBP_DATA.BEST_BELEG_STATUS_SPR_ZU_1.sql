--==============================================================
-- Table: best_beleg_status_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: best_beleg_status_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.best_beleg_status_spr_zu_1 (
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
best_beleg_status_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutiger Schluessel zur Identifikation eines Belegstatus der Bestellung.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprache im DWH'),
best_beleg_status_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung für den Bestellbelegstatus'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (system_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='RPW - Sprachabhängige Kurzbezeichnungen  für den Status_1 eines Bestellbeleges. Für jede DWH Sprache = 1 wird ein Eintrag per Initialisierung hinterlegt.');