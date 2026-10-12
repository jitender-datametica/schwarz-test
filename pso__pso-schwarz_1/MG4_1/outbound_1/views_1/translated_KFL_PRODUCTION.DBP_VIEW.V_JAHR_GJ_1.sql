CREATE OR REPLACE VIEW kfl_production_dbp_view.v_jahr_gj_1 (gj, akt_gj, akt_gj_komplett, td_insert, td_update) AS SELECT
 gj,
 akt_gj,
 akt_gj_komplett,
 td_insert,
 td_update
FROM kfl_production_dbp_data.jahr_gj_1;