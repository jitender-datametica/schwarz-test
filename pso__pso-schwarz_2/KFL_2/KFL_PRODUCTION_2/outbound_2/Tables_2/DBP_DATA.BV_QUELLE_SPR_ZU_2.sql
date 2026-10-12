--==============================================================
-- Table: bv_quelle_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bv_quelle_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:16 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.bv_quelle_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2     '),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprachschlüssel'),
bv_quelle_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='BV Quelle'),
bv_quelle_bez STRING(60) OPTIONS(description='BV Quelle Bez.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, bv_quelle_id) NOT ENFORCED
) OPTIONS(description='Bestellvorschlag Quelle Texte (DD07V Domname ZSCM_DC_OP_SOURCE)');