CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_CLIENT_ADVERT_WEEK_PERIOD_START_1
(
     client_id
,          adv_week_period_start_dt
,          adv_week_period_end_dt
,          adv_week_id
)
AS
(SELECT
Awps.client_id                   AS client_id
,Awps.adv_week_period_start_dt    AS adv_week_period_start_dt
,Awps.adv_week_period_end_dt      AS adv_week_period_end_dt
,Awps.adv_week_id                 AS adv_week_id
FROM p_lew_mart_pit_onprem.t_pit_client_advert_week_period_start_1        AS Awps
);