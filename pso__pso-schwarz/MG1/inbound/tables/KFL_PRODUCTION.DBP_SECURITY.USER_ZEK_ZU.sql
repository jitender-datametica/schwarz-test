create or replace TABLE KFL_PRODUCTION.DBP_SECURITY.USER_ZEK_ZU (
	USER_ID VARCHAR(30) NOT NULL COLLATE 'en-ci' COMMENT 'ID des MSI Users',
	ZEK_ID VARCHAR(3) NOT NULL COMMENT 'Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_USER_ZEK_ZU primary key (USER_ID, ZEK_ID, MANDANT_ID)
)COMMENT='AIS_KMO - alle Zentraleinkäufer, auf deren Artikel / Warengruppen ein User Anzeigeberechtigung hat'
;