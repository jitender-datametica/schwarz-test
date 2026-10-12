--==============================================================
-- Table: checklistenart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: checklistenart_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CHECKLISTENART_SPR_ZU_1 (
   checklistenart_id                   VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID des Checklistentyps, z.Bsp. CL1 aus cpr_chktyp',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.',
   cpr_checkliste_bez                  VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung der Checklistenart, z.Bsp. Checklist Header Type 1',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CHECKLISTENART_SPR_ZU PRIMARY KEY (checklistenart_id, spr_id) NOT ENFORCED
)  COMMENT = 'IOS - Sprachabhängige Bezeichnung der Checklistenart';

