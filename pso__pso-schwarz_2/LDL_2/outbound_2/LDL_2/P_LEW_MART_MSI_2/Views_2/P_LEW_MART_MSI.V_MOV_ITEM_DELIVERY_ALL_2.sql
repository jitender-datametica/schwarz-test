/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MOV_ITEM_DELIVERY_ALL_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  25.09.2017    Martin Murtenthaler neue Versionn n n n nn
#  1.2  08.11.2017    Meister.Ulrich neue Version n n n nn
#  1.3  09.11.2017    Meister.Ulrich Bestimmung Betriebsgesellschaften angepasst
#  1.4  09.11.2017    Meister.Ulrich Bestimmung zugeordnete Betriebsgesellschaft angepasst
#  1.5  13.11.2017    Meister.Ulrich Bestimmung case_size_dec angepasst
#  1.6  15.11.2017    Wieber.Harald            Release 1.1
#  1.7  17.11.2017    Meister.Ulrich Bestimmung case_size angepasst
#  1.8  17.01.2018    Murtenthaler.Martin      WAWI-Item_2 if possible
#  1.9  31.01.2018    Wieber,Harald            Release 2.3
# 1.10  04.04.2018    Arnold,Arne              Umstellung auf V_STORE_TO_WAREHOUSE_LASTKNOWN_2
# 1.11  07.05.2018    Knopp,Timo               Umstellung auf lew_core_ac.v_map_mis_move_type_deliv_2
# 1.12  13.06.2018    Meister,Ulrich           Konsolidierung der Aenderungen
# 1.13  24.07.2018    Michael Ueding           Referenz Item_2 Mapping geaendert
# 1.14  16.12.2019    Michael Ueding           Ersetzen Legacy mit Core Objekt 
# 1.15  13.01.2020    Ulrich Meister           changed to replace n_-View approach, Patch 20191218_2333_MCD_mart_views_WH_MOVE_DWH20 IDMO-2570, DWH-7995
# 1.16  09.11.2020    Torsten Bachmann         CROSS JOIN to v_supplier_map_key_2 added
#                                              PatchNo: 2652, REP3-7579
# 1.17  22.02.2021    Prasanna Ranjan          REP2-9080 - Include item_2 types ZKM and ZVM from USA and Serbia 
#----------------------------------------------------------------------------
*/


