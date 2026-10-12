CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_kol_item_predecessor (item_ian, pre_item_ian, pre_range_plan_cd,
dwh_created) AS SELECT item_ian,
 pre_item_ian,
 pre_range_plan_cd,
 dwh_created
FROM ldl_p_lew_mart_analytics.t_kol_item_predecessor;