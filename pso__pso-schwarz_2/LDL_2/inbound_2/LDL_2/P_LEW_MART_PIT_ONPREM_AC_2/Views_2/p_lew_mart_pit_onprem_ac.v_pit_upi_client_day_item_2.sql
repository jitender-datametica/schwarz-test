CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_UPI_CLIENT_DAY_ITEM_2
(
     client_id

,          dwh_cal_dt

,          item_sid
)
AS
(SELECT
Upi.client_id     AS client_id
,Upi.dwh_cal_dt    AS dwh_cal_dt
,Upi.item_sid      AS item_sid
FROM p_lew_mart_pit_onprem.t_pit_upi_client_day_item_2        AS Upi
);