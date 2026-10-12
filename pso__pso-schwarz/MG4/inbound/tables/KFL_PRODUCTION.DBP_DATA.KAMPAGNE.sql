create or replace TABLE KFL_PRODUCTION.DBP_DATA.KAMPAGNE (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH.',
	KAMPAGNE_ID VARCHAR(100) NOT NULL COMMENT 'Eindeutige Kennung der Kampagne, die der GUID im Quellsystem entspricht.',
	KAMPAGNE_NAME VARCHAR(200) NOT NULL COMMENT 'Bezeichnender Name der Kampagnendefinition.',
	DAT_KAMPAGNE_VON DATE COMMENT 'Datum, an dem die Kampagne startet wird.',
	DAT_KAMPAGNE_BIS DATE COMMENT 'Datum, an dem die Kampagne endet.',
	KAMPAGNE_RHYTHMUS_TYP_ID NUMBER(38,0) NOT NULL COMMENT 'Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne, z. B. 0 = Recurring, 1 = Ongoing, 2 = OneTime, 3 = Event.',
	KAMPAGNE_VERSION_NR NUMBER(38,0) NOT NULL COMMENT 'Version der Kampagne. Bei jedem Auslösen einer Kampagne wird eine neue Version erstellt. Diese Zahl entspricht der genutzen Version.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KAMPAGNE primary key (MANDANT_ID, KAMPAGNE_ID)
)COMMENT='Die Tabelle enthält Informationen über die CRM Kampagnen, mit denen Nachrichten wie E-Mail, Push-Benachrichtigungen und SMS über verschiedene Kanäle hinweg verfolgt und analysiert werden können.'
;