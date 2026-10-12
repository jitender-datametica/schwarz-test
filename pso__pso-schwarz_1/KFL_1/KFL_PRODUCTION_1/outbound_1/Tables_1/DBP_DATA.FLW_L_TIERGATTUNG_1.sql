--==============================================================
-- Table: flw_l_tiergattung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_tiergattung_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_tiergattung_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
tiergattung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID der Tiergattung, z.Bsp 1 = Schwein aus tgtky'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, tiergattung_id) NOT ENFORCED
) OPTIONS(description='FLW - Lookup Tabelle der Tiergattung aus spmeat_tmtgt');