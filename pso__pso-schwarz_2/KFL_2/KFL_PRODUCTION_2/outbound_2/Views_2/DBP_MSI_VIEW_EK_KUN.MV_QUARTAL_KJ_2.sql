CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_quartal_kj_2 (kjqu, akt_kjqu, akt_kjqu_komplett, kj, akt_kj,
akt_kj_komplett) AS SELECT kjqu,
 akt_kjqu,
 akt_kjqu_komplett,
 kj,
 akt_kj,
 akt_kj_komplett
FROM kfl_production_dbp_data.quartal_kj_2
WHERE kjqu > 200104;