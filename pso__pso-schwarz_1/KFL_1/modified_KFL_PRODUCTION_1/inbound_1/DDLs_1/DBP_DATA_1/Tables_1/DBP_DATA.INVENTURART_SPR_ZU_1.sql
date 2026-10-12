--==============================================================
-- Table: inventurart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: inventurart_spr_zu_1
   generated from Powerdesigner on Dienstag, 30. April 2024 18:14:48
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.INVENTURART_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   inventurart_id                      INTEGER     NOT NULL COMMENT 'ID der Inventurart (international nicht identisch)',
   inventurart_bez                     VARCHAR(100)     NOT NULL COMMENT 'Bezeichnung der Inventurart.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_INVENTURART_SPR_ZU PRIMARY KEY (mandant_id, spr_id, inventurart_id) NOT ENFORCED
)  COMMENT = 'Sprachabhängige Bezeichnungen der Inventurarten.';
