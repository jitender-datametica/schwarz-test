create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_OPTIN_BEZ_SPR_ZU_2 (
	CRM_OPTIN_BEZ_ID NUMBER(38,0) NOT NULL DEFAULT -9999 COMMENT 'ID zur Bezeichnung des Optins. Bezeichnungen sind generisch, bspw. SMS, Terms and Conditions etc.',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	CRM_OPTIN_BEZ VARCHAR(240) COMMENT 'Bezeichnung des Optins. Bezeichnungen sind generisch, bspw. SMS, Terms and Conditions etc.',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)COMMENT='CRM - Sprachtabelle für das Attribut \"Arvato_name\" (Entität \"Arvato_optin\", generische Optinbezeichnung) aus MS Dynamics CRM'
;