CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.kampagne_vorlage_mo_sum (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH.'),
kampagne_id STRING(100) NOT NULL
OPTIONS(description='Eindeutige Kennung der Kampagne, die der GUID im Quellsystem entspricht.'),
kjmo INTEGER NOT NULL OPTIONS(description='Kombinierter Schlüssel aus Kalenderjahr und Monat, formatiert als YYYYMM.'),
nachricht_vorlage_id STRING(100) NOT NULL
OPTIONS(description='Vom Quellsystem generierte ID der Nachrichtenvorlage (GUID).'),
kommunikationskanal_id INTEGER NOT NULL
OPTIONS(description='Kennung des Kommunikationskanals, für den die Nachrichtenvorlage bestimmt ist, z. B. E-Mail, Push-Benachrichtigung, SMS, etc.'),
nachricht_subvorlage_name_liste_txt STRING(4000) NOT NULL
OPTIONS(description='Enthält die Reihenfolge und Namen zu den IDs der verwendeten E-Mail-Subvorlagevarianten, z. B. für\"2-null-2-3\" in nachricht_subvorlage_id_liste_txt könnte hier stehen\"Obst-default-Obst-Gemüse\".'),
kampagne_name STRING(200) NOT NULL OPTIONS(description='Bezeichnender Name der Kampagnendefinition.'),
dat_kampagne_von DATE OPTIONS(description='Datum, an dem die Kampagne startet wird.'),
kampagne_rhythmus_typ_id INTEGER NOT NULL
OPTIONS(description='Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne, z. B. 0 = Recurring, 1 = Ongoing, 2 = OneTime, 3 = Event.'),
kampagne_version_nr INTEGER NOT NULL
OPTIONS(description='Version der Kampagne. Bei jedem Auslösen einer Kampagne wird eine neue Version erstellt. Diese Zahl entspricht der genutzen Version.'),
nachricht_vorlage_titel_txt STRING(4000)
OPTIONS(description='Titel der Nachrichtenvorlage, z. B. Betreff einer E-Mail. Gilt nur für E-Mail und Push-Benachrichtigung.'),
nachricht_vorlage_txt STRING(4000)
OPTIONS(description='Text der Nachrichtenvorlage. Es handelt sich um die Vorschau für E-Mails und die Nachricht für Push-Benachrichtigungen und SMS.'),
nachricht_vorlage_url_txt STRING(2000)
OPTIONS(description='In-App-Navigation Link-URL, die in der Nachrichtenvorlage enthalten sein soll. Sie wird nur für Push-Benachrichtigungen befüllt.'),
nachricht_vorlage_bild_id STRING(100)
OPTIONS(description='Kennung des Bildes, das in der Nachrichtenvorlage verwendet werden soll. Sie wird nur für Push-Benachrichtigungen befüllt.'),
anz_kampagne_kunde_gesamt INTEGER NOT NULL
OPTIONS(description='Zielgruppengröße, die über die Kampagne informiert wird. Die Zahle bezieht sich auf Ebene der Kampagne_ID und Monat.'),
anz_kunde_gesendet INTEGER NOT NULL OPTIONS(description='Anzahl der Kunden, an die eine Nachricht gesendet wurde.'),
rate_kunde_gesendet NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Nachricht, an die eine Nachricht gesendet wurde, an der Gesamtzahl der Kunden innerhalb der Kampagne. (Berechnung: anz_kunde_gesendet / anz_kampagne_kunde_gesamt)'),
anz_kunde_blockiert INTEGER NOT NULL OPTIONS(description='Anzahl der Kunden, an die eine Nachricht blockiert wurde.'),
rate_kunde_blockiert NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, an die eine Nachricht blockiert wurde, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_blockiert / anz_kunde_gesendet)'),
anz_kunde_zugestellt INTEGER NOT NULL OPTIONS(description='Anzahl der Kunden, an die eine Nachricht zugestellt wurde.'),
rate_kunde_zugestellt NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, an die eine Nachricht zugestellt wurde, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_zugestellt / anz_kunde_gesendet)'),
anz_kunde_bounced_soft INTEGER NOT NULL
OPTIONS(description='Anzahl der Kunden, bei denen eine Nachricht aufgrund eines Soft Bounces nicht zugestellt werden konnte.'),
rate_kunde_bounced_soft NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, bei denen eine Nachricht aufgrund eines Soft Bounces nicht zugestellt werden konnte, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_bounced_soft / anz_kunde_gesendet)'),
anz_kunde_bounced_hard INTEGER NOT NULL
OPTIONS(description='Anzahl der Kunden, bei denen eine Nachricht aufgrund eines Hard Bounces nicht zugestellt werden konnte.'),
rate_kunde_bounced_hard NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, bei denen eine Nachricht aufgrund eines Soft Bounces nicht zugestellt werden konnte, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_bounced_hard / anz_kunde_gesendet)'),
anz_kunde_geoeffnet INTEGER NOT NULL OPTIONS(description='Anzahl der Kunden, die eine Nachricht geöffnet hat.'),
rate_kunde_geoeffnet_zugestellt NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, die eine Nachricht geöffnet hat, an der Gesamtzahl der Kunden, an die eine Nachricht zugestellt wurde. (Berechnung: anz_kunde_geoeffnet / anz_kunde_zugestellt)'),
anz_kunde_geklickt INTEGER NOT NULL
OPTIONS(description='Anzahl der Kunden, die auf mindestens einen Link in einer Nachricht geklickt hat.'),
rate_kunde_geklickt_gesendet NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer Nachricht geklickt hat, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_geklickt / anz_kunde_gesendet)'),
rate_kunde_geklickt_geoeffnet NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer Nachricht geklickt hat, an der Gesamtzahl der Kunden, die eine Nachricht geöffnet hat. (Berechnung: anz_kunde_geklickt / anz_kunde_geoeffnet)'),
rate_kunde_geklickt_zugestellt NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer Nachricht geklickt hat, an der Gesamtzahl der Kunden, an die eine Nachricht zugestellt wurde. (Berechnung: anz_kunde_geklickt / anz_kunde_zugestellt)'),
anz_kunde_spam INTEGER NOT NULL
OPTIONS(description='Anzahl der Kunden, bei denen eine Nachricht als Spam klassifiziert wurde.'),
rate_kunde_spam NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, bei denen eine Nachricht als Spam klassifiziert wurde, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_spam / anz_kunde_gesendet)'),
anz_kunde_abgemeldet INTEGER NOT NULL OPTIONS(description='Anzahl der Kunden, die sich abgemeldet haben.'),
rate_kunde_abgemeldet NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, die sich abgemeldet haben, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_abgemeldet / anz_kunde_gesendet)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kampagne_id, kjmo, nachricht_vorlage_id, kommunikationskanal_id,
 nachricht_subvorlage_name_liste_txt) NOT ENFORCED
)
OPTIONS(description='Die Tabelle enthält monatlich aggregierte Daten zu den Kampagnen. Sie wird zur Erstellung von Monatsberichten verwendet und beinhaltet Kennzahlen wie die Gesamtzahl der versendeten Nachrichten, die Öffnungsraten, die Klickraten und weitere relevante Metriken pro Kampagne, Monat, Vorlage und Subvorlage_name_liste.');