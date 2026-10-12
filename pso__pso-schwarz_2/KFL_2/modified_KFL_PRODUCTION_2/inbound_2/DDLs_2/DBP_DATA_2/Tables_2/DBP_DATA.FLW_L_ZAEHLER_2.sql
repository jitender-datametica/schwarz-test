--==============================================================
-- Table: flw_l_zaehler_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_zaehler_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_ZAEHLER_2 (
   zaehler_id                          VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID des Zählers.',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   zaehlerart                          VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Art_2 des Zählers, z.Bsp. Wasser',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_ZAEHLER PRIMARY KEY (zaehler_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookuptabelle für Stammdaten der Verbrauchszähler (Strom, Gas, Wasser)';

