create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.VS (
	VS_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Vertriebsschiene',
	VS_BEZ VARCHAR(160) COMMENT 'Bezeichnung der Vertriebsschiene, z.Bsp. Nord',
	VK_ID NUMBER(38,0) COMMENT 'Vertriebskanal ID',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	VSVT_BEZ VARCHAR(160) COMMENT 'Bezeichnung, z.Bsp. Vertrieb Nord',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	VS_REF_WUP_ID NUMBER(38,0) COMMENT 'gibt den leitmarkt der region an. wird manuell befüllt'
)COMMENT='TP1_MIS - Vertriebsschiene'
;
