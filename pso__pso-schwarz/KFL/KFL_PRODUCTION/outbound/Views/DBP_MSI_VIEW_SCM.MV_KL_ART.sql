CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_kl_art AS SELECT CASE
  WHEN kl_art_id = 0
  THEN art_id
  ELSE kl_art_id
  END AS kl_art_id,
 mandant_id,
 art_id
FROM kfl_production_dbp_view.v_art
WHERE dat_bis = DATE '9999-12-31';