CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_customer_to_child_age_range_1 AS SELECT client_id,
 customer_sid,
 child_age_range_cd,
 child_age_range_forecasted_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_customer_to_child_age_range_1;