--==============================================================
-- Table: crm_themenbaum_lv2_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_themenbaum_lv2_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_THEMENBAUM_LV2_SPR_ZU_1 (
   crm_themenbaum_lv2_id               VARCHAR(36)      NOT NULL COLLATE 'en-ci' COMMENT 'Themenbaum Id',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   ebene_1_id                          INTEGER     NOT NULL COMMENT 'Für DWH BSI Mapping 2. Stuffe (Entspricht GEKU Bereich)',
   ebene_2_id                          INTEGER     NOT NULL COMMENT 'Für DWH BSI Mapping 3. Stuffe (Entspricht GEKU Grund)',
   ebene_3_id                          INTEGER     NOT NULL COMMENT 'Für DWH BSI Mapping 1. Stuffe Entspricht GEKU DWH Artikel_1)',
   ebene_1_bez                         VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Text für key_level_1 / Text für GEKU Bereich',
   ebene_2_bez                         VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Name des aktuellen Themnbaumlevels / Text für GEKU Grund',
   ebene_3_bez                         VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Text für key_level_2 / Text enstpricht GEKU DWH Artikel_1',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_THEMENBAUM_LV2_SPR_ZU PRIMARY KEY (crm_themenbaum_lv2_id, spr_id, ebene_1_id, ebene_2_id, ebene_3_id) NOT ENFORCED
)  COMMENT = 'KMR - Enthält Themenbaumeiträge der Ebene 2 (unterste Granularitätsebene) - MS Dynamics CRM';

