--==============================================================
-- Table: bestellart_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bestellart_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.bestellart_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant_2 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
bestellart_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.'),
bestellart_bez STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Dieses Attribut enthält die Kurztexte der Bestellarten.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
)
OPTIONS(description='TP408_LVS - In dieser Tabelle sind die sprachabhängigen Kurztexte für die Arten der Bestellungen enthalten - MULTISET.');