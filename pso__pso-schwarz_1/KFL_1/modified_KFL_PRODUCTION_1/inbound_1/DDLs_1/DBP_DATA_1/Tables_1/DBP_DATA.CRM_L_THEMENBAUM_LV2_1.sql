--==============================================================
-- Table: crm_l_themenbaum_lv2_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_themenbaum_lv2_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_L_THEMENBAUM_LV2_1 (
   crm_themenbaum_lv2_id               VARCHAR(36)      NOT NULL COLLATE 'en-ci' COMMENT 'Themenbaum Id',
   crm_themenbaum_lv1_id               VARCHAR(36)      COLLATE 'en-ci' COMMENT 'Zugehörigkeit zu einem höheren Themnbaum Eintrag',
   ebene_1_id                          INTEGER     COMMENT 'Für DWH BSI Mapping 2. Stuffe (Entspricht GEKU Bereich)',
   ebene_2_id                          INTEGER     COMMENT 'Für DWH BSI Mapping 3. Stuffe (Entspricht GEKU Grund)',
   ebene_3_id                          INTEGER     COMMENT 'Für DWH BSI Mapping 1. Stuffe Entspricht GEKU DWH Artikel_1)',
   number_level_1                      VARCHAR(15)      COLLATE 'en-ci' COMMENT 'number_level_1',
   number_level_2                      VARCHAR(15)      COLLATE 'en-ci' COMMENT 'number_level_2',
   number_level_3                      VARCHAR(15)      COLLATE 'en-ci' COMMENT 'number_level_3',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_L_THEMENBAUM_LV2 PRIMARY KEY (crm_themenbaum_lv2_id) NOT ENFORCED
)  COMMENT = 'KMR - Enthält Themenbaumeiträge der Ebene 2 (unterste Granularitätsebene) - MS Dynamics CRM';

