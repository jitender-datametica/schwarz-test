--==============================================================
-- Table: achsgruppe_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: achsgruppe_spr_zu_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.achsgruppe_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
achsgruppe_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gruppierung von Regalachsen aus achsgrid'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprachschlüssel im DWH'),
achsgruppe_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Achsgruppe aus achsgrt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, achsgruppe_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - WPL - WaSA Achsgruppen Bezeichnungen');