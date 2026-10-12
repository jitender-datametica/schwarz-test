create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_RETAIL_STORE_2(
	EXT_SYSTEM_NAME COMMENT 'Name des (externen) Quellsystems, das Daten für Reviews liefert, z.B. predict42.',
	EXT_STORE_ID COMMENT 'ID der Filiale im externen System.',
	RETAIL_STORE_NAME COMMENT 'Name der Filiale.',
	RETAIL_STORE_ADDRESS COMMENT 'Adresse der Filiale.',
	BREITENGRAD COMMENT 'Breitengrad aus dem GIS-System (Latitude)',
	LAENGENGRAD COMMENT 'Laengengrad aus dem GIS-System (Longitude)',
	EXT_RETAIL_COMPANY_ID COMMENT 'Fremdschlüssel zu retail_company_2, der angibt, zu welchem Markt das Geschäft gehört.',
	WUP_ID COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
	MANDANT_ID COMMENT 'Mandant_2 im DWH.',
	NB_ID COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
	COMPETITOR_WUP_ID COMMENT 'Von Kaufland intern generierte ID für die Filiale des Mitbewerbers.'
) as 
    SELECT 
        ext_system_name,
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

FROM DBP_DATA.RETAIL_STORE_2 ;
