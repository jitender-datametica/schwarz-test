create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_DATA.TS_LAGERORT_EWM_DAT (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH.',
	LAGERORT_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Dieses Feld referenziert die DWH Tabelle Lagerort.',
	LAGERNUMMER_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'ID der Lagernummer - hoechste Ebene der Lagerhierarchie.',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup ID, wird verwendet fuer Beziehung Lager zu Verteilzentrum.',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4. Stelle der Marktnummer, die Nebenbetriebskennziffer.',
	DAT DATE NOT NULL COMMENT 'Datum des EWM-GoLive.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TS_LAGERORT_EWM_DAT primary key (MANDANT_ID, LAGERORT_ID, LAGERNUMMER_ID, WUP_ID, NB_ID)
)COMMENT='EWM-GoLive Date per Lagerort (starting with this date, data should be excluded from LIS reporting).'
;
