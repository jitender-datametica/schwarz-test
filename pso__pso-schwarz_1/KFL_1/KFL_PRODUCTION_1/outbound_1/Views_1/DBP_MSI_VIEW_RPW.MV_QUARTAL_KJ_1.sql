CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_quartal_kj_1 (kjqu, kj, akt_kjqu, akt_kjqu_komplett, akt_kj,
akt_kj_komplett, system_id) AS SELECT kjqu,
 kj,
 akt_kjqu,
 akt_kjqu_komplett,
 akt_kj,
 akt_kj_komplett,
 7 AS system_id
FROM kfl_production_dbp_view.v_quartal_kj_1
WHERE kj >= 2005
 AND kj <= EXTRACT(YEAR FROM CURRENT_DATE);