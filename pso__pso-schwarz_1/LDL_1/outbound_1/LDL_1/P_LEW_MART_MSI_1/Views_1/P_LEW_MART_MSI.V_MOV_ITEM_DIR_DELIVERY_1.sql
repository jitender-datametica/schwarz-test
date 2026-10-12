/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MOV_ITEM_DIR_DELIVERY_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  25.09.2017    Martin Murtenthaler neue Versionn
#  1.2  08.11.2017    Meister.Ulrich neue Version
#  1.3  09.11.2017    Meister.Ulrich Bestimmung Betriebsgesellschaften angepasst
#  1.4  09.11.2017    Meister.Ulrich Bestimmung zugeordnete Betriebsgesellschaft angepasst
#  1.5  10.11.2017    Meister.Ulrich trim added for orig_receipt_nr_dir_del to avoid leading blanks
#  1.6  15.11.2017    Wieber.Harald            Release 1.1
#  1.7  17.01.2018    Murtenthaler.Martin      WAWI-Item_1 if possible
#  1.8  31.01.2018    Wieber.Harald            Release 2.3
#  1.9  04.04.2018    Arnold.Arne              Umstellung auf V_STORE_TO_WAREHOUSE_LASTKNOWN_1
# 1.10  19.04.2018    Knopp,Timo               Adaptation after changing core tables map_mis_mov_type(_deliv) to map_mis_movE_type(_deliv)
# 1.11  13.06.2018    Meister,Ulrich           Konsolidierung der Aenderungen
# 1.12  24.07.2018    Michael Ueding           Referenz Item_1 Mapping geaendert
# 1.13  16.12.2019    Michael Ueding           Ersetzen Legacy mit Core Objekt 
# 1.14  13.01.2020    Ulrich Meister           changed to replace n_-View approach, Patch 20191218_2333_MCD_mart_views_WH_MOVE_DWH20 IDMO-2570, DWH-7995
# 1.15  10.11.2020    Torsten Bachmann         CROSS JOIN to v_supplier_map_key_1 added
#                                              PatchNo: 2652, REP3-7579
# 1.16  22.02.2021    Prasanna Ranjan          REP2-9080 - Include item_1 types ZKM and ZVM from USA and Serbia 
#----------------------------------------------------------------------------
*/


/* Ungefilterte Artikelarten */ /* in alter Struktur immer der Wert NULL */ /* in alter Struktur immer der Wert NULL */
/* in alter Struktur immer der Wert NULL */ /* Bezeichnung in neuer Struktur nicht mehr vorhanden */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mov_item_dir_delivery_1 (client_id, store_id, item_id, dat_dayend, dir_del_id
, wh_id, supplier_id, vat_id, order_area_cd, orig_receipt_nr_dir_del, rcv_pos_id, dat_formdate, dat_booking, dat_rcv_mdd
, status_dayend, status_dir_del, act_price_item_cd, dd_matched_fg, dispo_unit_desc, dispo_unit_id, mdd_user,
mdd_return_fg, group_nr, comment_dir_del, price_act_wh, price_act_wh_net, price_cd, price_wh_dir_del,
price_wh_net_dir_del, price_str_dir_del, price_str_net_dir_del, qty_case_dir_del, case_size_dec, currency_iso_cd,
wh_id_del) AS SELECT A.client_id,
 A.loc_sid_store AS store_id,
 ITMP.item_sid_map AS item_id,
 A.dayend_dt AS dat_dayend,
 A.dir_del_id,
 D.src_wh_id AS wh_id,
 COALESCE(SUPMAP.sup_sid_map, A.orig_supplier_nr) AS supplier_id,
 A.vat_id,
 A.order_area_cd,
 TRIM(A.orig_receipt_nr) AS orig_receipt_nr_dir_del,
 A.rcv_pos_id,
 A.dwh_cal_dt AS dat_formdate,
 DATE(NULL) AS dat_booking,
 A.mdd_rcv_dt AS dat_rcv_mdd,
 A.dayend_status_id AS status_dayend,
 A.dir_del_status_id AS status_dir_del,
 A.act_price_item_id AS act_price_item_cd,
 A.dd_matched_fg,
 'Kolli' AS dispo_unit_desc,
 A.dispo_unit_id,
 A.mdd_user_name AS mdd_user,
 A.mdd_return_id AS mdd_return_fg,
 CAST(NULL AS NUMERIC) AS group_nr,
 A.comment_txt AS comment_dir_del,
  A.wh_act_gross_price / CRY.exchange_rate AS price_act_wh,
  A.wh_act_net_price / CRY.exchange_rate AS price_act_wh_net,
 CAST(NULL AS BIGNUMERIC) AS price_cd,
  A.wh_del_gross_price / CRY.exchange_rate AS price_wh_dir_del,
  A.wh_del_net_price / CRY.exchange_rate AS price_wh_net_dir_del,
  A.store_del_gross_price / CRY.exchange_rate AS price_str_dir_del,
  A.store_del_net_price / CRY.exchange_rate AS price_str_net_dir_del,
 A.case_qty AS qty_case_dir_del,
 A.case_size_dec,
 CRY.curr_cd_from AS currency_iso_cd,
 E.src_wh_id AS wh_id_del
