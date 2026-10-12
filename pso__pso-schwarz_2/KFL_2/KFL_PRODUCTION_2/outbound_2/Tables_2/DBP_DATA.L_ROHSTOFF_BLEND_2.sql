--==============================================================
-- Table: l_rohstoff_blend_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_rohstoff_blend_2
   generated from Powerdesigner on Mittwoch, 1. Oktober 2025 11:03:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_rohstoff_blend_2 (
rohstoff_blend_kfl_cd STRING(100) NOT NULL OPTIONS(description='Kaufland interne Code des Blends.'),
rohstoff_blend_kfl_name STRING(100) OPTIONS(description='Kaufland interne Name des Blends.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (rohstoff_blend_kfl_cd) NOT ENFORCED
)
OPTIONS(description='Lookup Tabelle für Kaufland definierte Blend : gemischtes Mineralölprodukt, das aus verschiedene Rohstoffe entsteht.');