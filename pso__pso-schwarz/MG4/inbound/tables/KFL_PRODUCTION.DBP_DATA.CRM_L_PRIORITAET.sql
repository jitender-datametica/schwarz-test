create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_L_PRIORITAET (
	CRM_PRIORITAET_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Priorität, niedrig, mittel, hoch',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_L_PRIORITAET primary key (CRM_PRIORITAET_ID)
)COMMENT='KMR - Lookup für die Vorgangsprioritäten - MS Dynamics CRM'
;