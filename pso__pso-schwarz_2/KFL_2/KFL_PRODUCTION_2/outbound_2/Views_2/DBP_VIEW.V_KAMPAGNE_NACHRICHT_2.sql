CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kampagne_nachricht_2 (mandant_id OPTIONS(description='Mandant_2 im DWH.'),
nachricht_workflow_id
OPTIONS(description='ID des Workflows, der die Interaktionen zum Kunde in einer Kampagne_2 verarbeitet.'),
nachricht_vorlage_id OPTIONS(description='Eindeutige Kennung der verwendeten Nachrichtenvorlage.'),
kommunikationskanal_id
OPTIONS(description='Kennung des Kommunikationskanals, über den die Nachricht versendet wurde, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.'),
kampagne_id
OPTIONS(description='Eindeutige Kennung der Kampagne_2, innerhalb derer die personalisierte Nachricht gesendet wird.'),
kampagne_kunde_id
OPTIONS(description='Eindeutige Kennung des Kunden, an den die Nachricht gesendet wurde. Nicht alle Quelltabellen enthalten diese Information und müssen aus anderen Quelltabellen gefüllt werden, daher bedeutet\'-1\', dass kein passender Kunde gefunden wurde.'),
nachricht_subvorlage_id_liste_txt
OPTIONS(description='Enthält die Reihenfolge und IDs der verwendeten E-Mail-Subvorlagevarianten, z. B. "2-null-2-2", "2-3".'),
nachricht_subvorlage_name_liste_txt
OPTIONS(description='Enthält die Reihenfolge und Namen zu den IDs der verwendeten E-Mail-Subvorlagevarianten, z. B. für "2-null-2-3" in nachricht_subvorlage_id_liste_txt könnte hier stehen "Obst-default-Obst-Gemüse".'),
email_domain_name OPTIONS(description='Domain der E-Mail-Adresse des Empfängers.'), betriebssystem_name
OPTIONS(description='Betriebssystem des Mobilgeräts. Nur für Push-Benachrichtigungen.'))
OPTIONS(DESCRIPTION = `Diese Tabelle enthält Details zu den gesendeten/blockierenden Nachrichten innerhalb einer Kampagne. Sie dient als Kopftabelle für alle gesendeten/blockierenden Nachrichten.`)
AS SELECT mandant_id,
 nachricht_workflow_id,
 nachricht_vorlage_id,
 kommunikationskanal_id,
 kampagne_id,
 kampagne_kunde_id,
 nachricht_subvorlage_id_liste_txt,
 nachricht_subvorlage_name_liste_txt,
 email_domain_name,
 betriebssystem_name
FROM kfl_production_dbp_data.kampagne_nachricht_2;