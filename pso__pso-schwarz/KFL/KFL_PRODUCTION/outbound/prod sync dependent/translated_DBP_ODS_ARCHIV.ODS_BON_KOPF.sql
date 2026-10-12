DROP TABLE IF EXISTS kfl_production_dbp_ods_archiv.ods_bon_kopf;
CREATE OR REPLACE TABLE kfl_production_dbp_ods_archiv.ods_bon_kopf (
bon_id STRING(100) NOT NULL OPTIONS(description='eindeutige ID eines Bons, generierter Hashwert'),
bon_dat DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey'),
kasse_typ_id INTEGER
OPTIONS(description='Kassentyp. Folgende Typen kommen vor: 1 = default(Sales POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt'),
kundenkarte_typ_id INTEGER NOT NULL OPTIONS(description='ID zur Kundenkarte mit Werten 0 und 1'),
wup_id INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprueft'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH - ein Mandant pro Land'),
bon_nr INTEGER NOT NULL
OPTIONS(description='Die Bonnummer des Bons (ist eine fortlaufende Nummer die in der Kasse generiert wird, im Normal Fall ist diese Nummer pro Tag und Kasse Unique)'),
kasse_nr INTEGER NOT NULL OPTIONS(description='Nummer der Kasse'),
kassierer_nr STRING(16) OPTIONS(description='Nummer des Kassierers'),
kunde_fg INTEGER NOT NULL
OPTIONS(description='Gibt an, ob dieser Bon für die Kundenzaehlung relevant ist. 1 = ja, 0 = nein'),
bon_beginn DATETIME OPTIONS(description='Start-Zeitpunkt des Bons'),
bon_ende DATETIME OPTIONS(description='Ende-Zeitpunkt des Bons'),
umsatz_mwst NUMERIC(29,4) DEFAULT 0 NOT NULL OPTIONS(description='auf den Mehrwertsteueranteil entfallender Betrag'),
umsatz_brutto NUMERIC(29,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz Brutto Betrag'),
bon_booking DATETIME NOT NULL
OPTIONS(description='Buchungszeitpunkt des Bons, relevant z.Bsp. für artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine Kasse offline war'),
dat_booking DATE NOT NULL
OPTIONS(description='Buchungsdatum des Bons, relevant z.Bsp. fuer artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine Kasse offline war. Redundant zu bon_booking aus Performancegruenden'),
turnover_fg INTEGER NOT NULL OPTIONS(description='Flag kennzeichnet die Umsatzrelevanz des Bons. 1 = relevant'),
wrg_id STRING(12) OPTIONS(description='Währung ID, z.Bsp\'EUR\''),
reactivated_fg INTEGER NOT NULL
OPTIONS(description='Bons koennen zurueckgestellt und spaeter reaktiviert werden (= 1), wenn z.Bsp. der Kunde nicht gleich zahlen kann. Diese Bons verbleiben laenger im System und die Zeiten duerfen nicht in die Berechnungen eingehen.'),
personal_id STRING(100) OPTIONS(description='Personalnummer(nur bei Personalrabett) als Hashwert verfremdet (Compress)'),
betrag_personal_rabatt NUMERIC(29,4),
kpos_kasse_typ STRING(80) OPTIONS(description='Im Kassensystem KPOS verwendete nicht-numerische Kassentypen'),
wagen_nr INTEGER OPTIONS(description='Nummer des Einkaufswagens'),
kundenkarte_id STRING(1020) OPTIONS(description='Beinhaltet die gehashte Kundennummer'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
druecken_summentaste DATETIME
OPTIONS(description='zeitstempel wird erzeugt wenn die summentaste an der kasse gedrueckt wird; zeitstempel wird nur einmalig erzeugt'),
schliessen_kassenschublade DATETIME
OPTIONS(description='zeitstempel wird an der kasse erzeugt, wenn die kassenlade geschlossen wird'),
fiskalisierung_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='kennzeichnung für einen bon, ob dieser für fiskalisierung relevant ist')
) CLUSTER BY mandant_id, bon_dat, wup_id;