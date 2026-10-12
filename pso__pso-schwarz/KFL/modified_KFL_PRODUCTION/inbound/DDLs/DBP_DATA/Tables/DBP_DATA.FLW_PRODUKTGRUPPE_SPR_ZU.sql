--==============================================================
-- Table: flw_produktgruppe_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_produktgruppe_spr_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_PRODUKTGRUPPE_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH. In der Regel länderbezogen',
   produktgruppe_id                    VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Produktguppe Id aus prodgr',
   spr_id                              INTEGER     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   produktgruppe_bez                   VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Produktgruppen Bezeichnung aus bezeich',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_PRODUKTGRUPPE_SPR_ZU PRIMARY KEY (mandant_id, produktgruppe_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Produktgruppen - Bezeichnungen aus zfw_prodgr';

