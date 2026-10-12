CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_quartal_kj (kjqu, akt_kjqu, akt_kjqu_komplett, kj, akt_kj,
akt_kj_komplett, kjqu_bez) AS SELECT kjqu,
 akt_kjqu,
 akt_kjqu_komplett,
 kj,
 akt_kj,
 akt_kj_komplett,
   CAST(MIN(dat) AS STRING) || '-' || CAST(MAX(dat) AS STRING) AS kjqu_bez
FROM kfl_production_dbp_view.v_tag AS V01
WHERE akt_gj BETWEEN - 10 AND 1
GROUP BY kjqu,
 akt_kjqu,
 akt_kjqu_komplett,
 kj,
 akt_kj,
 akt_kj_komplett;