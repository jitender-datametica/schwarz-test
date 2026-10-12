create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_GENDER_SPR_ZU_1 (
	GENDER_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'ID für das Geschlecht des Kunden',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	GENDER_BEZ VARCHAR(50) DEFAULT 'system generated' COMMENT 'Bezeichnugn für das Geschlecht des Kunden',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)COMMENT='CRM - Sprachtabelle für das Attribut \"Gendercode\" (Entität \"Contact_1\", Kundengeschlecht) aus MS Dynamics CRM'
;