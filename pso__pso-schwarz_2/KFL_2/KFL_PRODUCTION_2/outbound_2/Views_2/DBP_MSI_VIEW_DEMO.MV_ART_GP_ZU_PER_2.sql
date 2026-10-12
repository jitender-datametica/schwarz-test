CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_demo.mv_art_gp_zu_per_2 AS SELECT art_id,
 gp_id,
 mandant_id,
 herst_id,
 gp_art_id,
 MAX(dat_von) AS dat_von,
 MAX(dat_bis) AS dat_bis
FROM kfl_production_dbp_view.v_art_gp_zu_per_2
WHERE dat_bis = DATE '9999-12-31'
GROUP BY art_id,
 gp_id,
 mandant_id,
 herst_id,
 gp_art_id;