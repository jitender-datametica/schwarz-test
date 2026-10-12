CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_hersteller_2 (herst_id, herst_name, mandant_id, strasse, plz,
ort, land_id, herst_fg) AS SELECT gp_id AS herst_id,
 gp_name AS herst_name,
 mandant_id,
 gp_strasse AS strasse,
 gp_plz AS plz,
 gp_ort AS ort,
 land_id,
 herst_fg
FROM kfl_production_dbp_view.v_gp_2
WHERE mandant_id = 1
 AND herst_fg = 1;