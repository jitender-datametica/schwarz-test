CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_adresse_abholung_ort_1 (land_id, ort) AS SELECT land_id,
 ort
FROM kfl_production_dbp_view.v_belos_adresse_1
WHERE spedition_fg = 0
GROUP BY land_id,
 ort;