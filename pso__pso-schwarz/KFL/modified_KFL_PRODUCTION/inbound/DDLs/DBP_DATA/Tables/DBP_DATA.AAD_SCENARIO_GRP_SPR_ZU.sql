--==============================================================
-- Table: aad_scenario_grp_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_scenario_grp_spr_zu
   generated from Powerdesigner on Sonntag, 4. Juni 2023 15:34:10
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AAD_SCENARIO_GRP_SPR_ZU (
   scenario_grp_id                     INTEGER     NOT NULL COMMENT 'Unique Identifier of the Scenariogroup',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH - ein Mandant pro Land.',
   scenario_grp_descr                      VARCHAR(255)     COMMENT 'Scenariogroup´s name in the corresponding language',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AAD_SCENARIO_GRP_SPR_ZU PRIMARY KEY (scenario_grp_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'Scenariogroup´s name in the corresponding language';
