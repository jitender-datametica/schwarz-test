--==============================================================
-- Table: art_umrechnung_faktor_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_umrechnung_faktor_per_2
   generated from Powerdesigner on Montag, 27. Januar 2025 17:12:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_umrechnung_faktor_per_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
altnv_menge_einh_id STRING(3) NOT NULL
OPTIONS(description='Id der alternativen Mengeneinheit. Anhand dieser ID wird pro Mandant_2 und Artikel_2 eine_2 alternative Mengeneinheit eindeutig identifiziert.Aus meinh'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
dat_von DATE NOT NULL
OPTIONS(description='Gültigkeitbeginn für diesen Datensatz. Es wird dazu das Datum aus dem Dateinamen der Schnittstelle herangezogen.'),
bruttogew NUMERIC(18,3) NOT NULL
OPTIONS(description='Das Feld  enthält das Bruttogewicht in der in dem Attribut gew_einh_id aufgeführten Einheit. Aus brgew'),
umrech_faktor BIGNUMERIC(38,22) NOT NULL
OPTIONS(description='Umrechnungsfaktor für eine_2 alternative Mengenheinheit zur Umrechnung einer Basismenge in diese Mengeneinheit.'),
gew_einh_id STRING(3) NOT NULL OPTIONS(description='Dieses Feld enthält die Einheit für das Bruttogewicht.Aus gewei'),
dat_bis DATE NOT NULL
OPTIONS(description='Gültigkeitsende des Datensatzes. Wenn dieser Datensatz die momentan gültige Version darstellt besitzt dieses Attribut den Wert 31.12.9999.'),
laenge NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Länge (Tiefe) in cm aus laeng'),
breite NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Breite in cm aus breit'),
hoehe NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Höhe in cm aus hoehe'),
umrech_zaehler BIGNUMERIC(38,0) OPTIONS(description='Zähler für die Umrechnung in Basismengeneinheiten'),
umrech_nenner BIGNUMERIC(38,0) OPTIONS(description='Nenner für die Umrechnung in Basismengeneinheiten'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, altnv_menge_einh_id, art_id) NOT ENFORCED
)
OPTIONS(description='TP408_LVS - In dieser Tabelle sind die Umrechnungsfaktoren in die alternative Lagereinheit für die einzelnen Artikel_2 hinterlegt - MULTISET');