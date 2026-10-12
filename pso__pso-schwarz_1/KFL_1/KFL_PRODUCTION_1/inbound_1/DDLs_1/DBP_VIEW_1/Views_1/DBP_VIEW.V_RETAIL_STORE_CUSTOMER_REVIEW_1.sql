create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_RETAIL_STORE_CUSTOMER_REVIEW_1(
	EXT_SYSTEM_NAME COMMENT 'Name des (externen) Quellsystems, das Daten für Reviews liefert, z.B. predict42',
	EXT_CUSTOMER_REVIEW_ID COMMENT 'ID der Review im externen System',
	EXT_RETAIL_COMPANY_ID COMMENT 'Id of the retail company in the system that provides the info',
	WUP_ID COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	MANDANT_ID COMMENT 'Mandant_1 im DWH',
	EXT_STORE_ID COMMENT 'Id of the retail store in the system that provides the info',
	REVIEW_TMSP COMMENT 'Zeitstempel, wann der Kunde die Rezension abgegeben hat',
	REVIEW_RATING COMMENT 'Bewertung, die der Kunde dem Einzelhandelsgeschäft gegeben hat',
	REVIEW_NATIVE_TXT COMMENT 'Rezension in der Originalsprache, die der Kunde dem Einzelhandelsgeschäft gegeben hat',
	REVIEW_ENGLISH_TXT COMMENT 'Englische Übersetzung der Rezension, die der Kunde dem Einzelhandelsgeschäft gegeben hat. Diese Spalte ist null, wenn review_native_ext Emoji enthält.',
	REVIEW_STATUS_CD COMMENT 'Der Code gibt die Art_1 der Einfügung an, ob die Kundenrezension zuletzt eingefügt oder aktualisiert wurde. (I = Insert, U = Update)'
) as 
    SELECT 
        ext_system_name,
        ext_customer_review_id,
        ext_retail_company_id,
        wup_id,
        nb_id,
        mandant_id,
        ext_store_id,
        review_tmsp,
        review_rating,
        review_native_txt,
        review_english_txt,
        review_status_cd

FROM DBP_DATA.RETAIL_STORE_CUSTOMER_REVIEW_1 ;
