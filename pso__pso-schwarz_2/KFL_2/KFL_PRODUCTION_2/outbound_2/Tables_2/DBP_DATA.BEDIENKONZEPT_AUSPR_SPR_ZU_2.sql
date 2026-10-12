--==============================================================
-- Table: bedienkonzept_auspr_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bedienkonzept_auspr_spr_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.bedienkonzept_auspr_spr_zu_2 (
bedienkonzept_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Die bedienkonzept_id wird im DWH vergeben'),
bedienkonzept_auspr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Ausprägung des Bedienkonzepts'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr_2 fuer jede DWH Sprache = 1.'),
bedienkonzept_auspr_bez STRING(50) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung der Ausprägung des Bedienkonzepts, z.Bsp. Bedienung, separate Leergutannahme'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (bedienkonzept_id, bedienkonzept_auspr_id, spr_id) NOT ENFORCED
) OPTIONS(description='RPM -  Sprachabhängige Bezeichnung der Ausprägung der Bedienkonzepte');