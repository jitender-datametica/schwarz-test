CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_jahr_kj (kj, akt_kj, akt_kj_komplett, system_id) AS SELECT kj
 ,
 akt_kj,
 akt_kj_komplett,
 7 AS system_id
FROM kfl_production_dbp_view.v_jahr_kj
WHERE kj >= 2005
 AND kj <= EXTRACT(YEAR FROM CURRENT_DATE);