CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_ais_mandant_wup_2 (mandant_id, wup_id, nb_id, gp_id) AS
SELECT mandant_id,
 wup_id,
 0 AS nb_id,
 gp_id
FROM kfl_production_dbp_msi_v_view.v_ais_mandant_wup_2
WHERE mandant_id <> 1;