CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_mov_item_fv_delivery_2 AS
-- in neuer STruktur nicht mehr vorhanden, in alter Struktur immer mit Wert 2

-- in neuer Struktur nicht mehr vorhanden, in alter Struktur immer der Wert NULL

-- in neuer Struktur nicht mehr vorhanden, in alter Struktur immer der Wert NULL
 SELECT 2 AS booking_fg,
 A.case_size_dec,
 A.case_size_dec AS case_size_real,
 A.client_id,
 CRY.curr_cd_from AS currency_iso_cd,
 A.dayend_dt AS dat_dayend,
 A.dwh_cal_dt AS dat_formdate,
 NULL AS dsac_nr,
 A.dur_del_cnt AS dur_fv_del,
 CAST(A.fv_del_id AS STRING) AS fv_del_id,
 A.item_sid AS item_id,
 A.layer_order_nr,
 A.order_area_cd,
 A.order_unit_cd AS order_unit,
  A.old_retail_gross_price / CRY.exchange_rate AS price_retail_fv_del_old,
  A.old_retail_net_price / CRY.exchange_rate AS price_retail_net_fv_del_old,
  A.store_gross_price / CRY.exchange_rate AS price_str_fv,
  A.store_net_price / CRY.exchange_rate AS price_str_net_fv,
  A.wh_gross_price / CRY.exchange_rate AS price_wh_fv,
  A.wh_net_price / CRY.exchange_rate AS price_wh_net_fv,
 CAST(NULL AS NUMERIC) AS val_pr_diff_del,
 CAST(NULL AS NUMERIC) AS val_pr_diff_net_del,
 CAST(A.price_grp_id_store AS NUMERIC) AS pricegroup_store,
 A.case_qty AS qty_case_fv_del,
 A.piece_qty AS qty_piece_fv_del,
 A.initial_piece_qty AS qty_piece_fv_del_initial,
 A.real_piece_qty AS qty_piece_fv_del_real,
 A.receipt_id_fv_del,
 NULL AS satas_nr,
 A.slot_nr,
 NULL AS status_dayend,
 A.loc_sid_store AS store_id,
 A.vat_id,
 D.src_wh_id AS wh_id,
 E.src_wh_id AS wh_id_del,
 0 AS src_fg
FROM ldl_p_lew_core_ac.v_item_fruits_vegetables_delivery_2 AS A
 INNER JOIN ldl_p_lew_mart_msi.v_itm_item_2 AS I ON A.client_id = I.client_id AND A.item_sid = I.item_id
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS B ON A.client_id = B.client_id AND A.loc_sid_store = B.loc_sid_store
   
 INNER JOIN ldl_p_lew_core_ac.v_item_group_2 AS C ON B.client_id = C.client_id AND C.src_matkl = '@ALL'
 INNER JOIN ldl_p_lew_core_ac.v_location_2 AS D ON B.client_id = D.client_id AND B.loc_sid_wh = D.loc_sid
 LEFT JOIN ldl_p_lew_core_ac.v_location_2 AS E ON A.client_id = E.client_id AND A.loc_sid_wh = E.loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CRY ON A.client_id = CRY.client_id AND CURRENT_DATE BETWEEN
     CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to AND CRY.deleted_fg
    = 0
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS CRZ ON CRY.client_id = CRZ.client_id AND CRY.x_rate_type_sid = CRZ
    .x_rate_type_sid AND CRZ.src_kurst = '@BEWE'
   /* #DescStart#
#$Revision: 13400 $, $LastChangedBy: umeister $
#SubjectAreas#: Anliefermenge
#DescEnd# */;