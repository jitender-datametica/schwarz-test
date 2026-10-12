CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_lagernummer_les_2 (mandant_id, wup_id, nb_id,
lagernummer_les_id) AS SELECT mandant_id,
 wup_id,
 '-111' AS nb_id,
 lagernummer_les_id
FROM kfl_production_dbp_view.v_ts_mercareon_mapping_2
GROUP BY mandant_id,
 wup_id,
 lagernummer_les_id
UNION DISTINCT
SELECT mandant_id,
 wup_id,
 '-111' AS nb_id,
 '-1'
FROM kfl_production_dbp_view.v_ts_mercareon_mapping_2
GROUP BY mandant_id,
 wup_id;