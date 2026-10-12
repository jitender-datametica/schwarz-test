--==============================================================
-- Table: flw_mes_schicht
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_schicht
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:22:35
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_mes_schicht (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
schicht_id STRING(32) NOT NULL OPTIONS(description='identifier of the shift in the production line'),
schichttyp_id STRING(2) NOT NULL OPTIONS(description='identifier of the shift type in the production line'),
datzeit_schicht_anfang TIMESTAMP NOT NULL OPTIONS(description='timestamp when shift starts'),
datzeit_schicht_ende TIMESTAMP NOT NULL OPTIONS(description='timestamp when the shift ends'),
zeit_schicht_beginn TIME NOT NULL OPTIONS(description='time of the day when the shift starts'),
zeit_schicht_ende TIME NOT NULL OPTIONS(description='time of the day when the shift ends'),
flw_werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='plant where the meat is processed'),
flw_arbeitsplatz_id STRING(8) OPTIONS(description='identifier of the working place in production line'),
dat_schicht DATE OPTIONS(description='date of shift'),
schicht_dauer BIGNUMERIC(38,5) OPTIONS(description='shift duration'),
schicht_dauer_einh STRING(1) OPTIONS(description='measument unit of shift duration '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, schicht_id, schichttyp_id, datzeit_schicht_anfang, datzeit_schicht_ende) NOT ENFORCED
) OPTIONS(description='table contains the shifts in production line for employees');