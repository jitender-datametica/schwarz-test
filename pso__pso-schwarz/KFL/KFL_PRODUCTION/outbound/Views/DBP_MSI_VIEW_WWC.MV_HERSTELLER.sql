CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_hersteller (herst_id, herst_name, mandant_id, strasse, plz,
ort, land_id, herst_fg, ampel_flg) AS SELECT gp_id AS herst_id,
 gp_name AS herst_name,
 mandant_id,
 gp_strasse AS strasse,
 gp_plz AS plz,
 gp_ort AS ort,
 land_id,
 herst_fg,
 1 AS ampel_flg
FROM kfl_production_dbp_view.v_gp AS V01
WHERE herst_fg = 1;