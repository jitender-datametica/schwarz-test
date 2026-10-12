create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.COS_BONUSKAUF_STATUS_SPR_ZU_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	BONUSKAUF_STATUS_ID NUMBER(18,0) NOT NULL COMMENT 'Gibt den Status_1 des Coupons an.  0 = inaktiv, 1 = aktiv, 2 = widerruft, bzw. inactive, active, revoked respektiv',
	SPR_ID NUMBER(18,0) NOT NULL COMMENT 'ID der Sprache',
	BONUSKAUF_STATUS_BEZ VARCHAR(200) NOT NULL COMMENT 'Bezeichung des Status_1 des Coupons inaktiv, aktiv,  widerruft, bzw. inactive, active, revoked respektiv',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_COS_BONUSKAUF_STATUS_SPR_ZU primary key (MANDANT_ID, BONUSKAUF_STATUS_ID, SPR_ID)
)COMMENT='Sprachtabelle für den Status_1 des Coupons'
;
