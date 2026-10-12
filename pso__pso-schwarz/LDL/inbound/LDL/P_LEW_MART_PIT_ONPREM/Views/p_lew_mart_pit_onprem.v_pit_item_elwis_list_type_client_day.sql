CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_ITEM_ELWIS_LIST_TYPE_CLIENT_DAY
(
     client_id
,          dwh_cal_dt
,          item_sid
,          list_type_mark
,          list_type_label
)
AS
(SELECT
Elt.client_id          AS client_id
,Elt.dwh_cal_dt         AS dwh_cal_dt
,Elt.item_sid           AS item_sid
,Elt.list_type_mark     AS list_type_mark
,Elt.list_type_label    AS list_type_label
FROM p_lew_mart_pit_onprem.t_pit_item_elwis_list_type_client_day        AS Elt
);