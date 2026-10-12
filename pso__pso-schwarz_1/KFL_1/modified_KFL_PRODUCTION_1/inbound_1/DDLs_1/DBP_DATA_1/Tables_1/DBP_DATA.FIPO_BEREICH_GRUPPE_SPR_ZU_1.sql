--==============================================================
-- Table: fipo_bereich_gruppe_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_bereich_gruppe_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_BEREICH_GRUPPE_SPR_ZU_1 (
   fipo_bereich_gruppe_id              INTEGER     NOT NULL COMMENT 'Eindeutige ID der FIPO-Bereichsgruppe aus dem Quellfeld bgr_id.',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache
            ',
   fipo_bereich_gruppe_bez             VARCHAR(60)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung der Bereichsgruppe',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_BEREICH_GRUPPE_SPR_ZU PRIMARY KEY (fipo_bereich_gruppe_id, spr_id) NOT ENFORCED
)  COMMENT = 'FIPO - Sprachabhängige Bezeichnungen der FIPO-Bereichsgruppen';

