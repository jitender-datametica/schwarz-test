CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_log.mv_l_queue AS SELECT mandant_id,
 lagernummer_id,
 queue_id
FROM kfl_production_dbp_data.lageraufgabe
GROUP BY mandant_id,
 lagernummer_id,
 queue_id;