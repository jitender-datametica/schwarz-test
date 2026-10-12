create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.L_COS_BONUSKAUF_STATUS_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	BONUSKAUF_STATUS_ID NUMBER(18,0) NOT NULL COMMENT 'Gibt den Status_2 des Coupons an.  0 = inaktiv, 1 = aktiv, 2 = widerruft, bzw. inactive, active, revoked respektiv ',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_L_COS_BONUSKAUF_STATUS primary key (MANDANT_ID, BONUSKAUF_STATUS_ID)
)COMMENT='Lookup-Tabelle für den Status_2 des Coupons.'
;
