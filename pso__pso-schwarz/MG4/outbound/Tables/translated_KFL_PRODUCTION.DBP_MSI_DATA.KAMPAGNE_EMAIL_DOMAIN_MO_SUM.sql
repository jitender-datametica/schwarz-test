CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.kampagne_email_domain_mo_sum (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH.'),
kjmo INTEGER NOT NULL OPTIONS(description='Kombinierter Schlüssel aus Kalenderjahr und Monat, formatiert als YYYYMM'),
email_domain_name STRING(100) NOT NULL OPTIONS(description='Domain der E-Mail-Adresse des Empfängers.'),
anz_kunde_gesamt INTEGER NOT NULL
OPTIONS(description='Anzahl der Kunden, an die im betreffenden Monat E-Mails gesendet wurden, unabhängig von der Domäne'),
anz_kunde_gesendet INTEGER NOT NULL OPTIONS(description='Anzahl der Kunden, an eine E-Mail gesendet wurde.'),
rate_kunde_gesendet NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, an die eine E-Mail gesendet wurde, an der Gesamtzahl der Kunden innerhalb der Kampagne. (Berechnung: anz_kunde_gesendet / anz_kunde_gesamt)'),
anz_kunde_blockiert INTEGER NOT NULL OPTIONS(description='Anzahl der Kunden, an die eine E-Mail blockiert wurde.'),
rate_kunde_blockiert NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, an die eine E-Mail blockiert wurde, an der Gesamtzahl der Kunden, an die eine E-Email gesendet wurde. (Berechnung: anz_kunde_blockiert / anz_kunde_gesendet)'),
anz_kunde_zugestellt INTEGER NOT NULL OPTIONS(description='Anzahl der Kunden, an die eine E-Mail zugestellt wurde.'),
rate_kunde_zugestellt NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, an die eine E-Mail zugestellt wurde, an der Gesamtzahl der Kunden, an die eine E-Mail gesendet wurde. (Berechnung: anz_kunde_zugestellt / anz_kunde_gesendet)'),
anz_kunde_bounced_soft INTEGER NOT NULL
OPTIONS(description='Anzahl der Kunden, bei denen eine E-Mail aufgrund eines Soft Bounces nicht zugestellt werden konnte.'),
rate_kunde_bounced_soft NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, bei denen eine E-Mail aufgrund eines Soft Bounces nicht zugestellt werden konnte, an der Gesamtzahl der Kunden, an die eine E-Mail gesendet wurde. (Berechnung: anz_kunde_bounced_soft / anz_kunde_gesendet)'),
anz_kunde_bounced_hard INTEGER NOT NULL
OPTIONS(description='Anzahl der Kunden, bei denen eine E-Mail aufgrund eines Hard Bounces nicht zugestellt werden konnte.'),
rate_kunde_bounced_hard NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, bei denen eine E-Mail aufgrund eines Soft Bounces nicht zugestellt werden konnte, an der Gesamtzahl der Kunden, an die eine E-Mail gesendet wurde. (Berechnung: anz_kunde_bounced_hard / anz_kunde_gesendet)'),
anz_kunde_geoeffnet INTEGER NOT NULL OPTIONS(description='Anzahl der Kunden, die eine E-Mail geöffnet hat.'),
rate_kunde_geoeffnet_zugestellt NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, die eine E-Mail geöffnet hat, an der Gesamtzahl der Kunden, an die eine E-Mail zugestellt wurde. (Berechnung: anz_kunde_geoeffnet / anz_kunde_zugestellt)'),
anz_kunde_geklickt INTEGER NOT NULL
OPTIONS(description='Anzahl der Kunden, die auf mindestens einen Link in einer E-Mail geklickt hat.'),
rate_kunde_geklickt_gesendet NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer Nachricht geklickt hat, an der Gesamtzahl der Kunden, an die eine E-Mail gesendet wurde. (Berechnung: anz_kunde_geklickt / anz_kunde_gesendet)'),
rate_kunde_geklickt_geoeffnet NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer E-Mail geklickt hat, an der Gesamtzahl der Kunden, die eine E-Mail geöffnet hat. (Berechnung: anz_kunde_geklickt / anz_kunde_geoeffnet)'),
rate_kunde_geklickt_zugestellt NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer E-Mail geklickt hat, an der Gesamtzahl der Kunden, an die eine E-Mail zugestellt wurde. (Berechnung: anz_kunde_geklickt / anz_kunde_zugestellt)'),
anz_kunde_spam INTEGER NOT NULL
OPTIONS(description='Anzahl der Kunden, bei denen eine E-Mail als Spam klassifiziert wurde.'),
rate_kunde_spam NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, bei denen eine E-Mail als Spam klassifiziert wurde, an der Gesamtzahl der Kunden, an die eine E-Mail gesendet wurde. (Berechnung: anz_kunde_spam / anz_kunde_gesendet)'),
anz_kunde_abgemeldet INTEGER NOT NULL OPTIONS(description='Anzahl der Kunden, die sich abgemeldet haben.'),
rate_kunde_abgemeldet NUMERIC(29,5) NOT NULL
OPTIONS(description='Prozentualer Anteil der Kunden, die sich abgemeldet haben, an der Gesamtzahl der Kunden, an die eine E-Mail gesendet wurde. (Berechnung: anz_kunde_abgemeldet / anz_kunde_gesendet)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, email_domain_name, kjmo) NOT ENFORCED
)
OPTIONS(description='Die Tabelle enthält monatlich aggregierte Daten zu den Kampagnen, gruppiert nach E-Mail-Domain. Sie wird zur Analyse der Kampagnenperformance auf Domain-Ebene verwendet und beinhaltet Kennzahlen wie die Anzahl der gesendeten E-Mails, die Öffnungsrate, die Klickrate und die Bounce-Rate pro Domain und Monat.');