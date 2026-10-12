CREATE OR REPLACE TABLE kfl_production_dbp_data.retail_store_distance_1 (
ext_system_name STRING(50) NOT NULL
OPTIONS(description='Name des (externen) Quellsystems, das Daten für Reviews liefert, z.B. predict42.'),
ext_store_id INTEGER NOT NULL OPTIONS(description='ID der Filiale im externen System.'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
drivetime_distance_km BIGNUMERIC(29,16) NOT NULL
OPTIONS(description='Entfernung zwischen zwei Filialen (Fahrstrecke in KM).'),
nb_id INTEGER OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ext_system_name, ext_store_id) NOT ENFORCED
)
OPTIONS(description='Die Tabelle enthält Entfernungen zwischen Filialen. Wird verwendet, um geografisch nahe gelegene Konkurrenten zu identifizieren.');