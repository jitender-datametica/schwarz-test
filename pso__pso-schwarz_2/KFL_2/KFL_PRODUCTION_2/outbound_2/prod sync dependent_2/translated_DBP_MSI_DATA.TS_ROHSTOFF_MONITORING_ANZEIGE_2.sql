CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.ts_rohstoff_monitoring_anzeige_2 (
rohstoff_nr STRING(200) NOT NULL OPTIONS(description='Mintecs Interne ID des Rohstoffs.'),
rohstoff_kategorie_kfl_name STRING(300) NOT NULL
OPTIONS(description='Kaufland interne Kategorische Zuordnung des Rohstoffs.'),
rohstoff_kfl_bez STRING(300) NOT NULL OPTIONS(description='Kaufland interne Bezeichnung des Rohstoffs.'),
rohstoff_subkategorie_kfl_name STRING(300)
OPTIONS(description='Kaufland interne Subkategorische Zuordnung des Rohstoffs.'),
rohstoff_blend_kfl_txt STRING(300)
OPTIONS(description='Gemischtes Mineralölprodukt, das aus verschiedene Rohstoffe entsteht.'),
rohstoff_qualitaet_txt STRING(1000) OPTIONS(description='Beschreibung der Qualität des Rohstoffs.'),
rohstoff_quell_bez STRING(200) OPTIONS(description='Enthält Informationen zur Quelle des Rohstoffes.'),
rohstoff_cluster_id INTEGER
OPTIONS(description='Rohstoffe können für eine_2 Rohstoffgruppe einem Cluster zugeordnet werden, welches als Sortierkriterium zur Anzeige im FE verwendet werden kann. Aktuell nur für rohstoff_gruppe_typ_id = 2 verwendet.'),
dat_anzeige_von DATE
OPTIONS(description='Gibt an, ab welchem Datum die Zuordnung zwischen den Rohstoffengruppen in die Rohstoffberichte gültig ist.'),
dat_anzeige_bis DATE
OPTIONS(description='Gibt an, bis zu welchem Datum die Zuordnung zwischen den Rohstoffengruppen in die Rohstoffberichte gültig ist.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (rohstoff_nr, rohstoff_kategorie_kfl_name) NOT ENFORCED
) OPTIONS(description='KFL Informationen über Rohstoff.');