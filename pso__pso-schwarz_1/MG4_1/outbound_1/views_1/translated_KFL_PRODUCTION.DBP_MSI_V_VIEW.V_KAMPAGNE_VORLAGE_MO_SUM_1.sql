CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_kampagne_vorlage_mo_sum_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH.'), kampagne_id
OPTIONS(description='Eindeutige Kennung der Kampagne_1, die der GUID im Quellsystem entspricht.'), kjmo
OPTIONS(description='Kombinierter Schlüssel aus Kalenderjahr und Monat_1, formatiert als YYYYMM.'), nachricht_vorlage_id
OPTIONS(description='Vom Quellsystem generierte ID der Nachrichtenvorlage (GUID).'), kommunikationskanal_id
OPTIONS(description='Kennung des Kommunikationskanals, für den die Nachrichtenvorlage bestimmt ist, z. B. E-Mail, Push-Benachrichtigung, SMS, etc.'),
nachricht_subvorlage_name_liste_txt
OPTIONS(description='Enthält die Reihenfolge und Namen zu den IDs der verwendeten E-Mail-Subvorlagevarianten, z. B. für\"2-null-2-3\" in nachricht_subvorlage_id_liste_txt könnte hier stehen\"Obst-default-Obst-Gemüse\".'),
kampagne_name OPTIONS(description='Bezeichnender Name der Kampagnendefinition.'), dat_kampagne_von
OPTIONS(description='Datum, an dem die Kampagne_1 startet wird.'), kampagne_rhythmus_typ_id
OPTIONS(description='Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne_1, z. B. 0 = Recurring, 1 = Ongoing, 2 = OneTime, 3 = Event.'),
kampagne_version_nr
OPTIONS(description='Version der Kampagne. Bei jedem Auslösen einer Kampagne_1 wird eine_1 neue Version erstellt. Diese Zahl entspricht der genutzen Version.'),
nachricht_vorlage_titel_txt
OPTIONS(description='Titel der Nachrichtenvorlage, z. B. Betreff einer E-Mail. Gilt nur für E-Mail und Push-Benachrichtigung.'),
nachricht_vorlage_txt
OPTIONS(description='Text der Nachrichtenvorlage. Es handelt sich um die Vorschau für E-Mails und die Nachricht für Push-Benachrichtigungen und SMS.'),
nachricht_vorlage_url_txt
OPTIONS(description='In-App-Navigation Link-URL, die in der Nachrichtenvorlage enthalten sein soll. Sie wird nur für Push-Benachrichtigungen befüllt.'),
nachricht_vorlage_bild_id
OPTIONS(description='Kennung des Bildes, das in der Nachrichtenvorlage verwendet werden soll. Sie wird nur für Push-Benachrichtigungen befüllt.'),
anz_kampagne_kunde_gesamt
OPTIONS(description='Zielgruppengröße, die über die Kampagne_1 informiert wird. Die Zahle bezieht sich auf Ebene der Kampagne_ID und Monat.'),
anz_kunde_gesendet OPTIONS(description='Anzahl der Kunden, an die eine_1 Nachricht gesendet wurde.'), rate_kunde_gesendet
OPTIONS(description='Prozentualer Anteil der Nachricht, an die eine_1 Nachricht gesendet wurde, an der Gesamtzahl der Kunden innerhalb der Kampagne. (Berechnung: anz_kunde_gesendet / anz_kampagne_kunde_gesamt)'),
anz_kunde_blockiert OPTIONS(description='Anzahl der Kunden, an die eine_1 Nachricht blockiert wurde.'),
rate_kunde_blockiert
OPTIONS(description='Prozentualer Anteil der Kunden, an die eine_1 Nachricht blockiert wurde, an der Gesamtzahl der Kunden, an die eine_1 Nachricht gesendet wurde. (Berechnung: anz_kunde_blockiert / anz_kunde_gesendet)'),
anz_kunde_zugestellt OPTIONS(description='Anzahl der Kunden, an die eine_1 Nachricht zugestellt wurde.'),
rate_kunde_zugestellt
OPTIONS(description='Prozentualer Anteil der Kunden, an die eine_1 Nachricht zugestellt wurde, an der Gesamtzahl der Kunden, an die eine_1 Nachricht gesendet wurde. (Berechnung: anz_kunde_zugestellt / anz_kunde_gesendet)'),
anz_kunde_bounced_soft
OPTIONS(description='Anzahl der Kunden, bei denen eine_1 Nachricht aufgrund eines Soft Bounces nicht zugestellt werden konnte.'),
rate_kunde_bounced_soft
OPTIONS(description='Prozentualer Anteil der Kunden, bei denen eine_1 Nachricht aufgrund eines Soft Bounces nicht zugestellt werden konnte, an der Gesamtzahl der Kunden, an die eine_1 Nachricht gesendet wurde. (Berechnung: anz_kunde_bounced_soft / anz_kunde_gesendet)'),
anz_kunde_bounced_hard
OPTIONS(description='Anzahl der Kunden, bei denen eine_1 Nachricht aufgrund eines Hard Bounces nicht zugestellt werden konnte.'),
rate_kunde_bounced_hard
OPTIONS(description='Prozentualer Anteil der Kunden, bei denen eine_1 Nachricht aufgrund eines Soft Bounces nicht zugestellt werden konnte, an der Gesamtzahl der Kunden, an die eine_1 Nachricht gesendet wurde. (Berechnung: anz_kunde_bounced_hard / anz_kunde_gesendet)'),
anz_kunde_geoeffnet OPTIONS(description='Anzahl der Kunden, die eine_1 Nachricht geöffnet hat.'),
rate_kunde_geoeffnet_zugestellt
OPTIONS(description='Prozentualer Anteil der Kunden, die eine_1 Nachricht geöffnet hat, an der Gesamtzahl der Kunden, an die eine_1 Nachricht zugestellt wurde. (Berechnung: anz_kunde_geoeffnet / anz_kunde_zugestellt)'),
anz_kunde_geklickt
OPTIONS(description='Anzahl der Kunden, die auf mindestens einen Link in einer Nachricht geklickt hat.'),
rate_kunde_geklickt_gesendet
OPTIONS(description='Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer Nachricht geklickt hat, an der Gesamtzahl der Kunden, an die eine_1 Nachricht gesendet wurde. (Berechnung: anz_kunde_geklickt / anz_kunde_gesendet)'),
rate_kunde_geklickt_geoeffnet
OPTIONS(description='Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer Nachricht geklickt hat, an der Gesamtzahl der Kunden, die eine_1 Nachricht geöffnet hat. (Berechnung: anz_kunde_geklickt / anz_kunde_geoeffnet)'),
rate_kunde_geklickt_zugestellt
OPTIONS(description='Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer Nachricht geklickt hat, an der Gesamtzahl der Kunden, an die eine_1 Nachricht zugestellt wurde. (Berechnung: anz_kunde_geklickt / anz_kunde_zugestellt)'),
anz_kunde_spam OPTIONS(description='Anzahl der Kunden, bei denen eine_1 Nachricht als Spam klassifiziert wurde.'),
rate_kunde_spam
OPTIONS(description='Prozentualer Anteil der Kunden, bei denen eine_1 Nachricht als Spam klassifiziert wurde, an der Gesamtzahl der Kunden, an die eine_1 Nachricht gesendet wurde. (Berechnung: anz_kunde_spam / anz_kunde_gesendet)'),
anz_kunde_abgemeldet OPTIONS(description='Anzahl der Kunden, die sich abgemeldet haben.'), rate_kunde_abgemeldet
OPTIONS(description='Prozentualer Anteil der Kunden, die sich abgemeldet haben, an der Gesamtzahl der Kunden, an die eine_1 Nachricht gesendet wurde. (Berechnung: anz_kunde_abgemeldet / anz_kunde_gesendet)'))
AS SELECT mandant_id,
 kampagne_id,
 kjmo,
 nachricht_vorlage_id,
 kommunikationskanal_id,
 nachricht_subvorlage_name_liste_txt,
 kampagne_name,
 dat_kampagne_von,
 kampagne_rhythmus_typ_id,
 kampagne_version_nr,
 nachricht_vorlage_titel_txt,
 nachricht_vorlage_txt,
 nachricht_vorlage_url_txt,
 nachricht_vorlage_bild_id,
 anz_kampagne_kunde_gesamt,
 anz_kunde_gesendet,
 rate_kunde_gesendet,
 anz_kunde_blockiert,
 rate_kunde_blockiert,
 anz_kunde_zugestellt,
 rate_kunde_zugestellt,
 anz_kunde_bounced_soft,
 rate_kunde_bounced_soft,
 anz_kunde_bounced_hard,
 rate_kunde_bounced_hard,
 anz_kunde_geoeffnet,
 rate_kunde_geoeffnet_zugestellt,
 anz_kunde_geklickt,
 rate_kunde_geklickt_gesendet,
 rate_kunde_geklickt_geoeffnet,
 rate_kunde_geklickt_zugestellt,
 anz_kunde_spam,
 rate_kunde_spam,
 anz_kunde_abgemeldet,
 rate_kunde_abgemeldet
FROM kfl_production_dbp_msi_data.kampagne_vorlage_mo_sum_1;