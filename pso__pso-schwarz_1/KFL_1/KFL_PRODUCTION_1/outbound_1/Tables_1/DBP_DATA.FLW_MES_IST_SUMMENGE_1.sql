--==============================================================
-- Table: flw_mes_ist_summenge_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_ist_summenge_1
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:21:02
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_mes_ist_summenge_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
flw_werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='plant where the meat is processed'),
flw_arbeitsplatz_id STRING(8) NOT NULL OPTIONS(description='identifier of the working place in production line'),
schicht_id STRING(32) NOT NULL OPTIONS(description='identifier of the shift in the production line'),
mes_prodmengetyp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='type of the step of processing meat'),
dat_prod DATE NOT NULL OPTIONS(description='date of production'),
ist_menge BIGNUMERIC(38,0) OPTIONS(description='Number of  goods produced'),
ist_einh STRING(2) OPTIONS(description='measurement unit_1 for produced goods (ex ST = Stück)'),
datzeit_aenderung DATETIME OPTIONS(description='Records update time in plant\'s timezone '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, flw_werk_id, flw_arbeitsplatz_id, schicht_id, mes_prodmengetyp_id, dat_prod) NOT ENFORCED
)
OPTIONS(description='table describes the production process within a shift on a location_1 ( working place in procuction line)');