/* Ungefilterte Artikelarten */ /* Auswertung 10er-Stelle (Resultat Division ist Integer ungerundet) */
/* in alter Struktur immer der Wert NULL */
/* in neuer Struktur nicht mehr vorhanden, in alter Struktur immer der Wert NULL */
/* in neuer STruktur nicht mehr vorhanden, in alter Struktur immer mit Wert 2 */
/* in alter Struktur immer der Wert NULL */
/* in neuer STruktur nicht mehr vorhanden, in alter Struktur immer mit Wert 2 */
/* in alter Struktur immer der Wert NULL */
/* in neuer Struktur nicht mehr vorhanden, in alter Struktur immer der Wert NULL */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mov_item_delivery_all_2 (client_id OPTIONS(description=''), item_id
OPTIONS(description=''), dat_formdate OPTIONS(description=''), receipt_id_del OPTIONS(description=''), store_id
OPTIONS(description=''), wh_id OPTIONS(description=''), vat_id OPTIONS(description=''), order_area_cd
OPTIONS(description=''), dat_dayend OPTIONS(description=''), deliverytype_id OPTIONS(description=''), dispo_unit_id
OPTIONS(description=''), booking_fg OPTIONS(description=''), blocking_cd OPTIONS(description=''), dsac_nr
OPTIONS(description=''), group_nr OPTIONS(description=''), print_nr OPTIONS(description=''), satas_nr
OPTIONS(description=''), pricegroup_act_price OPTIONS(description=''), stc_location_id OPTIONS(description=''),
stc_slot_area OPTIONS(description=''), stc_slot_id OPTIONS(description=''), pallet_part OPTIONS(description=''),
pallet_part_euro OPTIONS(description=''), pallet_part_tiko OPTIONS(description=''), comment_del OPTIONS(description=''),
status_prot_receipt OPTIONS(description=''), status_dayend OPTIONS(description=''), dur_del OPTIONS(description=''),
price_wh_del OPTIONS(description=''), price_wh_net_del OPTIONS(description=''), price_str_del OPTIONS(description=''),
price_str_net_del OPTIONS(description=''), price_fg OPTIONS(description=''), price_retail_wh OPTIONS(description=''),
price_retail_wh_net OPTIONS(description=''), val_pr_diff_del OPTIONS(description=''), val_pr_diff_net_del
OPTIONS(description=''), qty_case_act OPTIONS(description=''), qty_case_del OPTIONS(description=''), qty_case_order
OPTIONS(description=''), qty_piece_del OPTIONS(description=''), qty_piece_act_del OPTIONS(description=''), supplier_id
OPTIONS(description='gemappte Systemgenierierte ID des Lieferanten (sup_sid_map in Core.v_supplier_map_key_2)'),
orig_receipt_nr_dir_del OPTIONS(description=''), rcv_pos_id OPTIONS(description=''), dat_booking OPTIONS(description=''),
dat_rcv_mdd OPTIONS(description=''), dd_matched_fg OPTIONS(description=''), mdd_user OPTIONS(description=''),
mdd_return_fg OPTIONS(description=''), case_size_real OPTIONS(description=''), currency_iso_cd OPTIONS(description=''),
rate_currency_exchange OPTIONS(description=''), case_size OPTIONS(description=''), wh_id_del OPTIONS(description=''),
byr OPTIONS(description=''), cy_week OPTIONS(description=''), src_fg OPTIONS(description=''))
OPTIONS(DESCRIPTION = `VIEW`) AS ((SELECT A.client_id,
   ITMP.item_sid_map AS item_id,
   A.dwh_cal_dt AS dat_formdate,
   A.receipt_id AS receipt_id_del,
   A.loc_sid_store AS store_id,
   D.src_wh_id AS wh_id,
   A.vat_id,
   A.order_area_cd,
   A.dayend_dt AS dat_dayend,
   A.delivery_type_id AS deliverytype_id,
   A.dispo_unit_id,
   2 AS booking_fg,
   A.blocking_id AS blocking_cd,
   A.dsac_nr,
   A.group_nr,
   A.print_nr,
   A.satas_nr,
   A.pricegroup_act_price_val AS pricegroup_act_price,
   A.stc_location_id,
   A.stc_slot_area_nr AS stc_slot_area,
   A.stc_slot_nr AS stc_slot_id,
   A.pallet_rate AS pallet_part,
   A.euro_pallet_rate AS pallet_part_euro,
   A.frozen_food_pallet_rate AS pallet_part_tiko,
   A.comment_txt AS comment_del,
   A.prot_receipt_status_id AS status_prot_receipt,
   A.dayend_status_id AS status_dayend,
   A.dur_del_cnt AS dur_del,
    A.wh_del_gross_price / CRY.exchange_rate AS price_wh_del,
    A.wh_del_net_price / CRY.exchange_rate AS price_wh_net_del,
    A.store_del_gross_price / CRY.exchange_rate AS price_str_del,
    A.store_del_net_price / CRY.exchange_rate AS price_str_net_del,
   A.price_fg,
    A.wh_retail_gross_price / CRY.exchange_rate AS price_retail_wh,
    A.wh_retail_net_price / CRY.exchange_rate AS price_retail_wh_net,
     ROUND(CAST(IFNULL(A.store_del_gross_price, 0) - IFNULL(A.wh_del_gross_price, 0) AS NUMERIC), 4) * ROUND(CAST((IFNULL(A.del_case_qty, 0) + IFNULL(A.ordered_case_qty, 0)) * COALESCE(A.case_size_dec, CAST(F.src_case_size AS BIGNUMERIC)
          ) + IFNULL(A.del_piece_qty, 0) AS NUMERIC), 4) / CRY.exchange_rate AS val_pr_diff_del,
     CAST(IFNULL(A.store_del_net_price, 0) - IFNULL(A.wh_del_net_price, 0) AS NUMERIC) * ROUND(CAST((IFNULL(A.del_case_qty, 0) + IFNULL(A.ordered_case_qty, 0)) * COALESCE(A.case_size_dec, CAST(F.src_case_size AS BIGNUMERIC)
          ) + IFNULL(A.del_piece_qty, 0) AS NUMERIC), 5) / CRY.exchange_rate AS val_pr_diff_net_del,
   A.act_case_qty AS qty_case_act,
   A.del_case_qty AS qty_case_del,
   A.ordered_case_qty AS qty_case_order,
   A.del_piece_qty AS qty_piece_del,
   A.act_del_piece_qty AS qty_piece_act_del,
   CAST(- 1 AS BIGNUMERIC) AS supplier_id,
   '' AS orig_receipt_nr_dir_del,
   CAST(- 1 AS NUMERIC) AS rcv_pos_id,
   DATE(NULL) AS dat_booking,
   DATE(NULL) AS dat_rcv_mdd,
   CAST(- 1 AS BIGNUMERIC) AS dd_matched_fg,
   '' AS mdd_user,
   CAST(- 1 AS BIGNUMERIC) AS mdd_return_fg,
   CAST(NULL AS NUMERIC) AS case_size_real,
   CRY.curr_cd_from AS currency_iso_cd,
   CRY.exchange_rate AS rate_currency_exchange,
   COALESCE(F2.case_size_dec, ROUND(CAST(F.src_case_size AS NUMERIC), 4)) AS case_size,
   E.src_wh_id AS wh_id_del,
   G.busyear AS byr,
   G.cy_week,
   0 AS src_fg
  FROM ldl_p_lew_core_ac.v_item_delivery_2 AS A
   INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS B ON A.client_id = B.client_id AND A.loc_sid_store = B
     .loc_sid_store
   INNER JOIN ldl_p_lew_core_ac.v_item_group_2 AS C ON B.client_id = C.client_id AND C.src_matkl = '@ALL'
   INNER JOIN ldl_p_lew_core_ac.v_location_2 AS D ON B.client_id = D.client_id AND B.loc_sid_wh = D.loc_sid
   LEFT JOIN ldl_p_lew_core_ac.v_location_2 AS E ON A.client_id = E.client_id AND A.loc_sid_wh = E.loc_sid
   INNER JOIN ldl_p_lew_bil_ac.v_item_2 AS F ON A.client_id = F.client_id AND A.item_sid = F.item_sid
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_2 AS F2 ON A.client_id = F2.client_id AND A.item_sid = F2.item_sid
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS G ON A.dwh_cal_dt = G.cal_dt
   INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CRY ON A.client_id = CRY.client_id AND CURRENT_DATE
       BETWEEN CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
    AND CRY.deleted_fg = 0
   INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS CRZ ON CRY.client_id = CRZ.client_id AND CRY.x_rate_type_sid =
      CRZ.x_rate_type_sid AND CRZ.src_kurst = '@BEWE'
   INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMP ON A.client_id = ITMP.client_id AND A.item_sid
     /* replaced by UNIION to eliminate duplicates: UNION ALL */ = ITMP.item_sid
  UNION DISTINCT
  SELECT A.client_id,
   ITMP.item_sid_map AS item_id,
   A.dwh_cal_dt AS dat_formdate,
   CAST(A.dir_del_id AS STRING) AS dir_del_id,
   A.loc_sid_store AS store_id,
   D.src_wh_id AS wh_id,
   A.vat_id,
   A.order_area_cd,
   A.dayend_dt AS dat_dayend,
   3 AS deliverytype_id,
   A.dispo_unit_id,
   CAST(- 1 AS BIGNUMERIC) AS booking_fg,
   CAST(- 1 AS BIGNUMERIC) AS blocking_cd,
   CAST(- 1 AS BIGNUMERIC) AS dsac_nr,
   CAST(NULL AS INTEGER) AS group_nr,
   CAST(- 1 AS BIGNUMERIC) AS print_nr,
   CAST(- 1 AS BIGNUMERIC) AS satas_nr,
   CAST(A.act_price_item_id AS NUMERIC) AS act_price_item_cd,
   CAST(- 1 AS BIGNUMERIC) AS stc_location_id,
   CAST(- 1 AS BIGNUMERIC) AS stc_slot_area,
   CAST(- 1 AS BIGNUMERIC) AS stc_slot_id,
   CAST(- 1 AS NUMERIC) AS pallet_part,
   CAST(- 1 AS NUMERIC) AS pallet_part_euro,
   CAST(- 1 AS NUMERIC) AS pallet_part_tiko,
   A.comment_txt AS comment_dir_del,
   A.dir_del_status_id AS status_dir_del,
   A.dayend_status_id AS status_dayend,
   CAST(- 1 AS BIGNUMERIC) AS dur_del,
    A.wh_del_gross_price / CRY.exchange_rate AS price_wh_dir_del,
    A.wh_del_net_price / CRY.exchange_rate AS price_wh_net_dir_del,
    A.store_del_gross_price / CRY.exchange_rate AS price_str_dir_del,
    A.store_del_net_price / CRY.exchange_rate AS price_str_net_del,
   CAST(NULL AS BIGNUMERIC) AS price_cd,
    A.wh_act_gross_price / CRY.exchange_rate AS price_act_wh,
    A.wh_act_net_price / CRY.exchange_rate AS price_act_wh_net,
     ROUND(CAST(IFNULL(A.store_del_gross_price, 0) - IFNULL(A.wh_del_gross_price, 0) AS NUMERIC), 4) * ROUND(CAST(IFNULL(A.case_qty, 0) * COALESCE(A.case_size_dec, CAST(F.src_case_size AS BIGNUMERIC)
          ) + IFNULL(A.piece_qty, 0) AS NUMERIC), 4) / CRY.exchange_rate AS val_pr_diff_del,
     CAST(IFNULL(A.store_del_net_price, 0) - IFNULL(A.wh_del_net_price, 0) AS NUMERIC) * ROUND(CAST(IFNULL(A.case_qty, 0) * COALESCE(A.case_size_dec, CAST(F.src_case_size AS BIGNUMERIC)
          ) + IFNULL(A.piece_qty, 0) AS NUMERIC), 5) / CRY.exchange_rate AS val_pr_diff_net_del,
   CAST(NULL AS NUMERIC) AS qty_case_act,
   A.case_qty AS qty_case_dir_del,
   CAST(NULL AS NUMERIC) AS qty_case_order,
   A.piece_qty AS qty_piece_dir_del,
   CAST(NULL AS NUMERIC) AS qty_piece_act_del,
   A.orig_supplier_nr AS supplier_id,
   A.orig_receipt_nr AS orig_receipt_nr_dir_del,
   A.rcv_pos_id,
   DATE(NULL) AS dat_booking,
   A.mdd_rcv_dt AS dat_rcv_mdd,
   A.dd_matched_fg,
   A.mdd_user_name AS mdd_user,
   A.mdd_return_id AS mdd_return_fg,
   CAST(NULL AS NUMERIC) AS case_size_real,
   CRY.curr_cd_from AS currency_iso_cd,
   CRY.exchange_rate AS rate_currency_exchange,
   COALESCE(F2.case_size_dec, ROUND(CAST(F.src_case_size AS NUMERIC), 4)) AS case_size,
   E.src_wh_id AS wh_id_del,
   G.busyear AS byr,
   G.cy_week,
   0 AS src_fg
  FROM ldl_p_lew_core_ac.v_item_direct_delivery_2 AS A
   INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS B ON A.client_id = B.client_id AND A.loc_sid_store = B
     .loc_sid_store
   INNER JOIN ldl_p_lew_core_ac.v_item_group_2 AS C ON B.client_id = C.client_id AND C.src_matkl = '@ALL'
   INNER JOIN ldl_p_lew_core_ac.v_location_2 AS D ON B.client_id = D.client_id AND B.loc_sid_wh = D.loc_sid
   LEFT JOIN ldl_p_lew_core_ac.v_location_2 AS E ON A.client_id = E.client_id AND A.loc_sid_wh = E.loc_sid
   INNER JOIN ldl_p_lew_core_ac.v_item_2 AS F ON A.client_id = F.client_id AND A.item_sid = F.item_sid
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_2 AS F2 ON A.client_id = F2.client_id AND A.item_sid = F2.item_sid
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS G ON A.dwh_cal_dt = G.cal_dt
   INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CRY ON A.client_id = CRY.client_id AND CURRENT_DATE
       BETWEEN CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
    AND CRY.deleted_fg = 0
   INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS CRZ ON CRY.client_id = CRZ.client_id AND CRY.x_rate_type_sid =
      CRZ.x_rate_type_sid AND CRZ.src_kurst = '@BEWE'
   INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMP ON A.client_id = ITMP.client_id AND A.item_sid
     /* replaced by UNIION to eliminate duplicates: UNION ALL */ = ITMP.item_sid)
 UNION DISTINCT
 SELECT A.client_id,
  ITMP.item_sid_map AS item_id,
  A.dwh_cal_dt AS dat_formdate,
  CAST(A.fv_del_id AS STRING) AS fv_del_id,
  A.loc_sid_store AS store_id,
  D.src_wh_id AS wh_id,
  A.vat_id,
  A.order_area_cd,
  A.dayend_dt AS dat_dayend,
  4 AS deliverytype_id,
  CAST(- 1 AS BIGNUMERIC) AS dispo_unit_id,
  2 AS booking_fg,
  CAST(- 1 AS BIGNUMERIC) AS blocking_cd,
  CAST(NULL AS BIGNUMERIC) AS dsac_nr,
  CAST(- 1 AS NUMERIC) AS group_nr,
  CAST(- 1 AS BIGNUMERIC) AS print_nr,
  CAST(NULL AS BIGNUMERIC) AS satas_nr,
  CAST(A.price_grp_id_store AS NUMERIC) AS pricegroup_store,
  A.layer_order_nr /* in neuer Struktur nicht mehr vorhanden, in alter Struktur immer der Wert NULL */,
  CAST(- 1 AS BIGNUMERIC) AS stc_slot_area,
  A.slot_nr,
  CAST(- 1 AS NUMERIC) AS pallet_part,
  CAST(- 1 AS NUMERIC) AS pallet_part_euro,
  CAST(- 1 AS NUMERIC) AS pallet_part_tiko,
  '' AS comment_del,
  CAST(- 1 AS BIGNUMERIC) AS status_prot_receipt,
  CAST(NULL AS BIGNUMERIC) AS status_dayend,
  A.dur_del_cnt AS dur_fv_del,
   A.wh_gross_price / CRY.exchange_rate AS price_wh_fv,
   A.wh_net_price / CRY.exchange_rate AS price_wh_net_fv,
   A.store_gross_price / CRY.exchange_rate AS price_str_fv,
   A.store_net_price / CRY.exchange_rate AS price_str_net_fv,
  CAST(- 1 AS BIGNUMERIC) AS price_fg,
   A.old_retail_gross_price / CRY.exchange_rate AS price_retail_fv_del_old,
   A.old_retail_net_price / CRY.exchange_rate AS price_retail_net_fv_del_old,
  CAST(NULL AS NUMERIC) AS val_pr_diff_del,
  CAST(NULL AS NUMERIC) AS val_pr_diff_net_del,
  CAST(NULL AS NUMERIC) AS qty_case_act,
  A.case_qty AS qty_case_fv_del,
  CAST(NULL AS NUMERIC) AS qty_case_order,
  CAST(NULL AS NUMERIC) AS qty_piece_del,
  CAST(NULL AS NUMERIC) AS qty_piece_act_del,
  CAST(- 1 AS BIGNUMERIC) AS supplier_id,
  '' AS orig_receipt_nr_dir_del,
  CAST(- 1 AS NUMERIC) AS rcv_pos_id,
  DATE(NULL) AS dat_booking,
  DATE(NULL) AS dat_rcv_mdd,
  CAST(- 1 AS BIGNUMERIC) AS dd_matched_fg,
  '' AS mdd_user,
  CAST(- 1 AS BIGNUMERIC) AS mdd_return_fg,
  A.case_size_dec AS case_size_real,
  CRY.curr_cd_from AS currency_iso_cd,
  CRY.exchange_rate AS rate_currency_exchange,
  COALESCE(F2.case_size_dec, ROUND(CAST(F.src_case_size AS NUMERIC), 4)) AS case_size,
  E.src_wh_id AS wh_id_del,
  G.busyear AS byr,
  G.cy_week,
  0 AS src_fg
 FROM ldl_p_lew_core_ac.v_item_fruits_vegetables_delivery_2 AS A
  INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS B ON A.client_id = B.client_id AND A.loc_sid_store = B.loc_sid_store
    
  INNER JOIN ldl_p_lew_core_ac.v_item_group_2 AS C ON B.client_id = C.client_id AND C.src_matkl = '@ALL'
  INNER JOIN ldl_p_lew_core_ac.v_location_2 AS D ON B.client_id = D.client_id AND B.loc_sid_wh = D.loc_sid
  LEFT JOIN ldl_p_lew_core_ac.v_location_2 AS E ON A.client_id = E.client_id AND A.loc_sid_wh = E.loc_sid
  INNER JOIN ldl_p_lew_core_ac.v_item_2 AS F ON A.client_id = F.client_id AND A.item_sid = F.item_sid
  LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_2 AS F2 ON A.client_id = F2.client_id AND A.item_sid = F2.item_sid
  INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS G ON A.dwh_cal_dt = G.cal_dt
  INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CRY ON A.client_id = CRY.client_id AND CURRENT_DATE BETWEEN
      CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to AND CRY.deleted_fg
     = 0
  INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS CRZ ON CRY.client_id = CRZ.client_id AND CRY.x_rate_type_sid =
     CRZ.x_rate_type_sid AND CRZ.src_kurst = '@BEWE'
  INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMP ON A.client_id = ITMP.client_id AND A.item_sid
    /* replaced by UNIION to eliminate duplicates: UNION ALL */ = ITMP.item_sid)
