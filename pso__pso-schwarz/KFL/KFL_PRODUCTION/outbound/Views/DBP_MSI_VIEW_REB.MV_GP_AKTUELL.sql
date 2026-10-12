CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_gp_aktuell (mandant_id, akt_gp_id, akt_gp_name) AS SELECT V01
 .mandant_id,
 V01.gp_id AS akt_gp_id,
 V02.gp_name AS akt_gp_name
FROM kfl_production_dbp_view.v_art_gp_zu_per AS V01
 LEFT JOIN kfl_production_dbp_view.v_gp AS V02 ON V01.gp_id = V02.gp_id AND V01.mandant_id = V02.mandant_id
WHERE V01.dat_bis = DATE '9999-12-31'
GROUP BY V01.mandant_id,
 V01.gp_id,
 V02.gp_name;