DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_ODS_ARCHIV.ODS_BON_KOPF_2;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_ODS_ARCHIV.ODS_BON_KOPF_2 (
BON_ID STRING(100) NOT NULL OPTIONS(description='eindeutige ID eines Bons, generierter Hashwert'),
BON_DAT DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey'),
KASSE_TYP_ID INTEGER
OPTIONS(description='Kassentyp. Folgende Typen kommen vor: 1 = default(Sales_2 POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt'),
KUNDENKARTE_TYP_ID INTEGER NOT NULL OPTIONS(description='ID zur Kundenkarte mit Werten 0 und 1'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprueft'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH - ein Mandant_2 pro Land_2'),
BON_NR INTEGER NOT NULL
OPTIONS(description='Die Bonnummer des Bons (ist eine_2 fortlaufende Nummer die in der Kasse generiert wird, im Normal Fall ist diese Nummer pro Tag_2 und Kasse Unique)'),
KASSE_NR INTEGER NOT NULL OPTIONS(description='Nummer der Kasse'),
KASSIERER_NR STRING(16) OPTIONS(description='Nummer des Kassierers'),
KUNDE_FG INTEGER NOT NULL
OPTIONS(description='Gibt an, ob dieser Bon für die Kundenzaehlung relevant ist. 1 = ja, 0 = nein'),
BON_BEGINN TIMESTAMP OPTIONS(description='Start-Zeitpunkt des Bons'),
BON_ENDE TIMESTAMP OPTIONS(description='Ende-Zeitpunkt des Bons'),
UMSATZ_MWST NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='auf den Mehrwertsteueranteil entfallender Betrag'),
UMSATZ_BRUTTO NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz Brutto Betrag'),
BON_BOOKING TIMESTAMP NOT NULL
OPTIONS(description='Buchungszeitpunkt des Bons, relevant z.Bsp. für artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine_2 Kasse offline war'),
DAT_BOOKING DATE NOT NULL
OPTIONS(description='Buchungsdatum des Bons, relevant z.Bsp. fuer artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine_2 Kasse offline war. Redundant zu bon_booking aus Performancegruenden'),
TURNOVER_FG INTEGER NOT NULL OPTIONS(description='Flag kennzeichnet die Umsatzrelevanz des Bons. 1 = relevant'),
WRG_ID STRING(12) OPTIONS(description='Währung ID, z.Bsp\'EUR\''),
REACTIVATED_FG INTEGER NOT NULL
OPTIONS(description='Bons koennen zurueckgestellt und spaeter reaktiviert werden (= 1), wenn z.Bsp. der Kunde nicht gleich zahlen kann. Diese Bons verbleiben laenger im System und die Zeiten duerfen nicht in die Berechnungen eingehen.'),
PERSONAL_ID STRING(100) OPTIONS(description='Personalnummer(nur bei Personalrabett) als Hashwert verfremdet (Compress)'),
BETRAG_PERSONAL_RABATT NUMERIC(18,4),
KPOS_KASSE_TYP STRING(80) OPTIONS(description='Im Kassensystem KPOS verwendete nicht-numerische Kassentypen'),
WAGEN_NR INTEGER OPTIONS(description='Nummer des Einkaufswagens'),
KUNDENKARTE_ID STRING(1020) OPTIONS(description='Beinhaltet die gehashte Kundennummer'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
DRUECKEN_SUMMENTASTE TIMESTAMP
OPTIONS(description='zeitstempel wird erzeugt wenn die summentaste an der kasse gedrueckt wird; zeitstempel wird nur einmalig erzeugt'),
SCHLIESSEN_KASSENSCHUBLADE TIMESTAMP
OPTIONS(description='zeitstempel wird an der kasse erzeugt, wenn die kassenlade geschlossen wird'),
FISKALISIERUNG_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='kennzeichnung für einen bon, ob dieser für fiskalisierung relevant ist')
) CLUSTER BY MANDANT_ID, BON_DAT, WUP_ID;