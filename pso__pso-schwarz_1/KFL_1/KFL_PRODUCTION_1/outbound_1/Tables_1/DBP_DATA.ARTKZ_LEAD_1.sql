--==============================================================
-- Table: artkz_lead_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artkz_lead_1
   generated from Powerdesigner on Sonntag, 4. Februar 2024 11:29:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artkz_lead_1 (
lead_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelkennzeichen leader 1 ist Leader, sonst 0'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
lead_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung Leader'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (lead_id, mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookuptabelle des Artikelkennzeichens Leaderartikel');