CREATE OR REPLACE VIEW kfl_production_dbp_view.v_retail_store_distance_2 (ext_system_name
OPTIONS(description='Name des (externen) Quellsystems, das Daten für Reviews liefert, z.B. predict42.'), ext_store_id
OPTIONS(description='ID der Filiale im externen System.'), wup_id
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'), mandant_id
OPTIONS(description='Mandant_2 im DWH.'), drivetime_distance_km
OPTIONS(description='Entfernung zwischen zwei Filialen (Fahrstrecke in KM).'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.')) AS SELECT
 ext_system_name,
 ext_store_id,
 wup_id,
 mandant_id,
 drivetime_distance_km,
 nb_id
FROM kfl_production_dbp_data.retail_store_distance_2;