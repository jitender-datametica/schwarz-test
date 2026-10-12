CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_ITEM_ELWIS_BUYING_LIST_TYPE_CLIENT_DAY
(
     client_id

,          dwh_cal_dt

,          item_sid

,          list_type_mark

,          list_type_label

,          brand_sid

,          brand_type_mark

,          brand_type_label

,          buying_list_type_id

,          buying_list_type_descr
)
AS
(SELECT
Blt.client_id                 AS client_id
,Blt.dwh_cal_dt                AS dwh_cal_dt
,Blt.item_sid                  AS item_sid
,Blt.list_type_mark            AS list_type_mark
,Blt.list_type_label           AS list_type_label
,Blt.brand_sid                 AS brand_sid
,Blt.brand_type_mark           AS brand_type_mark
,Blt.brand_type_label          AS brand_type_label
,Blt.buying_list_type_id       AS buying_list_type_id
,Blt.buying_list_type_descr    AS buying_list_type_descr
FROM p_lew_mart_pit_onprem.t_pit_item_elwis_buying_list_type_client_day        AS Blt
);