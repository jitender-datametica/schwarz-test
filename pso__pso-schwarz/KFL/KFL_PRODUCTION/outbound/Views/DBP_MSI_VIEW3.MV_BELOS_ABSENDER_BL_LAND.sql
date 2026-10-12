CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_belos_absender_bl_land (land_id) AS SELECT land_id
FROM kfl_production_dbp_view.v_belos_adresse
WHERE spedition_fg = 0
GROUP BY land_id;