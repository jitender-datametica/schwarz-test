create or replace view KFL_PRODUCTION.DBP_VIEW.V_KAMPAGNE(
	MANDANT_ID COMMENT 'Mandant im DWH.',
	KAMPAGNE_ID COMMENT 'Eindeutige Kennung der Kampagne, die der GUID im Quellsystem entspricht.',
	KAMPAGNE_NAME COMMENT 'Bezeichnender Name der Kampagnendefinition.',
	DAT_KAMPAGNE_VON COMMENT 'Datum, an dem die Kampagne startet wird.',
	DAT_KAMPAGNE_BIS COMMENT 'Datum, an dem die Kampagne endet.',
	KAMPAGNE_RHYTHMUS_TYP_ID COMMENT 'Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne, z. B. 0 = Recurring, 1 = Ongoing, 2 = OneTime, 3 = Event.',
	KAMPAGNE_VERSION_NR COMMENT 'Version der Kampagne. Bei jedem Auslösen einer Kampagne wird eine neue Version erstellt. Diese Zahl entspricht der genutzen Version.'
) COMMENT='Die Tabelle enthält Informationen über die CRM Kampagnen, mit denen Nachrichten wie E-Mail, Push-Benachrichtigungen und SMS über verschiedene Kanäle hinweg verfolgt und analysiert werden können.'
 as 
    SELECT 
        mandant_id,
        kampagne_id,
        kampagne_name,
        dat_kampagne_von,
        dat_kampagne_bis,
        kampagne_rhythmus_typ_id,
        kampagne_version_nr

FROM DBP_DATA.KAMPAGNE ;