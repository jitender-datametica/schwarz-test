create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_L_EINGANGSKANAL_1 (
	CRM_EINGANGSKANAL_ID NUMBER(38,0) NOT NULL COMMENT 'Eingangskanal ID - z.B. Telefon, Email, etc.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_L_EINGANGSKANAL primary key (CRM_EINGANGSKANAL_ID)
)COMMENT='KMR - Lookup für Eingangskanal - MS Dynamics CRM'
;