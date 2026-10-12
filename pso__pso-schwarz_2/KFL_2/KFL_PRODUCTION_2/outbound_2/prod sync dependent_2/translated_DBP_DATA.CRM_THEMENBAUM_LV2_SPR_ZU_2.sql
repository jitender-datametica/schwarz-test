CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_themenbaum_lv2_spr_zu_2 (
crm_themenbaum_lv2_id STRING(36) COLLATE 'und:ci' NOT NULL OPTIONS(description='Themenbaum Id'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
ebene_1_id INTEGER NOT NULL OPTIONS(description='Für DWH BSI Mapping 2. Stuffe (Entspricht GEKU Bereich)'),
ebene_2_id INTEGER NOT NULL OPTIONS(description='Für DWH BSI Mapping 3. Stuffe (Entspricht GEKU Grund)'),
ebene_3_id INTEGER NOT NULL OPTIONS(description='Für DWH BSI Mapping 1. Stuffe Entspricht GEKU DWH Artikel_2)'),
ebene_1_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Text für key_level_1 / Text für GEKU Bereich'),
ebene_2_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Name des aktuellen Themnbaumlevels / Text für GEKU Grund'),
ebene_3_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Text für key_level_2 / Text enstpricht GEKU DWH Artikel_2'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (spr_id, ebene_1_id, ebene_2_id, ebene_3_id) NOT ENFORCED
) OPTIONS(description='KMR - Enthält Themenbaumeiträge der Ebene 2 (unterste Granularitätsebene) - MS Dynamics CRM');