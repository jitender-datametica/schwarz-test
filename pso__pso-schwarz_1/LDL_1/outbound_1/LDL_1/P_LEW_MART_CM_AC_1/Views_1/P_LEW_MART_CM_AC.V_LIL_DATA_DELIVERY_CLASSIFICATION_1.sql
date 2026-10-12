CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_data_delivery_classification_1 (client_id, period_id, year_id,
period_type_id, dsc_nr, lfl_id, pp_lfl_id, py_lfl_id) AS SELECT *
FROM ldl_p_lew_mart_cm.v_lil_data_delivery_classification_1;