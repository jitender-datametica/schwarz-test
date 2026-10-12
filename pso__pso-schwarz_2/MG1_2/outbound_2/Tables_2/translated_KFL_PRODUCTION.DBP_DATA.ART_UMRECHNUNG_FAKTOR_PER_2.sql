CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_UMRECHNUNG_FAKTOR_PER_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
ALTNV_MENGE_EINH_ID STRING(3) NOT NULL
OPTIONS(description='Id der alternativen Mengeneinheit. Anhand dieser ID wird pro Mandant_2 und Artikel_2 eine_2 alternative Mengeneinheit eindeutig identifiziert.Aus meinh'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
DAT_VON DATE NOT NULL
OPTIONS(description='Gültigkeitbeginn für diesen Datensatz. Es wird dazu das Datum aus dem Dateinamen der Schnittstelle herangezogen.'),
BRUTTOGEW NUMERIC(18,3) NOT NULL
OPTIONS(description='Das Feld  enthält das Bruttogewicht in der in dem Attribut gew_einh_id aufgeführten Einheit. Aus brgew'),
UMRECH_FAKTOR BIGNUMERIC(29,22) NOT NULL
OPTIONS(description='Umrechnungsfaktor für eine_2 alternative Mengenheinheit zur Umrechnung einer Basismenge in diese Mengeneinheit.'),
GEW_EINH_ID STRING(3) NOT NULL OPTIONS(description='Dieses Feld enthält die Einheit für das Bruttogewicht.Aus gewei'),
DAT_BIS DATE NOT NULL
OPTIONS(description='Gültigkeitsende des Datensatzes. Wenn dieser Datensatz die momentan gültige Version darstellt besitzt dieses Attribut den Wert 31.12.9999.'),
LAENGE NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Länge (Tiefe) in cm aus laeng'),
BREITE NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Breite in cm aus breit'),
HOEHE NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Höhe in cm aus hoehe'),
UMRECH_ZAEHLER INTEGER OPTIONS(description='Zähler für die Umrechnung in Basismengeneinheiten'),
UMRECH_NENNER INTEGER OPTIONS(description='Nenner für die Umrechnung in Basismengeneinheiten'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, ALTNV_MENGE_EINH_ID, ART_ID) NOT ENFORCED
)
OPTIONS(description='TP408_LVS - In dieser Tabelle sind die Umrechnungsfaktoren in die alternative Lagereinheit für die einzelnen Artikel_2 hinterlegt - MULTISET');