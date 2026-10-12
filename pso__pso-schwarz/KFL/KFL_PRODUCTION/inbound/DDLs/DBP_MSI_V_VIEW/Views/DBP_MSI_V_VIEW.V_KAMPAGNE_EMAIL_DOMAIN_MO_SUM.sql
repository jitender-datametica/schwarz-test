CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_KAMPAGNE_EMAIL_DOMAIN_MO_SUM (
   mandant_id                               COMMENT 'Mandant im DWH.'
  ,kjmo                                     COMMENT 'Kombinierter Schlüssel aus Kalenderjahr und Monat, formatiert als YYYYMM'
  ,email_domain_name                        COMMENT 'Domain der E-Mail-Adresse des Empfängers.'
  ,anz_kunde_gesamt                         COMMENT 'Anzahl der Kunden, an die im betreffenden Monat E-Mails gesendet wurden, unabhängig von der Domäne'
  ,anz_kunde_gesendet                       COMMENT 'Anzahl der Kunden, an eine E-Mail gesendet wurde.'
  ,rate_kunde_gesendet                      COMMENT 'Prozentualer Anteil der Kunden, an die eine E-Mail gesendet wurde, an der Gesamtzahl der Kunden innerhalb der Kampagne. (Berechnung: anz_kunde_gesendet / anz_kunde_gesamt)'
  ,anz_kunde_blockiert                      COMMENT 'Anzahl der Kunden, an die eine E-Mail blockiert wurde.'
  ,rate_kunde_blockiert                     COMMENT 'Prozentualer Anteil der Kunden, an die eine E-Mail blockiert wurde, an der Gesamtzahl der Kunden, an die eine E-Email gesendet wurde. (Berechnung: anz_kunde_blockiert / anz_kunde_gesendet)'
  ,anz_kunde_zugestellt                     COMMENT 'Anzahl der Kunden, an die eine E-Mail zugestellt wurde.'
  ,rate_kunde_zugestellt                    COMMENT 'Prozentualer Anteil der Kunden, an die eine E-Mail zugestellt wurde, an der Gesamtzahl der Kunden, an die eine E-Mail gesendet wurde. (Berechnung: anz_kunde_zugestellt / anz_kunde_gesendet)'
  ,anz_kunde_bounced_soft                   COMMENT 'Anzahl der Kunden, bei denen eine E-Mail aufgrund eines Soft Bounces nicht zugestellt werden konnte.'
  ,rate_kunde_bounced_soft                  COMMENT 'Prozentualer Anteil der Kunden, bei denen eine E-Mail aufgrund eines Soft Bounces nicht zugestellt werden konnte, an der Gesamtzahl der Kunden, an die eine E-Mail gesendet wurde. (Berechnung: anz_kunde_bounced_soft / anz_kunde_gesendet)'
  ,anz_kunde_bounced_hard                   COMMENT 'Anzahl der Kunden, bei denen eine E-Mail aufgrund eines Hard Bounces nicht zugestellt werden konnte.'
  ,rate_kunde_bounced_hard                  COMMENT 'Prozentualer Anteil der Kunden, bei denen eine E-Mail aufgrund eines Soft Bounces nicht zugestellt werden konnte, an der Gesamtzahl der Kunden, an die eine E-Mail gesendet wurde. (Berechnung: anz_kunde_bounced_hard / anz_kunde_gesendet)'
  ,anz_kunde_geoeffnet                      COMMENT 'Anzahl der Kunden, die eine E-Mail geöffnet hat.'
  ,rate_kunde_geoeffnet_zugestellt          COMMENT 'Prozentualer Anteil der Kunden, die eine E-Mail geöffnet hat, an der Gesamtzahl der Kunden, an die eine E-Mail zugestellt wurde. (Berechnung: anz_kunde_geoeffnet / anz_kunde_zugestellt)'
  ,anz_kunde_geklickt                       COMMENT 'Anzahl der Kunden, die auf mindestens einen Link in einer E-Mail geklickt hat.'
  ,rate_kunde_geklickt_gesendet             COMMENT 'Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer Nachricht geklickt hat, an der Gesamtzahl der Kunden, an die eine E-Mail gesendet wurde. (Berechnung: anz_kunde_geklickt / anz_kunde_gesendet)'
  ,rate_kunde_geklickt_geoeffnet            COMMENT 'Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer E-Mail geklickt hat, an der Gesamtzahl der Kunden, die eine E-Mail geöffnet hat. (Berechnung: anz_kunde_geklickt / anz_kunde_geoeffnet)'
  ,rate_kunde_geklickt_zugestellt           COMMENT 'Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer E-Mail geklickt hat, an der Gesamtzahl der Kunden, an die eine E-Mail zugestellt wurde. (Berechnung: anz_kunde_geklickt / anz_kunde_zugestellt)'
  ,anz_kunde_spam                           COMMENT 'Anzahl der Kunden, bei denen eine E-Mail als Spam klassifiziert wurde.'
  ,rate_kunde_spam                          COMMENT 'Prozentualer Anteil der Kunden, bei denen eine E-Mail als Spam klassifiziert wurde, an der Gesamtzahl der Kunden, an die eine E-Mail gesendet wurde. (Berechnung: anz_kunde_spam / anz_kunde_gesendet)'
  ,anz_kunde_abgemeldet                     COMMENT 'Anzahl der Kunden, die sich abgemeldet haben.'
  ,rate_kunde_abgemeldet                    COMMENT 'Prozentualer Anteil der Kunden, die sich abgemeldet haben, an der Gesamtzahl der Kunden, an die eine E-Mail gesendet wurde. (Berechnung: anz_kunde_abgemeldet / anz_kunde_gesendet)'
)
COMMENT = 'Die Tabelle enthält monatlich aggregierte Daten zu den Kampagnen, gruppiert nach E-Mail-Domain. Sie wird zur Analyse der Kampagnenperformance auf Domain-Ebene verwendet und beinhaltet Kennzahlen wie die Anzahl der gesendeten E-Mails, die Öffnungsrate, die Klickrate und die Bounce-Rate pro Domain und Monat.'
 AS 
    SELECT 
        mandant_id,
        kjmo,
        email_domain_name,
        anz_kunde_gesamt,
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

FROM DBP_MSI_DATA.KAMPAGNE_EMAIL_DOMAIN_MO_SUM ;