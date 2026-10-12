--==============================================================
-- Table: flw_l_zerlege_gruppe
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_zerlege_gruppe
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_zerlege_gruppe (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH. In der Regel länderbezogen'),
zerlege_gruppe_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Zerlegegruppe aus zgrup.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, zerlege_gruppe_id) NOT ENFORCED
) OPTIONS(description='FLW - Lookup Tabelle der Zerlege_Gruppen aus spmeat_tzgrpt');