--==============================================================
-- Table: inventurart_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: inventurart_spr_zu
   generated from Powerdesigner on Dienstag, 30. April 2024 18:14:48
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.INVENTURART_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   inventurart_id                      NUMBER(38,0)     NOT NULL COMMENT 'ID der Inventurart (international nicht identisch)',
   inventurart_bez                     VARCHAR(100)     NOT NULL COMMENT 'Bezeichnung der Inventurart.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_INVENTURART_SPR_ZU PRIMARY KEY (mandant_id, spr_id, inventurart_id) NOT ENFORCED
)  COMMENT = 'Sprachabhängige Bezeichnungen der Inventurarten.';
