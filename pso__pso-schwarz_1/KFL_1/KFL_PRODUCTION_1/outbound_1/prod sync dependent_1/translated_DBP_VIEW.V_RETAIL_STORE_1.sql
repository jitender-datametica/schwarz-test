CREATE OR REPLACE VIEW kfl_production_dbp_view.v_retail_store_1 (ext_system_name
OPTIONS(description='Name des (externen) Quellsystems, das Daten für Reviews liefert, z.B. predict42.'), ext_store_id
OPTIONS(description='ID der Filiale im externen System.'), retail_store_name OPTIONS(description='Name der Filiale.'),
retail_store_address OPTIONS(description='Adresse der Filiale.'), breitengrad
OPTIONS(description='Breitengrad aus dem GIS-System (Latitude)'), laengengrad
OPTIONS(description='Laengengrad aus dem GIS-System (Longitude)'), ext_retail_company_id
OPTIONS(description='Fremdschlüssel zu retail_company_1, der angibt, zu welchem Markt das Geschäft gehört.'), wup_id
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'), mandant_id
OPTIONS(description='Mandant_1 im DWH.'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'), competitor_wup_id
OPTIONS(description='Von Kaufland intern generierte ID für die Filiale des Mitbewerbers.')) AS SELECT ext_system_name,
 ext_store_id,
 retail_store_name,
 retail_store_address,
 breitengrad,
 laengengrad,
 ext_retail_company_id,
 wup_id,
 mandant_id,
 nb_id,
 competitor_wup_id
FROM kfl_production_dbp_data.retail_store_1;