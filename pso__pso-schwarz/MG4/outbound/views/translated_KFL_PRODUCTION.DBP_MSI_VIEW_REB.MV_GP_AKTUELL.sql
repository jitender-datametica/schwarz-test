CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_gp_aktuell (mandant_id, akt_gp_id, akt_gp_name) AS SELECT v01
 .mandant_id,
 v01.gp_id AS akt_gp_id,
 v02.gp_name AS akt_gp_name
FROM kfl_production_dbp_view.v_art_gp_zu_per AS v01
 LEFT JOIN kfl_production_dbp_view.v_gp AS v02 ON v01.gp_id = v02.gp_id AND v01.mandant_id = v02.mandant_id
WHERE v01.dat_bis = DATE '9999-12-31'
GROUP BY v01.mandant_id,
 v01.gp_id,
 v02.gp_name;