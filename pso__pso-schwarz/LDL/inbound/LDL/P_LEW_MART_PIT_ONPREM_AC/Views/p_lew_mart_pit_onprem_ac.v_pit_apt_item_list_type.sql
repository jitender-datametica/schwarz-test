CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_APT_ITEM_LIST_TYPE
(
     item_list_type_id

,          item_list_type
)
AS
(SELECT
Apt.item_list_type_id    AS item_list_type_id
,Apt.item_list_type       AS item_list_type
FROM p_lew_mart_pit_onprem.t_pit_apt_item_list_type    AS Apt
);