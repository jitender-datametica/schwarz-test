--==============================================================
-- Table: aad_scenario_grp_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_scenario_grp_spr_zu_1
   generated from Powerdesigner on Sonntag, 4. Juni 2023 15:34:10
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AAD_SCENARIO_GRP_SPR_ZU_1 (
   scenario_grp_id                     NUMBER(38,0)     NOT NULL COMMENT 'Unique Identifier of the Scenariogroup',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land.',
   scenario_grp_descr                      VARCHAR(255)     COMMENT 'Scenariogroup´s name in the corresponding language',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AAD_SCENARIO_GRP_SPR_ZU PRIMARY KEY (scenario_grp_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'Scenariogroup´s name in the corresponding language';
