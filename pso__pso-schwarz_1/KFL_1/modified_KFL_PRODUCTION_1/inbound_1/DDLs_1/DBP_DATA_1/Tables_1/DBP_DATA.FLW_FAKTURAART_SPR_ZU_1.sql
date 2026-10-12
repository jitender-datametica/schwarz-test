--==============================================================
-- Table: flw_fakturaart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_fakturaart_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_FAKTURAART_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH. In der Regel länderbezogen',
   fakturaart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Fakturaart aus fkart',
   spr_id                              INTEGER     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   fakturaart_bez                      VARCHAR(20)      NOT NULL COLLATE 'en-ci',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_FAKTURAART_SPR_ZU PRIMARY KEY (mandant_id, fakturaart_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnung der Fakturaarten aus tvfkt';
