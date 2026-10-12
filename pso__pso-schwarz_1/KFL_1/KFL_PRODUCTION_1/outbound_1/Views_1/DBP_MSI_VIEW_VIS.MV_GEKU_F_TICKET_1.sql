CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_geku_f_ticket_1 AS SELECT geku_ticket_id,
 geku_artikel_uid,
 beschwerde_antwort_id,
 abschlussgrund_id,
 wmd_austraeger_gebiet_uid,
 geku_eingangskanal_id,
 geku_emotion_id,
 dat_start,
 dat_ende,
 dat_zufriedenheit_abfrage,
 geku_antwortkanal_id,
 geku_prioritaet_id,
  CASE
  WHEN wup_id IS NULL
  THEN mandant_id
  ELSE mandant_id_wup
  END AS geku_mandant_id,
  CASE
  WHEN wup_id IS NULL
  THEN mandant_id
  ELSE mandant_id_wup
  END AS mandant_id,
  CASE
  WHEN wup_id IS NULL
  THEN CAST(- 1 AS BIGNUMERIC)
  ELSE nb_id
  END AS nb_id,
 COALESCE(wup_id, 0) AS wup_id
FROM kfl_production_dbp_view.v_geku_ticket_1;