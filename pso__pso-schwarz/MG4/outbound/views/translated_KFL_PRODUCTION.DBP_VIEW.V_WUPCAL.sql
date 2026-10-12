CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wupcal (mandant_id OPTIONS(description='PK Mandant im DWH'), wup_id
OPTIONS(description='PK Warenumschlagsplatz'), nb_id
OPTIONS(description='PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), dat
OPTIONS(description='PK - Datum im Format JJJJ-MM-TT'), offen
OPTIONS(description='kennzeichnet, ob ein Markt zu einem Datum geoeffnet war. 1 offen, 0 geschlossen'), werbewoche
OPTIONS(description='wird z.Zt. nicht benutzt'), datenlieferung_artbew_wg_sum
OPTIONS(description='Datenlieferungs-Stati\t\n0\tnicht geliefert\n1\tgeliefert\n2\tkalkuliert\n3\tgesplittet\n4\tnicht mehr lieferbar\n5\tkumuliert (ueber n Tage)\n6\tkalkuliert und nicht mehr lieferbar'),
datenlieferung_bonanzahl
OPTIONS(description='Datenlieferungs-Stati\t\n0\tnicht geliefert\n1\tgeliefert\n2\tkalkuliert\n3\tgesplittet\n4\tnicht mehr lieferbar\n5\tkumuliert (ueber n Tage)\n6\tkalkuliert und nicht mehr lieferbar'),
datenlieferung_misvier
OPTIONS(description='Daten aus der Schnittstelle misvier wurden geliefert\nDatenlieferungs-Stati\t\n0\tnicht geliefert\n1\tgeliefert\n2\tkalkuliert\n3\tgesplittet\n4\tnicht mehr lieferbar\n5\tkumuliert (ueber n Tage)\n6\tkalkuliert und nicht mehr lieferbar'),
datenlieferung_artbew
OPTIONS(description='Lieferung der Artikelbewegungsdaten aus dem Markt\nDatenlieferungs-Stati\t\n0\tnicht geliefert\n1\tgeliefert\n2\tkalkuliert\n3\tgesplittet\n4\tnicht mehr lieferbar\n5\tkumuliert (ueber n Tage)\n6\tkalkuliert und nicht mehr lieferbar'),
datenlieferung_qbm_status
OPTIONS(description='Lieferung der QBM-Daten (Reklamationen) aus dem Markt\nDatenlieferungs-Stati\t\n0   nicht geliefert\n1    geliefert\nweitere Stati koennen zu einem spaeteren Zeitpunkt festgelegt werden'),
pruef_status_id_umsatz
OPTIONS(description='Status der Pruefung des Umsatzes. Der Umsatz wird auf Plausibilitaet geprueft'),
pruef_status_id_kunde
OPTIONS(description='Status der Pruefung der Kundenzahl. Die Kundenzahl wird auf Plausibilitaet geprueft'),
pruef_grund_id_umsatz OPTIONS(description='Grund der Pruefung des Umsatzes'), pruef_grund_id_kunde
OPTIONS(description='Grund der Pruefung der Kundenzahl'), wrg_id
OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'), dat_extrakt_umsatz
OPTIONS(description='Datum des Erhalts der  Schnittstelle Umsatz'), offen_von
OPTIONS(description='Zeitpunkt der Marktoeffnung'), offen_bis OPTIONS(description='Schließungszeitpunkt des Marktes'),
offen_theke_von OPTIONS(description='Thekenoeffnungszeit von pro Markt / Tag'), offen_theke_bis
OPTIONS(description='Thekenoeffnungszeit bis pro Markt / Tag'), umsatz_brutto_ods_verkauf
OPTIONS(description='Befuellung im ETL-Prozess - Summe Umsaetze aus ods_verkauf. Nur K-POS'),
umsatz_brutto_ods_kassenabschluss
OPTIONS(description='Befuellung im ETL-Prozess - Summe Umsaetze aus ods_kassenabschluss. Nur K_POS'), bonanzahl
OPTIONS(description='Anzahl der Kassenbons'), bonanzahl_misvier OPTIONS(description='Anzahl Bons'), bonanzahl_imbiss
OPTIONS(description='Anzahl Kunden im Imbiss des Marktes. Gehoert logisch nicht hierher, da abhaengig von einer Warengruppe bzw. bestimmten Kassierer-Nummern.'),
bonanzahl_sug
OPTIONS(description='Bons mit mindestens einer positiven Position - einheitliche Definition der Kundenzahl innerhalb der Schwarz-Unternehmensgruppe'),
bonanzahl_sug_kassenabschluss OPTIONS(description='Kunden Kassenabschluss (EOD), Logik analog bonanzahl_sug'),
bonanzahl_frischetheke_ohne_fisch
OPTIONS(description='Kundenanzahl der Frischetheke ohne OWG 1005 Fisch (Sobald ein Kunde etwas aus den OWGs 1001, 1002, 1003, 1004 kauft, zählt dieser als Kunde der Frischetheke ohne Fisch).'),
bonanzahl_kundenkarte_payback OPTIONS(description='Anzahl der Kunden mit Payback als Kundenkarte (nur für Polen).'),
bonanzahl_kundenkarte
OPTIONS(description='Aggregation der Bons mit Kundenkarten_Typ_ID = 2 (Kaufland Loyalty Card) auf Markt-Tag-Land-Ebene '),
betrag_vk_netto_kundenkarte
OPTIONS(description='Umsatz netto mit Kaufland Loyalty Programm (kundenkarte_typ_id =2) auf Markt.Tag-Ebene.'),
ssm_umsatz_faktor OPTIONS(description='Berechnung je Wochentag. HL Planwert / Durchschnitt letzte 10 Wochen')) AS SELECT
 mandant_id,
 wup_id,
 nb_id,
 dat,
 offen,
 werbewoche,
 datenlieferung_artbew_wg_sum,
 datenlieferung_bonanzahl,
 datenlieferung_misvier,
 datenlieferung_artbew,
 datenlieferung_qbm_status,
 pruef_status_id_umsatz,
 pruef_status_id_kunde,
 pruef_grund_id_umsatz,
 pruef_grund_id_kunde,
 wrg_id,
 dat_extrakt_umsatz,
 offen_von,
 offen_bis,
 offen_theke_von,
 offen_theke_bis,
 umsatz_brutto_ods_verkauf,
 umsatz_brutto_ods_kassenabschluss,
 bonanzahl,
 bonanzahl_misvier,
 bonanzahl_imbiss,
 bonanzahl_sug,
 bonanzahl_sug_kassenabschluss,
 bonanzahl_frischetheke_ohne_fisch,
 bonanzahl_kundenkarte_payback,
 bonanzahl_kundenkarte,
 betrag_vk_netto_kundenkarte,
 ssm_umsatz_faktor
FROM kfl_production_dbp_data.wupcal;