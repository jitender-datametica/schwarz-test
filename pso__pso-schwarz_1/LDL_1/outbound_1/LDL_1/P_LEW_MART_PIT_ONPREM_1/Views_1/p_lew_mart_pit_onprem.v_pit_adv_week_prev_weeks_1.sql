CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_adv_week_prev_weeks_1 AS SELECT W1.client_id,
 W1.adv_week_id,
 W2.adv_week_id AS prev_adv_week_id
FROM ldl_p_lew_mart_pit_onprem.t_advert_week_1 AS W1
 INNER JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_1 AS W2 ON W1.client_id = W2.client_id AND W1.adv_week_id > W2.adv_week_id;