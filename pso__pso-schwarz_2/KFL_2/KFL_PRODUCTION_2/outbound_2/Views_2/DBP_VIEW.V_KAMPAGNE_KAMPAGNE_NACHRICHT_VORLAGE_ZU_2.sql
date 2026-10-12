CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kampagne_kampagne_nachricht_vorlage_zu_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH.'), kampagne_id
OPTIONS(description='Eindeutige Kennung der Kampagne_2, innerhalb derer die personalisierte Nachricht gesendet wird.'),
nachricht_vorlage_id OPTIONS(description='Vom Quellsystem generierte ID der Nachrichtenvorlage (GUID).'),
kommunikationskanal_id
OPTIONS(description='Kennung des Kommunikationskanals, für den die Nachrichtenvorlage bestimmt ist, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.'))
OPTIONS(DESCRIPTION = `ZUORDNUNG VON NACHRICHTENVORLAGEN ZU KAMPAGNEN. DARÜBER LÄSST SICH SEHEN WELCHE VORLAGEN FÜR WELCHE KAMPAGNEN VERWENDET WERDEN.`)
AS SELECT mandant_id,
 kampagne_id,
 nachricht_vorlage_id,
 kommunikationskanal_id
FROM kfl_production_dbp_data.kampagne_kampagne_nachricht_vorlage_zu_2;