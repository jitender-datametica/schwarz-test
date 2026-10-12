--==============================================================
-- Table: flw_herkunft_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_herkunft_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_herkunft_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
herkunft_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Herkunft'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
herkunft_bez STRING(40) NOT NULL OPTIONS(description='Bezichnung der Herkunft'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, herkunft_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW - Sprach-Tabelle für die Herkunft - SAP P21 -/SPMEAT/ORIGIN');