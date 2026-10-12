CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_tour_plombe_ziel_1 (mandant_id, nb_id, wup_id, tour_id, plombe_id,
plombe_prozess_id, plombe_aktivitaet, dat_scan, zeit_scan) AS SELECT mandant_id,
 nb_id,
 wup_id,
 tour_id,
 plombe_id,
 plombe_prozess_id,
 plombe_aktivitaet,
 dat_scan,
 zeit_scan
FROM kfl_production_dbp_view.v_tour_plombe_ziel_1
WHERE EXTRACT(YEAR FROM dat_scan) >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2;