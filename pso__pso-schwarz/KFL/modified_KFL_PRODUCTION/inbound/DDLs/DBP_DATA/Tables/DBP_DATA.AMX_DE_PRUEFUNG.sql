--==============================================================
-- Table: amx_de_pruefung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_de_pruefung
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_DE_PRUEFUNG (
   pruefung_id                         INTEGER     NOT NULL COMMENT 'Eindeutige ID der Prüfung',
   pruefung_nr                         VARCHAR(30)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Prüfungsnummer',
   zustand_id                          INTEGER     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID des Zustanddes',
   pruefung_bez                        VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung der Prüfung',
   dat_start                           DATE             COMMENT 'Startdatum der Prüfung',
   dat_ende                            DATE             COMMENT 'Enddatum der Prüfung',
   revisor_id                          INTEGER     NOT NULL DEFAULT -1 COMMENT 'ID des Revisors, wird aus datenschutzrechtlichen Gründen nicht verwendet',
   pruefung_typ_id                     INTEGER     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID des Prüfungstypes',
   pruefung_klasse_id                  INTEGER     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID der Prüfungsklasse',
   pruefung_ergebnis_wert              INTEGER     NOT NULL DEFAULT -1 COMMENT 'Ergebnisswert',
   business_unit_id                    INTEGER     COMMENT 'ID der Organisationseinheit',
   mandant_id                          INTEGER     COMMENT 'ID des Mandanten',
   wup_id                              INTEGER     COMMENT 'ID der Filiale',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_DE_PRUEFUNG PRIMARY KEY (pruefung_id) NOT ENFORCED
)  COMMENT = 'KMR - Audimex. Enthält Prüfungsdaten Kurzcheck aus DE';

