--==============================================================
-- Table: geku_kundenfaktor_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_kundenfaktor_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_KUNDENFAKTOR_SPR_ZU_2 (
   kundenfaktor_id                     INTEGER     NOT NULL COMMENT 'eindeutige ID des Kundenfaktors, aktuell zwischen 1 und 27',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
   kf_kommentar                        VARCHAR(255)     COLLATE 'en-ci' COMMENT 'Kommentar zum Kundenfaktor, z.Bsp. "Gebäude, Flächen, Betriebssicherheit"',
   kf_bez                              VARCHAR(255)     COLLATE 'en-ci' COMMENT 'Bezeichnung des Kundenfaktors, z.Bsp. "Sicherheit"',
   quelle_spr_id                       INTEGER     COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_KUNDENFAKTOR_SPR_ZU PRIMARY KEY (kundenfaktor_id, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - Sprachabhängige Bezeichnungen der Kundenfaktoren aus dem GeKu-Plakat - "manuelle SST"';

