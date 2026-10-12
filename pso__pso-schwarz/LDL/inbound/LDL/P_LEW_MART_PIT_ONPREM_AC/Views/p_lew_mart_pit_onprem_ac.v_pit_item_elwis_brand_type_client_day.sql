CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_ITEM_ELWIS_BRAND_TYPE_CLIENT_DAY
(
     client_id

,          dwh_cal_dt

,          item_sid

,          brand_sid

,          brand_type_mark

,          brand_type_label
)
AS
(SELECT
Ebt.client_id           AS client_id
,Ebt.dwh_cal_dt          AS dwh_cal_dt
,Ebt.item_sid            AS item_sid
,Ebt.brand_sid           AS brand_sid
,Ebt.brand_type_mark     AS brand_type_mark
,Ebt.brand_type_label    AS brand_type_label
FROM p_lew_mart_pit_onprem.t_pit_item_elwis_brand_type_client_day        AS Ebt
);