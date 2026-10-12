--==============================================================
-- Table: flw_mes_schichtkap_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_schichtkap_2
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:04:02
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_mes_schichtkap_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
schicht_id STRING(32) NOT NULL OPTIONS(description='identifier of the shift in the production line'),
kapatyp_id STRING(5) NOT NULL
OPTIONS(description='capacity of machine type; FLM Fleischwarenmaschine [only this one is used]'),
schichttyp_id STRING(2) NOT NULL OPTIONS(description='identifier of the shift type in the production line'),
ngrad_angabe INTEGER NOT NULL OPTIONS(description='capacity in percentage (0-100)'),
kapa_dauer BIGNUMERIC(38,5) OPTIONS(description='duration of capacity  measurement'),
kapa_einh STRING(1) OPTIONS(description='capacity duration type for example in seconds: S'),
mengen_anz BIGNUMERIC(38,0) OPTIONS(description='number/quantity producd for duration'),
dat_schicht DATE OPTIONS(description='date of shift'),
pause_dauer_sec BIGNUMERIC(38,5) OPTIONS(description='break/pause duration in seconds'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, schicht_id, kapatyp_id, schichttyp_id) NOT ENFORCED
)
OPTIONS(description='table cotains data for the availabilty of the capacity of a specific machine type (in meat processing)');