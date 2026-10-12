--==============================================================
-- Table: kampagne_vorlage_mo_sum
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_vorlage_mo_sum
   generated from Powerdesigner on Freitag, 8. November 2024 17:56:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.KAMPAGNE_VORLAGE_MO_SUM (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH.',
   kampagne_id                         VARCHAR(100)     NOT NULL COMMENT 'Eindeutige Kennung der Kampagne, die der GUID im Quellsystem entspricht.',
   kjmo                                NUMBER(38,0)     NOT NULL COMMENT 'Kombinierter Schlüssel aus Kalenderjahr und Monat, formatiert als YYYYMM.',
   nachricht_vorlage_id                VARCHAR(100)     NOT NULL COMMENT 'Vom Quellsystem generierte ID der Nachrichtenvorlage (GUID).',
   kommunikationskanal_id              NUMBER(38,0)     NOT NULL COMMENT 'Kennung des Kommunikationskanals, für den die Nachrichtenvorlage bestimmt ist, z. B. E-Mail, Push-Benachrichtigung, SMS, etc.',
   nachricht_subvorlage_name_liste_txt VARCHAR(4000)    NOT NULL COMMENT 'Enthält die Reihenfolge und Namen zu den IDs der verwendeten E-Mail-Subvorlagevarianten, z. B. für "2-null-2-3" in nachricht_subvorlage_id_liste_txt könnte hier stehen "Obst-default-Obst-Gemüse".',
   kampagne_name                       VARCHAR(200)     NOT NULL COMMENT 'Bezeichnender Name der Kampagnendefinition.',
   dat_kampagne_von                    DATE             COMMENT 'Datum, an dem die Kampagne startet wird.',
   kampagne_rhythmus_typ_id            NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne, z. B. 0 = Recurring, 1 = Ongoing, 2 = OneTime, 3 = Event.',
   kampagne_version_nr                 NUMBER(38,0)     NOT NULL COMMENT 'Version der Kampagne. Bei jedem Auslösen einer Kampagne wird eine neue Version erstellt. Diese Zahl entspricht der genutzen Version.',
   nachricht_vorlage_titel_txt         VARCHAR(4000)    COMMENT 'Titel der Nachrichtenvorlage, z. B. Betreff einer E-Mail. Gilt nur für E-Mail und Push-Benachrichtigung.',
   nachricht_vorlage_txt               VARCHAR(4000)    COMMENT 'Text der Nachrichtenvorlage. Es handelt sich um die Vorschau für E-Mails und die Nachricht für Push-Benachrichtigungen und SMS.',
   nachricht_vorlage_url_txt           VARCHAR(2000)    COMMENT 'In-App-Navigation Link-URL, die in der Nachrichtenvorlage enthalten sein soll. Sie wird nur für Push-Benachrichtigungen befüllt.',
   nachricht_vorlage_bild_id           VARCHAR(100)     COMMENT 'Kennung des Bildes, das in der Nachrichtenvorlage verwendet werden soll. Sie wird nur für Push-Benachrichtigungen befüllt.',
   anz_kampagne_kunde_gesamt           NUMBER(38,0)     NOT NULL COMMENT 'Zielgruppengröße, die über die Kampagne informiert wird. Die Zahle bezieht sich auf Ebene der Kampagne_ID und Monat.',
   anz_kunde_gesendet                  NUMBER(38,0)     NOT NULL COMMENT 'Anzahl der Kunden, an die eine Nachricht gesendet wurde.',
   rate_kunde_gesendet                 NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Nachricht, an die eine Nachricht gesendet wurde, an der Gesamtzahl der Kunden innerhalb der Kampagne. (Berechnung: anz_kunde_gesendet / anz_kampagne_kunde_gesamt)',
   anz_kunde_blockiert                 NUMBER(38,0)     NOT NULL COMMENT 'Anzahl der Kunden, an die eine Nachricht blockiert wurde.',
   rate_kunde_blockiert                NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, an die eine Nachricht blockiert wurde, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_blockiert / anz_kunde_gesendet)',
   anz_kunde_zugestellt                NUMBER(38,0)     NOT NULL COMMENT 'Anzahl der Kunden, an die eine Nachricht zugestellt wurde.',
   rate_kunde_zugestellt               NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, an die eine Nachricht zugestellt wurde, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_zugestellt / anz_kunde_gesendet)',
   anz_kunde_bounced_soft              NUMBER(38,0)     NOT NULL COMMENT 'Anzahl der Kunden, bei denen eine Nachricht aufgrund eines Soft Bounces nicht zugestellt werden konnte.',
   rate_kunde_bounced_soft             NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, bei denen eine Nachricht aufgrund eines Soft Bounces nicht zugestellt werden konnte, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_bounced_soft / anz_kunde_gesendet)',
   anz_kunde_bounced_hard              NUMBER(38,0)     NOT NULL COMMENT 'Anzahl der Kunden, bei denen eine Nachricht aufgrund eines Hard Bounces nicht zugestellt werden konnte.',
   rate_kunde_bounced_hard             NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, bei denen eine Nachricht aufgrund eines Soft Bounces nicht zugestellt werden konnte, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_bounced_hard / anz_kunde_gesendet)',
   anz_kunde_geoeffnet                 NUMBER(38,0)     NOT NULL COMMENT 'Anzahl der Kunden, die eine Nachricht geöffnet hat.',
   rate_kunde_geoeffnet_zugestellt     NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, die eine Nachricht geöffnet hat, an der Gesamtzahl der Kunden, an die eine Nachricht zugestellt wurde. (Berechnung: anz_kunde_geoeffnet / anz_kunde_zugestellt)',
   anz_kunde_geklickt                  NUMBER(38,0)     NOT NULL COMMENT 'Anzahl der Kunden, die auf mindestens einen Link in einer Nachricht geklickt hat.',
   rate_kunde_geklickt_gesendet        NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer Nachricht geklickt hat, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_geklickt / anz_kunde_gesendet)',
   rate_kunde_geklickt_geoeffnet       NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer Nachricht geklickt hat, an der Gesamtzahl der Kunden, die eine Nachricht geöffnet hat. (Berechnung: anz_kunde_geklickt / anz_kunde_geoeffnet)',
   rate_kunde_geklickt_zugestellt      NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer Nachricht geklickt hat, an der Gesamtzahl der Kunden, an die eine Nachricht zugestellt wurde. (Berechnung: anz_kunde_geklickt / anz_kunde_zugestellt)',
   anz_kunde_spam                      NUMBER(38,0)     NOT NULL COMMENT 'Anzahl der Kunden, bei denen eine Nachricht als Spam klassifiziert wurde.',
   rate_kunde_spam                     NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, bei denen eine Nachricht als Spam klassifiziert wurde, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_spam / anz_kunde_gesendet)',
   anz_kunde_abgemeldet                NUMBER(38,0)     NOT NULL COMMENT 'Anzahl der Kunden, die sich abgemeldet haben.',
   rate_kunde_abgemeldet               NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, die sich abgemeldet haben, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_abgemeldet / anz_kunde_gesendet)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KAMPAGNE_VORLAGE_MO_SUM PRIMARY KEY (mandant_id, kampagne_id, kjmo, nachricht_vorlage_id, kommunikationskanal_id, nachricht_subvorlage_name_liste_txt) NOT ENFORCED
)  COMMENT = 'Die Tabelle enthält monatlich aggregierte Daten zu den Kampagnen. Sie wird zur Erstellung von Monatsberichten verwendet und beinhaltet Kennzahlen wie die Gesamtzahl der versendeten Nachrichten, die Öffnungsraten, die Klickraten und weitere relevante Metriken pro Kampagne, Monat, Vorlage und Subvorlage_name_liste.';
