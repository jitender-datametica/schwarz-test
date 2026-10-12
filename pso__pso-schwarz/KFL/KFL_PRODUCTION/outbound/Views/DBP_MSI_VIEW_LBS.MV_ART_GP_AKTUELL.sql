CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_art_gp_aktuell (art_id, akt_gp_id, mandant_id, wup_id) AS
SELECT art_id,
 gp_id AS akt_gp_id,
 mandant_id,
 wup_id
FROM kfl_production_dbp_view.v_art_gp_nm_zu_per
WHERE dat_bis = DATE '9999-12-31'
GROUP BY art_id,
 gp_id,
 mandant_id,
 wup_id;