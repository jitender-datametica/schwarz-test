
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_MOV_ITEM_FV_DELIVERY_2

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT
2 AS booking_fg -- in neuer STruktur nicht mehr vorhanden, in alter Struktur immer mit Wert 2
,
a.case_size_dec,
a.case_size_dec AS case_size_real,
a.client_id,
cry.curr_cd_from                          AS currency_iso_cd,
a.dayend_dt AS dat_dayend,
a.dwh_cal_dt AS dat_formdate,
NULL AS dsac_nr -- in neuer Struktur nicht mehr vorhanden, in alter Struktur immer der Wert NULL 
,
a.dur_del_cnt AS dur_fv_del,
CAST(a.fv_del_id AS VARCHAR(20))          AS fv_del_id,
a.item_sid                                AS item_id,
a.layer_order_nr,
a.order_area_cd,
a.order_unit_cd AS order_unit,
a.old_retail_gross_price / cry.exchange_rate   AS price_retail_fv_del_old,
a.old_retail_net_price / cry.exchange_rate    AS price_retail_net_fv_del_old,
a.store_gross_price / cry.exchange_rate      AS price_str_fv,
a.store_net_price / cry.exchange_rate        AS price_str_net_fv,
a.wh_gross_price / cry.exchange_rate         AS price_wh_fv,
a.wh_net_price / cry.exchange_rate            AS price_wh_net_fv,
(CAST((ZEROIFNULL(a.store_gross_price)-ZEROIFNULL(a.wh_gross_price)) AS DECIMAL(18,4)) *
    CAST((((ZEROIFNULL(a.case_qty) + ZEROIFNULL(NULL)) *
    COALESCE(a.case_size_dec, i.case_size_dec)) + ZEROIFNULL(a.piece_qty)) AS DECIMAL(18,4))) /
    cry.exchange_rate AS val_pr_diff_del,
(CAST((ZEROIFNULL(a.store_net_price)-ZEROIFNULL(a.wh_net_price)) AS DECIMAL(19,5)) *
    CAST((((ZEROIFNULL(a.case_qty) + ZEROIFNULL(NULL)) *
    COALESCE(a.case_size_dec, i.case_size_dec)) + ZEROIFNULL(a.piece_qty)) AS DECIMAL(19,5)))
    / cry.exchange_rate AS val_pr_diff_net_del,
CAST(a.price_grp_id_store AS DECIMAL(18,4))         AS pricegroup_store,
a.case_qty AS qty_case_fv_del,
a.piece_qty AS qty_piece_fv_del,
a.initial_piece_qty AS qty_piece_fv_del_initial,
a.real_piece_qty AS qty_piece_fv_del_real,
a.receipt_id_fv_del,
NULL AS satas_nr,
a.slot_nr,
NULL AS status_dayend -- in neuer Struktur nicht mehr vorhanden, in alter Struktur immer der Wert NULL 
,
a.loc_sid_store                              AS store_id,
a.vat_id,
d.src_wh_id                               AS wh_id,
e.src_wh_id                               AS wh_id_del,
CAST(0 AS BYTEINT)                        AS src_fg
FROM p_lew_core_ac.v_item_fruits_vegetables_delivery_2 AS a
INNER JOIN p_lew_mart_msi.v_itm_item_2     AS i
ON i.client_id = a.client_id
  AND i.item_id = a.item_sid
INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS b
ON b.client_id = a.client_id
  AND b.loc_sid_store = a.loc_sid_store
INNER JOIN p_lew_core_ac.v_item_group_2 AS c
ON c.client_id = b.client_id
  AND c.src_matkl='@ALL'
INNER JOIN p_lew_core_ac.v_location_2 AS d
ON d.client_id = b.client_id
  AND d.loc_sid = b.loc_sid_wh
LEFT JOIN p_lew_core_ac.v_location_2 AS e
ON e.client_id = a.client_id
  AND e.loc_sid = a.loc_sid_wh
INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_2 AS cry
ON cry.client_id = a.client_id
  AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
  AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
  AND cry.deleted_fg = 0
INNER JOIN p_lew_core_ac.v_exchange_rate_type_2 AS crz
ON crz.client_id = cry.client_id
  AND crz.x_rate_type_sid = cry.x_rate_type_sid
  AND crz.src_kurst = '@BEWE' /*
#DescStart#
#$Revision: 13400 $, $LastChangedBy: umeister $
#SubjectAreas#: Anliefermenge
#DescEnd#
*/
;
/**** WARNING: MISSING DEPENDENT OBJECTS "p_lew_bil_ac.v_warehouse_2", "p_lew_core_ac.v_wawi_ref_client_currency_rate_2", "p_lew_mart_msi.v_itm_item_skey_2", "p_lew_core_ac.v_wawi_itm_item_wh_2", "p_lew_core_ac.v_wawi_itm_wh_slot_2", "p_lew_core_ac.v_item_delivery_2", "p_lew_core_ac.v_item_fruits_vegetables_delivery_2" ****/
