create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_L_FREMDKOERPER (
	CRM_FREMDKOERPER_ID NUMBER(38,0) NOT NULL COMMENT 'Art der Verunreinigung ID',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_L_FREMDKOERPER primary key (CRM_FREMDKOERPER_ID)
)COMMENT='KMR - Lookup für Fremdkörper - MS Dynamics CRM'
;