--==============================================================
-- Table: flw_hauptgruppe_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_hauptgruppe_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_HAUPTGRUPPE_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH. In der Regel länderbezogen',
   hauptgruppe_id                      VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Hauptgruppe = oberste Hierarchiestufe der Fleischwerk- Produkthierarchie. Entspricht der Tierart',
   spr_id                              INTEGER     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   hauptgruppe_bez                     VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Hauptgruppe aus bezeich',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_HAUPTGRUPPE_SPR_ZU PRIMARY KEY (mandant_id, hauptgruppe_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnung der Hauptgruppe aus  zfw_hauptgr';

