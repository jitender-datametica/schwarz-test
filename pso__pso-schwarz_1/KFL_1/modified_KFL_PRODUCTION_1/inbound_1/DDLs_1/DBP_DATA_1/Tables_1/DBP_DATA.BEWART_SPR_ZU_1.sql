--==============================================================
-- Table: bewart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bewart_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BEWART_SPR_ZU_1 (
   bewart_id                           INTEGER     NOT NULL COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache
            ',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   bewart_bez                          VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Bewegungsart',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BEWART_SPR_ZU PRIMARY KEY (bewart_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'Bewegungsart-Sprachen-Zuordnung';

