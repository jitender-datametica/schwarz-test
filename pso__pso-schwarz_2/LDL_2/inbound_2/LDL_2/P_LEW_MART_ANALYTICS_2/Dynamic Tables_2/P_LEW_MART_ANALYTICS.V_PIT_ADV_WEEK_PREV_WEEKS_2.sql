
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_ANALYTICS.V_PIT_ADV_WEEK_PREV_WEEKS_2
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_ANALYTICS
AS
   SELECT
     w1.client_id,
   w1.adv_week_id,
   w2.adv_week_id AS prev_adv_week_id
  FROM p_lew_mart_analytics.t_advert_week_2 AS w1
   INNER JOIN p_lew_mart_analytics.t_advert_week_2 AS w2
   ON  w1.client_id   = w2.client_id
   AND w1.adv_week_id > w2.adv_week_id
   ;
