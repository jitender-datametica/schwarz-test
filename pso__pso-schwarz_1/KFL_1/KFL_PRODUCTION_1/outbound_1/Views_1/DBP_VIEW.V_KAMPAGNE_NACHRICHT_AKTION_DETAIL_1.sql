CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kampagne_nachricht_aktion_detail_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH.'), nachricht_workflow_id
OPTIONS(description='ID des Workflows, der die Interaktionen zum Kunde in einer Kampagne_1 verarbeitet.'),
nachricht_vorlage_id OPTIONS(description='Eindeutige Kennung der verwendeten Nachrichtenvorlage.'),
kommunikationskanal_id
OPTIONS(description='Kennung des Kommunikationskanals, über den die Nachricht versendet wurde, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.'),
datzeit_nachricht_aktion OPTIONS(description='Zeitpunkt, an dem der Empfänger die Aktion_1 ausgeführt hat.'),
nachricht_aktion_typ_id
OPTIONS(description='ID, die die Art_1 der ausgeführten Aktion_1 angibt, z. B. 1 = Link geklickt, 2 = Geöffnet, 3 = Feedback Loop.'),
personalisierte_url_name OPTIONS(description='Bezeichnung des Hyperlinks, auf den der Empfänger geklickt hat.'),
personalisierte_url_txt OPTIONS(description='Personalisierte URL des Hyperlinks, auf den der Empfänger geklickt hat.'))
OPTIONS(DESCRIPTION = `DIESE TABELLE DIENT ZUR ERFASSUNG VON DETAILS ZU NACHRICHTENAKTIONEN. DERZEIT ENTHÄLT SIE NUR GEKLICKTE PERSONALISIERTE URLS IN NACHRICHTEN.`)
AS SELECT mandant_id,
 nachricht_workflow_id,
 nachricht_vorlage_id,
 kommunikationskanal_id,
 datzeit_nachricht_aktion,
 nachricht_aktion_typ_id,
 personalisierte_url_name,
 personalisierte_url_txt
FROM kfl_production_dbp_data.kampagne_nachricht_aktion_detail_1;