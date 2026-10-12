CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_jahr_gj_1 (gj, akt_gj, akt_gj_komplett, system_id) AS SELECT gj
 ,
 akt_gj,
 akt_gj_komplett,
 7 AS system_id
FROM kfl_production_dbp_view.v_jahr_gj_1
WHERE gj >= 2005
 AND gj <= EXTRACT(YEAR FROM CURRENT_DATE);