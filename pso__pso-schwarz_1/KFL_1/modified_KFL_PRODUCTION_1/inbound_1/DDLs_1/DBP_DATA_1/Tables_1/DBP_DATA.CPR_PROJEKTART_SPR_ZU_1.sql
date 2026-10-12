--==============================================================
-- Table: cpr_projektart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_projektart_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CPR_PROJEKTART_SPR_ZU_1 (
   projektart_id                       VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'ID der Projektart, z.Bsp. EX',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.',
   projektart_bez                      VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Sprachabhängige Beschreibung der Projektart, z.Bsp. Expansionsprojekt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CPR_PROJEKTART_SPR_ZU PRIMARY KEY (projektart_id, spr_id) NOT ENFORCED
)  COMMENT = 'IOS - Sprachabhängige Bezeichnung der Projektarten';

