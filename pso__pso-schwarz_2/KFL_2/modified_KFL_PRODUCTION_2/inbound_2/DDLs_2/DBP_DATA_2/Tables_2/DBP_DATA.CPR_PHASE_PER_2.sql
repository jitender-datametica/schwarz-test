--==============================================================
-- Table: cpr_phase_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_phase_per_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CPR_PHASE_PER_2 (
   projekt_phase_id                    VARCHAR(32)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID einer Projektphase aus xlcphase',
   dat_von                             DATE             NOT NULL COMMENT 'Datum, ab dem der Datensatz gültig ist',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.',
   projekt_id                          VARCHAR(32)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID des Projekts',
   cpr_ext_id                          VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'zusätzliche ID pro Projekt / Phase',
   dat_freigabe                        DATE             COMMENT 'Datum der Freigabe',
   einzel_massnahme                    VARCHAR(30)      COLLATE 'en-ci' COMMENT 'Einelmassnahme',
   teil_massnahme_id                   VARCHAR(30)      COLLATE 'en-ci' COMMENT 'eindeutige ID der Teilmassnahme',
   teil_massn_kz                       INTEGER     NOT NULL COMMENT 'Kennzeichen zur Teil-Massnahme. Enthält Werte von 1 bis 4',
   cpr_systemstatus1_id                INTEGER     NOT NULL COMMENT 'Schluessel für den Systemstatus1, Enthält numerische Werte von 1 aufsteigend',
   cpr_systemstatus2_id                INTEGER     NOT NULL COMMENT 'Schluessel für den Systemstatus2.  Enthält numerische Werte von 1 aufsteigend',
   cpr_systemstatus3_id                INTEGER     NOT NULL COMMENT 'Schluessel für den Systemstatus3.  Enthält numerische Werte von 1 aufsteigend',
   phasenart_id                        VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Schlüssel der Phasenart, z.Bsp P7-Planung',
   cpr_suchfeld_id                     INTEGER     COMMENT 'Diese ID wird bei der Versorgung aus dem von der Quelle gelieferten Feld generiert',
   cpr_phase_version_id                VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Version (Kundenfeld) einer Phase aus zz_ppo_version. Inhalt z.Bsp. 1.1',
   cpr_phase_version_dat               DATE             COMMENT 'Datum_ab einer Version aus zz_ppo_datum_vom',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CPR_PHASE_PER PRIMARY KEY (projekt_phase_id, dat_von) NOT ENFORCED
)  COMMENT = 'IOS - Projektphase';

