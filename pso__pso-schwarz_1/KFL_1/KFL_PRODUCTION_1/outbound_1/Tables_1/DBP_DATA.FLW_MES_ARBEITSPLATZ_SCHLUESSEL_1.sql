--==============================================================
-- Table: flw_mes_arbeitsplatz_schluessel_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_arbeitsplatz_schluessel_1
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:31:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_mes_arbeitsplatz_schluessel_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
flw_arbeitsplatzschluessel_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In order to get the name of the work place we have to enter it in the table CRHD_1 and then search for the text with the object ID in the table CRTX and yes, here we only need the KTEXT.'),
flw_arbeitsplatz_id STRING(8) NOT NULL OPTIONS(description='identifier of the working place in production line'),
flw_werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='plant where the meat is processed'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, flw_arbeitsplatzschluessel_id) NOT ENFORCED
) OPTIONS(description='this table contains data for  the working place allocation');