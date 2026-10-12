--==============================================================
-- Table: aad_scenario_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_scenario_spr_zu_2
   generated from Powerdesigner on Sonntag, 4. Juni 2023 15:33:54
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AAD_SCENARIO_SPR_ZU_2 (
   scenario_id                         INTEGER     NOT NULL COMMENT 'Unique Identifier of the Scenario',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH - ein Mandant_2 pro Land.',
   scenario_descr                      VARCHAR(255)     COMMENT 'Scenario´s name in the corresponding language',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AAD_SCENARIO_SPR_ZU PRIMARY KEY (scenario_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = ' Contains the description of the scenario in the corresponding languages';
