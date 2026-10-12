CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_kampagne_vorlage_mo_sum_2 (mandant_id, kampagne_id, kjmo,
nachricht_vorlage_id, kommunikationskanal_id, message_titel, nachricht_subvorlage_name_liste_txt, variation,
kampagne_name, dat_kampagne_von, kj_kampagne_von, kjwo_kampagne_von, kjmo_kampagne_von, kampagne_rhythmus_typ_id,
kampagne_version_nr, nachricht_vorlage_titel_txt, nachricht_vorlage_txt, message_content, nachricht_vorlage_url_txt, url
, nachricht_vorlage_bild_id, picture, anz_kampagne_kunde_gesamt, member_count_email, member_count_push, member_count_sms
, anz_kunde_gesendet, sent_email, sent_sms, sent_push, rate_kunde_gesendet, click_sent_rate_email, click_sent_rate_push
, anz_kunde_blockiert, blocked_email, rate_kunde_blockiert, rate_blocked_email, anz_kunde_zugestellt, delivered_email,
rate_kunde_zugestellt, delivered_rate_email, delivered_rate_push, anz_kunde_bounced_soft, anz_kunde_bounced_hard,
hard_bounce_email, soft_bounce_email, soft_bounce_rate_provider, hard_bounce_rate_provider, hard_bounce_rate_email,
soft_bounce_rate_email, anz_kunde_geoeffnet, opened_email, opened_sms, opened_push, rate_kunde_geoeffnet_zugestellt,
opened_rate_email, opened_rate_push, anz_kunde_geklickt, clicks_email, clicks_push, rate_kunde_geklickt_gesendet,
rate_kunde_geklickt_geoeffnet, click_rate_email, click_rate_push, rate_kunde_geklickt_zugestellt, anz_kunde_spam,
spam_email, rate_kunde_spam, spam_rate_email) AS SELECT mandant_id,
 kampagne_id,
 kjmo,
 nachricht_vorlage_id,
 kommunikationskanal_id,
  CASE
  WHEN kommunikationskanal_id IN (1, 2)
  THEN CAST(nachricht_vorlage_titel_txt AS STRING)
  ELSE
  ' END AS MESSAGE_TITEL\n,NACHRICHT_SUBVORLAGE_NAME_LISTE_TXT\n,CASE WHEN KOMMUNIKATIONSKANAL_ID = 1 THEN CAST(NACHRICHT_SUBVORLAGE_NAME_LISTE_TXT AS STRING(4000)) ELSE '
  END AS variation0,
 kampagne_name AS nachricht_subvorlage_name_liste_txt,
 dat_kampagne_von AS variation,
 EXTRACT(YEAR FROM dat_kampagne_von) AS kj_kampagne_von,
  CAST(EXTRACT(YEAR FROM dat_kampagne_von) AS STRING) || LPAD(SUBSTR(CAST(EXTRACT(ISOWEEK FROM dat_kampagne_von) AS STRING)
    , 1, 19), 2, '0') AS kjwo_kampagne_von0,
  CAST(EXTRACT(YEAR FROM dat_kampagne_von) AS STRING) || LPAD(SUBSTR(CAST(EXTRACT(MONTH FROM dat_kampagne_von) AS STRING)
    , 1, 19), 2, '0') AS kjmo_kampagne_von0,
 kampagne_rhythmus_typ_id AS kjwo_kampagne_von,
 kampagne_version_nr AS kjmo_kampagne_von,
 nachricht_vorlage_titel_txt AS kampagne_rhythmus_typ_id,
 nachricht_vorlage_txt AS kampagne_version_nr,
  CASE
  WHEN kommunikationskanal_id IN (2, 3)
  THEN CAST(nachricht_vorlage_txt AS STRING)
  ELSE
  ' END AS MESSAGE_CONTENT\n,NACHRICHT_VORLAGE_URL_TXT\n,CASE WHEN KOMMUNIKATIONSKANAL_ID = 2 THEN NACHRICHT_VORLAGE_URL_TXT ELSE '
  END AS url,
 nachricht_vorlage_bild_id AS nachricht_vorlage_txt,
  CASE
  WHEN kommunikationskanal_id = 2
  THEN nachricht_vorlage_bild_id
  ELSE ''
  END AS picture,
 anz_kampagne_kunde_gesamt AS nachricht_vorlage_url_txt,
  CASE
  WHEN kommunikationskanal_id = 1
  THEN anz_kampagne_kunde_gesamt
  ELSE 0
  END AS member_count_email,
  CASE
  WHEN kommunikationskanal_id = 2
  THEN anz_kampagne_kunde_gesamt
  ELSE 0
  END AS member_count_push,
  CASE
  WHEN kommunikationskanal_id = 3
  THEN anz_kampagne_kunde_gesamt
  ELSE 0
  END AS member_count_sms,
 anz_kunde_gesendet AS anz_kampagne_kunde_gesamt,
  CASE
  WHEN kommunikationskanal_id = 1
  THEN anz_kunde_gesendet
  ELSE 0
  END AS sent_email,
  CASE
  WHEN kommunikationskanal_id = 3
  THEN anz_kunde_gesendet
  ELSE 0
  END AS sent_sms,
  CASE
  WHEN kommunikationskanal_id = 2
  THEN anz_kunde_gesendet
  ELSE 0
  END AS sent_push0,
 rate_kunde_gesendet AS anz_kunde_gesendet,
  CASE
  WHEN kommunikationskanal_id = 1
  THEN rate_kunde_gesendet
  ELSE 0
  END AS click_sent_rate_email0,
  CASE
  WHEN kommunikationskanal_id = 2
  THEN rate_kunde_gesendet
  ELSE 0
  END AS click_sent_rate_push,
 anz_kunde_blockiert AS sent_push,
  CASE
  WHEN kommunikationskanal_id = 1
  THEN anz_kunde_blockiert
  ELSE 0
  END AS blocked_email,
 rate_kunde_blockiert AS click_sent_rate_email,
  CASE
  WHEN kommunikationskanal_id = 1
  THEN rate_kunde_blockiert
  ELSE 0
  END AS rate_blocked_email,
 anz_kunde_zugestellt AS anz_kunde_blockiert,
  CASE
  WHEN kommunikationskanal_id = 1
  THEN anz_kunde_zugestellt
  ELSE 0
  END AS delivered_email0,
 rate_kunde_zugestellt AS rate_kunde_blockiert,
  CASE
  WHEN kommunikationskanal_id = 1
  THEN rate_kunde_zugestellt
  ELSE 0
  END AS delivered_rate_email,
  CASE
  WHEN kommunikationskanal_id = 2
  THEN rate_kunde_zugestellt
  ELSE 0
  END AS delivered_rate_push,
 anz_kunde_bounced_soft AS delivered_email,
 anz_kunde_bounced_hard AS rate_kunde_zugestellt,
  CASE
  WHEN kommunikationskanal_id = 1
  THEN anz_kunde_bounced_hard
  ELSE 0
  END AS hard_bounce_email,
  CASE
  WHEN kommunikationskanal_id = 1
  THEN anz_kunde_bounced_soft
  ELSE 0
  END AS soft_bounce_email,
 rate_kunde_bounced_soft AS soft_bounce_rate_provider0,
 rate_kunde_bounced_hard AS hard_bounce_rate_provider,
  CASE
  WHEN kommunikationskanal_id = 1
  THEN rate_kunde_bounced_hard
  ELSE 0
  END AS hard_bounce_rate_email,
  CASE
  WHEN kommunikationskanal_id = 1
  THEN rate_kunde_bounced_soft
  ELSE 0
  END AS soft_bounce_rate_email,
 anz_kunde_geoeffnet AS soft_bounce_rate_provider,
  CASE
  WHEN kommunikationskanal_id = 1
  THEN anz_kunde_geoeffnet
  ELSE 0
  END AS opened_email,
  CASE
  WHEN kommunikationskanal_id = 3
  THEN anz_kunde_geoeffnet
  ELSE 0
  END AS opened_sms,
  CASE
  WHEN kommunikationskanal_id = 2
  THEN anz_kunde_geoeffnet
  ELSE 0
  END AS opened_push0,
 rate_kunde_geoeffnet_zugestellt AS anz_kunde_geoeffnet,
  CASE
  WHEN kommunikationskanal_id = 1
  THEN rate_kunde_geoeffnet_zugestellt
  ELSE 0
  END AS opened_rate_email,
  CASE
  WHEN kommunikationskanal_id = 2
  THEN rate_kunde_geoeffnet_zugestellt
  ELSE 0
  END AS opened_rate_push0,
 anz_kunde_geklickt AS opened_push,
  CASE
  WHEN kommunikationskanal_id = 1
  THEN anz_kunde_geklickt
  ELSE 0
  END AS clicks_email,
  CASE
  WHEN kommunikationskanal_id = 2
  THEN anz_kunde_geklickt
  ELSE 0
  END AS clicks_push,
 rate_kunde_geklickt_gesendet AS opened_rate_push,
 rate_kunde_geklickt_geoeffnet AS anz_kunde_geklickt,
  CASE
  WHEN kommunikationskanal_id = 1
  THEN rate_kunde_geklickt_geoeffnet
  ELSE 0
  END AS click_rate_email,
  CASE
  WHEN kommunikationskanal_id = 2
  THEN rate_kunde_geklickt_geoeffnet
  ELSE 0
  END AS click_rate_push0,
 rate_kunde_geklickt_zugestellt AS rate_kunde_geklickt_gesendet,
 anz_kunde_spam AS rate_kunde_geklickt_geoeffnet,
  CASE
  WHEN kommunikationskanal_id = 1
  THEN anz_kunde_spam
  ELSE 0
  END AS spam_email,
 rate_kunde_spam AS click_rate_push,
  CASE
  WHEN kommunikationskanal_id = 1
  THEN rate_kunde_spam
  ELSE 0
  END AS spam_rate_email,
 anz_kunde_abgemeldet AS anz_kunde_spam,
  CASE
  WHEN kommunikationskanal_id = 1
  THEN anz_kunde_abgemeldet
  ELSE 0
  END AS unsubscribe_email,
 rate_kunde_abgemeldet AS rate_kunde_spam,
  CASE
  WHEN kommunikationskanal_id = 1
  THEN rate_kunde_abgemeldet
  ELSE 0
  END AS unsubscribe_rate_email
FROM kfl_production_dbp_msi_v_view.v_kampagne_vorlage_mo_sum_2;