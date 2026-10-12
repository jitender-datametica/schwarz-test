CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_nachlieferungsprocess_request_2 AS SELECT IFNULL(MAX(nachlieferung_request_id
    ), 0) + 1 AS nachlieferung_request_id
FROM kfl_production_dbp_msi_v_view.v_ts_nachlieferung_2;