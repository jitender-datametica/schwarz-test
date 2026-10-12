--==============================================================
-- Table: in_instandhaltung_leistungsart_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_instandhaltung_leistungsart_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_instandhaltung_leistungsart_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
instandhaltung_leistungsart_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Instandhaltungs-Leistungsart aus dem Quellfeld ilart'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
instandhaltung_leistungsart_bez STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='LIS - Sprachtabelle Leistungsarten der Instandhaltung');