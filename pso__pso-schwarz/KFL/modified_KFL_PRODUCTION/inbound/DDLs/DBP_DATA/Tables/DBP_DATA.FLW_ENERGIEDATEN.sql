--==============================================================
-- Table: flw_energiedaten
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_energiedaten
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_ENERGIEDATEN (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   zaehler_id                          VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID des Zählers.',
   dat                                 DATE             NOT NULL COMMENT 'Tagesdatum. Zählerstände können täglich oder monatlich gemeldet werden. Vergleichbarkeit nur auf Monatsebene gegeben.',
   pc_id                               VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Fachschluessel fuer die Profitcenter',
   krk_id                              VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'globale ID des Kostenrechnungskreises',
   kjmo                                INTEGER     NOT NULL COMMENT 'Monat eines Kalenderjahres, Format JJJJMM',
   menge_verbrauch                     NUMBER(29,5)     NOT NULL COMMENT 'Verbrauchte Menge',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_ENERGIEDATEN PRIMARY KEY (mandant_id, zaehler_id, dat, pc_id, krk_id) NOT ENFORCED
)  COMMENT = 'FLW - Verbrauchswerte pro Zähler';

