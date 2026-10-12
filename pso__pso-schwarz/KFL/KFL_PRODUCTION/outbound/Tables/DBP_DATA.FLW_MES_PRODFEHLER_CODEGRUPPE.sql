--==============================================================
-- Table: flw_mes_prodfehler_codegruppe
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_prodfehler_codegruppe
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:00:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_mes_prodfehler_codegruppe (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
fehler_katalog_id STRING(1) NOT NULL
OPTIONS(description='Basic catalogue of faults - random letter taken by business to identify'),
fehler_code_gruppe_id STRING(9) NOT NULL
OPTIONS(description='group identifier of the code of a fault happened during production'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, fehler_code_gruppe_id) NOT ENFORCED
) OPTIONS(description='this table is about the fault code group and description of code group');