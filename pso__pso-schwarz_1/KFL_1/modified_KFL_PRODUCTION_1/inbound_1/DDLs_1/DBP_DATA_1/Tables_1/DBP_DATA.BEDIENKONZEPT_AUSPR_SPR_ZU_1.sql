--==============================================================
-- Table: bedienkonzept_auspr_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bedienkonzept_auspr_spr_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BEDIENKONZEPT_AUSPR_SPR_ZU_1 (
   bedienkonzept_id                    INTEGER     NOT NULL COMMENT 'Die bedienkonzept_id wird im DWH vergeben',
   bedienkonzept_auspr_id              INTEGER     NOT NULL COMMENT 'ID der Ausprägung des Bedienkonzepts',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.',
   bedienkonzept_auspr_bez             VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Ausprägung des Bedienkonzepts, z.Bsp. Bedienung, separate Leergutannahme',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BEDIENKONZEPT_AUSPR_SPR_ZU PRIMARY KEY (bedienkonzept_id, bedienkonzept_auspr_id, spr_id) NOT ENFORCED
)  COMMENT = 'RPM -  Sprachabhängige Bezeichnung der Ausprägung der Bedienkonzepte';

