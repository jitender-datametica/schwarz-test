--==============================================================
-- Table: kampagne_email_domain_mo_sum_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_email_domain_mo_sum_2
   generated from Powerdesigner on Freitag, 8. November 2024 17:56:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.KAMPAGNE_EMAIL_DOMAIN_MO_SUM_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH.',
   kjmo                                NUMBER(38,0)     NOT NULL COMMENT 'Kombinierter Schlüssel aus Kalenderjahr und Monat_2, formatiert als YYYYMM',
   email_domain_name                   VARCHAR(100)     NOT NULL COMMENT 'Domain der E-Mail-Adresse des Empfängers.',
   anz_kunde_gesamt                    NUMBER(38,0)     NOT NULL COMMENT 'Anzahl der Kunden, an die im betreffenden Monat_2 E-Mails gesendet wurden, unabhängig von der Domäne',
   anz_kunde_gesendet                  NUMBER(38,0)     NOT NULL COMMENT 'Anzahl der Kunden, an eine_2 E-Mail gesendet wurde.',
   rate_kunde_gesendet                 NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, an die eine_2 E-Mail gesendet wurde, an der Gesamtzahl der Kunden innerhalb der Kampagne. (Berechnung: anz_kunde_gesendet / anz_kunde_gesamt)',
   anz_kunde_blockiert                 NUMBER(38,0)     NOT NULL COMMENT 'Anzahl der Kunden, an die eine_2 E-Mail blockiert wurde.',
   rate_kunde_blockiert                NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, an die eine_2 E-Mail blockiert wurde, an der Gesamtzahl der Kunden, an die eine_2 E-Email gesendet wurde. (Berechnung: anz_kunde_blockiert / anz_kunde_gesendet)',
   anz_kunde_zugestellt                NUMBER(38,0)     NOT NULL COMMENT 'Anzahl der Kunden, an die eine_2 E-Mail zugestellt wurde.',
   rate_kunde_zugestellt               NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, an die eine_2 E-Mail zugestellt wurde, an der Gesamtzahl der Kunden, an die eine_2 E-Mail gesendet wurde. (Berechnung: anz_kunde_zugestellt / anz_kunde_gesendet)',
   anz_kunde_bounced_soft              NUMBER(38,0)     NOT NULL COMMENT 'Anzahl der Kunden, bei denen eine_2 E-Mail aufgrund eines Soft Bounces nicht zugestellt werden konnte.',
   rate_kunde_bounced_soft             NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, bei denen eine_2 E-Mail aufgrund eines Soft Bounces nicht zugestellt werden konnte, an der Gesamtzahl der Kunden, an die eine_2 E-Mail gesendet wurde. (Berechnung: anz_kunde_bounced_soft / anz_kunde_gesendet)',
   anz_kunde_bounced_hard              NUMBER(38,0)     NOT NULL COMMENT 'Anzahl der Kunden, bei denen eine_2 E-Mail aufgrund eines Hard Bounces nicht zugestellt werden konnte.',
   rate_kunde_bounced_hard             NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, bei denen eine_2 E-Mail aufgrund eines Soft Bounces nicht zugestellt werden konnte, an der Gesamtzahl der Kunden, an die eine_2 E-Mail gesendet wurde. (Berechnung: anz_kunde_bounced_hard / anz_kunde_gesendet)',
   anz_kunde_geoeffnet                 NUMBER(38,0)     NOT NULL COMMENT 'Anzahl der Kunden, die eine_2 E-Mail geöffnet hat.',
   rate_kunde_geoeffnet_zugestellt     NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, die eine_2 E-Mail geöffnet hat, an der Gesamtzahl der Kunden, an die eine_2 E-Mail zugestellt wurde. (Berechnung: anz_kunde_geoeffnet / anz_kunde_zugestellt)',
   anz_kunde_geklickt                  NUMBER(38,0)     NOT NULL COMMENT 'Anzahl der Kunden, die auf mindestens einen Link in einer E-Mail geklickt hat.',
   rate_kunde_geklickt_gesendet        NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer Nachricht geklickt hat, an der Gesamtzahl der Kunden, an die eine_2 E-Mail gesendet wurde. (Berechnung: anz_kunde_geklickt / anz_kunde_gesendet)',
   rate_kunde_geklickt_geoeffnet       NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer E-Mail geklickt hat, an der Gesamtzahl der Kunden, die eine_2 E-Mail geöffnet hat. (Berechnung: anz_kunde_geklickt / anz_kunde_geoeffnet)',
   rate_kunde_geklickt_zugestellt      NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer E-Mail geklickt hat, an der Gesamtzahl der Kunden, an die eine_2 E-Mail zugestellt wurde. (Berechnung: anz_kunde_geklickt / anz_kunde_zugestellt)',
   anz_kunde_spam                      NUMBER(38,0)     NOT NULL COMMENT 'Anzahl der Kunden, bei denen eine_2 E-Mail als Spam klassifiziert wurde.',
   rate_kunde_spam                     NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, bei denen eine_2 E-Mail als Spam klassifiziert wurde, an der Gesamtzahl der Kunden, an die eine_2 E-Mail gesendet wurde. (Berechnung: anz_kunde_spam / anz_kunde_gesendet)',
   anz_kunde_abgemeldet                NUMBER(38,0)     NOT NULL COMMENT 'Anzahl der Kunden, die sich abgemeldet haben.',
   rate_kunde_abgemeldet               NUMBER(38,5)     NOT NULL COMMENT 'Prozentualer Anteil der Kunden, die sich abgemeldet haben, an der Gesamtzahl der Kunden, an die eine_2 E-Mail gesendet wurde. (Berechnung: anz_kunde_abgemeldet / anz_kunde_gesendet)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KAMPAGNE_EMAIL_DOMAIN_MO_SUM PRIMARY KEY (mandant_id, email_domain_name, kjmo) NOT ENFORCED
)  COMMENT = 'Die Tabelle enthält monatlich aggregierte Daten zu den Kampagnen, gruppiert nach E-Mail-Domain. Sie wird zur Analyse der Kampagnenperformance auf Domain-Ebene verwendet und beinhaltet Kennzahlen wie die Anzahl der gesendeten E-Mails, die Öffnungsrate, die Klickrate und die Bounce-Rate pro Domain und Monat.';
