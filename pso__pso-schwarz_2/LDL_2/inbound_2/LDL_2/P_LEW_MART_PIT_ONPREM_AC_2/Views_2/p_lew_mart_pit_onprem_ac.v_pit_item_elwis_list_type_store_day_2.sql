CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_ITEM_ELWIS_LIST_TYPE_STORE_DAY_2
(
     client_id

,          store_sid

,          dwh_cal_dt

,          item_sid

,          permissive_fg

,          list_type_mark

,          list_type_label

,          deleted_fg
)
AS
(SELECT
Elt.client_id          AS client_id
,Elt.store_sid          AS store_sid
,Elt.dwh_cal_dt         AS dwh_cal_dt
,Elt.item_sid           AS item_sid
,Elt.permissive_fg      AS permissive_fg
,Elt.list_type_mark     AS list_type_mark
,Elt.list_type_label    AS list_type_label
,Elt.deleted_fg         AS deleted_fg
FROM p_lew_mart_pit_onprem.t_pit_item_elwis_list_type_store_day_2        AS Elt
);