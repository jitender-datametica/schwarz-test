--==============================================================
-- Table: anlage_klasse_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: anlage_klasse_spr_zu_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.anlage_klasse_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
anlage_klasse_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der Anlageklasse aus der Quelle anlkl. Als Char-Feld mit führenden Nullen gespeichert'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
anlage_klasse_bez_kurz STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kurzbezeichnung der Anlageklasse aus txt20'),
anlage_klasse_bez STRING(50) COLLATE 'und:ci' NOT NULL OPTIONS(description='Langbezeichnung der Anlageklasse aus txt50'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='IMS - Sprachabhängige Bezeichnung der Anlageklasse');