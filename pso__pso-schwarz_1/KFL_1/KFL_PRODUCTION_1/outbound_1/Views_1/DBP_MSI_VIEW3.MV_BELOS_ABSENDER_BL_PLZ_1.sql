CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_belos_absender_bl_plz_1 (land_id, ort, plz) AS SELECT land_id,
 ort,
 CAST(plz AS STRING) AS plz
FROM kfl_production_dbp_view.v_belos_adresse_1
WHERE spedition_fg = 0
GROUP BY land_id,
 ort,
 plz;