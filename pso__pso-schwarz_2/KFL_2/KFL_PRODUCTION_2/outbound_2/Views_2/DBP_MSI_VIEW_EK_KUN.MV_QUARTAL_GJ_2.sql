CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_quartal_gj_2 (gjqu, akt_gjqu, akt_gjqu_komplett, gj, akt_gj,
akt_gj_komplett) AS SELECT gjqu,
 akt_gjqu,
 akt_gjqu_komplett,
 gj,
 akt_gj,
 akt_gj_komplett
FROM kfl_production_dbp_data.quartal_gj_2
WHERE gjqu > 200104;