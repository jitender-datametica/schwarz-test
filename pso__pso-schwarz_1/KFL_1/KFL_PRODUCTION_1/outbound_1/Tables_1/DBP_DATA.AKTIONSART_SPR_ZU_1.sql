--==============================================================
-- Table: aktionsart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktionsart_spr_zu_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aktionsart_spr_zu_1 (
aktionsart_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kommt aus der Tabelle WAKH_1            Angabe, die eine_1 Aktion_1 nach technischen Gesichtspunkten klassifiziert.            Die Aktionsart umfaßt folgende Werte:            ZF: 	Food            ZFI: 	Fisch            ZFL: 	Fleisch            ZNF:	Nonfood            ZWG:	Wurst und Geflügel            '),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache. Ganzzahliger Wert > 0'),
aktionsart_bez STRING(18) COLLATE 'und:ci'
OPTIONS(description='Kommt aus der SAP Tabelle TWAAT            Langbezeichnung der Aktionsart'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='Enthält die Bezeichnungen für Aktionsarten             Diese Tabelle ist noch nicht realisiert');