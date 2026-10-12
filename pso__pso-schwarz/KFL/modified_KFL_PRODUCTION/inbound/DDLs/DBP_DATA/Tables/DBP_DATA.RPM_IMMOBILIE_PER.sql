--==============================================================
-- Table: rpm_immobilie_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rpm_immobilie_per
   generated from Powerdesigner on Dienstag, 18. Januar 2022 13:17:22
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.RPM_IMMOBILIE_PER (
   rpm_hierarchie_id                   VARCHAR(32)     COLLATE 'en-ci' NOT NULL COMMENT 'Eindeutige ID der Immobilie',
   dat_von                             DATE            NOT NULL COMMENT 'Datum, ab dem der Datensatz gueltig ist',
   techn_platz_id                      VARCHAR(30)     COLLATE 'en-ci' NOT NULL COMMENT 'Der technische Platz ist eine von Kaufland Facility Management verwaltete Einheit',
   vs_id                               INTEGER    NOT NULL COMMENT 'Referenz zur Vertriebsschiene aus zppm_konzept',
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   wrg_id                              VARCHAR(3)      COLLATE 'en-ci' NOT NULL COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   gesamtbew_note                      NUMBER(29,2)     COMMENT 'Gesamtbewertung Durchschnittsnote aus zppm_gesamtbew',
   bewertungszahl_a                    NUMBER(29,2)     COMMENT 'Bewertungszahl aus zppm_bew_zahl_a',
   bewertungszahl_b                    NUMBER(29,2)     COMMENT 'Bewertungszahl aus zppm_bew_zahl_b',
   bewertungszahl_c                    NUMBER(29,2)     COMMENT 'Bewertungszahl aus zppm_bew_zahl_c',
   dat_bis                             DATE            NOT NULL COMMENT 'Datum, bis zu dem der Datensatz gueltig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.',
   gj_umbvorschl                       INTEGER    COMMENT 'Umbauvorschlag - Geschaeftsjahr aus zppm_umbvorschl',
   wup_id                              INTEGER    COMMENT 'Mutter Wup ID wird verwendet fuer Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   wup_standort                        VARCHAR(40)     COLLATE 'en-ci' COMMENT 'Standort aus zppm_standort',
   strasse                             VARCHAR(80)     COLLATE 'en-ci' COMMENT 'Strasse des Objekts aus zppm_strasse',
   plz                                 VARCHAR(10)     COLLATE 'en-ci' COMMENT 'Postleitzahl aus zppm_plz',
   zielumsatz_3gj                      NUMBER(29,4)    DEFAULT 0.0000 NOT NULL COMMENT 'Zielumsatz im dritten GJ aus zppm_zielumsatz',
   dat_eroeffn_fb_imm                  DATE            DEFAULT CAST('1900-01-01' AS DATE) NOT NULL COMMENT 'Datum Eroeffnung Festbau Immobilie aus zppm_er_fbau_imm',
   uebernahme_von                      VARCHAR(40)     COLLATE 'en-ci' COMMENT 'uebernahmefirma aus zppm_uebernfirm',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'RPM - Informationen zu einer Immobilie (IST) aus inm_initiative';