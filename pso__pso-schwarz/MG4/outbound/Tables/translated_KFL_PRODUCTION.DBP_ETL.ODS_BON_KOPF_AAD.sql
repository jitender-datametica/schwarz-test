DROP TABLE IF EXISTS kfl_production_dbp_etl.ods_bon_kopf_aad;
CREATE OR REPLACE TABLE kfl_production_dbp_etl.ods_bon_kopf_aad (
bon_id STRING(25) NOT NULL OPTIONS(description='Eindeutige ID eines Bons, generierter Hashwert.'),
bon_dat DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey.'),
kasse_typ_id INTEGER
OPTIONS(description='Kassentyp. Folgende Typen kommen vor: 1 = default (Sales POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office), 5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt.'),
kundenkarte_typ_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='ID zum Kundenkartentyp mit Werten 0, 1, 2. '),
wup_id INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprüft.'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH - ein Mandant pro Land.'),
bon_nr INTEGER NOT NULL
OPTIONS(description='Die Bonnummer des Bons (ist eine fortlaufende Nummer die in der Kasse generiert wird, im Normalfall ist diese Nummer pro Tag und Kasse unique).'),
kasse_nr INTEGER NOT NULL OPTIONS(description='Nummer der Kasse.'),
kassierer_nr STRING(4) OPTIONS(description='Nummer des Kassierers.'),
kunde_fg INTEGER NOT NULL
OPTIONS(description='Gibt an, ob dieser Bon für die Kundenzählung relevant ist. 1 = ja, 0 = nein.'),
bon_beginn DATETIME OPTIONS(description='Start-Zeitpunkt des Bons.'),
bon_ende DATETIME OPTIONS(description='Ende-Zeitpunkt des Bons.'),
umsatz_mwst NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Auf den Mehrwertsteueranteil entfallender Betrag.'),
umsatz_brutto NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz Brutto Betrag.'),
bon_booking DATETIME NOT NULL
OPTIONS(description='Buchungszeitpunkt des Bons, relevant z.Bsp. für artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine Kasse offline war.'),
dat_booking DATE NOT NULL
OPTIONS(description='Buchungsdatum des Bons, relevant z.Bsp. für artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine Kasse offline war. Redundant zu bon_booking aus Performancegründen.'),
turnover_fg INTEGER NOT NULL OPTIONS(description='Flag kennzeichnet die Umsatzrelevanz des Bons. 1 = relevant.'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
reactivated_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='SPALTE WIRD NICHT BEFÜLLT / FUNKTIONIERT NICHT. Bons können zurückgestellt und später reaktiviert werden (= 1), wenn z.Bsp. der Kunde nicht gleich zahlen kann. Diese Bons verbleiben länger im System und die Zeiten dürfen nicht in die Berechnungen eingehen.'),
personal_id STRING(25)
OPTIONS(description='Personalnummer (nur bei Personalrabatt) als Hashwert verfremdet (Compress).'),
betrag_personal_rabatt NUMERIC(18,4) OPTIONS(description='Mitarbeiterrabatt als Geldbetrag.'),
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
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
paybackkarte_id STRING(255)
OPTIONS(description='Beinhaltet die gehashte Payback-Kundennummer. Es können in einigen Ländern beide Karten gleichzeitig, Kaufland Card und Payback Karte, an der Kasse gezeigt werden, in welchem Fall dann die KL-Card Kundennummer in Spalte kundenkarte_id geschrieben wird und in dieser Spalte die Nummer der Payback Karte.'),
suspended_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag: Kennzeichnung des Suspended-Status der Transaktion. 1 = suspended'),
suspended_bon_nr INTEGER
OPTIONS(description='Bonnummer des zuvor zurückgestellten Bons. Ein reaktivierter Bon erhält eine neue Bonnummer und mit dieser Spalte kann auf den vorher zurückgestellten Bon verwiesen werden.\n            Bons können zurückgestellt und später reaktiviert werden, wenn z.Bsp. der Kunde nicht gleich zahlen kann. Diese Bons verbleiben länger im Kassensystem und die Zeiten dürfen nicht in die Berechnungen eingehen.'),
online_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Kennzeichnet einen Online Bon; Fg = 1 = Online Bon liegt vor; Fg = 0 = Offline Bon liegt vor. Sobald eine Bonzeile ein Online-Verkauf ist, zählt der Bon als Online. Quelle Kassen XML aztec Code Stelle 2 E-Food / Offline mit umgekehrter Flag Logik.'),
online_transaktion_id INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Transaktionsnummer, einzigartig innerhalbt eines Bons. Tritt nur bei Online Bestellungen auf. Quelle: Kassen XML Aztec Code Stelle 5 TransactionID.'),
online_bestellung_nr STRING(100) DEFAULT '0' NOT NULL
OPTIONS(description='Bestellnummer bei Online Bestellungen, alphanumerisch mit unterschiedlicher Länge. Quelle: Kassen XML Aztec Code Stelle 7 Ordernumber.'),
dienstleister_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Bei Online Bestellungen wird ein Dienstleister beauftragt die bestellte Ware zusammen zu stellen. ID kann 0 bis 9 annehmen. Siehe Lookup Tabelle l_dienstleister und dienstleister_spr_zu. Quelle Kassen XML Aztec Code Stelle 4 VendorID.'),
geraet_id INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Gerätekennzeichnung mit dem die online bestellte Ware gescannt wurde. < 200 Waage; >200 und < 800 Geschenkkorb (MDE); > 800 MDE E-Food RO. Quelle Kassen XML Aztec Code Stelle 6 DeviceID.'),
bon_typ_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Kennzeichnet den Typ des Bons: 0 = rein gedruckter Bon; 1 = gedruckter Bon mit Sendung an Web Service; 2 = reiner Digitalbon. Quelle: Kassen XML digitalReceipt.'),
PRIMARY KEY (bon_id, bon_dat, wup_id, mandant_id) NOT ENFORCED
) CLUSTER BY mandant_id, bon_dat, wup_id;