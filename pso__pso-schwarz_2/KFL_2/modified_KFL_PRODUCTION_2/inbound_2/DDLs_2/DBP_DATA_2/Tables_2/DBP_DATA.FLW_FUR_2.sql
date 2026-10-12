--==============================================================
-- Table: flw_fur_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_fur_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_FUR_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   flw_art_id                          INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   flw_kunde_id                        INTEGER     NOT NULL COMMENT 'Im DWH generierter Surrogate Key für die Kundennummer aus SAP',
   dat                                 DATE             NOT NULL COMMENT 'Auf dieses Datum bezieht sich die Prognose',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   menge_sicherheit                    NUMBER(29,3)      NOT NULL DEFAULT 0 COMMENT 'Sicherheitsbestand',
   menge_plan                          NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Geplante Menge aus der FuR-Prognose',
   dat_erstellung                      DATE             NOT NULL COMMENT 'Erstelldatum der Prognose',
   einh_id                             VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Internationalen Maßeinheit aus msehi',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_FUR PRIMARY KEY (mandant_id, flw_art_id, flw_kunde_id, dat) NOT ENFORCED
)  COMMENT = 'FLW - Prognosedaten aus der Anwendung Forecast & Replenishment - Multiset';

