--==============================================================
-- Table: immo_l_we_region
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_l_we_region
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_l_we_region (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
we_region STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Region (nicht Bundesland) einer Wirtschaftseinheit'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='IMMO - Lookup-Tabelle für WE-Region - SAP Baustein ZBI_RE_DATA_BE_CI_DATA');