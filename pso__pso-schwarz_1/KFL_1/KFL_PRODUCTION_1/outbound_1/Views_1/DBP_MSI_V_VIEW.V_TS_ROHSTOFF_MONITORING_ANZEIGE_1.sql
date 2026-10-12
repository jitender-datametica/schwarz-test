CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_rohstoff_monitoring_anzeige_1 (rohstoff_nr
OPTIONS(description='Mintecs Interne ID des Rohstoffs.'), rohstoff_kategorie_kfl_name
OPTIONS(description='Kaufland interne Kategorische Zuordnung des Rohstoffs.'), rohstoff_kfl_bez
OPTIONS(description='Kaufland interne Bezeichnung des Rohstoffs.'), rohstoff_subkategorie_kfl_name
OPTIONS(description='Kaufland interne Subkategorische Zuordnung des Rohstoffs.'), rohstoff_blend_kfl_txt
OPTIONS(description='Gemischtes Mineralölprodukt, das aus verschiedene Rohstoffe entsteht.'), rohstoff_qualitaet_txt
OPTIONS(description='Beschreibung der Qualität des Rohstoffs.'), rohstoff_quell_bez
OPTIONS(description='Enthält Informationen zur Quelle des Rohstoffes.'), rohstoff_cluster_id
OPTIONS(description='Rohstoffe können für eine_1 Rohstoffgruppe einem Cluster zugeordnet werden, welches als Sortierkriterium zur Anzeige im FE verwendet werden kann. Aktuell nur für rohstoff_gruppe_typ_id = 2 verwendet.'),
dat_anzeige_von
OPTIONS(description='Gibt an, ab welchem Datum die Zuordnung zwischen den Rohstoffengruppen in die Rohstoffberichte gültig ist.'),
dat_anzeige_bis
OPTIONS(description='Gibt an, bis zu welchem Datum die Zuordnung zwischen den Rohstoffengruppen in die Rohstoffberichte gültig ist.'))
OPTIONS(DESCRIPTION = `KFL INFORMATIONEN ÜBER ROHSTOFF.`) AS SELECT rohstoff_nr,
 rohstoff_kategorie_kfl_name,
 rohstoff_kfl_bez,
 rohstoff_subkategorie_kfl_name,
 rohstoff_blend_kfl_txt,
 rohstoff_qualitaet_txt,
 rohstoff_quell_bez,
 rohstoff_cluster_id,
 dat_anzeige_von,
 dat_anzeige_bis
FROM kfl_production_dbp_msi_data.ts_rohstoff_monitoring_anzeige_1;