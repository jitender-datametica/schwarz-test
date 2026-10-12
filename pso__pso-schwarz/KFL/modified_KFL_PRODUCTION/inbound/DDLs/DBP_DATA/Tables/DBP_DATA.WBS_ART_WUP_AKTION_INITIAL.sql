--==============================================================
-- Table: wbs_art_wup_aktion_initial
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_art_wup_aktion_initial
   generated from Powerdesigner on Montag, 17. März 2025 17:44:04
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WBS_ART_WUP_AKTION_INITIAL (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant (Markt)',
   art_id                              INTEGER     NOT NULL COMMENT 'Artikel',
   wup_id                              INTEGER     NOT NULL COMMENT 'Markt',
   nb_id                               INTEGER     NOT NULL DEFAULT 0 COMMENT 'Nebenbetrieb (Markt)',
   mandant_id_vz                       INTEGER     NOT NULL COMMENT 'Mandant (VZ)',
   wup_id_vz                           INTEGER     NOT NULL COMMENT 'Verteilzentrum',
   nb_id_vz                            INTEGER     NOT NULL DEFAULT -111 COMMENT 'Nebenbetrieb (VZ)',
   aktion_id                           VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Aktion',
   ausliefergruppe_id                  VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Ausliefergruppe',
   dat_von                             DATE             COMMENT 'Datum im Format JJJJ-MM-TT',
   dat_bis                             DATE             COMMENT 'Aktion gültig bis',
   dat_bestandsperiode_rel             DATE             COMMENT 'Relevantes Datum Bestandsperiode',
   dat_lief_split                      DATE             COMMENT 'Lieferdatum Split-Logik',
   dat_lief_wunsch                     DATE             COMMENT 'Planlieferdatum',
   dat_bestandsperiode_bis             DATE             COMMENT 'Bestandsperiode Datum Bis',
   dat_letzte_nachversorgung           DATE             COMMENT 'Letzter Tag für Nachversorgung',
   we_bearbeitungszeit                 INTEGER     COMMENT 'WE-Bearbeitungszeit',
   menge_gesamt_bme                    NUMBER(29,3)     COMMENT 'Gesamtmenge in BME. Die für die Aktion ursprünglich insgesamt berechnete Menge.',
   menge_min_bme                       NUMBER(29,3)     COMMENT 'Mindestplatzierung in BME',
   menge_initial_bme                   NUMBER(29,3)     COMMENT 'Initialmenge in BME. Die Menge der ersten Lieferung an den Markt. Ist ein Teil der ursprünglichen Gesamtmenge.',
   menge_initial_ame                   NUMBER(29,3)     COMMENT 'Initialmenge in AME. Die Menge der ersten Lieferung an den Markt. Ist ein Teil der ursprünglichen Gesamtmenge.',
   menge_initial_pal                   NUMBER(29,3)     COMMENT 'Initialmenge in PAL. Die Menge der ersten Lieferung an den Markt. Ist ein Teil der ursprünglichen Gesamtmenge.',
   split_fg                            INTEGER     COMMENT 'Split möglich - 0/1',
   fair_share_fg                       INTEGER     COMMENT 'Welches Werbethema hatte der Artikel am Vortag',
   order_type                          VARCHAR(4)       NOT NULL DEFAULT '9999' COMMENT 'Bestellart/Belegart für SAP UBP, UBP1, UBP0, UBGK,UBG1, UBG2',
   init_lief_modus_kz                  VARCHAR(100)     COMMENT 'Beschreibt den Modus, in welchem die initiale Belieferung berechnet wird (O = Order, S = Simulation, N = None).
            - N: wenn keine initiale Belieferung errechnet wird (vor wbs_phase_id = 8).
            - S: berechnen die Erstlieferung 40 Tage vor der Promotion - es werden keine wirklichen Bestellungen in den Geschäften erzeugt sondern die Spalte ermöglicht DC Dispo, den ersten Liefersplit schon sehr früh zu sehen und die Mengen beim Lieferanten entsprechend zu bestellen (wbs_phase_id 7 bis 3).
            - O: der ursprüngliche initiale Lieferlauf findet 9 Tage vor der Promotion statt, und der Berechnungslauf wird als "O" (Order Creation) gekennzeichnet (ab wbs_phase_id = 2).',
   dat_beladung                        DATE             COMMENT 'Datum der Beladung.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WBS_ART_WUP_AKTION_INITIAL PRIMARY KEY (mandant_id, art_id, wup_id, nb_id, mandant_id_vz, wup_id_vz, nb_id_vz, aktion_id) NOT ENFORCED
)  COMMENT = 'Initialversorgung WBS';
