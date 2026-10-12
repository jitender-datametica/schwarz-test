CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_CLIENT_ADVERT_WEEK_1
(
     client_id

,          adv_week_id

,          adv_week_start_dt

,          adv_week_end_dt

,          adv_week_order_desc
)
AS
(SELECT
Caw.client_id              AS client_id
,Caw.adv_week_id            AS adv_week_id
,Caw.adv_week_start_dt      AS adv_week_start_dt
,Caw.adv_week_end_dt        AS adv_week_end_dt
,Caw.adv_week_order_desc    AS adv_week_order_desc
FROM p_lew_mart_pit_onprem.t_pit_client_advert_week_1    AS Caw
);