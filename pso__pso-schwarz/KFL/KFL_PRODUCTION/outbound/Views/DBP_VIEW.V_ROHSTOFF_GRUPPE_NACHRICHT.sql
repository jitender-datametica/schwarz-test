CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rohstoff_gruppe_nachricht (rohstoff_gruppe_typ_id
OPTIONS(description='ID des Gruppierungstyps eines Rohstoffs.'), rohstoff_gruppe_name
OPTIONS(description='Name der Gruppe eines Rohstoffs nach Gruppierungstyp.'), nachricht_typ_id
OPTIONS(description='Enthält die ID um welchen Nachrichtentyp es sich handelt.0 = Trend1 = Märkte2 = Preisbeeinflussender Faktoren'),
spr_id OPTIONS(description='ID der Sprache'), nachricht_titel_txt
OPTIONS(description='Enthält den Titel einesTextblocks im Report.'), nachricht_inhalt_txt
OPTIONS(description='Kaufland interne Beschreibung der Rohstoffgruppe des Rohstoffs.'), trend_typ_id
OPTIONS(description='Gibt den Trend der Rohstoffsgruppe an für die Einfärbung im Report (0-2).0 =  Aufwaertstrend1 =  Abwaertstrend2 =  Seitwaertstrend'),
dat_trend_von OPTIONS(description='Gültigkeitsstart des Trend der Rohstoffsgruppe.'), prognose_halbjahr_typ_id
OPTIONS(description='Prognosetyp der Rohstoffsgruppe für das Halbjahr an (0-4).0  =  >+20%1  =  +5 -20%2  =  bis + -5%3  = -5 -20 %4  = > -20%'),
nachricht_link_txt OPTIONS(description='Hinterlegt einen Link zu Netzlaufwerken/Sharepoint oder ins Internet.'),
preis_reduzierende_faktoren_txt OPTIONS(description='Beschreibungen von Preisreduzierende Faktoren.'),
preis_steigernde_faktoren_txt OPTIONS(description='Beschreibungen von Preissteigernde Faktoren.'), forecast_txt
OPTIONS(description='Enthält eine Forecast-Beschreibung z.B. Ausblick für das Jahr ist positiv.'), dat_gueltig_von
OPTIONS(description='Gültigkeitsstart des Eintrags.'), dat_gueltig_bis
OPTIONS(description='Gültigkeitsende des Eintrags'))
OPTIONS(DESCRIPTION = `Nachrichten (Trend, Markt und Prognose) über Rohstoffskategorie.`) AS SELECT
 rohstoff_gruppe_typ_id,
 rohstoff_gruppe_name,
 nachricht_typ_id,
 spr_id,
 nachricht_titel_txt,
 nachricht_inhalt_txt,
 trend_typ_id,
 dat_trend_von,
 prognose_halbjahr_typ_id,
 nachricht_link_txt,
 preis_reduzierende_faktoren_txt,
 preis_steigernde_faktoren_txt,
 forecast_txt,
 dat_gueltig_von,
 dat_gueltig_bis
FROM kfl_production_dbp_data.rohstoff_gruppe_nachricht;