CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_wup_autodispo_flw_tag_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), kunde_id OPTIONS(description='Marktnummer'), wup_id
OPTIONS(description='Lieferndes VZ o. dezentraler Lieferant'), nb_id_kunde OPTIONS(description='Nebenbetrieb Markt (0)'),
nb_id_lieferant OPTIONS(description='Nebenbetrieb Lieferndes VZ o. dezentraler Lieferant (-111)'), art_id
OPTIONS(description='Artikel_1'), dat OPTIONS(description='Datum'), menge_einh_id
OPTIONS(description='Mengeneinheit der Kennzahlen - für DE Fleisch BME, KG, KOL, ST, EUR - Rest nur Basismengeneinheit (BME)'),
we_bearbeitungszeit OPTIONS(description='Bearbeitungszeit Wareneingang in Tagen'), planlieferzeit
OPTIONS(description='Planlieferzeit in Tagen'), kdis OPTIONS(description='Flag: kDiS oder DiS (Bestelllistung)'),
verkaufslistung_fg OPTIONS(description='Flag: Verkaufslistung (Bestelllistung + X Tage)'), sa_af_fg
OPTIONS(description='Flag: Sonderaktion oder Aktionsfrei'), udf_prognose_menge_gesteuert
OPTIONS(description='SAP UDF-Prognose (gesteuert)'), udf_prognose_menge_ungesteuert
OPTIONS(description='SAP UDF-Prognose (ungesteuert)'), fur_prognose_menge_ungesteuert
OPTIONS(description='SAP F&R-Prognose (ungesteuert)'), fur_prognose_menge_gesteuert
OPTIONS(description='SAP F&R-Prognose (gesteuert)'), fur_prognose_menge_max
OPTIONS(description='SAP F&R-Prognose (max)'), menge_abverkauf OPTIONS(description='Abverkaufte Menge'), ret_bestand
OPTIONS(description='Frei verfügbarer Bestand im Markt (SAP Retail)'), fur_bestand
OPTIONS(description='Bestand im Markt (SAP F&R)'), menge_we_offen
OPTIONS(description='Offener Wareneingang (Bestellungen ohne Endlieferkenzeichen)'), menge_bv
OPTIONS(description='Menge Bestellvorschlag'), menge_ofc OPTIONS(description='Menge Order Forecast'), nullbestand_fg
OPTIONS(description='Flag: Nullbestand im Markt (F&R Bestand <= 0)'), menge_preisabschriften
OPTIONS(description='Menge Preisabschriften'), menge_totalabschriften OPTIONS(description='Menge Totalabschriften'),
kollifaktor OPTIONS(description='Kollifaktor'), egalisierungsfaktor
OPTIONS(description='Egalisierungsfaktor (=Packungsinhalt)'), servicelevel OPTIONS(description='Servicelevel'), optik
OPTIONS(description='Optik'), menge_we OPTIONS(description='Menge Wareneingang (gebuchter WE)'), nullbestand_exc_fg
OPTIONS(description='Flag: Nullbestand im Markt (Exception 209)'), menge_we_geplant
OPTIONS(description='Geplanter Wareneingang. Berechnungslogik: - wenn Bestelltag < Heute dann menge_we- wenn Bestelltag = Heute dann menge_we_offen- wenn Bestelltag > Heute dann menge_ofc + menge_we_offenOffener Wareneingang aus SAP RET EKPO_1; Order Forecast für Liefertag aus ZFRE_OFC'),
display_art_id
OPTIONS(description='Artikel_1-ID des Displays im Lagerbewegungsbeleg. Displays (a.k.a. Aussteller) als auch die Komponenten / Artikel_1 in einem Display werden im Lagerbewegungsbeleg als eigene Positionen / Artikel_1 aufgeführt. Ein Display ist beispielsweise eine_1 fertig gebaute Palette von Mondelez, die mehrere Sorten Milka Schokolade enthält und an den Markt geliefert wird. Über diese Spalte bekommen die Komponenten die art_id des zugehörigen Displays. Wird bei der Beladung gefüllt.'),
komponentenmenge
OPTIONS(description='Gibt an, wie viele Einheiten einer bestimmten Sorte (Komponente) in einem Display enthalten sind. Für die Komponenten selbst wird hier die jeweilige Einzelmenge erfasst. Für das Display (DP) wird die Summe aller enthaltenen  Aus stueckliste_det_1 befüllt'))
OPTIONS(DESCRIPTION = `Tabelle enthält Artikel_1/Markt/Tag_1 Kombinationen auf Autodispo - Grundgesamtheit bildet für Fleischartikel in DE der EK Ordersatz (EORD_1), für den Rest die Tabelle ZE1WBB06 (beide SAP RET).`)
AS SELECT mandant_id,
 kunde_id,
 wup_id,
 nb_id_kunde,
 nb_id_lieferant,
 art_id,
 dat,
 menge_einh_id,
 we_bearbeitungszeit,
 planlieferzeit,
 kdis,
 verkaufslistung_fg,
 sa_af_fg,
 udf_prognose_menge_gesteuert,
 udf_prognose_menge_ungesteuert,
 fur_prognose_menge_ungesteuert,
 fur_prognose_menge_gesteuert,
 fur_prognose_menge_max,
 menge_abverkauf,
 ret_bestand,
 fur_bestand,
 menge_we_offen,
 menge_bv,
 menge_ofc,
 nullbestand_fg,
 menge_preisabschriften,
 menge_totalabschriften,
 kollifaktor,
 egalisierungsfaktor,
 servicelevel,
 optik,
 menge_we,
 nullbestand_exc_fg,
 menge_we_geplant,
 display_art_id,
 komponentenmenge
FROM kfl_production_dbp_data.art_wup_autodispo_flw_tag_1;