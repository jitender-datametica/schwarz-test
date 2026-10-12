CREATE TABLE DBP_DATA.CRM_KUNDE_STATUSGRUND_SPR_ZU (
	KUNDE_STATUSGRUND_ID NUMBER(38,0) NOT NULL DEFAULT -9999 COMMENT 'Statusgrund-ID des Kunden (liefert Information darüber, wieso der Kunde die entsprechende Status-ID hat)',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	KUNDE_STATUSGRUND_BEZ VARCHAR(120) COMMENT 'Bezeichnung des Kundenstatusgrunds',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)COMMENT='CRM - Sprachtabelle für das Attribut \"Statuscode\" (Entität \"Contact\", Kundenstatus) aus MS Dynamics CRM'
;