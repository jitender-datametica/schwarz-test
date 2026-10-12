/* --------------------------------------------------------------------------------
   DDL for table: t_campaign_element_plan_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_campaign_element_plan_1 (
campaign_elem_plan_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a plan (sales_1 or activity plan) that is defined for a certain campaign element.'),
src_srcinst_cd STRING(2) COLLATE 'und:ci'
OPTIONS(description='techn. identifier part of the campaign element plan (general) within APT source system'),
src_proplan_id STRING(30) COLLATE 'und:ci'
OPTIONS(description='techn. identifier part of the campaign element plan (general) within APT source system'),
src_pvpac_id STRING(30) COLLATE 'und:ci'
OPTIONS(description='techn. identifier part of the campaign element plan (activity) within APT source system'),
src_pvpit_id STRING(30) COLLATE 'und:ci'
OPTIONS(description='techn. identifier part of the campaign element plan (general) within APT source system'),
src_salestype_value STRING(20) COLLATE 'und:ci'
OPTIONS(description='techn. identifier part of the campaign element plan (sales_1 a. pricechange) within APT source system'),
src_pvpgp_no STRING(20) COLLATE 'und:ci'
OPTIONS(description='techn. identifier part of the campaign element plan (general) within APT source system'),
src_valid_from DATE
OPTIONS(description='techn. identifier part of the campaign element plan (general) within APT source system'),
src_advmed_id STRING(30) COLLATE 'und:ci'
OPTIONS(description='techn. identifier part of the campaign element plan (adv acitivity) within APT source system'),
src_strplm_id STRING(30) COLLATE 'und:ci'
OPTIONS(description='techn. identifier part of the campaign element plan (storeplacement activity) within APT source system'),
campaign_plan_type_cd STRING(8) COLLATE 'und:ci'
OPTIONS(description='A code uniquely identifying the campaign element plan type.'),
campaign_activity_type_cd STRING(5) COLLATE 'und:ci'
OPTIONS(description='The discriminator code for campaign activities. It distinguishes between price changes, store placements and advertisements.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (campaign_elem_plan_sid) NOT ENFORCED
) OPTIONS(description='Related to a campaign element there are certain plans - be it activity plans or sales_1 plans');