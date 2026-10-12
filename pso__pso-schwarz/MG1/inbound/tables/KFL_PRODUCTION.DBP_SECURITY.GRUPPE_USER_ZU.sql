create or replace TABLE KFL_PRODUCTION.DBP_SECURITY.GRUPPE_USER_ZU (
	GRUPPE_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige ID einer Usergruppe',
	USER_ID VARCHAR(30) NOT NULL COLLATE 'en-ci' COMMENT 'ID des MSI Users',
	DAT_GUELTIG_BIS DATE NOT NULL DEFAULT CAST('9999-12-31' AS DATE) COMMENT 'Gültigkeitsende der Zuordnung des Users zur ZEK Grupppe.(immer bis inkl. des Datums, d.h. bei einem dat_gueltig_bis vom 20.04.2025 wird der User bis und inkl. dem 20.04.2025 der Gruppe zugeteilt).',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GRUPPE_USER_ZU primary key (GRUPPE_ID, USER_ID)
)COMMENT='AIS KMO - Securitytabelle zur Pflege von Usergruppen'
;