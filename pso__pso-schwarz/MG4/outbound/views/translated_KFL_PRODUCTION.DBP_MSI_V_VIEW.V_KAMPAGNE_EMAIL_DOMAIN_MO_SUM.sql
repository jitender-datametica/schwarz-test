CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_kampagne_email_domain_mo_sum (mandant_id
OPTIONS(description='Mandant im DWH.'), kjmo
OPTIONS(description='Kombinierter Schlüssel aus Kalenderjahr und Monat, formatiert als YYYYMM'), email_domain_name
OPTIONS(description='Domain der E-Mail-Adresse des Empfängers.'), anz_kunde_gesamt
OPTIONS(description='Anzahl der Kunden, an die im betreffenden Monat E-Mails gesendet wurden, unabhängig von der Domäne'),
anz_kunde_gesendet OPTIONS(description='Anzahl der Kunden, an eine E-Mail gesendet wurde.'), rate_kunde_gesendet
OPTIONS(description='Prozentualer Anteil der Kunden, an die eine E-Mail gesendet wurde, an der Gesamtzahl der Kunden innerhalb der Kampagne. (Berechnung: anz_kunde_gesendet / anz_kunde_gesamt)'),
anz_kunde_blockiert OPTIONS(description='Anzahl der Kunden, an die eine E-Mail blockiert wurde.'), rate_kunde_blockiert
OPTIONS(description='Prozentualer Anteil der Kunden, an die eine E-Mail blockiert wurde, an der Gesamtzahl der Kunden, an die eine E-Email gesendet wurde. (Berechnung: anz_kunde_blockiert / anz_kunde_gesendet)'),
anz_kunde_zugestellt OPTIONS(description='Anzahl der Kunden, an die eine E-Mail zugestellt wurde.'),
rate_kunde_zugestellt
OPTIONS(description='Prozentualer Anteil der Kunden, an die eine E-Mail zugestellt wurde, an der Gesamtzahl der Kunden, an die eine E-Mail gesendet wurde. (Berechnung: anz_kunde_zugestellt / anz_kunde_gesendet)'),
anz_kunde_bounced_soft
OPTIONS(description='Anzahl der Kunden, bei denen eine E-Mail aufgrund eines Soft Bounces nicht zugestellt werden konnte.'),
rate_kunde_bounced_soft
OPTIONS(description='Prozentualer Anteil der Kunden, bei denen eine E-Mail aufgrund eines Soft Bounces nicht zugestellt werden konnte, an der Gesamtzahl der Kunden, an die eine E-Mail gesendet wurde. (Berechnung: anz_kunde_bounced_soft / anz_kunde_gesendet)'),
anz_kunde_bounced_hard
OPTIONS(description='Anzahl der Kunden, bei denen eine E-Mail aufgrund eines Hard Bounces nicht zugestellt werden konnte.'),
rate_kunde_bounced_hard
OPTIONS(description='Prozentualer Anteil der Kunden, bei denen eine E-Mail aufgrund eines Soft Bounces nicht zugestellt werden konnte, an der Gesamtzahl der Kunden, an die eine E-Mail gesendet wurde. (Berechnung: anz_kunde_bounced_hard / anz_kunde_gesendet)'),
anz_kunde_geoeffnet OPTIONS(description='Anzahl der Kunden, die eine E-Mail geöffnet hat.'),
rate_kunde_geoeffnet_zugestellt
OPTIONS(description='Prozentualer Anteil der Kunden, die eine E-Mail geöffnet hat, an der Gesamtzahl der Kunden, an die eine E-Mail zugestellt wurde. (Berechnung: anz_kunde_geoeffnet / anz_kunde_zugestellt)'),
anz_kunde_geklickt OPTIONS(description='Anzahl der Kunden, die auf mindestens einen Link in einer E-Mail geklickt hat.'),
rate_kunde_geklickt_gesendet
OPTIONS(description='Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer Nachricht geklickt hat, an der Gesamtzahl der Kunden, an die eine E-Mail gesendet wurde. (Berechnung: anz_kunde_geklickt / anz_kunde_gesendet)'),
rate_kunde_geklickt_geoeffnet
OPTIONS(description='Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer E-Mail geklickt hat, an der Gesamtzahl der Kunden, die eine E-Mail geöffnet hat. (Berechnung: anz_kunde_geklickt / anz_kunde_geoeffnet)'),
rate_kunde_geklickt_zugestellt
OPTIONS(description='Prozentualer Anteil der Kunden, die auf mindestens einen Link in einer E-Mail geklickt hat, an der Gesamtzahl der Kunden, an die eine E-Mail zugestellt wurde. (Berechnung: anz_kunde_geklickt / anz_kunde_zugestellt)'),
anz_kunde_spam OPTIONS(description='Anzahl der Kunden, bei denen eine E-Mail als Spam klassifiziert wurde.'),
rate_kunde_spam
OPTIONS(description='Prozentualer Anteil der Kunden, bei denen eine E-Mail als Spam klassifiziert wurde, an der Gesamtzahl der Kunden, an die eine E-Mail gesendet wurde. (Berechnung: anz_kunde_spam / anz_kunde_gesendet)'),
anz_kunde_abgemeldet OPTIONS(description='Anzahl der Kunden, die sich abgemeldet haben.'), rate_kunde_abgemeldet
OPTIONS(description='Prozentualer Anteil der Kunden, die sich abgemeldet haben, an der Gesamtzahl der Kunden, an die eine E-Mail gesendet wurde. (Berechnung: anz_kunde_abgemeldet / anz_kunde_gesendet)'))
AS SELECT mandant_id,
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
FROM kfl_production_dbp_msi_data.kampagne_email_domain_mo_sum;