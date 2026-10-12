--==============================================================
-- Table: in_leistungsart_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_leistungsart_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_leistungsart_spr_zu_2 (
co_leistungsart_id STRING(7) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der CO-Leistungsart aus der Quelle lstar'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der DWH-Sprache, z.B. 22 ist deutsch'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
co_leistungsart_bez_kurz STRING(20) COLLATE 'und:ci'
OPTIONS(description='Kurzbezeichnung der CO-Leistungsart aus ktext'),
co_leistungsart_bez_lang STRING(40) COLLATE 'und:ci'
OPTIONS(description='Langbezeichnung der CO-Leistungsart aus ltext'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='LIS - Sprachabhängige Bezeichnungen  der CO-Leistungsarten aus SAP Industrie cslt');