CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_mandant_2 AS SELECT v_mandant.mandant_id,
 v_mandant.mandant_bez,
 v_mandant.mandant_kbez,
  CASE
  WHEN V04.wrg_typ_id = 1
  THEN v_mandant.default_wrg
  ELSE 'EUR'
  END AS wrg_id,
 v_mandant.mandant_sort_id
FROM kfl_production_dbp_view.v_mandant_2
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V04 ON TRUE;