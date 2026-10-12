--==============================================================
-- Table: flw_l_bew_ziel_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_bew_ziel_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_bew_ziel_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
flw_ziel_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Ziel (PDAO) aus SAP Quelle /SPDGS/PDAOE1.ZZFWZIEL'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, flw_ziel_id) NOT ENFORCED
) OPTIONS(description='FLW - Lookuptabelle Ziel (PDAO)');