UNION DISTINCT
SELECT CAST(B.client_id AS BIGNUMERIC) AS client_id,
 ITMP.item_sid_map AS item_id,
 B.dwh_cal_dt AS dat_formdate,
 '0' AS receipt_id_del,
 B.loc_sid AS store_id,
 J.src_wh_id AS wh_id,
 COALESCE(D.vat_id, - 2) AS vat_id,
 CAST(NULL AS STRING) AS order_area_cd,
 DATE(B.dwh_created) AS dat_dayend,
 MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) AS deliverytype_id,
 0 AS dispo_unit_id,
 CAST(CASE
   WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
   THEN - 1
   ELSE NULL
   END AS BIGNUMERIC) AS booking_fg,
 CAST(CASE
   WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
   THEN - 1
   ELSE NULL
   END AS BIGNUMERIC) AS blocking_cd,
 CAST(CASE
   WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
   THEN - 1
   ELSE NULL
   END AS BIGNUMERIC) AS dsac_nr,
 CAST(NULL AS NUMERIC) AS group_nr,
 CAST(CASE
   WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
   THEN - 1
   ELSE NULL
   END AS BIGNUMERIC) AS print_nr,
 CAST(CASE
   WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
   THEN - 1
   ELSE NULL
   END AS BIGNUMERIC) AS satas_nr,
 CAST(NULL AS NUMERIC) AS pricegroup_act_price,
 CAST(CASE
   WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
   THEN - 1
   ELSE NULL
   END AS BIGNUMERIC) AS stc_location_id,
 CAST(CASE
   WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
   THEN - 1
   ELSE NULL
   END AS BIGNUMERIC) AS stc_slot_area,
 CAST(CASE
   WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
   THEN - 1
   ELSE NULL
   END AS BIGNUMERIC) AS stc_slot_id,
 CAST(CASE
   WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
   THEN - 1
   ELSE NULL
   END AS NUMERIC) AS pallet_part,
 CAST(CASE
   WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
   THEN - 1
   ELSE NULL
   END AS NUMERIC) AS pallet_part_euro,
 CAST(CASE
   WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
   THEN - 1
   ELSE NULL
   END AS NUMERIC) AS pallet_part_tiko,
 CAST(NULL AS STRING) AS comment_del,
 CAST(CASE
   WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
   THEN 3
   ELSE NULL
   END AS BIGNUMERIC) AS status_prot_receipt,
 3 AS status_dayend,
 CAST(CASE
   WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
   THEN - 1
   ELSE NULL
   END AS BIGNUMERIC) AS dur_del,
  CAST(CASE
    WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
    THEN M.cond_val_eff_calc
    ELSE NULL
    END AS NUMERIC) / CRY.exchange_rate,
  CAST(CASE
    WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
    THEN M.net_val_eff_calc
    ELSE NULL
    END AS NUMERIC) / CRY.exchange_rate,
  CAST(CASE
    WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
    THEN L.cond_val_eff_calc
    ELSE NULL
    END AS NUMERIC) / CRY.exchange_rate,
  CAST(CASE
    WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
    THEN L.net_val_eff_calc
    ELSE NULL
    END AS NUMERIC) / CRY.exchange_rate,
 CAST(NULL AS BIGNUMERIC) AS price_fg,
  CAST(CASE
    WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
    THEN M.cond_val_eff_calc
    ELSE NULL
    END AS NUMERIC) / CRY.exchange_rate,
  CAST(CASE
    WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
    THEN M.net_val_eff_calc
    ELSE NULL
    END AS NUMERIC) / CRY.exchange_rate,
 CAST(NULL AS NUMERIC) AS val_pr_diff_del,
 CAST(NULL AS NUMERIC) AS val_pr_diff_net_del,
 CAST(NULL AS NUMERIC) AS qty_case_act,
 0 AS qty_case_del,
 CAST(CASE
   WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
   THEN NULL
   ELSE 0
   END AS NUMERIC) AS qty_case_order,
 ROUND(CAST(B.ship_qty * COALESCE(C.component_qty, 1) * - 1 AS NUMERIC), 4) AS qty_piece_del,
 CAST(NULL AS NUMERIC) AS qty_piece_act_del,
  CASE
  WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
  THEN SUPMAP.sup_sid_map
  ELSE - 1
  END AS supplier_id,
  CASE
  WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
  THEN CAST(CAST(B.order_record_id AS BIGNUMERIC) AS STRING)
  ELSE ''
  END AS orig_receipt_nr_dir_del,
 CAST(CASE
   WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
   THEN B.order_record_pos_id
   ELSE CAST(- 1 AS BIGNUMERIC)
   END AS BIGNUMERIC) AS rcv_pos_id,
  CASE
  WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
  THEN B.dwh_cal_dt
  ELSE NULL
  END AS dat_booking,
 DATE(NULL) AS dat_rcv_mdd,
 CAST(CASE
   WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
   THEN 0
   ELSE - 1
   END AS BIGNUMERIC) AS dd_matched_fg,
 CAST(CASE
   WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
   THEN NULL
   ELSE ''
   END AS STRING) AS mdd_user,
 CAST(CASE
   WHEN MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) = 3
   THEN 0
   ELSE - 1
   END AS BIGNUMERIC) AS mdd_return_fg,
 CAST(NULL AS NUMERIC) AS case_size_real,
 CRY.curr_cd_from AS currency_iso_cd,
 CRY.exchange_rate AS rate_currency_exchange,
 IUOMH.conv_to_base_numerator AS case_size,
 J.src_wh_id AS wh_id_del,
 S.busyear AS byr,
 S.cy_week,
 1 AS src_fg
