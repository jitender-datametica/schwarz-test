-- Table: bq_findung_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bq_findung_spr_zu
   generated from Powerdesigner on Sonntag, 4. Februar 2024 12:13:15
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BQ_FINDUNG_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   bq_findung_id                       NUMBER(38,0)     NOT NULL COMMENT 'ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Sprache im DWH',
   bq_findung_bez                      VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung des Ausstiegspunkts',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BQ_FINDUNG_SPR_ZU PRIMARY KEY (mandant_id, bq_findung_id, spr_id) NOT ENFORCED
)  COMMENT = 'AIS - Sprachabhängige Bezeichnung der Ausstiegspunkte bei der Bezugsquellenfindung - initial versorgt';
