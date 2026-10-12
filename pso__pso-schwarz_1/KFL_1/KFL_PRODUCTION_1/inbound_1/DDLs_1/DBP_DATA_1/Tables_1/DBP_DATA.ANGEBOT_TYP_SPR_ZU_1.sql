--==============================================================
-- Table: angebot_typ_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: angebot_typ_spr_zu_1
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:48:49
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ANGEBOT_TYP_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   angebot_typ_cd                      VARCHAR(10)      NOT NULL COMMENT 'Alphanumerischer Code des Angebotstyps',
   angebot_typ_bez                     VARCHAR(200)     NOT NULL COMMENT 'Sprachabhängige Bezeichnung des Angebotstyps.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ANGEBOT_TYP_SPR_ZU PRIMARY KEY (mandant_id, spr_id, angebot_typ_cd) NOT ENFORCED
)  COMMENT = 'Tabelle für sprachabhängige Bezeichnungen der Angebotstypen.';
