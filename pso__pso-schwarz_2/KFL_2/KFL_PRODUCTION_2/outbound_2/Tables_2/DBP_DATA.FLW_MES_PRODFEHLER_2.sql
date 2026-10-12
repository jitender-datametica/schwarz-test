--==============================================================
-- Table: flw_mes_prodfehler_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_prodfehler_2
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:03:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_mes_prodfehler_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
schicht_id STRING(32) NOT NULL OPTIONS(description='identifier of the shift in the production line'),
mes_prodzeittyp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='type of the step of processing meat'),
fehler_katalog_id STRING(1) NOT NULL
OPTIONS(description='Basic catalogue of faults - random letter taken by business to identify'),
fehler_code_gruppe_id STRING(9) NOT NULL
OPTIONS(description='group identifier of the code of a fault happened during production'),
fehler_code_id STRING(4) NOT NULL OPTIONS(description='code of a fault happened during production'),
datzeit_anfang TIMESTAMP OPTIONS(description='timestamp whet the fault started'),
datzeit_ende TIMESTAMP OPTIONS(description='timestamp when the fault ended'),
ist_fehler_dauer BIGNUMERIC(38,5) OPTIONS(description='duration of the fault'),
ist_fehler_einh STRING(1) OPTIONS(description='Fault duration type (ex  S = seconds)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, schicht_id, mes_prodzeittyp_id, fehler_katalog_id, fehler_code_gruppe_id, fehler_code_id)
NOT ENFORCED
) OPTIONS(description='table is about a Basic catalogue of faults in production line');