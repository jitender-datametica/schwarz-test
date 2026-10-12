create or replace view KFL_PRODUCTION.DBP_VIEW.V_KAMPAGNE_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH.',
	KAMPAGNE_ID COMMENT 'Eindeutige Kennung der Kampagne_1, die der GUID im Quellsystem entspricht.',
	KAMPAGNE_NAME COMMENT 'Bezeichnender Name der Kampagnendefinition.',
	DAT_KAMPAGNE_VON COMMENT 'Datum, an dem die Kampagne_1 startet wird.',
	DAT_KAMPAGNE_BIS COMMENT 'Datum, an dem die Kampagne_1 endet.',
	KAMPAGNE_RHYTHMUS_TYP_ID COMMENT 'Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne_1, z. B. 0 = Recurring, 1 = Ongoing, 2 = OneTime, 3 = Event.',
	KAMPAGNE_VERSION_NR COMMENT 'Version der Kampagne. Bei jedem Auslösen einer Kampagne_1 wird eine_1 neue Version erstellt. Diese Zahl entspricht der genutzen Version.'
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

FROM DBP_DATA.KAMPAGNE_1 ;