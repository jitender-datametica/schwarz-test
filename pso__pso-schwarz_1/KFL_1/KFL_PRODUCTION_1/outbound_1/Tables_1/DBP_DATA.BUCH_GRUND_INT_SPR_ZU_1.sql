--==============================================================
-- Table: buch_grund_int_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: buch_grund_int_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.buch_grund_int_spr_zu_1 (
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
buch_grund_int_id STRING(3) NOT NULL
OPTIONS(description='Eindeutiger Schluessel fuer die internen Buchungsgründe der Rechnungen auf Kopf- und Positionsebene.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.'),
buch_grund_int_bez STRING(40) OPTIONS(description='Sprachabhängige Kurzbezeichnungen der internen Buchungsgründe.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (system_id, mandant_id, buch_grund_int_id, spr_id) NOT ENFORCED
)
OPTIONS(description='RPW - Diese Tabelle enthält die sprachabhängigen Kurzbezeichnungen für die internen Buchungsgründe. Für jede DWH Sprache = 1 wird ein Eintrag angelegt.');