--==============================================================
-- Table: flw_codegruppe_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_codegruppe_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_CODEGRUPPE_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH. In der Regel länderbezogen',
   katalogart_id                       VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Katalogart',
   codegruppe_id                       VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'ID der codegruppe',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   codegruppe_bez                      VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Codegruppe aus kurztext',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_CODEGRUPPE_SPR_ZU PRIMARY KEY (mandant_id, katalogart_id, codegruppe_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Codegruppen-Bezeichnungen aus qpgt';

