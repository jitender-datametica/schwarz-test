CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_in_instandhaltung (auftrag_id, mandant_id,
instandhaltung_leistungsart_id, in_kunde_id, qual_meldung_id, wart_plan_id, wart_plan_abruf_id, wart_plan_pos_id,
dat_bezug, auftrag_aus_wartung) AS SELECT auftrag_id,
 mandant_id,
 instandhaltung_leistungsart_id,
 in_kunde_id,
 qual_meldung_id,
 wart_plan_id,
 wart_plan_abruf_id,
 wart_plan_pos_id,
 dat_bezug,
  CASE
  WHEN wart_plan_id IS NULL
  THEN 'nein'
  ELSE 'ja'
  END AS auftrag_aus_wartung
FROM kfl_production_dbp_view.v_in_instandhaltung AS V01;