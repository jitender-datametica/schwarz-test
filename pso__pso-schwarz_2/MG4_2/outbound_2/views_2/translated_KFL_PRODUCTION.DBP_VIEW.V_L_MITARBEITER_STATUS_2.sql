CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_mitarbeiter_status_2 (mandant_id, ma_status_id) AS SELECT mandant_id,
 ma_status_id
FROM kfl_production_dbp_data.l_mitarbeiter_status_2;