--==============================================================
-- Table: flw_hauptgruppe_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_hauptgruppe_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_HAUPTGRUPPE_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   hauptgruppe_id                      VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Hauptgruppe = oberste Hierarchiestufe der Fleischwerk- Produkthierarchie. Entspricht der Tierart',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_HAUPTGRUPPE PRIMARY KEY (mandant_id, hauptgruppe_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnung der Hauptgruppe aus  zfw_hauptgr';

