CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_UPI_STORE_DAY_ITEM_2
(
     client_id
,          store_sid
,          dwh_cal_dt
,          item_sid
,          effective_client_id
,          luxembourg_fg
)
AS
(SELECT
Upi.client_id              AS client_id
,Upi.store_sid              AS store_sid
,Upi.dwh_cal_dt             AS dwh_cal_dt
,Upi.item_sid               AS item_sid
,Upi.effective_client_id    AS effective_client_id
,Upi.luxembourg_fg          AS luxembourg_fg
FROM p_lew_mart_pit_onprem.t_pit_upi_store_day_item_2        AS Upi
);