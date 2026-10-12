--==============================================================
-- Table: rpm_element_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rpm_element_per
   generated from Powerdesigner on Dienstag, 18. Januar 2022 13:34:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.RPM_ELEMENT_PER (
   dat_von                             DATE            NOT NULL COMMENT 'Datum, ab dem der Datensatz gueltig ist',
   rpm_hierarchie_id                   VARCHAR(32)     COLLATE 'en-ci' NOT NULL COMMENT 'Eindeutige ID der Immobilie',
   rpm_immobilie_id                    VARCHAR(32)     COLLATE 'en-ci' COMMENT 'Eindeutige ID der Immobilie, auf die sich das Element bezieht aus initiative_guid',
   projekt_id                          VARCHAR(32)     COLLATE 'en-ci' NOT NULL COMMENT 'Eindeutige ID des Projekts',
   dat_bis                             DATE            NOT NULL COMMENT 'Datum, bis zu dem der Datensatz gueltig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.',
   rpm_status_id                       INTEGER    NOT NULL COMMENT 'Status eines Projekts (Massnahme)',
   wrg_id                              VARCHAR(3)      COLLATE 'en-ci' NOT NULL COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   dat_start_prognose                  DATE            COMMENT 'Startdatum Prognose aus forecast start',
   dat_start_plan                      DATE            COMMENT 'Geplantes Startdatum aus planned start',
   dat_start                           DATE            COMMENT 'Tatsaechliches Startdatum',
   dat_ende_prognose                   DATE            COMMENT 'Endedatum Prognose aus forecast finish',
   dat_ende_plan                       DATE            COMMENT 'Geplantes Endedatum aus planned finish',
   dat_ende                            DATE            COMMENT 'Tatsaechliches Endedatum aus actual finish',
   land_id                             VARCHAR(2)      COLLATE 'en-ci' NOT NULL COMMENT 'Land, in dem sich der Markt befindet. Hat immer Laenge von 2 Zeichen (PL, CZ, DE,..). Im Quellsystem SAP hat das Feld 3 Zeichen',
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   strasse                             VARCHAR(80)     COLLATE 'en-ci' COMMENT 'Strasse des Objekts aus zppm_strasse',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter Wup ID wird verwendet fuer Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   bereich_name                        VARCHAR(3)      COLLATE 'en-ci' COMMENT 'Bereichsname, Auswahlfeld aus zppm_bername',
   wup_standort                        VARCHAR(40)     COLLATE 'en-ci' COMMENT 'Standort aus zppm_standort',
   plz                                 VARCHAR(10)     COLLATE 'en-ci' COMMENT 'Postleitzahl aus zppm_plz',
   expansionauftrag_nr                 VARCHAR(10)     COLLATE 'en-ci' COMMENT 'Nummer des Expansionsauftrags aus zppm_expauftr',
   eigenentw                           VARCHAR(40)     COLLATE 'en-ci' COMMENT 'Eigenentwicklung Text aus zppm_eigenentw. COMPRESS',
   angebot_nr                          VARCHAR(10)     COLLATE 'en-ci' COMMENT 'Angebotsnummer Expansion aus zppm_ang_nr',
   auftraggeber_name                   VARCHAR(30)     COLLATE 'en-ci' COMMENT 'Name des Auftraggebers aus zppm_auftrgeb',
   objekt_planer_name                  VARCHAR(30)     COLLATE 'en-ci' COMMENT 'Name des Objektplaners aus zppm_objplan',
   gj_umbvorschl                       INTEGER    COMMENT 'Umbauvorschlag - Geschaeftsjahr aus zppm_umbvorschl',
   rpm_projekt_typ_id                  VARCHAR(20)     COLLATE 'en-ci' COMMENT 'Eindeutige ID fuer den Projekttyp eines Projekts (Massnahme) aus phase_t',
   rpm_phase_id                        VARCHAR(20)     COLLATE 'en-ci' COMMENT 'Phase ID, z.Bsp. ZPPM_EP_5 aus rpmphas',
   testmarkt_fg                        INTEGER    DEFAULT 0 NOT NULL COMMENT 'Testmarkt-Flag aus zppm_testmarkt',
   massnahmentyp_id                    INTEGER    COMMENT 'ID des Maßnahmentyps',
   besitzverhaeltnis_id                VARCHAR(3)      COLLATE 'en-ci' COMMENT 'ID des Besitzverhaeltnis',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'RPM - Projekte (Massnahmen) zu einer Immobilie (SOLL) aus item_d';