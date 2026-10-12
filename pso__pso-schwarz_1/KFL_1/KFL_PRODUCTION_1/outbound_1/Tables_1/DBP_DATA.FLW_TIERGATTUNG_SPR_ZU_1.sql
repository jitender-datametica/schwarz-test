--==============================================================
-- Table: flw_tiergattung_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_tiergattung_spr_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_tiergattung_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
tiergattung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID der Tiergattung, z.Bsp 1 = Schwein aus tgtky'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
tiergattung_bez STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung der Tiergattung (Schwein, Rind,..) aus txt40'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, tiergattung_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW - Sprachabhängige Bezeichnung der Tiergattung aus spmeat_tmtgt');