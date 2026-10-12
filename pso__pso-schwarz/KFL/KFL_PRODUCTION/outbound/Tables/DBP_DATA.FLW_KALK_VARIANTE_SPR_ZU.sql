--==============================================================
-- Table: flw_kalk_variante_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_kalk_variante_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_kalk_variante_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
kalk_variante_id STRING(4) NOT NULL
OPTIONS(description='Kalkulationsvariante aus klvar. Schlüssel, der festlegt, wie eine Kalkulation durchgeführt und bewertet wird (Kalkulation mit oder ohne Mengengerüst).'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
kalk_variante_bez STRING(30) DEFAULT ' ' NOT NULL OPTIONS(description='Bezeichnung der Kalkulationsvariante aus txklv'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kalk_variante_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW - Sprachabhängige Bezeichnung der Kalkulationsvariante - SAP P21 TCK04');