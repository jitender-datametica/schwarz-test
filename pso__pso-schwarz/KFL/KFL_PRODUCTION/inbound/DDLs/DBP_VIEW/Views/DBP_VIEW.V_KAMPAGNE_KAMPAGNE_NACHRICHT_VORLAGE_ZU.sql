CREATE OR REPLACE VIEW DBP_VIEW.V_KAMPAGNE_KAMPAGNE_NACHRICHT_VORLAGE_ZU (
   mandant_id                               COMMENT 'Mandant im DWH.'
  ,kampagne_id                              COMMENT 'Eindeutige Kennung der Kampagne, innerhalb derer die personalisierte Nachricht gesendet wird.'
  ,nachricht_vorlage_id                     COMMENT 'Vom Quellsystem generierte ID der Nachrichtenvorlage (GUID).'
  ,kommunikationskanal_id                   COMMENT 'Kennung des Kommunikationskanals, für den die Nachrichtenvorlage bestimmt ist, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.'
)
COMMENT = 'Zuordnung von Nachrichtenvorlagen zu Kampagnen. Darüber lässt sich sehen welche Vorlagen für welche Kampagnen verwendet werden.'
 AS 
    SELECT 
        mandant_id,
        kampagne_id,
        nachricht_vorlage_id,
        kommunikationskanal_id

FROM DBP_DATA.KAMPAGNE_KAMPAGNE_NACHRICHT_VORLAGE_ZU ;