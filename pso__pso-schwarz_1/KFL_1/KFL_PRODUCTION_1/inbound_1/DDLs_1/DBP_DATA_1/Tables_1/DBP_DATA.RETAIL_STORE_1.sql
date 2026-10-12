create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.RETAIL_STORE_1 (
	EXT_SYSTEM_NAME VARCHAR(50) NOT NULL COMMENT 'Name des (externen) Quellsystems, das Daten für Reviews liefert, z.B. predict42.',
	EXT_STORE_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Filiale im externen System.',
	RETAIL_STORE_NAME VARCHAR(255) NOT NULL COMMENT 'Name der Filiale.',
	RETAIL_STORE_ADDRESS VARCHAR(255) NOT NULL COMMENT 'Adresse der Filiale.',
	BREITENGRAD NUMBER(38,16) NOT NULL COMMENT 'Breitengrad aus dem GIS-System (Latitude)',
	LAENGENGRAD NUMBER(38,16) NOT NULL COMMENT 'Laengengrad aus dem GIS-System (Longitude)',
	EXT_RETAIL_COMPANY_ID NUMBER(38,0) NOT NULL COMMENT 'Fremdschlüssel zu retail_company_1, der angibt, zu welchem Markt das Geschäft gehört.',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH.',
	NB_ID NUMBER(38,0) COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
	COMPETITOR_WUP_ID VARCHAR(50) NOT NULL COMMENT 'Von Kaufland intern generierte ID für die Filiale des Mitbewerbers.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_RETAIL_STORE primary key (EXT_SYSTEM_NAME, EXT_STORE_ID)
)COMMENT='Die Tabelle enthält 1 Zeile pro Filiale eines Marktes. Einschließlich Kaufland-Filialen und Filialen von Wettbewerbern.'
;
