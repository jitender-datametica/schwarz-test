CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_art_zek_zu (art_id, mandant_id, zek_id) AS SELECT DISTINCT art_id
 ,
 mandant_id,
 zek_id
FROM kfl_production_dbp_view.v_art
WHERE mandant_id = 1
 AND dat_bis = DATE '9999-12-31';