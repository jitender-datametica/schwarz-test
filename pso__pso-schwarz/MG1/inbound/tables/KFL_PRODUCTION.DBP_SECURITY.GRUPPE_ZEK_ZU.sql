create or replace TABLE KFL_PRODUCTION.DBP_SECURITY.GRUPPE_ZEK_ZU (
	GRUPPE_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige ID einer Usergruppe',
	ZEK_ID VARCHAR(3) NOT NULL COMMENT 'Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	ALLE_ZEK_FG NUMBER(38,0) COMMENT 'User dieser Gruppe werden allen zeks zugeordnet.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GRUPPE_ZEK_ZU primary key (GRUPPE_ID, ZEK_ID, MANDANT_ID)
)COMMENT='AIS KMO - Securitytabelle zur Pflege von Usergruppen'
;