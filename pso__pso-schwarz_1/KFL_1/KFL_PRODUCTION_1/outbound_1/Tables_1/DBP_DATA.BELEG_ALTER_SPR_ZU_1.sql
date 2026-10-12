--==============================================================
-- Table: beleg_alter_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: beleg_alter_spr_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.beleg_alter_spr_zu_1 (
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.'),
beleg_alter_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutiger Schlüssel für die verschiedenen Kategorien des Alters eines Belegs.'),
beleg_alter_bez STRING(40) COLLATE 'und:ci'
OPTIONS(description='Sprachabhängige Kurzbezeichnung für die Kategorien des Belegalters. Für jede DWH Sprache = 1 wird ein Eintrag angelegt.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (system_id, mandant_id, spr_id, beleg_alter_id) NOT ENFORCED
)
OPTIONS(description='RPW - Diese Tabelle enthält die sprachabhängigen Kurzbezeichnungen für die Kategorien des Belegalters. Für jede DWH Sprache = 1 wird ein Eintrag angelegt.');