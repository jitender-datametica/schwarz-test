create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_L_OPTIN_1 (
	CRM_OPTIN_ID VARCHAR(144) NOT NULL COMMENT 'CRM-interne ID für ein Optin ',
	CRM_OPTIN_TYP_ID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'CRM-interne ID für den Typ des Optins (bspw. Email, Mobile Phone, Telephone...)',
	CRM_OPTIN_HERKUNFT_ID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'CRM-interne ID für die Herkunft/den Ursprung des Optins (fast alle Optins sollten den Ursrung in der Loyalty App haben)',
	CRM_OPTIN_KANAL_ID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'CRM-interne ID für den Kanal des Optins',
	CRM_OPTIN_BEZ_ID NUMBER(38,0) NOT NULL DEFAULT -9999 COMMENT 'ID zur Bezeichnung des Optins. Bezeichnungen sind generisch, bspw. SMS, Terms and Conditions etc.',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)COMMENT='CRM - Enthält Daten der Entität \"Arvato_optin\" (Optin) aus MS Dynamics CRM'
;