FROM ldl_p_lew_core_ac.v_item_movement_record_pos_2 AS B
 LEFT JOIN (SELECT CA.client_id,
   CA.item_sid,
   CA.item_bom_sid
  FROM ldl_p_lew_core_ac.v_item_bom_2 AS CA
   LEFT JOIN ldl_p_lew_core_ac.v_item_bom_2 AS CB ON CA.client_id = CB.client_id AND CA.item_sid = CB.item_sid AND CB.src_werks
        = '@ALL' AND CB.deleted_fg = 0 AND (CA.src_stlnr < CB.src_stlnr OR CA.src_stlnr = CB.src_stlnr AND CA.item_bom_sid
         < CB.item_bom_sid)
  WHERE CA.src_werks = '@ALL'
   AND CA.deleted_fg = 0
   AND CB.client_id IS NULL) AS c0 ON B.client_id = c0.client_id AND B.item_sid = c0.item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_item_bom_pos_hist_2 AS C ON c0.client_id = C.client_id AND c0.item_bom_sid = C.item_bom_sid
      AND CURRENT_DATE BETWEEN C.dwh_valid_from AND C.dwh_valid_to AND C.deleted_fg = 0
 LEFT JOIN ldl_p_lew_bil_ac.v_item_vat_act_2 AS D ON B.client_id = D.client_id AND D.item_sid = COALESCE(C.item_sid, B.item_sid
    )
 INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS E ON B.client_id = E.client_id AND B.item_sid = E.item_sid AND CURRENT_DATE
   BETWEEN E.dwh_valid_from AND E.dwh_valid_to
 LEFT JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS F ON B.client_id = F.client_id AND B.loc_sid_counterparty = F.loc_sid_wh AND
    F.bges_active_fg = 1 /* warehouse ist Betriebsgesellschaft */ AND CURRENT_DATE BETWEEN F.dwh_valid_from AND F.dwh_valid_to
   
 INNER JOIN ldl_p_lew_core_ac.v_location_2 AS G ON B.client_id = G.client_id AND B.loc_sid = G.loc_sid AND G.wh_store_mark
       = 'A' AND G.global_loc_type_cd = '0' /* Bedingung aus p_core_biz.v_s_loc_store */ AND G.global_loc_ctry_cd <>
    'ZV' /* Aehnlich einer Bedingung aus p_core_biz.v_s_loc_store */ AND G.opening_dt IS NOT NULL
 INNER JOIN ldl_p_lew_core_ac.v_location_hist_2 AS H ON B.client_id = H.client_id AND B.loc_sid = H.loc_sid AND (H.test_store_fg
     IS NULL OR H.test_store_fg = 0) AND CURRENT_DATE BETWEEN H.dwh_valid_from AND H.dwh_valid_to
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS I ON B.client_id = I.client_id AND B.loc_sid = I.loc_sid_store
   
 INNER JOIN ldl_p_lew_core_ac.v_item_group_2 AS II ON I.client_id = II.client_id AND II.src_matkl = '@ALL'
 INNER JOIN ldl_p_lew_core_ac.v_location_2 AS J ON I.client_id = J.client_id AND I.loc_sid_wh = J.loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_item_2 AS KA ON B.client_id = KA.client_id AND KA.item_sid = COALESCE(C.item_sid, B.item_sid
    )
 LEFT JOIN ldl_p_lew_core_ac.v_item_unit_of_measurement_2 AS IUOM ON KA.client_id = IUOM.client_id AND KA.item_sid = IUOM
    .item_sid AND KA.log_var_cd = IUOM.log_var_cd
 LEFT JOIN ldl_p_lew_core_ac.v_item_unit_of_measurement_hist_2 AS IUOMH ON IUOM.client_id = IUOMH.client_id AND IUOM.item_sid
      = IUOMH.item_sid AND IUOM.uom_sid = IUOMH.uom_sid AND CURRENT_DATE BETWEEN IUOMH.dwh_valid_from AND IUOMH.dwh_valid_to
   
 INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS K ON KA.client_id = K.client_id AND KA.item_sid = K.item_sid AND
   CURRENT_DATE BETWEEN K.dwh_valid_from AND K.dwh_valid_to
 LEFT JOIN ldl_p_lew_bil_ac.v_item_loc_sales_cond_denorm_2 AS L ON K.client_id = L.client_id AND K.item_sid = L.item_sid
    AND K.uom_sid_base = L.uom_sid_cond AND B.loc_sid = L.loc_sid AND B.dwh_cal_dt BETWEEN L.dwh_valid_from AND L.dwh_valid_to
   
 LEFT JOIN ldl_p_lew_bil_ac.v_item_loc_sales_cond_denorm_2 AS M ON K.client_id = M.client_id AND K.item_sid = M.item_sid
    AND K.uom_sid_base = M.uom_sid_cond AND I.loc_sid_wh = M.loc_sid AND B.dwh_cal_dt BETWEEN M.dwh_valid_from AND M.dwh_valid_to
   
 INNER JOIN ldl_p_lew_core_ac.v_order_record_2 AS P ON B.client_id = P.client_id AND B.order_record_id = P.order_record_id
   
 INNER JOIN ldl_p_lew_core_ac.v_map_mis_move_type_deliv_2 AS Q ON P.client_id = Q.client_id AND P.order_type_cd = Q.order_type_cd
     AND B.move_type_cd = Q.move_type_cd
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS S ON B.dwh_cal_dt = S.cal_dt
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CRY ON B.client_id = CRY.client_id AND CURRENT_DATE BETWEEN
     CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to AND CRY.deleted_fg
    = 0
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS CRZ ON CRY.client_id = CRZ.client_id AND CRY.x_rate_type_sid = CRZ
    .x_rate_type_sid AND CRZ.src_kurst = '@BEWE' /* Zu ignorierende Artikelarten */
 LEFT JOIN ldl_p_lew_process_ac.v_item_type_ignore_2 AS ITI ON E.client_id = ITI.client_id AND E.item_type_sid = ITI.item_type_sid
      AND (ITI.client_id IN (33, 34) AND ITI.item_type_cd NOT IN ('ZKM', 'ZVM') OR ITI.client_id NOT IN (33, 34)) AND
   ITI.item_type_grp_cd = 'ANL'
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMP ON B.client_id = ITMP.client_id AND ITMP.item_sid = COALESCE(B.item_sid
    , C.item_sid)
 INNER JOIN ldl_p_lew_core_ac.v_supplier_map_key_2 AS SUPMAP ON B.client_id = SUPMAP.client_id AND B.sup_sid = SUPMAP.sup_sid
   
WHERE CASE
   WHEN Q.mis_deliv_type_id / 10 = 1 AND F.client_id IS NULL
   THEN 0
   ELSE 1
   END = 1
 AND ITI.item_type_cd IS NULL;