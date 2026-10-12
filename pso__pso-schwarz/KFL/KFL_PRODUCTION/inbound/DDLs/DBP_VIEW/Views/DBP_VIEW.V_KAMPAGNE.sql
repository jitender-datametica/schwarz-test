CREATE OR REPLACE VIEW DBP_VIEW.V_KAMPAGNE (
   mandant_id                               COMMENT 'Mandant im DWH.'
  ,kampagne_id                              COMMENT 'Eindeutige Kennung der Kampagne, die der GUID im Quellsystem entspricht.'
  ,kampagne_name                            COMMENT 'Bezeichnender Name der Kampagnendefinition.'
  ,dat_kampagne_von                         COMMENT 'Datum, an dem die Kampagne startet wird.'
  ,dat_kampagne_bis                         COMMENT 'Datum, an dem die Kampagne endet.'
  ,kampagne_rhythmus_typ_id                 COMMENT 'Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne, z. B. 0 = Recurring, 1 = Ongoing, 2 = OneTime, 3 = Event.'
  ,kampagne_version_nr                      COMMENT 'Version der Kampagne. Bei jedem Auslösen einer Kampagne wird eine neue Version erstellt. Diese Zahl entspricht der genutzen Version.'
)
COMMENT = 'Die Tabelle enthält Informationen über die CRM Kampagnen, mit denen Nachrichten wie E-Mail, Push-Benachrichtigungen und SMS über verschiedene Kanäle hinweg verfolgt und analysiert werden können.'
 AS 
    SELECT 
        mandant_id,
        kampagne_id,
        kampagne_name,
        dat_kampagne_von,
        dat_kampagne_bis,
        kampagne_rhythmus_typ_id,
        kampagne_version_nr

FROM DBP_DATA.KAMPAGNE ;