FROM ldl_p_lew_core_ac.v_item_direct_delivery_1 AS A
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS B ON A.client_id = B.client_id AND A.loc_sid_store = B.loc_sid_store
   
 INNER JOIN ldl_p_lew_core_ac.v_item_group_1 AS C ON B.client_id = C.client_id AND C.src_matkl = '@ALL'
 INNER JOIN ldl_p_lew_core_ac.v_location_1 AS D ON B.client_id = D.client_id AND B.loc_sid_wh = D.loc_sid
 LEFT JOIN ldl_p_lew_core_ac.v_location_1 AS E ON A.client_id = E.client_id AND A.loc_sid_wh = E.loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS CRY ON A.client_id = CRY.client_id AND CURRENT_DATE BETWEEN
     CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to AND CRY.deleted_fg
    = 0
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS CRZ ON CRY.client_id = CRZ.client_id AND CRY.x_rate_type_sid = CRZ
    .x_rate_type_sid AND CRZ.src_kurst = '@BEWE'
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS ITMP ON A.client_id = ITMP.client_id AND A.item_sid = ITMP.item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_supplier_map_key_1 AS SUPMAP ON A.client_id = SUPMAP.client_id AND A.orig_supplier_nr =
   SUPMAP.wawi_dwh_orig_supplier_nr /* replaced by UNION to eliminate duplicates: UNION ALL */
UNION DISTINCT
SELECT CAST(B.client_id AS BIGNUMERIC) AS client_id,
 B.loc_sid AS store_id,
 ITMP.item_sid_map AS item_id,
 DATE(B.dwh_created) AS dat_dayend,
 0 AS receipt_id_del,
 J.src_wh_id AS wh_id,
  CASE
  WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
  THEN SUPMAP.sup_sid_map
  ELSE - 1
  END AS supplier_id,
 COALESCE(D.vat_id, - 2) AS vat_id,
 CAST(NULL AS STRING) AS order_area_cd,
 TRIM(CAST(CAST(B.order_record_id AS BIGNUMERIC) AS STRING)) AS orig_receipt_nr_dir_del,
 CAST(B.order_record_pos_id AS NUMERIC) AS rcv_pos_id,
 B.dwh_cal_dt AS dat_formdate,
 B.dwh_cal_dt AS dat_booking,
 DATE(NULL) AS dat_rcv_mdd,
 3 AS status_dayend,
 3 AS status_prot_receipt,
 CAST(NULL AS BIGNUMERIC) AS pricegroup_act_price,
 0 AS dd_matched_fg,
 'Kolli' AS dispo_unit_desc,
 0 AS dispo_unit_id,
 CAST(NULL AS STRING) AS mdd_user,
 0 AS mdd_return_fg,
 CAST(NULL AS NUMERIC) AS group_nr,
 CAST(NULL AS STRING) AS comment_del,
  ROUND(CAST(M.cond_val_eff_calc AS NUMERIC), 4) / CRY.exchange_rate AS price_retail_wh,
  CAST(M.net_val_eff_calc AS NUMERIC) / CRY.exchange_rate AS price_act_wh_net,
 CAST(NULL AS BIGNUMERIC) AS price_cd,
  ROUND(CAST(M.cond_val_eff_calc AS NUMERIC), 4) / CRY.exchange_rate AS price_wh_del,
  CAST(M.net_val_eff_calc AS NUMERIC) / CRY.exchange_rate AS price_wh_net_del,
  ROUND(CAST(L.cond_val_eff_calc AS NUMERIC), 4) / CRY.exchange_rate AS price_str_del,
  CAST(L.net_val_eff_calc AS NUMERIC) / CRY.exchange_rate AS price_str_net_del,
 0 AS qty_case_del,
 CAST(CASE
   WHEN B.capt_qty * COALESCE(C.component_qty, 1) <> 0
   THEN B.ship_qty * COALESCE(C.component_qty, 1) / (B.capt_qty * COALESCE(C.component_qty, 1))
   ELSE 0
   END AS NUMERIC) AS case_size_dec,
 CRY.curr_cd_from AS currency_iso_cd,
 CAST(- 2147483647 AS BIGNUMERIC) AS wh_id_del
