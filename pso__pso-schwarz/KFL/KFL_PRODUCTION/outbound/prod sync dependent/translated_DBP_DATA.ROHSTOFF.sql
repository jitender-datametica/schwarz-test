CREATE OR REPLACE TABLE kfl_production_dbp_data.rohstoff (
rohstoff_nr STRING(200) NOT NULL OPTIONS(description='Mintecs Interne ID des Rohstoffs.'),
rohstoff_basis_einh_name STRING(100) NOT NULL OPTIONS(description='Die Basiseinheit des Rohstoffs (native).'),
rohstoff_bez STRING(300) NOT NULL OPTIONS(description='Bezeichnung des Rohstoffs.'),
rohstoff_kfl_bez STRING(300) NOT NULL OPTIONS(description='Kaufland interne Bezeichnung des Rohstoffs.'),
rohstoff_beschreibung_txt STRING(1000) NOT NULL OPTIONS(description='Beschreibung des Rohstoffs.'),
rohstoff_qualitaet_txt STRING(1000) OPTIONS(description='Beschreibung der Qualität des Rohstoffs.'),
rohstoff_herkunftsort_name STRING(100)
OPTIONS(description='Herkunfsort des Rohstoffs - Dieser kann Land, Region oder Länderguppe sein.'),
rohstoff_lieferort_name STRING(100) NOT NULL
OPTIONS(description='Land, Region oder Ländergruppe, die den Rohstof fliefert.'),
rohstoff_quell_bez STRING(200) OPTIONS(description='Enthält Informationen zur Quelle des Rohstoffes.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (rohstoff_nr) NOT ENFORCED
) OPTIONS(description='Diese Tabelle enthält Informationen über die Rohstoffe verwendet bei Kaufland.');