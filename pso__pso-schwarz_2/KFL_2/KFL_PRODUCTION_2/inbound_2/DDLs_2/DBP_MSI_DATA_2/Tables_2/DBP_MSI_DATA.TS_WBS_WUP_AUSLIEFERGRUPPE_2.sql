create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_DATA.TS_WBS_WUP_AUSLIEFERGRUPPE_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH.',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum.',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
	AUSLIEFERGRUPPE_ID VARCHAR(10) NOT NULL COMMENT 'Ausliefergruppe',
	INIT_LIEF_MARKT_CLUSTER_ID NUMBER(38,0) NOT NULL COMMENT 'Markt-Cluster für die initiale Belieferung (1-5).',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TS_WBS_WUP_AUSLIEFERGRUPPE primary key (MANDANT_ID, WUP_ID, NB_ID, AUSLIEFERGRUPPE_ID)
)COMMENT='Settings for WBS calculation core on Store level / content maintained by transaction services document. User can define Initial Delivery Cluster per Delivery Group on Store Level.\n             Einstellungen für die WBS-Berechnung auf Filialebene. Der Inhalt wird durch TS gepflegt. Der Benutzer kann pro Liefergruppe den initialen Liefer-Cluster auf Filialebene definieren.'
;
