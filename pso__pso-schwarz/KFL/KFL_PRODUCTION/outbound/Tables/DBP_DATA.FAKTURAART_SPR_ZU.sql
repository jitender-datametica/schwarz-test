--==============================================================
-- Table: fakturaart_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fakturaart_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fakturaart_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
fakturaart_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Klassifiziert verschiedene Arten von Fakturabelegen, die eine unterschiedliche Verarbeitung durch das System erfordern.'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.'),
fakturaart_bez STRING(20) COLLATE 'und:ci' DEFAULT '                    ' NOT NULL
OPTIONS(description='Sprachabhängiger Kurztext für die Arten der Fakturabelege.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
)
OPTIONS(description='TP408_LVS - In dieser Tabelle sind die sprachabhängigen Kurztexte für die Arten der Fakturabelege enthalten. - MULTISET');