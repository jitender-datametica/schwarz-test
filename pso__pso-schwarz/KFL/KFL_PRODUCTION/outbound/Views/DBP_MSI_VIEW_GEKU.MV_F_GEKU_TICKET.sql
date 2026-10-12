CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_f_geku_ticket (geku_ticket_id, geku_artikel_uid,
beschwerde_antwort_id, abschlussgrund_id, wmd_austraeger_gebiet_uid, geku_eingangskanal_id, geku_emotion_id, dat_start,
dat_ende, wup_id, nb_id, mandant_id, dat_zufriedenheit_abfrage, geku_antwortkanal_id, geku_prioritaet_id, geku_status_id
, hat_gutschein_fg) AS SELECT V01.geku_ticket_id,
 V01.geku_artikel_uid,
 V01.beschwerde_antwort_id,
 V01.abschlussgrund_id,
 V01.wmd_austraeger_gebiet_uid,
 V01.geku_eingangskanal_id,
 V01.geku_emotion_id,
 V01.dat_start,
 V01.dat_ende,
 COALESCE(V01.wup_id, 0) AS wup_id,
  CASE
  WHEN V01.wup_id IS NULL
  THEN CAST(- 1 AS BIGNUMERIC)
  ELSE V01.nb_id
  END AS nb_id,
  CASE
  WHEN V01.wup_id IS NULL
  THEN V01.mandant_id
  ELSE V01.mandant_id_wup
  END AS mandant_id,
 V01.dat_zufriedenheit_abfrage,
 V01.geku_antwortkanal_id,
 V01.geku_prioritaet_id,
 V01.geku_status_id,
  CASE
  WHEN v02.geku_ticket_id IS NULL
  THEN 0
  ELSE 1
  END AS hat_gutschein_fg
FROM kfl_production_dbp_view.v_geku_ticket AS V01
 LEFT JOIN (SELECT DISTINCT geku_ticket_id
  FROM kfl_production_dbp_view.v_gutschein
  WHERE transaktion_id = 4 AND ausgeber_id = 'KDM004'
   OR ausgeber_id = 'KDM005') AS v02 ON V01.geku_ticket_id = v02.geku_ticket_id;