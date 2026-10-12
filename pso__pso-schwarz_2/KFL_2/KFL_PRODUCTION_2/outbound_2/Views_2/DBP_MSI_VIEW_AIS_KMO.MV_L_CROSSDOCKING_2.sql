CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_crossdocking_2 (mandant_id, crossdocking_id) AS SELECT
 mandant_id,
 crossdocking_id
FROM kfl_production_dbp_data.l_crossdocking_2
WHERE mandant_id <> 1;