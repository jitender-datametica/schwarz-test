--==============================================================
-- Table: ods_bon_kopf
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ods_bon_kopf
   generated from Powerdesigner on Mittwoch, 21. Juli 2021 17:49:32
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_ODS_ARCHIV.ods_bon_kopf  cluster by (
      mandant_id,
      bon_dat,
      wup_id
 )(
   bon_id                              VARCHAR(100)     NOT NULL COMMENT 'eindeutige ID eines Bons, generierter Hashwert',
   bon_dat                             DATE            NOT NULL COMMENT 'Checkoutdatum, auch Businessday bzw. Kassenkey',
   kasse_typ_id                        INTEGER    COMMENT 'Kassentyp. Folgende Typen kommen vor: 1 = default(Sales POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt',
   kundenkarte_typ_id                  INTEGER    NOT NULL COMMENT 'ID zur Kundenkarte mit Werten 0 und 1',
   wup_id                              INTEGER    NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprueft',
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH - ein Mandant pro Land',
   bon_nr                              INTEGER    NOT NULL COMMENT 'Die Bonnummer des Bons (ist eine fortlaufende Nummer die in der Kasse generiert wird, im Normal Fall ist diese Nummer pro Tag und Kasse Unique)',
   kasse_nr                            INTEGER    NOT NULL COMMENT 'Nummer der Kasse',
   kassierer_nr                        VARCHAR(16)      COMMENT 'Nummer des Kassierers',
   kunde_fg                            INTEGER    NOT NULL COMMENT 'Gibt an, ob dieser Bon für die Kundenzaehlung relevant ist. 1 = ja, 0 = nein',
   bon_beginn                          TIMESTAMP_LTZ   COMMENT 'Start-Zeitpunkt des Bons',
   bon_ende                            TIMESTAMP_LTZ   COMMENT 'Ende-Zeitpunkt des Bons',
   umsatz_mwst                         NUMBER(29,4)    DEFAULT 0.0000 NOT NULL COMMENT 'auf den Mehrwertsteueranteil entfallender Betrag',
   umsatz_brutto                       NUMBER(29,4)    DEFAULT 0.0000 NOT NULL COMMENT 'Umsatz Brutto Betrag',
   bon_booking                         TIMESTAMP_LTZ   NOT NULL COMMENT 'Buchungszeitpunkt des Bons, relevant z.Bsp. für artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine Kasse offline war',
   dat_booking                         DATE            NOT NULL COMMENT 'Buchungsdatum des Bons, relevant z.Bsp. fuer artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine Kasse offline war. Redundant zu bon_booking aus Performancegruenden',
   turnover_fg                         INTEGER    NOT NULL COMMENT 'Flag kennzeichnet die Umsatzrelevanz des Bons. 1 = relevant',
   wrg_id                              VARCHAR(12)      COMMENT 'Währung ID, z.Bsp ''EUR''',
   reactivated_fg                      INTEGER    NOT NULL COMMENT 'Bons koennen zurueckgestellt und spaeter reaktiviert werden (= 1), wenn z.Bsp. der Kunde nicht gleich zahlen kann. Diese Bons verbleiben laenger im System und die Zeiten duerfen nicht in die Berechnungen eingehen.',
   personal_id                         VARCHAR(100)     COMMENT 'Personalnummer(nur bei Personalrabett) als Hashwert verfremdet (Compress)',
   betrag_personal_rabatt              NUMBER(29,4),
   kpos_kasse_typ                      VARCHAR(80)     COMMENT 'Im Kassensystem KPOS verwendete nicht-numerische Kassentypen',
   wagen_nr                            INTEGER    COMMENT 'Nummer des Einkaufswagens',
   kundenkarte_id                      VARCHAR(1020)    COMMENT 'Beinhaltet die gehashte Kundennummer',
   druecken_summentaste                TIMESTAMP_LTZ   COMMENT 'Zeitstempel wird erzeugt wenn die Summentaste an der Kasse gedrueckt wird; Zeitstempel wird nur einmalig erzeugt',
   schliessen_kassenschublade          TIMESTAMP_LTZ   COMMENT 'Zeitstempel wird an der Kasse erzeugt, wenn die Kassenlade geschlossen wird',
   fiskalisierung_fg                   INTEGER    Default 0 NOT NULL COMMENT 'Kennzeichnung für einen Bon, ob dieser für Fiskalisierung relevant ist'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'ODS - Aus den Kassensystemen near Realtime geladene Bon-Koepfe';
