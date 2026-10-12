--==============================================================
-- Table: immo_vertragsart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_vertragsart_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_VERTRAGSART_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   vertragsart_id                      NUMBER(38,0)     NOT NULL COMMENT 'Vertragsart',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   vertragsart_bez                     VARCHAR(30)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung der Vertragsart',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_VERTRAGSART_SPR_ZU PRIMARY KEY (mandant_id, vertragsart_id, spr_id) NOT ENFORCED
)  COMMENT = 'IMMO - Sprachabhängige Bezeichnung der Art_1 des Vermietungsvertrags  - SAP REFX - TIV2F';
