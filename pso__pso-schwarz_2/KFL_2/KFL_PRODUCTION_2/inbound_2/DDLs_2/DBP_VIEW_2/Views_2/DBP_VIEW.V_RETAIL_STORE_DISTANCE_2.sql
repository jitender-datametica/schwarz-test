create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_RETAIL_STORE_DISTANCE_2(
	EXT_SYSTEM_NAME COMMENT 'Name des (externen) Quellsystems, das Daten für Reviews liefert, z.B. predict42.',
	EXT_STORE_ID COMMENT 'ID der Filiale im externen System.',
	WUP_ID COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
	MANDANT_ID COMMENT 'Mandant_2 im DWH.',
	DRIVETIME_DISTANCE_KM COMMENT 'Entfernung zwischen zwei Filialen (Fahrstrecke in KM).',
	NB_ID COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'
) as 
    SELECT 
        ext_system_name,
        ext_store_id,
        wup_id,
        mandant_id,
        drivetime_distance_km,
        nb_id

FROM DBP_DATA.RETAIL_STORE_DISTANCE_2 ;
