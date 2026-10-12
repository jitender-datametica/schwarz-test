--==============================================================
-- Table: flw_l_bew_grund_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_bew_grund_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_bew_grund_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
flw_bew_grund_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Grund der Bewegung (PDAO) aus SAP Quelle T157E.GRUND (Ursprung /SPDGS/PDAOE1.ZZGRUND)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, flw_bew_grund_id) NOT ENFORCED
) OPTIONS(description='FLW - Lookuptabelle Grund der Bewegung');