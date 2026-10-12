--==============================================================
-- Table: flw_pruefkatalog_code_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_pruefkatalog_code_spr_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_PRUEFKATALOG_CODE_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH. In der Regel länderbezogen',
   katalogart_id                       VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Katalogart',
   codegruppe_id                       VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'ID der codegruppe',
   pruefcode_id                        VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID des Prüfcodes aus code',
   version_id                          NUMBER(38,0)     NOT NULL COMMENT 'Versionsnummer aus version1',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   pruefkatalog_code_bez               VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Kurbezeichnung zum code aus kurztext',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_PRUEFKATALOG_CODE_SPR_ZU PRIMARY KEY (mandant_id, katalogart_id, codegruppe_id, pruefcode_id, version_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnungen der Prüfcodes aus qpct';

