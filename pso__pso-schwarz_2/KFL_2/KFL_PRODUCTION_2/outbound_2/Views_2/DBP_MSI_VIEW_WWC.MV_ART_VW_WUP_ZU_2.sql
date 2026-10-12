CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_vw_wup_zu_2 (mandant_id, wup_id, vw_id, art_id, nb_id,
rabatt_zul_fg) AS SELECT mandant_id,
 wup_id,
 vw_id,
 art_id,
 nb_id,
 rabatt_zul_fg
FROM kfl_production_dbp_view.v_art_vw_wup_zu_2
WHERE wup_id = - 1
 AND vw_id = 10;