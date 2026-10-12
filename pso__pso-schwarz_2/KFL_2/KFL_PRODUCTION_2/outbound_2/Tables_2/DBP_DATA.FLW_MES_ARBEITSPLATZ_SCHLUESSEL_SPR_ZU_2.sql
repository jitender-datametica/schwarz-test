--==============================================================
-- Table: flw_mes_arbeitsplatz_schluessel_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_arbeitsplatz_schluessel_spr_zu_2
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:32:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_mes_arbeitsplatz_schluessel_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
flw_arbeitsplatzschluessel_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In order to get the name of the work place we have to enter it in the table CRHD_2 and then search for the text with the object ID in the table CRTX and yes, here we only need the KTEXT.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige Kennzeichnung der Sprache'),
flw_arbeitsplatz_bez STRING(500) NOT NULL OPTIONS(description='Description of production line'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, flw_arbeitsplatzschluessel_id, spr_id, flw_arbeitsplatz_bez) NOT ENFORCED
) OPTIONS(description='this table contains translation data for  the working place allocation');