--==============================================================
-- Table: bestaetigung_typ_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bestaetigung_typ_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.bestaetigung_typ_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant_2 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
bestaetigung_typ_id STRING(2) NOT NULL OPTIONS(description='Schlüssel für die Art_2 der Bestätigung.'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.'),
bestaetigung_typ_bez STRING(20) DEFAULT ' ' NOT NULL
OPTIONS(description='Sprachabhängiger Kurztext für die Art_2 der Bestätigungen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bestaetigung_typ_id, spr_id) NOT ENFORCED
)
OPTIONS(description='TP408_LVS - In dieser Tabelle sind die sprachabhängigen Kurztexte für die Typen der Bestellbestätigung enthalten. - MULTISET');