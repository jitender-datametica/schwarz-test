CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_rohstoff_monitoring_nachricht (nachricht_typ_id
OPTIONS(description='Enthält die ID um welchen Nachrichtentyp es sich handelt.0 = Trend1 = Märkte2 = Preisbeeinflussender Faktoren'),
rohstoff_kategorie_kfl_name OPTIONS(description='Kaufland interne Kategorische Zuordnung eines Rohstoffs.'), spr_id
OPTIONS(description='ID der Sprache'), nachricht_titel_txt
OPTIONS(description='Enthält den Titel einesTextblocks im Report.'), nachricht_inhalt_txt
OPTIONS(description='Kaufland interne Beschreibung der Kategorie des Rohstoffs.'), trend_typ_id
OPTIONS(description='Gibt den Trend der Rohstoffskategorie an für die Einfärbung im Report (0-2).'), dat_trend_von
OPTIONS(description='Gültigkeitsstart des Trend der Kategorie.'), prognose_halbjahr_typ_id
OPTIONS(description='Prognosetyp der Kategorie für das Halbjahr an (0-4).'), nachricht_link_txt
OPTIONS(description='Hinterlegt einen Link zu Netzlaufwerken/Sharepoint oder ins Internet.'),
preis_reduzierende_faktoren_txt OPTIONS(description='Beschreibungen von Preisreduzierende Faktoren.'),
preis_steigernde_faktoren_txt OPTIONS(description='Beschreibungen von Preissteigernde Faktoren.'), forecast_txt
OPTIONS(description='Enthält eine Forecast-Beschreibung z.B. Ausblick für das Jahr ist positiv.'), dat_gueltig_von
OPTIONS(description='Gültigkeitsstart des Eintrags.'), dat_gueltig_bis
OPTIONS(description='Gültigkeitsende des Eintrags.'))
OPTIONS(DESCRIPTION = 'Informationen wie Trend, Märkte und preisbeeinflussender Faktoren einer Rohstoffskategorie.') AS
SELECT nachricht_typ_id,
 rohstoff_kategorie_kfl_name,
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
FROM kfl_production_dbp_msi_data.ts_rohstoff_monitoring_nachricht;