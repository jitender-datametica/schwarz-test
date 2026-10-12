--==============================================================
-- Table: protokoll_verladung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: protokoll_verladung
   generated from Powerdesigner on Dienstag, 28. September 2021 14:58:55
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.PROTOKOLL_VERLADUNG (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   tour_id                             INTEGER    NOT NULL COMMENT 'Nummer des Transportes (Tour)',
   handling_unit_id_ext                VARCHAR(20)     NOT NULL COMMENT 'Externe Handling Unit Identifikation',
   datzeit_scan                        TIMESTAMP_LTZ   NOT NULL COMMENT 'UTC-Zeitstempel in Langform (JJJJMMTThhmmssmmmuuun)',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   lagernummer_id                      VARCHAR(4)      COMMENT 'Lagernummer/Lagerkomplex',
   kunde_id                            VARCHAR(10)     COMMENT 'Warenempfänger',
   dat_scan                            DATE            COMMENT 'Datum',
   zeit_scan                           TIMESTAMP_LTZ   COMMENT 'Tageszeit',
   versandeinheit_id                   VARCHAR(20)     COMMENT 'Träger-Nummer-Versand-Einheit (bei Sammelpalette). Enthält 18-stelligen Nummer, wenn Teil einer Palette, -1 wenn Palette, 1 wenn Sammelpalette',
   lief_beleg_id                       INTEGER    COMMENT 'Vertriebsbelegnummer',
   dat_lief_soll                       DATE            COMMENT 'Lieferdatum',
   arbeitsgebiet_id                    VARCHAR(20)     COMMENT 'Arbeitsgebiet',
   pruef_id                            VARCHAR(3)      COMMENT 'Arbeitsgebiet. Prüfungsgrund ID',
   gesamtgewicht_hu                    NUMBER(29,3)    COMMENT 'Gesamtgewicht der Handling Unit',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = '''Protokolltabelle Verladung';
