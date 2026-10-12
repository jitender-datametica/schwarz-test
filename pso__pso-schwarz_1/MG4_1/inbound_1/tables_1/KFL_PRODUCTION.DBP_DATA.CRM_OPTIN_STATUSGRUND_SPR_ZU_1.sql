create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_OPTIN_STATUSGRUND_SPR_ZU_1 (
	OPTIN_STATUSGRUND_ID NUMBER(38,0) NOT NULL DEFAULT -9999 COMMENT 'Statusgrund-ID des Optins (liefert Information darüber, wieso das Optin die entsprechende Status_1-ID hat, bspw. Erlaubnis erteilt, Erlaubnis nicht erteilt, Erlaubnis entzogen)',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	OPTIN_STATUSGRUND_BEZ VARCHAR(120) COMMENT 'Statusgrund-Bezeichnung des Optins',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)COMMENT='CRM - Sprachtabelle für das Attribut \"Statuscode\" (Entität \"Arvato_optin\", Optin-Statusgrund) aus MS Dynamics CRM'
;