--==============================================================
-- Table: crm_l_themenbaum_lv2_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_themenbaum_lv2_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_l_themenbaum_lv2_2 (
crm_themenbaum_lv2_id STRING(36) COLLATE 'und:ci' NOT NULL OPTIONS(description='Themenbaum Id'),
crm_themenbaum_lv1_id STRING(36) COLLATE 'und:ci'
OPTIONS(description='Zugehörigkeit zu einem höheren Themnbaum Eintrag'),
ebene_1_id BIGNUMERIC(38,0) OPTIONS(description='Für DWH BSI Mapping 2. Stuffe (Entspricht GEKU Bereich)'),
ebene_2_id BIGNUMERIC(38,0) OPTIONS(description='Für DWH BSI Mapping 3. Stuffe (Entspricht GEKU Grund)'),
ebene_3_id BIGNUMERIC(38,0) OPTIONS(description='Für DWH BSI Mapping 1. Stuffe Entspricht GEKU DWH Artikel_2)'),
number_level_1 STRING(15) COLLATE 'und:ci' OPTIONS(description='number_level_1'),
number_level_2 STRING(15) COLLATE 'und:ci' OPTIONS(description='number_level_2'),
number_level_3 STRING(15) COLLATE 'und:ci' OPTIONS(description='number_level_3'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='KMR - Enthält Themenbaumeiträge der Ebene 2 (unterste Granularitätsebene) - MS Dynamics CRM');