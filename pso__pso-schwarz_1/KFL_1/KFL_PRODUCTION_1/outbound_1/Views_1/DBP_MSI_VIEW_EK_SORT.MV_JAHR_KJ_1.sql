CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_jahr_kj_1 AS SELECT kj,
 akt_kj,
 akt_kj_komplett,
  kj - 1 AS prev_kj
FROM kfl_production_dbp_view.v_jahr_kj_1 AS V01
WHERE akt_kj BETWEEN - 11 AND 2;