--==============================================================
-- Table: flw_zaehler_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_zaehler_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_ZAEHLER_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   zaehler_id                          VARCHAR(10)      NOT NULL COMMENT 'Eindeutige ID des Zählers.',
   spr_id                              INTEGER     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   system_id                           INTEGER     COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   zaehler_bez                         VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Verbrauchszählers, z.Bsp. "OF Wasser Eismaschine"',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_ZAEHLER_SPR_ZU PRIMARY KEY (mandant_id, zaehler_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW -Sprachabhängige Bezeichnungen der Verbrauchszähler (Strom, Gas, Wasser)';

