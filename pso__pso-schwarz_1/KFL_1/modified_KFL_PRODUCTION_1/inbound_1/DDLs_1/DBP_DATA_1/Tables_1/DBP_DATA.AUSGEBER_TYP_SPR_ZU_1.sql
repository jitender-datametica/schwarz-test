--==============================================================
-- Table: ausgeber_typ_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ausgeber_typ_spr_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AUSGEBER_TYP_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   ausgeber_typ_id                     VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Typ des Ausgebers, es gibt z. Bsp. KDC, TIP und Filiale',
   spr_id                              INTEGER     NOT NULL COMMENT 'Nummer der Sprache',
   ausgeber_typ_bez                    VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Ausgebertypen, z.Bsp. TIP',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AUSGEBER_TYP_SPR_ZU PRIMARY KEY (mandant_id, ausgeber_typ_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS - sprachabhängige Bezeichnungen der Ausgebertypen';

