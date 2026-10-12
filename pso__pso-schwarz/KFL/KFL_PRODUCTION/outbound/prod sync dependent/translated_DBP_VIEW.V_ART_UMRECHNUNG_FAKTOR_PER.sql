CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_umrechnung_faktor_per (mandant_id
OPTIONS(description='Mandant im DWH'), altnv_menge_einh_id
OPTIONS(description='Id der alternativen Mengeneinheit. Anhand dieser ID wird pro Mandant und Artikel eine alternative Mengeneinheit eindeutig identifiziert.Aus meinh'),
art_id
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
dat_von
OPTIONS(description='Gültigkeitbeginn für diesen Datensatz. Es wird dazu das Datum aus dem Dateinamen der Schnittstelle herangezogen.'),
bruttogew
OPTIONS(description='Das Feld  enthält das Bruttogewicht in der in dem Attribut gew_einh_id aufgeführten Einheit. Aus brgew'),
umrech_faktor
OPTIONS(description='Umrechnungsfaktor für eine alternative Mengenheinheit zur Umrechnung einer Basismenge in diese Mengeneinheit.'),
gew_einh_id OPTIONS(description='Dieses Feld enthält die Einheit für das Bruttogewicht.Aus gewei'), dat_bis
OPTIONS(description='Gültigkeitsende des Datensatzes. Wenn dieser Datensatz die momentan gültige Version darstellt besitzt dieses Attribut den Wert 31.12.9999.'),
laenge OPTIONS(description='Länge (Tiefe) in cm aus laeng'), breite OPTIONS(description='Breite in cm aus breit'), hoehe
OPTIONS(description='Höhe in cm aus hoehe'), umrech_zaehler
OPTIONS(description='Zähler für die Umrechnung in Basismengeneinheiten'), umrech_nenner
OPTIONS(description='Nenner für die Umrechnung in Basismengeneinheiten')) AS SELECT mandant_id,
 altnv_menge_einh_id,
 art_id,
 dat_von,
 bruttogew,
 umrech_faktor,
 gew_einh_id,
 dat_bis,
 laenge,
 breite,
 hoehe,
 umrech_zaehler,
 umrech_nenner
FROM kfl_production_dbp_data.art_umrechnung_faktor_per;