CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_jahr_kj_2 (kj, akt_kj, akt_kj_komplett) AS SELECT kj,
 akt_kj,
 akt_kj_komplett
FROM kfl_production_dbp_view.v_jahr_kj_2 AS V01
WHERE akt_kj BETWEEN - 11 AND 2;