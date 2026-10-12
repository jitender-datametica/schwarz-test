CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_adresse_abholung_ort (land_id, ort) AS SELECT land_id,
 ort
FROM kfl_production_dbp_view.v_belos_adresse
WHERE spedition_fg = 0
GROUP BY land_id,
 ort;