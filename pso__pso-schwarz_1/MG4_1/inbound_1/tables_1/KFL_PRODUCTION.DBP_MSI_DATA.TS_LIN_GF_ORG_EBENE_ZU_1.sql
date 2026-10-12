create or replace TABLE KFL_PRODUCTION.DBP_MSI_DATA.TS_LIN_GF_ORG_EBENE_ZU_1 (
	USER_ID VARCHAR(30) NOT NULL COLLATE 'en-ci' COMMENT 'LDAP / Benutzerkennung',
	HR_OBJEKT_EBENE2_ID NUMBER(18,0) COMMENT 'ID zur Organisationseinheit auf Ebene 2',
	HR_OBJEKT_EBENE3_ID NUMBER(18,0) COMMENT 'ID zur Organisationseinheit auf Ebene 3',
	HR_OBJEKT_EBENE4_ID NUMBER(18,0) COMMENT 'ID zur Organisationseinheit auf Ebene 4',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Tabelle fuer Transaction-Service: Zuordnung GF_1 zu Organisationshierarchie-Ebene'
;