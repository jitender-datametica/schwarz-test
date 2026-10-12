CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_as_food_phase_spr_zu_1 (phase_id, phase_bez, phase_bez_de,
phase_bez_cz, phase_bez_sk, phase_bez_hr, phase_bez_pl, phase_bez_ro, phase_bez_bg) AS SELECT DISTINCT phase_id,
  'Phase ' || CAST(phase_id AS STRING) AS phase_bez,
  'Phase ' || CAST(phase_id AS STRING) AS phase_bez_de,
  'Fáze ' || CAST(phase_id AS STRING) AS phase_bez_cz,
  'Fáza ' || CAST(phase_id AS STRING) AS phase_bez_sk,
  'Faza ' || CAST(phase_id AS STRING) AS phase_bez_hr,
  'Faza ' || CAST(phase_id AS STRING) AS phase_bez_pl,
  'Faza ' || CAST(phase_id AS STRING) AS phase_bez_ro,
  'Фаза ' || CAST(phase_id AS STRING) AS phase_bez_bg
FROM kfl_production_dbp_view.v_as_food_det_1 AS V01
WHERE phase_id <> 4;