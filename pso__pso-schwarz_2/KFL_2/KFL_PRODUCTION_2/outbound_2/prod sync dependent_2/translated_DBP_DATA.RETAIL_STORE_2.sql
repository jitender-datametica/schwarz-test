CREATE OR REPLACE TABLE kfl_production_dbp_data.retail_store_2 (
ext_system_name STRING(50) NOT NULL
OPTIONS(description='Name des (externen) Quellsystems, das Daten für Reviews liefert, z.B. predict42.'),
ext_store_id INTEGER NOT NULL OPTIONS(description='ID der Filiale im externen System.'),
retail_store_name STRING(255) NOT NULL OPTIONS(description='Name der Filiale.'),
retail_store_address STRING(255) NOT NULL OPTIONS(description='Adresse der Filiale.'),
breitengrad BIGNUMERIC(38,16) NOT NULL OPTIONS(description='Breitengrad aus dem GIS-System (Latitude)'),
laengengrad BIGNUMERIC(38,16) NOT NULL OPTIONS(description='Laengengrad aus dem GIS-System (Longitude)'),
ext_retail_company_id INTEGER NOT NULL
OPTIONS(description='Fremdschlüssel zu retail_company_2, der angibt, zu welchem Markt das Geschäft gehört.'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
nb_id INTEGER OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
competitor_wup_id STRING(50) NOT NULL
OPTIONS(description='Von Kaufland intern generierte ID für die Filiale des Mitbewerbers.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ext_system_name, ext_store_id) NOT ENFORCED
)
OPTIONS(description='Die Tabelle enthält 1 Zeile pro Filiale eines Marktes. Einschließlich Kaufland-Filialen und Filialen von Wettbewerbern.');