--==============================================================
-- Table: flw_mes_prodfehler_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_prodfehler_spr_zu_2
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:20:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_mes_prodfehler_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
mes_prodzeittyp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='type of the step of processing meat'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige Kennzeichnung der Sprache'),
mes_prodzeittyp_bez STRING(255) OPTIONS(description='description of the type of steps in meat processing '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, mes_prodzeittyp_id, spr_id) NOT ENFORCED
) OPTIONS(description='translation table for type of steps in meat processing ');