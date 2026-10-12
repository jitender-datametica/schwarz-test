CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_kampagne_vorlage_mo_sum (mandant_id, kampagne_id, kjmo,
nachricht_vorlage_id, kommunikationskanal_id, message_titel, message_name_id, message_name,
nachricht_subvorlage_name_liste_txt, variation, kampagne_name, dat_kampagne_von, kj_kampagne_von, kjwo_kampagne_von,
kjmo_kampagne_von, kampagne_rhythmus_typ_id, kampagne_version_nr, nachricht_vorlage_titel_txt, nachricht_vorlage_txt,
message_content, nachricht_vorlage_url_txt, url, nachricht_vorlage_bild_id, picture, anz_kampagne_kunde_gesamt,
member_count_email, member_count_push, member_count_sms, anz_kunde_gesendet, sent_email, sent_sms, sent_push,
rate_kunde_gesendet, click_sent_rate_email, click_sent_rate_push, anz_kunde_blockiert, blocked_email,
rate_kunde_blockiert, rate_blocked_email, anz_kunde_zugestellt, delivered_email, rate_kunde_zugestellt,
delivered_rate_email, delivered_rate_push, anz_kunde_bounced_soft, anz_kunde_bounced_hard, hard_bounce_email,
soft_bounce_email, soft_bounce_rate_provider, hard_bounce_rate_provider, hard_bounce_rate_email, soft_bounce_rate_email
, anz_kunde_geoeffnet, opened_email, opened_sms, opened_push, rate_kunde_geoeffnet_zugestellt, opened_rate_email,
opened_rate_push, anz_kunde_geklickt, clicks_email, clicks_push, rate_kunde_geklickt_gesendet,
rate_kunde_geklickt_geoeffnet, click_rate_email, click_rate_push, rate_kunde_geklickt_zugestellt, anz_kunde_spam,
spam_email, rate_kunde_spam, spam_rate_email, anz_kunde_abgemeldet, unsubscribe_email, rate_kunde_abgemeldet,
unsubscribe_rate_email) AS SELECT V01.mandant_id,
 V01.kampagne_id,
 V01.kjmo,
 V01.nachricht_vorlage_id,
 V01.kommunikationskanal_id,
  CASE
  WHEN V01.kommunikationskanal_id IN (1, 2)
  THEN CAST(V01.nachricht_vorlage_titel_txt AS STRING)
  ELSE ''
  END AS message_titel,
  CASE
  WHEN V01.kommunikationskanal_id IN (1)
  THEN CAST(V01.nachricht_vorlage_id AS STRING)
  ELSE ''
  END AS message_name_id,
  CASE
  WHEN V01.kommunikationskanal_id IN (1)
  THEN CAST(V02.nachricht_vorlage_name AS STRING)
  ELSE ''
  END AS message_name,
 V01.nachricht_subvorlage_name_liste_txt,
  CASE
  WHEN V01.kommunikationskanal_id = 1
  THEN CAST(V01.nachricht_subvorlage_name_liste_txt AS STRING)
  ELSE ''
  END AS variation,
 V01.kampagne_name,
 V01.dat_kampagne_von,
 EXTRACT(YEAR FROM V01.dat_kampagne_von) AS kj_kampagne_von,
  CAST(EXTRACT(YEAR FROM V01.dat_kampagne_von) AS STRING) || LPAD(SUBSTR(CAST(EXTRACT(ISOWEEK FROM V01.dat_kampagne_von) AS STRING)
    , 1, 19), 2, '0') AS kjwo_kampagne_von,
  CAST(EXTRACT(YEAR FROM V01.dat_kampagne_von) AS STRING) || LPAD(SUBSTR(CAST(EXTRACT(MONTH FROM V01.dat_kampagne_von) AS STRING)
    , 1, 19), 2, '0') AS kjmo_kampagne_von,
 V01.kampagne_rhythmus_typ_id,
 V01.kampagne_version_nr,
 V01.nachricht_vorlage_titel_txt,
 V01.nachricht_vorlage_txt,
  CASE
  WHEN V01.kommunikationskanal_id IN (2, 3)
  THEN CAST(V01.nachricht_vorlage_txt AS STRING)
  ELSE ''
  END AS message_content,
 V01.nachricht_vorlage_url_txt,
  CASE
  WHEN V01.kommunikationskanal_id = 2
  THEN V01.nachricht_vorlage_url_txt
  ELSE ''
  END AS url,
 V01.nachricht_vorlage_bild_id,
  CASE
  WHEN V01.kommunikationskanal_id = 2
  THEN V01.nachricht_vorlage_bild_id
  ELSE ''
  END AS picture,
 V01.anz_kampagne_kunde_gesamt,
  CASE
  WHEN V01.kommunikationskanal_id = 1
  THEN V01.anz_kampagne_kunde_gesamt
  ELSE 0
  END AS member_count_email,
  CASE
  WHEN V01.kommunikationskanal_id = 2
  THEN V01.anz_kampagne_kunde_gesamt
  ELSE 0
  END AS member_count_push,
  CASE
  WHEN V01.kommunikationskanal_id = 3
  THEN V01.anz_kampagne_kunde_gesamt
  ELSE 0
  END AS member_count_sms,
 V01.anz_kunde_gesendet,
  CASE
  WHEN V01.kommunikationskanal_id = 1
  THEN V01.anz_kunde_gesendet
  ELSE 0
  END AS sent_email,
  CASE
  WHEN V01.kommunikationskanal_id = 3
  THEN V01.anz_kunde_gesendet
  ELSE 0
  END AS sent_sms,
  CASE
  WHEN V01.kommunikationskanal_id = 2
  THEN V01.anz_kunde_gesendet
  ELSE 0
  END AS sent_push,
 V01.rate_kunde_gesendet,
  CASE
  WHEN V01.kommunikationskanal_id = 1
  THEN V01.rate_kunde_gesendet
  ELSE 0
  END AS click_sent_rate_email,
  CASE
  WHEN V01.kommunikationskanal_id = 2
  THEN V01.rate_kunde_gesendet
  ELSE 0
  END AS click_sent_rate_push,
 V01.anz_kunde_blockiert,
  CASE
  WHEN V01.kommunikationskanal_id = 1
  THEN V01.anz_kunde_blockiert
  ELSE 0
  END AS blocked_email,
 V01.rate_kunde_blockiert,
  CASE
  WHEN V01.kommunikationskanal_id = 1
  THEN V01.rate_kunde_blockiert
  ELSE 0
  END AS rate_blocked_email,
 V01.anz_kunde_zugestellt,
  CASE
  WHEN V01.kommunikationskanal_id = 1
  THEN V01.anz_kunde_zugestellt
  ELSE 0
  END AS delivered_email,
 V01.rate_kunde_zugestellt,
  CASE
  WHEN V01.kommunikationskanal_id = 1
  THEN V01.rate_kunde_zugestellt
  ELSE 0
  END AS delivered_rate_email,
  CASE
  WHEN V01.kommunikationskanal_id = 2
  THEN V01.rate_kunde_zugestellt
  ELSE 0
  END AS delivered_rate_push,
 V01.anz_kunde_bounced_soft,
 V01.anz_kunde_bounced_hard,
  CASE
  WHEN V01.kommunikationskanal_id = 1
  THEN V01.anz_kunde_bounced_hard
  ELSE 0
  END AS hard_bounce_email,
  CASE
  WHEN V01.kommunikationskanal_id = 1
  THEN V01.anz_kunde_bounced_soft
  ELSE 0
  END AS soft_bounce_email,
 V01.rate_kunde_bounced_soft AS soft_bounce_rate_provider,
 V01.rate_kunde_bounced_hard AS hard_bounce_rate_provider,
  CASE
  WHEN V01.kommunikationskanal_id = 1
  THEN V01.rate_kunde_bounced_hard
  ELSE 0
  END AS hard_bounce_rate_email,
  CASE
  WHEN V01.kommunikationskanal_id = 1
  THEN V01.rate_kunde_bounced_soft
  ELSE 0
  END AS soft_bounce_rate_email,
 V01.anz_kunde_geoeffnet,
  CASE
  WHEN V01.kommunikationskanal_id = 1
  THEN V01.anz_kunde_geoeffnet
  ELSE 0
  END AS opened_email,
  CASE
  WHEN V01.kommunikationskanal_id = 3
  THEN V01.anz_kunde_geoeffnet
  ELSE 0
  END AS opened_sms,
  CASE
  WHEN V01.kommunikationskanal_id = 2
  THEN V01.anz_kunde_geoeffnet
  ELSE 0
  END AS opened_push,
 V01.rate_kunde_geoeffnet_zugestellt,
  CASE
  WHEN V01.kommunikationskanal_id = 1
  THEN V01.rate_kunde_geoeffnet_zugestellt
  ELSE 0
  END AS opened_rate_email,
  CASE
  WHEN V01.kommunikationskanal_id = 2
  THEN V01.rate_kunde_geoeffnet_zugestellt
  ELSE 0
  END AS opened_rate_push,
 V01.anz_kunde_geklickt,
  CASE
  WHEN V01.kommunikationskanal_id = 1
  THEN V01.anz_kunde_geklickt
  ELSE 0
  END AS clicks_email,
  CASE
  WHEN V01.kommunikationskanal_id = 2
  THEN V01.anz_kunde_geklickt
  ELSE 0
  END AS clicks_push,
 V01.rate_kunde_geklickt_gesendet,
 V01.rate_kunde_geklickt_geoeffnet,
  CASE
  WHEN V01.kommunikationskanal_id = 1
  THEN V01.rate_kunde_geklickt_geoeffnet
  ELSE 0
  END AS click_rate_email,
  CASE
  WHEN V01.kommunikationskanal_id = 2
  THEN V01.rate_kunde_geklickt_geoeffnet
  ELSE 0
  END AS click_rate_push,
 V01.rate_kunde_geklickt_zugestellt,
 V01.anz_kunde_spam,
  CASE
  WHEN V01.kommunikationskanal_id = 1
  THEN V01.anz_kunde_spam
  ELSE 0
  END AS spam_email,
 V01.rate_kunde_spam,
  CASE
  WHEN V01.kommunikationskanal_id = 1
  THEN V01.rate_kunde_spam
  ELSE 0
  END AS spam_rate_email,
 V01.anz_kunde_abgemeldet,
  CASE
  WHEN V01.kommunikationskanal_id = 1
  THEN V01.anz_kunde_abgemeldet
  ELSE 0
  END AS unsubscribe_email,
 V01.rate_kunde_abgemeldet,
  CASE
  WHEN V01.kommunikationskanal_id = 1
  THEN V01.rate_kunde_abgemeldet
  ELSE 0
  END AS unsubscribe_rate_email
FROM kfl_production_dbp_msi_data.kampagne_vorlage_mo_sum AS V01
 LEFT JOIN kfl_production_dbp_data.kampagne_nachricht_vorlage AS V02 ON V01.mandant_id = V02.mandant_id AND V01.kommunikationskanal_id
     = V02.kommunikationskanal_id AND V01.nachricht_vorlage_id = V02.nachricht_vorlage_id;