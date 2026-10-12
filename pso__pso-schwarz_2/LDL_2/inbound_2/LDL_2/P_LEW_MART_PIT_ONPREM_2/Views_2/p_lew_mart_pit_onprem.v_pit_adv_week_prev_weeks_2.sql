CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_ADV_WEEK_PREV_WEEKS_2

AS
   SELECT
   w1.client_id
,   w1.adv_week_id
,   w2.adv_week_id AS prev_adv_week_id
   FROM p_lew_mart_pit_onprem.t_advert_week_2 AS w1
   INNER JOIN p_lew_mart_pit_onprem.t_advert_week_2 AS w2
   ON  w1.client_id   = w2.client_id
   AND w1.adv_week_id > w2.adv_week_id;