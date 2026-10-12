CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics.v_kol_range_selection_2 (client_id, range_plan_cd, range_advertise_from,
range_advertise_to) AS SELECT client_id,
 range_plan_cd,
 range_advertise_from,
 range_advertise_to
FROM ldl_p_lew_mart_analytics.t_kol_range_selection_2;