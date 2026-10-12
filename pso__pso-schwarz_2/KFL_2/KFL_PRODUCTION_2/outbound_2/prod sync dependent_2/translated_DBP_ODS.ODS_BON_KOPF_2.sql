DROP TABLE IF EXISTS kfl_production_dbp_ods.ods_bon_kopf_2;
CREATE OR REPLACE TABLE kfl_production_dbp_ods.ods_bon_kopf_2 (
bon_id STRING(25) NOT NULL OPTIONS(description='Eindeutige ID eines Bons, generierter Hashwert.'),
bon_dat DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey.'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH - ein Mandant_2 pro Land.'),
wup_id INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprüft.'),
kasse_typ_id INTEGER
OPTIONS(description='Kassentyp. Folgende Typen kommen vor: 1 = default (Sales_2 POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office), 5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt.'),
kundenkarte_typ_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='ID zum Kundenkartentyp mit Werten 0, 1, 2. '),
bon_nr INTEGER NOT NULL
OPTIONS(description='Die Bonnummer des Bons (ist eine_2 fortlaufende Nummer die in der Kasse generiert wird, im Normalfall ist diese Nummer pro Tag_2 und Kasse unique).'),
kasse_nr INTEGER NOT NULL OPTIONS(description='Nummer der Kasse.'),
kassierer_nr STRING(4) OPTIONS(description='Nummer des Kassierers.'),
kunde_fg INTEGER NOT NULL
OPTIONS(description='Gibt an, ob dieser Bon für die Kundenzählung relevant ist. 1 = ja, 0 = nein.'),
bon_beginn DATETIME OPTIONS(description='Start-Zeitpunkt des Bons.'),
bon_ende DATETIME OPTIONS(description='Ende-Zeitpunkt des Bons.'),
umsatz_mwst NUMERIC(29,4) DEFAULT 0 NOT NULL OPTIONS(description='Auf den Mehrwertsteueranteil entfallender Betrag.'),
umsatz_brutto NUMERIC(29,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz Brutto Betrag.'),
bon_booking DATETIME NOT NULL
OPTIONS(description='Buchungszeitpunkt des Bons, relevant z.Bsp. für artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine_2 Kasse offline war.'),
dat_booking DATE NOT NULL
OPTIONS(description='Buchungsdatum des Bons, relevant z.Bsp. für artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine_2 Kasse offline war. Redundant zu bon_booking aus Performancegründen.'),
turnover_fg INTEGER NOT NULL OPTIONS(description='Flag kennzeichnet die Umsatzrelevanz des Bons. 1 = relevant.'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
reactivated_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='SPALTE WIRD NICHT BEFÜLLT / FUNKTIONIERT NICHT. Bons können zurückgestellt und später reaktiviert werden (= 1), wenn z.Bsp. der Kunde nicht gleich zahlen kann. Diese Bons verbleiben länger im System und die Zeiten dürfen nicht in die Berechnungen eingehen.'),
personal_id STRING(25)
OPTIONS(description='Personalnummer (nur bei Personalrabatt) als Hashwert verfremdet (Compress).'),
betrag_personal_rabatt NUMERIC(29,4) OPTIONS(description='Mitarbeiterrabatt als Geldbetrag.'),
kpos_kasse_typ STRING(10) OPTIONS(description='Im Kassensystem KPOS verwendete nicht-numerische Kassentypen.'),
wagen_nr INTEGER OPTIONS(description='Nummer des Einkaufswagens.'),
kundenkarte_id STRING(255) OPTIONS(description='Beinhaltet die gehashte Kundennummer.'),
druecken_summentaste DATETIME
OPTIONS(description='Zeitstempel wird erzeugt wenn die Summentaste an der Kasse gedrückt wird; Zeitstempel wird nur einmalig erzeugt.'),
schliessen_kassenschublade DATETIME
OPTIONS(description='Zeitstempel wird an der Kasse erzeugt, wenn die Kassenlade geschlossen wird.'),
fiskalisierung_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Kennzeichnung für einen Bon, ob dieser für Fiskalisierung relevant ist.'),
bon_nr_fiscal INTEGER
OPTIONS(description='In Kombination mit Kasse und Markt einmalig kombiniertes Feld (Fiscal invoice receipt).'),
alternative_karte_id STRING(255)
OPTIONS(description='Beinhaltet gehashte kundenkartennummer, außer KCARD ( Z.B:TCBO, Payback).Es können in einigen Ländern beide Kartentyp gleichzeitig, Kaufland Card und eine_2 andere, an der Kasse gezeigt werden, in welchem Fall dann die KL-Card Kundennummer in Spalte kundenkarte_id geschrieben wird und in dieser Spalte die Nummer der anderen Karte.'),
suspended_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag: Kennzeichnung des Suspended-Status_2 der Transaktion. 1 = suspended'),
suspended_bon_nr INTEGER
OPTIONS(description='Bonnummer des zuvor zurückgestellten Bons. Ein reaktivierter Bon erhält eine_2 neue Bonnummer und mit dieser Spalte kann auf den vorher zurückgestellten Bon verwiesen werden.\n            Bons können zurückgestellt und später reaktiviert werden, wenn z.Bsp. der Kunde nicht gleich zahlen kann. Diese Bons verbleiben länger im Kassensystem und die Zeiten dürfen nicht in die Berechnungen eingehen.'),
online_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Kennzeichnet einen Online Bon; Fg = 1 = Online Bon liegt vor; Fg = 0 = Offline Bon liegt vor. Sobald eine_2 Bonzeile ein Online-Verkauf ist, zählt der Bon als Online. Quelle Kassen XML aztec Code Stelle 2 E-Food / Offline mit umgekehrter Flag Logik.'),
online_transaktion_id INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Transaktionsnummer, einzigartig innerhalbt eines Bons. Tritt nur bei Online Bestellungen auf. Quelle: Kassen XML Aztec Code Stelle 5 TransactionID.'),
online_bestellung_nr STRING(100) DEFAULT '0' NOT NULL
OPTIONS(description='Bestellnummer bei Online Bestellungen, alphanumerisch mit unterschiedlicher Länge. Quelle: Kassen XML Aztec Code Stelle 7 Ordernumber.'),
dienstleister_id INTEGER DEFAULT -1 NOT NULL
OPTIONS(description='Bei Online Bestellungen wird ein Dienstleister beauftragt die bestellte Ware zusammen zu stellen. ID kann 0 bis 9 annehmen. Siehe Lookup Tabelle l_dienstleister_2 und dienstleister_spr_zu. Quelle Kassen XML Aztec Code Stelle 4 VendorID.'),
geraet_id INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Gerätekennzeichnung mit dem die online bestellte Ware gescannt wurde. < 200 Waage; >200 und < 800 Geschenkkorb (MDE); > 800 MDE E-Food RO. Quelle Kassen XML Aztec Code Stelle 6 DeviceID.'),
bon_typ_id INTEGER DEFAULT -1 NOT NULL
OPTIONS(description='Kennzeichnet den Typ des Bons: 0 = rein gedruckter Bon; 1 = gedruckter Bon mit Sendung an Web Service; 2 = reiner Digitalbon. Quelle: Kassen XML digitalReceipt.'),
bon_gedruckt_fg INTEGER NOT NULL
OPTIONS(description='Gibt an, ob der Bon ausgedruckt wurde. 1 = Bon ausgedruckt; 0 = Bon nicht ausgedruckt. Default = 1 (in ETL definiert). Quelle ./paperReceiptPrintout'),
bondruck_abgelehnt_fg INTEGER NOT NULL
OPTIONS(description='Gibt an, ob der Kunde\""an der Kasse\"" auf Nachfrage den Bondruck abgelehnt hat. 1 = ja(abgelehnt); 0 = nein (nicht abgelehnt). Default = -1 (für Altdaten. in ETL definiert). Quelle ./customerSuppressedReceipt.\n            Ist beim Kunde im CRM / K Card\""kein Druck des Bons\"" hinterlegt hat, erhält diese Spalte trotzdem 0 (false). In diesem Fall wäre_2 sowohl bon_abgelehnt_fg, als auch bon_gedruckt_fg gleich 0. Bei Self Checkout Kassen gilt der Bondruck als automatisch abgelehnt, wenn der Kunde innerhalb von 5 Sekunden nicht den Audruck auswählt.'),
kundenkarte_status_bez STRING(20)
OPTIONS(description='Gibt den Status_2 der Kundenkarte an, den die Kasse vom CRM in der Schnittstelle erhält. Quelle ../loyaltyCardPositions/state\n            SUCCESSFUL -> Request & Response an CRM technisch erfolgreich, Karte ohne Fehler vom CRM gemeldet -> CRM Promotions angewendet/gegeben\n            PENDING -> Randfall technisch: Request läuft jedoch keine Response bis zum Transaktions-Abschluss (oder Bon Abbruch cellation oder Hard-Reset) -> keine CRM Promotion angewendet\n            INITIALIZED -> Randfall technisch: Request initialisiert aber Kasse wird während der Transaktion heruntergefahren oder Transaktion aus einem anderen Grund systemseitig automatisch abgebrochen -> keine CRM Promotion angewendet (ist ohnehin keine reguläre_2 SALES_2 Transaktion)\n            FAILED -> abhängig vom gemeldeten errorcode, ob CRM Promotion gewährt wird\n            TIMEDOUT -> abhängig vom gemeldeten errorcode, ob CRM Promotion gewährt wird'),
kundenkarte_fehler_txt STRING(50)
OPTIONS(description='Errorcode der Kundenkarte, den die Kasse vom CRM in der Schnittstelle erhält. Quelle ../loyaltyCardPositions/errorcode\n            ERROR_ARVADO_INTERNAL (arvato state: true)no CRM BBYs, only common BBYs ERROR_ARVADO_UNSUPPORTED(arvato state: true)no CRM BBYs, only common BBYs\n     ERROR_CARD_NOT_ACTIVATED(arvato state: true)no CRM BBYs, only common BBYs ERROR_CARD_UNKNOWN(arvato state: true)no CRM BBYs, only common BBYs ERROR_INTERNAL(arvato state: false)common BBYs + CRM customer BBYs granted ERROR_INVALID_RESPONSE(arvato state: false) common BBYs + CRM customer BBYs granted\n            ERROR_IO(arvato state: false)common BBYs + CRM customer BBYs granted\n\""NULL\""                                         all promotions are granted'),
loyalty_berechtigt_fg INTEGER
OPTIONS(description='Gibt an, ob CRM Promotion gewährt wurde. 1 = ja; 0 = nein. Ob eine_2 Promotion aufgrund der CRM-Karte gewährt wird, hängt sowohl vom kundenkarte_status_bez als auch vom kundenkarte_fehler_txt ab, den die Kasse vom CRM in der Schnittstelle erhält.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
bon_id_orig STRING(25) OPTIONS(description='Bon-ID des Ursprungeinakufs bei Retouren.'),
bon_dat_orig DATE OPTIONS(description='Datum des Ursprungseinkaufs bei Retouren.'),
wup_id_orig INTEGER OPTIONS(description='Martknummer des Urpsrungeinkaufs bei Retouren.'),
kasse_nr_orig INTEGER OPTIONS(description='Nummer der Kasse des Ursprungskauf bei Retouren.'),
kundenkarte_programm_cd STRING(10) OPTIONS(description='Gibt den Kundenbindungsprogramm der Karte wieder.'),
PRIMARY KEY (bon_id, bon_dat, wup_id, mandant_id) NOT ENFORCED
) CLUSTER BY mandant_id, bon_dat, wup_id
OPTIONS(description='ODS - Aus den Kassensystemen near Realtime geladene Bon-Köpfe');

