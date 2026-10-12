--==============================================================
-- Table: gp_fehlerart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gp_fehlerart_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gp_fehlerart_spr_zu_1 (
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.'),
gp_fehlerart_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutiger Schlüssel für die Fehlerarten eines Lieferanten z. B. Prieis- oder Konditionsfehler.'),
gp_fehlerart_bez STRING(40) COLLATE 'und:ci'
OPTIONS(description='Sprachabhängige Kurzbezeichnung der Lieferanten-Fehlerarten. Jeder Eintrag wird pro DWH Sprache = 1 hinterlegt.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (system_id, mandant_id, spr_id) NOT ENFORCED
)
OPTIONS(description='RPW - Diese Tabelle enthält die sprachabhängigen Kurzbezeichnungen der Fehlerarten eines Lieferanten. Pro DWH Sprache = 1 wird ein Eintrag hinterlegt.');