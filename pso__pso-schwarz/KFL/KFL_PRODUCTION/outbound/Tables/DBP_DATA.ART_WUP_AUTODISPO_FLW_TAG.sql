--==============================================================
-- Table: art_wup_autodispo_flw_tag
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_autodispo_flw_tag
   generated from Powerdesigner on Mittwoch, 9. Juli 2025 11:47:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_wup_autodispo_flw_tag (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
kunde_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lieferndes VZ o. dezentraler Lieferant'),
nb_id_kunde BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetrieb Markt (0)'),
nb_id_lieferant BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Nebenbetrieb Lieferndes VZ o. dezentraler Lieferant (-111)'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel'),
dat DATE NOT NULL OPTIONS(description='Datum'),
menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Mengeneinheit der Kennzahlen - für DE Fleisch BME, KG, KOL, ST, EUR - Rest nur Basismengeneinheit (BME)'),
we_bearbeitungszeit BIGNUMERIC(38,0) OPTIONS(description='Bearbeitungszeit Wareneingang in Tagen'),
planlieferzeit BIGNUMERIC(38,0) OPTIONS(description='Planlieferzeit in Tagen'),
kdis BIGNUMERIC(38,0) OPTIONS(description='Flag: kDiS oder DiS (Bestelllistung)'),
verkaufslistung_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Verkaufslistung (Bestelllistung + X Tage)'),
sa_af_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Sonderaktion oder Aktionsfrei'),
udf_prognose_menge_gesteuert NUMERIC(13,3) OPTIONS(description='SAP UDF-Prognose (gesteuert)'),
udf_prognose_menge_ungesteuert NUMERIC(13,3) OPTIONS(description='SAP UDF-Prognose (ungesteuert)'),
fur_prognose_menge_ungesteuert NUMERIC(13,3) OPTIONS(description='SAP F&R-Prognose (ungesteuert)'),
fur_prognose_menge_gesteuert NUMERIC(13,3) OPTIONS(description='SAP F&R-Prognose (gesteuert)'),
fur_prognose_menge_max NUMERIC(13,3) OPTIONS(description='SAP F&R-Prognose (max)'),
menge_abverkauf NUMERIC(13,3) OPTIONS(description='Abverkaufte Menge'),
ret_bestand NUMERIC(13,3) OPTIONS(description='Frei verfügbarer Bestand im Markt (SAP Retail)'),
fur_bestand NUMERIC(13,3) OPTIONS(description='Bestand im Markt (SAP F&R)'),
menge_we_offen NUMERIC(13,3) OPTIONS(description='Offener Wareneingang (Bestellungen ohne Endlieferkenzeichen)'),
menge_bv NUMERIC(13,3) OPTIONS(description='Menge Bestellvorschlag'),
menge_ofc NUMERIC(13,3) OPTIONS(description='Menge Order Forecast'),
nullbestand_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Nullbestand im Markt (F&R Bestand <= 0)'),
menge_preisabschriften NUMERIC(13,3) OPTIONS(description='Menge Preisabschriften'),
menge_totalabschriften NUMERIC(13,3) OPTIONS(description='Menge Totalabschriften'),
kollifaktor NUMERIC(13,3) OPTIONS(description='Kollifaktor'),
egalisierungsfaktor NUMERIC(13,3) OPTIONS(description='Egalisierungsfaktor (=Packungsinhalt)'),
servicelevel NUMERIC(5,2) OPTIONS(description='Servicelevel'),
optik NUMERIC(19,6) OPTIONS(description='Optik'),
menge_we NUMERIC(13,3) OPTIONS(description='Menge Wareneingang (gebuchter WE)'),
nullbestand_exc_fg BIGNUMERIC(38,0) DEFAULT 0 OPTIONS(description='Flag: Nullbestand im Markt (Exception 209)'),
menge_we_geplant BIGNUMERIC(38,3)
OPTIONS(description='Geplanter Wareneingang. Berechnungslogik:             - wenn Bestelltag < Heute dann menge_we            - wenn Bestelltag = Heute dann menge_we_offen            - wenn Bestelltag > Heute dann menge_ofc + menge_we_offen            Offener Wareneingang aus SAP RET EKPO; Order Forecast für Liefertag aus ZFRE_OFC'),
display_art_id BIGNUMERIC(38,0)
OPTIONS(description='Artikel-ID des Displays im Lagerbewegungsbeleg. Displays (a.k.a. Aussteller) als auch die Komponenten / Artikel in einem Display werden im Lagerbewegungsbeleg als eigene Positionen / Artikel aufgeführt. Ein Display ist beispielsweise eine fertig gebaute Palette von Mondelez, die mehrere Sorten Milka Schokolade enthält und an den Markt geliefert wird. Über diese Spalte bekommen die Komponenten die art_id des zugehörigen Displays. Wird bei der Beladung gefüllt.'),
komponentenmenge BIGNUMERIC(38,4)
OPTIONS(description='Gibt an, wie viele Einheiten einer bestimmten Sorte (Komponente) in einem Display enthalten sind. Für die Komponenten selbst wird hier die jeweilige Einzelmenge erfasst. Für das Display (DP) wird die Summe aller enthaltenen  Aus stueckliste_det befüllt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kunde_id, wup_id, nb_id_kunde, nb_id_lieferant, art_id, dat) NOT ENFORCED
) CLUSTER BY dat, mandant_id
OPTIONS(description='Tabelle enthält Artikel/Markt/Tag Kombinationen auf Autodispo - Grundgesamtheit bildet für Fleischartikel in DE der EK Ordersatz (EORD), für den Rest die Tabelle ZE1WBB06 (beide SAP RET).');