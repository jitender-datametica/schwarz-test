--==============================================================
-- Table: flw_kalk_variante_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_kalk_variante_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_kalk_variante_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
kalk_variante_id STRING(4) NOT NULL
OPTIONS(description='Kalkulationsvariante aus klvar. Schlüssel, der festlegt, wie eine_1 Kalkulation durchgeführt und bewertet wird (Kalkulation mit oder ohne Mengengerüst).'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
kalk_variante_bez STRING(30) DEFAULT ' ' NOT NULL OPTIONS(description='Bezeichnung der Kalkulationsvariante aus txklv'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kalk_variante_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW - Sprachabhängige Bezeichnung der Kalkulationsvariante - SAP P21 TCK04');