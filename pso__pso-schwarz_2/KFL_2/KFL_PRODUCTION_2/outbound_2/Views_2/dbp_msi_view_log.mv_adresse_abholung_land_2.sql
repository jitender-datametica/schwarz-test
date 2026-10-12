CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_adresse_abholung_land_2 (land_id) AS SELECT land_id
FROM kfl_production_dbp_view.v_belos_adresse_2
WHERE spedition_fg = 0
GROUP BY land_id;