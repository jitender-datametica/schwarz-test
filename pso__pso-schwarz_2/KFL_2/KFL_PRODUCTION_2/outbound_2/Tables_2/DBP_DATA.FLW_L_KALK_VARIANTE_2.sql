--==============================================================
-- Table: flw_l_kalk_variante_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_kalk_variante_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_kalk_variante_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
kalk_variante_id STRING(4) NOT NULL
OPTIONS(description='Kalkulationsvariante aus klvar. Schlüssel, der festlegt, wie eine_2 Kalkulation durchgeführt und bewertet wird (Kalkulation mit oder ohne Mengengerüst).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kalk_variante_id) NOT ENFORCED
) OPTIONS(description='FLW - Lookup der Kalkulationsvariante - SAP P21 TCK04');