--==============================================================
-- Table: ods_bon_kopf_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ods_bon_kopf_1
   generated from Powerdesigner on Mittwoch, 4. Juni 2025 16:50:59
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_ODS.ODS_BON_KOPF_1 CLUSTER BY (
     MANDANT_ID,
     BON_DAT,
     WUP_ID 
) (
   bon_id                              VARCHAR(25)      NOT NULL COMMENT 'Eindeutige ID eines Bons, generierter Hashwert.',
   bon_dat                             DATE             NOT NULL COMMENT 'Checkoutdatum, auch Businessday bzw. Kassenkey.',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land.',
   wup_id                              INTEGER     NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprüft.',
   kasse_typ_id                        INTEGER     COMMENT 'Kassentyp. Folgende Typen kommen vor: 1 = default (Sales_1 POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office), 5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt.',
   kundenkarte_typ_id                  INTEGER     NOT NULL DEFAULT 0 COMMENT 'ID zum Kundenkartentyp mit Werten 0, 1, 2. ',
   bon_nr                              INTEGER     NOT NULL COMMENT 'Die Bonnummer des Bons (ist eine_1 fortlaufende Nummer die in der Kasse generiert wird, im Normalfall ist diese Nummer pro Tag_1 und Kasse unique).',
   kasse_nr                            INTEGER     NOT NULL COMMENT 'Nummer der Kasse.',
   kassierer_nr                        VARCHAR(4)       COMMENT 'Nummer des Kassierers.',
   kunde_fg                            INTEGER     NOT NULL COMMENT 'Gibt an, ob dieser Bon für die Kundenzählung relevant ist. 1 = ja, 0 = nein.',
   bon_beginn                          TIMESTAMP_NTZ(9) COMMENT 'Start-Zeitpunkt des Bons.',
   bon_ende                            TIMESTAMP_NTZ(9) COMMENT 'Ende-Zeitpunkt des Bons.',
   umsatz_mwst                         NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Auf den Mehrwertsteueranteil entfallender Betrag.',
   umsatz_brutto                       NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Umsatz Brutto Betrag.',
   bon_booking                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Buchungszeitpunkt des Bons, relevant z.Bsp. für artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine_1 Kasse offline war.',
   dat_booking                         DATE             NOT NULL COMMENT 'Buchungsdatum des Bons, relevant z.Bsp. für artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine_1 Kasse offline war. Redundant zu bon_booking aus Performancegründen.',
   turnover_fg                         INTEGER     NOT NULL COMMENT 'Flag kennzeichnet die Umsatzrelevanz des Bons. 1 = relevant.',
   wrg_id                              VARCHAR(3)       COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
   reactivated_fg                      INTEGER     NOT NULL DEFAULT 0 COMMENT 'SPALTE WIRD NICHT BEFÜLLT / FUNKTIONIERT NICHT. Bons können zurückgestellt und später reaktiviert werden (= 1), wenn z.Bsp. der Kunde nicht gleich zahlen kann. Diese Bons verbleiben länger im System und die Zeiten dürfen nicht in die Berechnungen eingehen.',
   personal_id                         VARCHAR(25)      COMMENT 'Personalnummer (nur bei Personalrabatt) als Hashwert verfremdet (Compress).',
   betrag_personal_rabatt              NUMBER(29,4)     COMMENT 'Mitarbeiterrabatt als Geldbetrag.',
   kpos_kasse_typ                      VARCHAR(10)      COMMENT 'Im Kassensystem KPOS verwendete nicht-numerische Kassentypen.',
   wagen_nr                            INTEGER     COMMENT 'Nummer des Einkaufswagens.',
   kundenkarte_id                      VARCHAR(255)     COMMENT 'Beinhaltet die gehashte Kundennummer.',
   druecken_summentaste                TIMESTAMP_NTZ(9) COMMENT 'Zeitstempel wird erzeugt wenn die Summentaste an der Kasse gedrückt wird; Zeitstempel wird nur einmalig erzeugt.',
   schliessen_kassenschublade          TIMESTAMP_NTZ(9) COMMENT 'Zeitstempel wird an der Kasse erzeugt, wenn die Kassenlade geschlossen wird.',
   fiskalisierung_fg                   INTEGER     NOT NULL DEFAULT 0 COMMENT 'Kennzeichnung für einen Bon, ob dieser für Fiskalisierung relevant ist.',
   bon_nr_fiscal                       INTEGER     COMMENT 'In Kombination mit Kasse und Markt einmalig kombiniertes Feld (Fiscal invoice receipt).',
   alternative_karte_id                VARCHAR(255)     COMMENT 'Beinhaltet gehashte kundenkartennummer, außer KCARD ( Z.B:TCBO, Payback).Es können in einigen Ländern beide Kartentyp gleichzeitig, Kaufland Card und eine_1 andere, an der Kasse gezeigt werden, in welchem Fall dann die KL-Card Kundennummer in Spalte kundenkarte_id geschrieben wird und in dieser Spalte die Nummer der anderen Karte.',
   suspended_fg                        INTEGER     NOT NULL DEFAULT 0 COMMENT 'Flag: Kennzeichnung des Suspended-Status_1 der Transaktion. 1 = suspended',
   suspended_bon_nr                    INTEGER     COMMENT 'Bonnummer des zuvor zurückgestellten Bons. Ein reaktivierter Bon erhält eine_1 neue Bonnummer und mit dieser Spalte kann auf den vorher zurückgestellten Bon verwiesen werden.
            Bons können zurückgestellt und später reaktiviert werden, wenn z.Bsp. der Kunde nicht gleich zahlen kann. Diese Bons verbleiben länger im Kassensystem und die Zeiten dürfen nicht in die Berechnungen eingehen.',
   online_fg                           INTEGER     NOT NULL DEFAULT 0 COMMENT 'Kennzeichnet einen Online Bon; Fg = 1 = Online Bon liegt vor; Fg = 0 = Offline Bon liegt vor. Sobald eine_1 Bonzeile ein Online-Verkauf ist, zählt der Bon als Online. Quelle Kassen XML aztec Code Stelle 2 E-Food / Offline mit umgekehrter Flag Logik.',
   online_transaktion_id               INTEGER     NOT NULL DEFAULT 0 COMMENT 'Transaktionsnummer, einzigartig innerhalbt eines Bons. Tritt nur bei Online Bestellungen auf. Quelle: Kassen XML Aztec Code Stelle 5 TransactionID.',
   online_bestellung_nr                VARCHAR(100)     NOT NULL DEFAULT '0' COMMENT 'Bestellnummer bei Online Bestellungen, alphanumerisch mit unterschiedlicher Länge. Quelle: Kassen XML Aztec Code Stelle 7 Ordernumber.',
   dienstleister_id                    INTEGER     NOT NULL DEFAULT -1 COMMENT 'Bei Online Bestellungen wird ein Dienstleister beauftragt die bestellte Ware zusammen zu stellen. ID kann 0 bis 9 annehmen. Siehe Lookup Tabelle l_dienstleister_1 und dienstleister_spr_zu. Quelle Kassen XML Aztec Code Stelle 4 VendorID.',
   geraet_id                           INTEGER     NOT NULL DEFAULT 0 COMMENT 'Gerätekennzeichnung mit dem die online bestellte Ware gescannt wurde. < 200 Waage; >200 und < 800 Geschenkkorb (MDE); > 800 MDE E-Food RO. Quelle Kassen XML Aztec Code Stelle 6 DeviceID.',
   bon_typ_id                          INTEGER     NOT NULL DEFAULT -1 COMMENT 'Kennzeichnet den Typ des Bons: 0 = rein gedruckter Bon; 1 = gedruckter Bon mit Sendung an Web Service; 2 = reiner Digitalbon. Quelle: Kassen XML digitalReceipt.',
   bon_gedruckt_fg                     INTEGER     NOT NULL COMMENT 'Gibt an, ob der Bon ausgedruckt wurde. 1 = Bon ausgedruckt; 0 = Bon nicht ausgedruckt. Default = 1 (in ETL definiert). Quelle ./paperReceiptPrintout',
   bondruck_abgelehnt_fg               INTEGER     NOT NULL COMMENT 'Gibt an, ob der Kunde "an der Kasse" auf Nachfrage den Bondruck abgelehnt hat. 1 = ja(abgelehnt); 0 = nein (nicht abgelehnt). Default = -1 (für Altdaten. in ETL definiert). Quelle ./customerSuppressedReceipt. 
            Ist beim Kunde im CRM / K Card "kein Druck des Bons" hinterlegt hat, erhält diese Spalte trotzdem 0 (false). In diesem Fall wäre_1 sowohl bon_abgelehnt_fg, als auch bon_gedruckt_fg gleich 0. Bei Self Checkout Kassen gilt der Bondruck als automatisch abgelehnt, wenn der Kunde innerhalb von 5 Sekunden nicht den Audruck auswählt.',
   kundenkarte_status_bez              VARCHAR(20)      COMMENT 'Gibt den Status_1 der Kundenkarte an, den die Kasse vom CRM in der Schnittstelle erhält. Quelle ../loyaltyCardPositions/state
            SUCCESSFUL -> Request & Response an CRM technisch erfolgreich, Karte ohne Fehler vom CRM gemeldet -> CRM Promotions angewendet/gegeben
            PENDING -> Randfall technisch: Request läuft jedoch keine Response bis zum Transaktions-Abschluss (oder Bon Abbruch cellation oder Hard-Reset) -> keine CRM Promotion angewendet
            INITIALIZED -> Randfall technisch: Request initialisiert aber Kasse wird während der Transaktion heruntergefahren oder Transaktion aus einem anderen Grund systemseitig automatisch abgebrochen -> keine CRM Promotion angewendet (ist ohnehin keine reguläre_1 SALES_1 Transaktion)
            FAILED -> abhängig vom gemeldeten errorcode, ob CRM Promotion gewährt wird
            TIMEDOUT -> abhängig vom gemeldeten errorcode, ob CRM Promotion gewährt wird',
   kundenkarte_fehler_txt              VARCHAR(50)      COMMENT 'Errorcode der Kundenkarte, den die Kasse vom CRM in der Schnittstelle erhält. Quelle ../loyaltyCardPositions/errorcode
            ERROR_ARVADO_INTERNAL (arvato state: true)                -> no CRM BBYs, only common BBYs
            ERROR_ARVADO_UNSUPPORTED(arvato state: true)      -> no CRM BBYs, only common BBYs
            ERROR_CARD_NOT_ACTIVATED(arvato state: true)          -> no CRM BBYs, only common BBYs
            ERROR_CARD_UNKNOWN(arvato state: true)                    -> no CRM BBYs, only common BBYs
            ERROR_INTERNAL(arvato state: false)                                    -> common BBYs + CRM customer BBYs granted
            ERROR_INVALID_RESPONSE(arvato state: false)                -> common BBYs + CRM customer BBYs granted
            ERROR_IO(arvato state: false)                                                   -> common BBYs + CRM customer BBYs granted
            "NULL"                                                                                                -> all promotions are granted',
   loyalty_berechtigt_fg               INTEGER     COMMENT 'Gibt an, ob CRM Promotion gewährt wurde. 1 = ja; 0 = nein. Ob eine_1 Promotion aufgrund der CRM-Karte gewährt wird, hängt sowohl vom kundenkarte_status_bez als auch vom kundenkarte_fehler_txt ab, den die Kasse vom CRM in der Schnittstelle erhält.',
   bon_id_orig                         VARCHAR(25)      COMMENT 'Bon-ID des Ursprungeinakufs bei Retouren.',
   bon_dat_orig                        DATE             COMMENT 'Datum des Ursprungseinkaufs bei Retouren.',
   wup_id_orig                         INTEGER     COMMENT 'Martknummer des Urpsrungeinkaufs bei Retouren.',
   kasse_nr_orig                       INTEGER     COMMENT 'Nummer der Kasse des Ursprungskauf bei Retouren.',
   kundenkarte_programm_cd             VARCHAR(10)      COMMENT 'Gibt den Kundenbindungsprogramm der Karte wieder.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ODS_BON_KOPF PRIMARY KEY (bon_id, bon_dat, wup_id, mandant_id) NOT ENFORCED
)  COMMENT = 'ODS - Aus den Kassensystemen near Realtime geladene Bon-Köpfe';
