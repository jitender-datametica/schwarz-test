--==============================================================
-- Table: aad_scenario_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_scenario_spr_zu
   generated from Powerdesigner on Sonntag, 4. Juni 2023 15:33:54
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AAD_SCENARIO_SPR_ZU (
   scenario_id                         NUMBER(38,0)     NOT NULL COMMENT 'Unique Identifier of the Scenario',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH - ein Mandant pro Land.',
   scenario_descr                      VARCHAR(255)     COMMENT 'Scenario´s name in the corresponding language',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AAD_SCENARIO_SPR_ZU PRIMARY KEY (scenario_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = ' Contains the description of the scenario in the corresponding languages';
