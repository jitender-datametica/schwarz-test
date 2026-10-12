--==============================================================
-- Table: rabatt_typ_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rabatt_typ_spr_zu_1
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:43:30
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.RABATT_TYP_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   rabatt_typ_id                       NUMBER(38,0)     NOT NULL COMMENT 'ID des Rabatt Typs. Gibt die Art_1 des gewährten Rabattes an, bspw. Normalpreis (1), Rabattpreis (2), Absoluter Rabatt (3). etc.',
   rabatt_typ_bez                      VARCHAR(200)     NOT NULL COMMENT 'Sprachabhängige Bezeichnung des Rabatttyps.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_RABATT_TYP_SPR_ZU PRIMARY KEY (mandant_id, spr_id, rabatt_typ_id) NOT ENFORCED
)  COMMENT = 'Tabelle für sprachabhängige Bezeichnungen des Rabatttyps';
