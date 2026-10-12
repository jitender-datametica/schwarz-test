CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_jahr_gj_1 AS SELECT gj,
 akt_gj,
 akt_gj_komplett
FROM kfl_production_dbp_view.v_jahr_gj_1 AS V01
WHERE gj > 2001;