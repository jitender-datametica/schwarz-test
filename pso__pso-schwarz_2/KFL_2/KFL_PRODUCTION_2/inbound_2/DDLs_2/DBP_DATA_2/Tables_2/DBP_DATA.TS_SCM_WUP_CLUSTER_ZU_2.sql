create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.TS_SCM_WUP_CLUSTER_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Marktnummer',
	WUP_CLUSTER_ID NUMBER(38,0) NOT NULL COMMENT 'Marktcluster ID',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Nebenbetrieb',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Marktcluster (Zuordnung) für KL_SCM'
;
