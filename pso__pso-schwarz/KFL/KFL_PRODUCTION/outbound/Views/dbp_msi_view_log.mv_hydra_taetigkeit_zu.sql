CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_hydra_taetigkeit_zu (mandant_id, pers_teilbereich_id,
taetigkeit_id, taetigkeit_bez, taetigkeit_typ_id, taetigkeit_typ_bez, taetigkeit_int_id, taetigkeit_int_bez) AS SELECT
DISTINCT H_TT.mandant_id,
 H_TT.pers_teilbereich_id,
 H_TT.taetigkeit_id,
 COALESCE(H_TT.taetigkeit_bez, 'N/A') AS taetigkeit_bez,
 H_TT.taetigkeit_typ_id,
  CASE
  WHEN H_TT.taetigkeit_typ_id = 'Z'
  THEN 'Zeitlohn'
  WHEN H_TT.taetigkeit_typ_id = 'D'
  THEN 'Durchschnitt'
  ELSE NULL
  END AS taetigkeit_typ_bez,
 COALESCE(H_TT.taetigkeit_int_id, - 1) AS taetigkeit_int_id,
 COALESCE(L_HTI.taetigkeit_int_bez, 'N/A') AS taetigkeit_int_bez
FROM kfl_production_dbp_view.v_hydra_taetigkeit_zu AS H_TT
 LEFT JOIN kfl_production_dbp_view.v_l_hydra_taetigkeit_int AS L_HTI ON H_TT.taetigkeit_int_id = L_HTI.taetigkeit_int_id
    AND H_TT.mandant_id = L_HTI.mandant_id;