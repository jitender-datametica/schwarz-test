--==============================================================
-- Table: flw_gewichtsgrenzen_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_gewichtsgrenzen_per_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_GEWICHTSGRENZEN_PER_1 (
   flw_art_id                          INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   dat_von                             DATE             NOT NULL COMMENT 'Datum, ab dem der Satz gültig ist',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   system_id                           INTEGER     COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum, bis zu dem der Satz gültig ist. Bei aktuell gültigen Sätzen = 31.12.9999',
   gewicht_kg_von                      NUMBER(29,3)     NOT NULL COMMENT 'Gewichts-Untergrenze in Kilogramm',
   gewicht_kg_bis                      NUMBER(29,3)     NOT NULL COMMENT 'Gewichts-Obergrenze in Kilogramm',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_GEWICHTSGRENZEN_PER PRIMARY KEY (flw_art_id, dat_von, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - historisierte Gewichtsgrenzen gemäß der KL- Spezifikationen. Basis für EK- und für SB - Gewichtsgrenzen. Quelle ist Hyperion';