FROM ldl_p_lew_core_ac.v_item_movement_record_pos_1 AS B
 LEFT JOIN (SELECT CA.client_id,
   CA.item_sid,
   CA.item_bom_sid
  FROM ldl_p_lew_core_ac.v_item_bom_1 AS CA
   LEFT JOIN ldl_p_lew_core_ac.v_item_bom_1 AS CB ON CA.client_id = CB.client_id AND CA.item_sid = CB.item_sid AND CB.src_werks
        = '@ALL' AND CB.deleted_fg = 0 AND (CA.src_stlnr < CB.src_stlnr OR CA.src_stlnr = CB.src_stlnr AND CA.item_bom_sid
         < CB.item_bom_sid)
  WHERE CA.src_werks = '@ALL'
   AND CA.deleted_fg = 0
   AND CB.client_id IS NULL) AS c0 ON B.client_id = c0.client_id AND B.item_sid = c0.item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_item_bom_pos_hist_1 AS C ON c0.client_id = C.client_id AND c0.item_bom_sid = C.item_bom_sid
      AND CURRENT_DATE BETWEEN C.dwh_valid_from AND C.dwh_valid_to AND C.deleted_fg = 0
 LEFT JOIN ldl_p_lew_bil_ac.v_item_vat_act_1 AS D ON B.client_id = D.client_id AND D.item_sid = COALESCE(C.item_sid, B.item_sid
    )
 LEFT JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS F ON B.client_id = F.client_id AND B.loc_sid_counterparty = F.loc_sid_wh AND
    F.bges_active_fg = 1 /* warehouse ist Betriebsgesellschaft */ AND CURRENT_DATE BETWEEN F.dwh_valid_from AND F.dwh_valid_to
   
 INNER JOIN ldl_p_lew_core_ac.v_location_1 AS G ON B.client_id = G.client_id AND B.loc_sid = G.loc_sid AND G.wh_store_mark
       = 'A' AND G.global_loc_type_cd = '0' /* Bedingung aus p_core_biz.v_s_loc_store */ AND G.global_loc_ctry_cd <>
    'ZV' /* Aehnlich einer Bedingung aus p_core_biz.v_s_loc_store */ AND G.opening_dt IS NOT NULL
 INNER JOIN ldl_p_lew_core_ac.v_location_hist_1 AS H ON B.client_id = H.client_id AND B.loc_sid = H.loc_sid AND (H.test_store_fg
     IS NULL OR H.test_store_fg = 0) AND CURRENT_DATE BETWEEN H.dwh_valid_from AND H.dwh_valid_to
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS I ON B.client_id = I.client_id AND B.loc_sid = I.loc_sid_store
   
 INNER JOIN ldl_p_lew_core_ac.v_item_group_1 AS II ON I.client_id = II.client_id AND II.src_matkl = '@ALL'
 INNER JOIN ldl_p_lew_core_ac.v_location_1 AS J ON I.client_id = J.client_id AND I.loc_sid_wh = J.loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_item_1 AS KA ON B.client_id = KA.client_id AND KA.item_sid = COALESCE(C.item_sid, B.item_sid
    )
 INNER JOIN ldl_p_lew_core_ac.v_item_hist_1 AS K ON KA.client_id = K.client_id AND KA.item_sid = K.item_sid AND
   CURRENT_DATE BETWEEN K.dwh_valid_from AND K.dwh_valid_to
 LEFT JOIN ldl_p_lew_bil_ac.v_item_loc_sales_cond_denorm_1 AS L ON K.client_id = L.client_id AND K.item_sid = L.item_sid
    AND K.uom_sid_base = L.uom_sid_cond AND B.loc_sid = L.loc_sid AND B.dwh_cal_dt BETWEEN L.dwh_valid_from AND L.dwh_valid_to
   
 LEFT JOIN ldl_p_lew_bil_ac.v_item_loc_sales_cond_denorm_1 AS M ON K.client_id = M.client_id AND K.item_sid = M.item_sid
    AND K.uom_sid_base = M.uom_sid_cond AND I.loc_sid_wh = M.loc_sid AND B.dwh_cal_dt BETWEEN M.dwh_valid_from AND M.dwh_valid_to
   
 INNER JOIN ldl_p_lew_core_ac.v_order_record_1 AS P ON B.client_id = P.client_id AND B.order_record_id = P.order_record_id
   
 INNER JOIN ldl_p_lew_core_ac.v_map_mis_move_type_deliv_1 AS Q ON P.client_id = Q.client_id AND P.order_type_cd = Q.order_type_cd
     AND B.move_type_cd = Q.move_type_cd
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS CRY ON B.client_id = CRY.client_id AND CURRENT_DATE BETWEEN
     CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to AND CRY.deleted_fg
    = 0
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS CRZ ON CRY.client_id = CRZ.client_id AND CRY.x_rate_type_sid = CRZ
    .x_rate_type_sid AND CRZ.src_kurst = '@BEWE'
 LEFT JOIN ldl_p_lew_process_ac.v_item_type_ignore_1 AS ITI ON K.client_id = ITI.client_id AND K.item_type_sid = ITI.item_type_sid
      AND (ITI.client_id IN (33, 34) AND ITI.item_type_cd NOT IN ('ZKM', 'ZVM') OR ITI.client_id NOT IN (33, 34)) AND
   ITI.item_type_grp_cd = 'ANL'
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS ITMP ON B.client_id = ITMP.client_id AND ITMP.item_sid = COALESCE(B.item_sid
    , C.item_sid)
 INNER JOIN ldl_p_lew_core_ac.v_supplier_map_key_1 AS SUPMAP ON B.client_id = SUPMAP.client_id AND B.sup_sid = SUPMAP.sup_sid
   
WHERE MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
 AND ITI.item_type_sid IS NULL;