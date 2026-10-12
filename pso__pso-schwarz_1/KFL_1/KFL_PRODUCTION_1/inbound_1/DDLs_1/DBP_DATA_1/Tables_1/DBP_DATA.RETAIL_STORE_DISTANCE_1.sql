create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.RETAIL_STORE_DISTANCE_1 (
	EXT_SYSTEM_NAME VARCHAR(50) NOT NULL COMMENT 'Name des (externen) Quellsystems, das Daten für Reviews liefert, z.B. predict42.',
	EXT_STORE_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Filiale im externen System.',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH.',
	DRIVETIME_DISTANCE_KM NUMBER(38,16) NOT NULL COMMENT 'Entfernung zwischen zwei Filialen (Fahrstrecke in KM).',
	NB_ID NUMBER(38,0) COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_RETAIL_STORE_DISTANCE primary key (EXT_SYSTEM_NAME, EXT_STORE_ID)
)COMMENT='Die Tabelle enthält Entfernungen zwischen Filialen. Wird verwendet, um geografisch nahe gelegene Konkurrenten zu identifizieren.'
;
