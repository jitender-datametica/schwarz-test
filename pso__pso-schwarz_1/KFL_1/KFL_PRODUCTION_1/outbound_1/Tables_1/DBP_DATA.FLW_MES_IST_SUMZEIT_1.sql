--==============================================================
-- Table: flw_mes_ist_sumzeit_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_ist_sumzeit_1
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:21:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_mes_ist_sumzeit_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
flw_werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='plant where the meat is processed'),
flw_arbeitsplatz_id STRING(8) NOT NULL OPTIONS(description='identifier of the working place in production line'),
schicht_id STRING(32) NOT NULL OPTIONS(description='identifier of the shift in the production line'),
mes_prodmengetyp_gruppe STRING(4) NOT NULL OPTIONS(description='productiontype description: PROD;RUES'),
mes_prodzeittyp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='type of the step of processing meat'),
dat_ist_prod DATE OPTIONS(description='date of the production'),
ist_prod_dauer BIGNUMERIC(38,5) OPTIONS(description='duration of production uptime'),
ist_prod_einh STRING(1) OPTIONS(description='measument unit_1 of duration uptime'),
datzeit_aenderung DATETIME OPTIONS(description='Records update time in plant\'s timezone '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, flw_werk_id, schicht_id, flw_arbeitsplatz_id, mes_prodzeittyp_id, mes_prodmengetyp_gruppe)
NOT ENFORCED
) OPTIONS(description='this table contains data for actual prodcution uptime ');