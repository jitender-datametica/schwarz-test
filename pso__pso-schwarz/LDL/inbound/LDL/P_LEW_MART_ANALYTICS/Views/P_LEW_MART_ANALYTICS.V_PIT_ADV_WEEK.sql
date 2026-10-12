CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS.V_PIT_ADV_WEEK as
SELECT
  client_id
, adv_week_id
, (ROW_NUMBER() OVER (PARTITION BY client_id ORDER BY adv_week_id DESC) - 1) * (-1) AS adv_week_seq
, adv_week_descr
, CAST( TO_VARCHAR(adv_week_week_num,'99') AS CHAR(3))  || '/' || cast(adv_week_year_num AS CHAR(4)) AS adv_week_long_descr 
, adv_week_year_num
, adv_week_week_num
, adv_week_start_dt
, adv_week_end_dt
, dwh_created
, dwh_updated
FROM p_lew_mart_analytics.t_advert_week;