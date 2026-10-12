CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_sm_vw_zu (art_id, vw_id, sm_id, mandant_id) AS SELECT
 art_id,
 vw_id,
 sm_id,
 mandant_id
FROM kfl_production_dbp_view.v_art_sm_vw_zu_per AS V01
WHERE dat_bis = DATE '9999-12-31'
 AND vw_id = 10;