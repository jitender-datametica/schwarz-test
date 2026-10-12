create or replace TABLE KFL_PRODUCTION.DBP_SECURITY.USER_ROLLE_EK_INT_ZU_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	USER_ID VARCHAR(30) NOT NULL COLLATE 'en-ci' COMMENT 'ID des MSI Users',
	ROLLE_ID NUMBER(38,0) COMMENT 'ID der Rolle (Zuweisung ob ZEK_1, WBL_1 (EKL) oder GF_1)',
	ROLLE_BEZ VARCHAR(30) COLLATE 'en-ci' COMMENT 'Bezeichung der Rolle (ZEK_1, WBL_1 (EKL) oder GF_1)',
	ZEK_ID VARCHAR(3) COMMENT 'falls Rolle = ZEK_1 steht hier die Zentraleinkäufer - ID',
	WBL_ID NUMBER(38,0) COMMENT 'falls Rolle = WBL_1 steht hier die Warenbereichsleiter(EKL) ID ',
	GF_ID NUMBER(38,0) COMMENT 'falls Rolle = GF_1 steht hier dieGeschäftsführer ID',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_USER_ROLLE_EK_INT_ZU primary key (MANDANT_ID, USER_ID)
)COMMENT='EK-INT - Zuordnungstabelle UserID (LDAP) zu Rolle und entsprechender ID der Rolle (ZEK_1, WBL_1 oder GF_1) - wird manuell über MSI (TAS) befüllt'
;