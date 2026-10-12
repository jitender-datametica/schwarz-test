create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_OPTIN_KANAL_SPR_ZU_1 (
	CRM_OPTIN_KANAL_ID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'CRM-interne ID für den Kanal des Optins',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	CRM_OPTIN_KANAL_BEZ VARCHAR(120) COMMENT 'Bezeichnug für den Kanal des Optins',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)COMMENT='CRM - Sprachtabelle für das Attribut \"Arvato_Optintypecode\" (Entität \"Arvato_optin\", Optin-Herkunft) aus MS Dynamics CRM'
;