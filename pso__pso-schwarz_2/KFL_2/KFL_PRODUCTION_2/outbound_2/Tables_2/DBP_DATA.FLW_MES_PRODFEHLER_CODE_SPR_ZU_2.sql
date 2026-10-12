--==============================================================
-- Table: flw_mes_prodfehler_code_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_prodfehler_code_spr_zu_2
   generated from Powerdesigner on Donnerstag, 24. November 2022 14:04:22
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_mes_prodfehler_code_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
fehler_code_id STRING(4) NOT NULL OPTIONS(description='code of a fault happened during production'),
fehler_code_gruppe_id STRING(9) NOT NULL
OPTIONS(description='group identifier of the code of a fault happened during production'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
fehler_code_bez STRING(500) NOT NULL
OPTIONS(description='Text about the code example: Wartung, Reinigung, Folienriss, what shows the faults in production'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, fehler_code_id, fehler_code_gruppe_id, spr_id) NOT ENFORCED
) OPTIONS(description='this table is about the fault code and description of the code');