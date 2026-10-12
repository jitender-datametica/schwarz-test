DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_ODS.ODS_BON_KOPF_2;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_ODS.ODS_BON_KOPF_2 (
BON_ID STRING(25) NOT NULL OPTIONS(description='Eindeutige ID eines Bons, generierter Hashwert.'),
BON_DAT DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey.'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH - ein Mandant_2 pro Land.'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprüft.'),
KASSE_TYP_ID INTEGER
OPTIONS(description='Kassentyp. Folgende Typen kommen vor: 1 = default (Sales_2 POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office), 5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt.'),
KUNDENKARTE_TYP_ID INTEGER DEFAULT 0 NOT NULL OPTIONS(description='ID zum Kundenkartentyp mit Werten 0, 1, 2. '),
BON_NR INTEGER NOT NULL
OPTIONS(description='Die Bonnummer des Bons (ist eine_2 fortlaufende Nummer die in der Kasse generiert wird, im Normalfall ist diese Nummer pro Tag_2 und Kasse unique).'),
KASSE_NR INTEGER NOT NULL OPTIONS(description='Nummer der Kasse.'),
KASSIERER_NR STRING(4) OPTIONS(description='Nummer des Kassierers.'),
KUNDE_FG INTEGER NOT NULL
OPTIONS(description='Gibt an, ob dieser Bon für die Kundenzählung relevant ist. 1 = ja, 0 = nein.'),
BON_BEGINN DATETIME OPTIONS(description='Start-Zeitpunkt des Bons.'),
BON_ENDE DATETIME OPTIONS(description='Ende-Zeitpunkt des Bons.'),
UMSATZ_MWST NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Auf den Mehrwertsteueranteil entfallender Betrag.'),
UMSATZ_BRUTTO NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz Brutto Betrag.'),
BON_BOOKING DATETIME NOT NULL
OPTIONS(description='Buchungszeitpunkt des Bons, relevant z.Bsp. für artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine_2 Kasse offline war.'),
DAT_BOOKING DATE NOT NULL
OPTIONS(description='Buchungsdatum des Bons, relevant z.Bsp. für artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine_2 Kasse offline war. Redundant zu bon_booking aus Performancegründen.'),
TURNOVER_FG INTEGER NOT NULL OPTIONS(description='Flag kennzeichnet die Umsatzrelevanz des Bons. 1 = relevant.'),
WRG_ID STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
REACTIVATED_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='SPALTE WIRD NICHT BEFÜLLT / FUNKTIONIERT NICHT. Bons können zurückgestellt und später reaktiviert werden (= 1), wenn z.Bsp. der Kunde nicht gleich zahlen kann. Diese Bons verbleiben länger im System und die Zeiten dürfen nicht in die Berechnungen eingehen.'),
PERSONAL_ID STRING(25)
OPTIONS(description='Personalnummer (nur bei Personalrabatt) als Hashwert verfremdet (Compress).'),
BETRAG_PERSONAL_RABATT NUMERIC(18,4) OPTIONS(description='Mitarbeiterrabatt als Geldbetrag.'),
KPOS_KASSE_TYP STRING(10) OPTIONS(description='Im Kassensystem KPOS verwendete nicht-numerische Kassentypen.'),
WAGEN_NR INTEGER OPTIONS(description='Nummer des Einkaufswagens.'),
KUNDENKARTE_ID STRING(255) OPTIONS(description='Beinhaltet die gehashte Kundennummer.'),
DRUECKEN_SUMMENTASTE DATETIME
OPTIONS(description='Zeitstempel wird erzeugt wenn die Summentaste an der Kasse gedrückt wird; Zeitstempel wird nur einmalig erzeugt.'),
SCHLIESSEN_KASSENSCHUBLADE DATETIME
OPTIONS(description='Zeitstempel wird an der Kasse erzeugt, wenn die Kassenlade geschlossen wird.'),
FISKALISIERUNG_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Kennzeichnung für einen Bon, ob dieser für Fiskalisierung relevant ist.'),
BON_NR_FISCAL INTEGER
OPTIONS(description='In Kombination mit Kasse und Markt einmalig kombiniertes Feld (Fiscal invoice receipt).'),
ALTERNATIVE_KARTE_ID STRING(255)
OPTIONS(description='Beinhaltet gehashte kundenkartennummer, außer KCARD ( Z.B:TCBO, Payback).Es können in einigen Ländern beide Kartentyp gleichzeitig, Kaufland Card und eine_2 andere, an der Kasse gezeigt werden, in welchem Fall dann die KL-Card Kundennummer in Spalte kundenkarte_id geschrieben wird und in dieser Spalte die Nummer der anderen Karte.'),
SUSPENDED_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag: Kennzeichnung des Suspended-Status_2 der Transaktion. 1 = suspended'),
SUSPENDED_BON_NR INTEGER
OPTIONS(description='Bonnummer des zuvor zurückgestellten Bons. Ein reaktivierter Bon erhält eine_2 neue Bonnummer und mit dieser Spalte kann auf den vorher zurückgestellten Bon verwiesen werden.\n            Bons können zurückgestellt und später reaktiviert werden, wenn z.Bsp. der Kunde nicht gleich zahlen kann. Diese Bons verbleiben länger im Kassensystem und die Zeiten dürfen nicht in die Berechnungen eingehen.'),
ONLINE_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Kennzeichnet einen Online Bon; Fg = 1 = Online Bon liegt vor; Fg = 0 = Offline Bon liegt vor. Sobald eine_2 Bonzeile ein Online-Verkauf ist, zählt der Bon als Online. Quelle Kassen XML aztec Code Stelle 2 E-Food / Offline mit umgekehrter Flag Logik.'),
ONLINE_TRANSAKTION_ID INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Transaktionsnummer, einzigartig innerhalbt eines Bons. Tritt nur bei Online Bestellungen auf. Quelle: Kassen XML Aztec Code Stelle 5 TransactionID.'),
ONLINE_BESTELLUNG_NR STRING(100) DEFAULT '0' NOT NULL
OPTIONS(description='Bestellnummer bei Online Bestellungen, alphanumerisch mit unterschiedlicher Länge. Quelle: Kassen XML Aztec Code Stelle 7 Ordernumber.'),
DIENSTLEISTER_ID INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Bei Online Bestellungen wird ein Dienstleister beauftragt die bestellte Ware zusammen zu stellen. ID kann 0 bis 9 annehmen. Siehe Lookup Tabelle l_dienstleister_2 und dienstleister_spr_zu. Quelle Kassen XML Aztec Code Stelle 4 VendorID.'),
GERAET_ID INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Gerätekennzeichnung mit dem die online bestellte Ware gescannt wurde. < 200 Waage; >200 und < 800 Geschenkkorb (MDE); > 800 MDE E-Food RO. Quelle Kassen XML Aztec Code Stelle 6 DeviceID.'),
BON_TYP_ID INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Kennzeichnet den Typ des Bons: 0 = rein gedruckter Bon; 1 = gedruckter Bon mit Sendung an Web Service; 2 = reiner Digitalbon. Quelle: Kassen XML digitalReceipt.'),
BON_GEDRUCKT_FG INTEGER NOT NULL
OPTIONS(description='Gibt an, ob der Bon ausgedruckt wurde. 1 = Bon ausgedruckt; 0 = Bon nicht ausgedruckt. Default = 1 (in ETL definiert). Quelle ./paperReceiptPrintout'),
BONDRUCK_ABGELEHNT_FG INTEGER NOT NULL
OPTIONS(description='Gibt an, ob der Kunde\"an der Kasse\" auf Nachfrage den Bondruck abgelehnt hat. 1 = ja(abgelehnt); 0 = nein (nicht abgelehnt). Default = -1 (für Altdaten. in ETL definiert). Quelle ./customerSuppressedReceipt.\n            Ist beim Kunde im CRM / K Card\"kein Druck des Bons\" hinterlegt hat, erhält diese Spalte trotzdem 0 (false). In diesem Fall wäre_2 sowohl bon_abgelehnt_fg, als auch bon_gedruckt_fg gleich 0. Bei Self Checkout Kassen gilt der Bondruck als automatisch abgelehnt, wenn der Kunde innerhalb von 5 Sekunden nicht den Audruck auswählt.'),
KUNDENKARTE_STATUS_BEZ STRING(20)
OPTIONS(description='Gibt den Status_2 der Kundenkarte an, den die Kasse vom CRM in der Schnittstelle erhält. Quelle ../loyaltyCardPositions/state\n            SUCCESSFUL -> Request & Response an CRM technisch erfolgreich, Karte ohne Fehler vom CRM gemeldet -> CRM Promotions angewendet/gegeben\n            PENDING -> Randfall technisch: Request läuft jedoch keine Response bis zum Transaktions-Abschluss (oder Bon Abbruch cellation oder Hard-Reset) -> keine CRM Promotion angewendet\n            INITIALIZED -> Randfall technisch: Request initialisiert aber Kasse wird während der Transaktion heruntergefahren oder Transaktion aus einem anderen Grund systemseitig automatisch abgebrochen -> keine CRM Promotion angewendet (ist ohnehin keine reguläre_2 SALES_2 Transaktion)\n            FAILED -> abhängig vom gemeldeten errorcode, ob CRM Promotion gewährt wird\n            TIMEDOUT -> abhängig vom gemeldeten errorcode, ob CRM Promotion gewährt wird'),
KUNDENKARTE_FEHLER_TXT STRING(50)
OPTIONS(description='Errorcode der Kundenkarte, den die Kasse vom CRM in der Schnittstelle erhält. Quelle ../loyaltyCardPositions/errorcode\n            ERROR_ARVADO_INTERNAL (arvato state: true)                -> no CRM BBYs, only common BBYs\n            ERROR_ARVADO_UNSUPPORTED(arvato state: true)      -> no CRM BBYs, only common BBYs\n            ERROR_CARD_NOT_ACTIVATED(arvato state: true)          -> no CRM BBYs, only common BBYs\n            ERROR_CARD_UNKNOWN(arvato state: true)                    -> no CRM BBYs, only common BBYs\n            ERROR_INTERNAL(arvato state: false)                                    -> common BBYs + CRM customer BBYs granted\n            ERROR_INVALID_RESPONSE(arvato state: false)                -> common BBYs + CRM customer BBYs granted\n            ERROR_IO(arvato state: false)                                                   -> common BBYs + CRM customer BBYs granted\n\"NULL\"                                                                                                -> a'),
LOYALTY_BERECHTIGT_FG INTEGER
OPTIONS(description='Gibt an, ob CRM Promotion gewährt wurde. 1 = ja; 0 = nein. Ob eine_2 Promotion aufgrund der CRM-Karte gewährt wird, hängt sowohl vom kundenkarte_status_bez als auch vom kundenkarte_fehler_txt ab, den die Kasse vom CRM in der Schnittstelle erhält.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
BON_ID_ORIG STRING(25) OPTIONS(description='Bon-ID des Ursprungeinakufs bei Retouren.'),
BON_DAT_ORIG DATE OPTIONS(description='Datum des Ursprungseinkaufs bei Retouren.'),
WUP_ID_ORIG INTEGER OPTIONS(description='Martknummer des Urpsrungeinkaufs bei Retouren.'),
KASSE_NR_ORIG INTEGER OPTIONS(description='Nummer der Kasse des Ursprungskauf bei Retouren.'),
KUNDENKARTE_PROGRAMM_CD STRING(10) OPTIONS(description='Gibt den Kundenbindungsprogramm der Karte wieder.'),
PRIMARY KEY (BON_ID, BON_DAT, WUP_ID, MANDANT_ID) NOT ENFORCED
) CLUSTER BY MANDANT_ID, BON_DAT, WUP_ID
OPTIONS(description='ODS - Aus den Kassensystemen near Realtime geladene Bon-Köpfe');