create or replace TABLE KFL_PRODUCTION.DBP_DATA.RETAIL_STORE_CUSTOMER_REVIEW_1 (
	EXT_SYSTEM_NAME VARCHAR(50) NOT NULL COMMENT 'Name des (externen) Quellsystems, das Daten für Reviews liefert, z.B. predict42',
	EXT_CUSTOMER_REVIEW_ID VARCHAR(100) NOT NULL COMMENT 'ID der Review im externen System',
	EXT_RETAIL_COMPANY_ID NUMBER(38,0) NOT NULL COMMENT 'Id of the retail company in the system that provides the info',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	EXT_STORE_ID NUMBER(38,0) NOT NULL COMMENT 'Id of the retail store in the system that provides the info',
	REVIEW_TMSP TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel, wann der Kunde die Rezension abgegeben hat',
	REVIEW_RATING NUMBER(38,5) NOT NULL COMMENT 'Bewertung, die der Kunde dem Einzelhandelsgeschäft gegeben hat',
	REVIEW_NATIVE_TXT VARCHAR(10000) COMMENT 'Rezension in der Originalsprache, die der Kunde dem Einzelhandelsgeschäft gegeben hat',
	REVIEW_ENGLISH_TXT VARCHAR(10000) COMMENT 'Englische Übersetzung der Rezension, die der Kunde dem Einzelhandelsgeschäft gegeben hat. Diese Spalte ist null, wenn review_native_ext Emoji enthält.',
	REVIEW_STATUS_CD VARCHAR(1) COMMENT 'Der Code gibt die Art_1 der Einfügung an, ob die Kundenrezension zuletzt eingefügt oder aktualisiert wurde. (I = Insert, U = Update)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_RETAIL_STORE_CUSTOMER_REVIEW primary key (EXT_SYSTEM_NAME, EXT_CUSTOMER_REVIEW_ID)
)COMMENT='Die Tabelle enthält 1 Zeile pro Kundenrezension für einen Markt (kann ein KFL-Markt oder ein Konkurrenzmarkt sein). (Stand 09.02.2024) Tabelle enthält nur Google-Bewertungen.'
;