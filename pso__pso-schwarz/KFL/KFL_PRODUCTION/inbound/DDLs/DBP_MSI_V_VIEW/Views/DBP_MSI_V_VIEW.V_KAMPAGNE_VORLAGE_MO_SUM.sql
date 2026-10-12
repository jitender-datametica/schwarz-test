CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_KAMPAGNE_VORLAGE_MO_SUM (
   mandant_id                               COMMENT 'Mandant im DWH.'
  ,kampagne_id                              COMMENT 'Eindeutige Kennung der Kampagne, die der GUID im Quellsystem entspricht.'
  ,kjmo                                     COMMENT 'Kombinierter Schlüssel aus Kalenderjahr und Monat, formatiert als YYYYMM.'
  ,nachricht_vorlage_id                     COMMENT 'Vom Quellsystem generierte ID der Nachrichtenvorlage (GUID).'
  ,kommunikationskanal_id                   COMMENT 'Kennung des Kommunikationskanals, für den die Nachrichtenvorlage bestimmt ist, z. B. E-Mail, Push-Benachrichtigung, SMS, etc.'
  ,nachricht_subvorlage_name_liste_txt      COMMENT 'Enthält die Reihenfolge und Namen zu den IDs der verwendeten E-Mail-Subvorlagevarianten, z. B. für "2-null-2-3" in nachricht_subvorlage_id_liste_txt könnte hier stehen "Obst-default-Obst-Gemüse".'
  ,kampagne_name                            COMMENT 'Bezeichnender Name der Kampagnendefinition.'
  ,dat_kampagne_von                         COMMENT 'Datum, an dem die Kampagne startet wird.'
  ,kampagne_rhythmus_typ_id                 COMMENT 'Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne, z. B. 0 = Recurring, 1 = Ongoing, 2 = OneTime, 3 = Event.'
  ,kampagne_version_nr                      COMMENT 'Version der Kampagne. Bei jedem Auslösen einer Kampagne wird eine neue Version erstellt. Diese Zahl entspricht der genutzen Version.'
  ,nachricht_vorlage_titel_txt              COMMENT 'Titel der Nachrichtenvorlage, z. B. Betreff einer E-Mail. Gilt nur für E-Mail und Push-Benachrichtigung.'
  ,nachricht_vorlage_txt                    COMMENT 'Text der Nachrichtenvorlage. Es handelt sich um die Vorschau für E-Mails und die Nachricht für Push-Benachrichtigungen und SMS.'
  ,nachricht_vorlage_url_txt                COMMENT 'In-App-Navigation Link-URL, die in der Nachrichtenvorlage enthalten sein soll. Sie wird nur für Push-Benachrichtigungen befüllt.'
  ,nachricht_vorlage_bild_id                COMMENT 'Kennung des Bildes, das in der Nachrichtenvorlage verwendet werden soll. Sie wird nur für Push-Benachrichtigungen befüllt.'
  ,anz_kampagne_kunde_gesamt                COMMENT 'Zielgruppengröße, die über die Kampagne informiert wird. Die Zahle bezieht sich auf Ebene der Kampagne_ID und Monat.'
  ,anz_kunde_gesendet                       COMMENT 'Anzahl der Kunden, an die eine Nachricht gesendet wurde.'
  ,rate_kunde_gesendet                      COMMENT 'Prozentualer Anteil der Nachricht, an die eine Nachricht gesendet wurde, an der Gesamtzahl der Kunden innerhalb der Kampagne. (Berechnung: anz_kunde_gesendet / anz_kampagne_kunde_gesamt)'
  ,anz_kunde_blockiert                      COMMENT 'Anzahl der Kunden, an die eine Nachricht blockiert wurde.'
  ,rate_kunde_blockiert                     COMMENT 'Prozentualer Anteil der Kunden, an die eine Nachricht blockiert wurde, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_blockiert / anz_kunde_gesendet)'
  ,anz_kunde_zugestellt                     COMMENT 'Anzahl der Kunden, an die eine Nachricht zugestellt wurde.'
  ,rate_kunde_zugestellt                    COMMENT 'Prozentualer Anteil der Kunden, an die eine Nachricht zugestellt wurde, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_zugestellt / anz_kunde_gesendet)'
  ,anz_kunde_bounced_soft                   COMMENT 'Anzahl der Kunden, bei denen eine Nachricht aufgrund eines Soft Bounces nicht zugestellt werden konnte.'
  ,rate_kunde_bounced_soft                  COMMENT 'Prozentualer Anteil der Kunden, bei denen eine Nachricht aufgrund eines Soft Bounces nicht zugestellt werden konnte, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_bounced_soft / anz_kunde_gesendet)'
  ,anz_kunde_bounced_hard                   COMMENT 'Anzahl der Kunden, bei denen eine Nachricht aufgrund eines Hard Bounces nicht zugestellt werden konnte.'
  ,rate_kunde_bounced_hard                  COMMENT 'Prozentualer Anteil der Kunden, bei denen eine Nachricht aufgrund eines Soft Bounces nicht zugestellt werden konnte, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_bounced_hard / anz_kunde_gesendet)'
  ,anz_kunde_geoeffnet                      COMMENT 'Anzahl der Kunden, die eine Nachricht geöffnet hat.'
  ,rate_kunde_geoeffnet_zugestellt          COMMENT 'Prozentualer Anteil der Kunden, die eine Nachricht geöffnet hat, an der Gesamtzahl der Kunden, an die eine Nachricht zugestellt wurde. (Berechnung: anz_kunde_geoeffnet / anz_kunde_zugestellt)'
  ,anz_kunde_geklickt                       COMMENT 'Anzahl der Kunden, die auf mindestens einen Link in einer Nachricht geklickt hat.'
  ,rate_kunde_geklickt_gesendet             COMMENT 'Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer Nachricht geklickt hat, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_geklickt / anz_kunde_gesendet)'
  ,rate_kunde_geklickt_geoeffnet            COMMENT 'Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer Nachricht geklickt hat, an der Gesamtzahl der Kunden, die eine Nachricht geöffnet hat. (Berechnung: anz_kunde_geklickt / anz_kunde_geoeffnet)'
  ,rate_kunde_geklickt_zugestellt           COMMENT 'Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer Nachricht geklickt hat, an der Gesamtzahl der Kunden, an die eine Nachricht zugestellt wurde. (Berechnung: anz_kunde_geklickt / anz_kunde_zugestellt)'
  ,anz_kunde_spam                           COMMENT 'Anzahl der Kunden, bei denen eine Nachricht als Spam klassifiziert wurde.'
  ,rate_kunde_spam                          COMMENT 'Prozentualer Anteil der Kunden, bei denen eine Nachricht als Spam klassifiziert wurde, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_spam / anz_kunde_gesendet)'
  ,anz_kunde_abgemeldet                     COMMENT 'Anzahl der Kunden, die sich abgemeldet haben.'
  ,rate_kunde_abgemeldet                    COMMENT 'Prozentualer Anteil der Kunden, die sich abgemeldet haben, an der Gesamtzahl der Kunden, an die eine Nachricht gesendet wurde. (Berechnung: anz_kunde_abgemeldet / anz_kunde_gesendet)'
)
COMMENT = 'Die Tabelle enthält monatlich aggregierte Daten zu den Kampagnen. Sie wird zur Erstellung von Monatsberichten verwendet und beinhaltet Kennzahlen wie die Gesamtzahl der versendeten Nachrichten, die Öffnungsraten, die Klickraten und weitere relevante Metriken pro Kampagne, Monat, Vorlage und Subvorlage_name_liste.'
 AS 
    SELECT 
        mandant_id,
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

FROM DBP_MSI_DATA.KAMPAGNE_VORLAGE_MO_SUM ;