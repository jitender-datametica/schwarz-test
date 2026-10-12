--==============================================================
-- Table: belegart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belegart_spr_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.belegart_spr_zu_1 (
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.'),
belegart_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutiger Schluessel fuer die Belegarten bei den Eingangsrechnungen (z. B. Rechnung, Gutschrit, Bela, Rbela, usw.). Referenz zu der Tabelle l_belegart_1;'),
belegart_bez STRING(40) COLLATE 'und:ci'
OPTIONS(description='Sprachabhaengige Bezeichnung fuer die Belegarten. Fuer jede DWH Sprache wird ein Eintrag angelegt. Detaultwert ist die deutsche Bezeichnung.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (system_id, mandant_id, spr_id) NOT ENFORCED
)
OPTIONS(description='RPW - Sprachabhaengige Kurzbezeichnungen der Belegarten. Fuer jede DWH Sprache wird eine_1 Eintrag angelegt. Standard ist die deutsche Bezeichnung. Quelle fuer diese Daten ist die SAP Tabelle T003T.');