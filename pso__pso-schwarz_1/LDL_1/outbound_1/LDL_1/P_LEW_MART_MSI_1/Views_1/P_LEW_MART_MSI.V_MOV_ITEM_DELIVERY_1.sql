/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MOV_ITEM_DELIVERY_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  25.09.2017    Martin Murtenthaler neue Version 
#  1.2  24.10.2017    Meister.Ulrich Anpassungen Filterung und vat_id-Generierung 
#  1.3  26.10.2017    Meister.Ulrich UNION ALL has been replaced by UNION to avoid duplicates at all as in coex_view 
#  1.4  08.11.2017    Meister.Ulrich filtering on mis_deliv_type_id included 
#  1.5  09.11.2017    Meister.Ulrich Bestimmung Betriebsgesellschaften angepasst 
#  1.6  09.11.2017    Meister.Ulrich Bestimmung zugeordnete Betriebsgesellschaft angepasst 
#  1.7  15.11.2017    Wieber.Harald            Release 1.1
#  1.8  17.01.2018    Murtenthaler.Martin      WAWI-Item_1 if possible
#  1.9  31.01.2018    Wieber.Harald            Release 2.3
# 1.10  04.04.2018    Arnold.Arne              Umstellung auf V_STORE_TO_WAREHOUSE_LASTKNOWN_1
# 1.11  19.04.2018    Knopp,Timo               Adaptation after changing core tables map_mis_mov_type(_deliv) to map_mis_movE_type(_deliv)
# 1.12  12.06.2018    Meister,Ulrich           Konsolidierung der Aenderungen
# 1.13  24.07.2018    Michael Ueding           Referenz Item_1 Mapping geaendert
# 1.14  11.12.2019    Michael Ueding           Ersetzen Legacy mit Core Objekt 
# 1.15  13.01.2020    Ulrich Meister           changed to replace n_-View approach, Patch 20191218_2333_MCD_mart_views_WH_MOVE_DWH20 IDMO-2570, DWH-7995
# 1.16  22.02.2021    Prasanna Ranjan          REP2-9080 - Include item_1 types ZKM and ZVM from USA and Serbia 
#----------------------------------------------------------------------------
*/


/* in neuer STruktur nicht mehr vorhanden */ /* in neuer STruktur nicht mehr vorhanden */
/* Ungefilterte Artikelarten */ /* in neuer STruktur nicht mehr vorhanden, in alter Struktur immer mit Wert 2 */
/* Auswertung 10er-Stelle (Resultat Division ist Integer ungerundet) */ /* in neuer STruktur nicht mehr vorhanden */
/* in neuer STruktur nicht mehr vorhanden, in alter Struktur ueberwiegend mit Wert 0 */
/* UNION ALL has been replaced by UNION to avoid duplicates at all as in coex_view */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mov_item_delivery_1 (client_id, item_id, dat_formdate, receipt_id_del,
store_id, wh_id, vat_id, order_area_cd, dat_dayend, deliverytype_id, dispo_unit_id, booking_fg, blocking_cd, dsac_nr,
group_nr, print_nr, satas_nr, pricegroup_act_price, stc_location_id, stc_slot_area, stc_slot_id, pallet_part,
pallet_part_euro, pallet_part_tiko, comment_del, status_prot_receipt, status_dayend, dur_del, price_wh_del,
price_wh_net_del, price_str_del, price_str_net_del, price_fg, price_retail_wh, price_retail_wh_net, qty_case_act,
qty_case_del, qty_case_order, qty_piece_del, qty_piece_act_del, case_size_dec, weight, currency_iso_cd, wh_id_del) AS
SELECT A.client_id,
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
 CAST(NULL AS BIGNUMERIC) AS dsac_nr,
 A.group_nr,
 A.print_nr,
 A.satas_nr,
 A.pricegroup_act_price_val AS pricegroup_act_price,
 A.stc_location_id,
 A.stc_slot_area_nr AS stc_slot_area,
 A.stc_slot_nr AS stc_slot_id,
 A.pallet_rate AS pallet_part,
 CAST(NULL AS NUMERIC) AS pallet_part_euro,
 CAST(NULL AS NUMERIC) AS pallet_part_tiko,
 A.comment_txt AS comment_del,
 A.prot_receipt_status_id AS status_prot_receipt,
 0 AS status_dayend,
 A.dur_del_cnt AS dur_del,
  A.wh_del_net_price / CRY.exchange_rate AS price_wh_del,
  A.wh_del_gross_price / CRY.exchange_rate AS price_wh_net_del,
  A.store_del_net_price / CRY.exchange_rate AS price_str_del,
  A.store_del_gross_price / CRY.exchange_rate AS price_str_net_del,
 A.price_fg,
  A.wh_retail_net_price / CRY.exchange_rate AS price_retail_wh,
  A.wh_retail_gross_price / CRY.exchange_rate AS price_retail_wh_net,
 A.act_case_qty AS qty_case_act,
 A.del_case_qty AS qty_case_del,
 A.ordered_case_qty AS qty_case_order,
 A.del_piece_qty AS qty_piece_del,
 A.act_del_piece_qty AS qty_piece_act_del,
 A.case_size_dec,
 A.weight_qty AS weight,
 CRY.curr_cd_from AS currency_iso_cd,
 E.src_wh_id AS wh_id_del
FROM ldl_p_lew_core_ac.v_item_delivery_1 AS A
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
UNION DISTINCT
SELECT CAST(B.client_id AS BIGNUMERIC) AS client_id,
 ITMP.item_sid_map AS item_id,
 B.dwh_cal_dt,
 '0' AS receipt_id,
 B.loc_sid AS store_id,
 J.src_wh_id AS wh_id,
 COALESCE(D.vat_id, - 2) AS vat_id,
 CAST(NULL AS STRING) AS order_area_cd,
 DATE(B.dwh_created) AS dayend_dt,
 MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) AS delivery_type_id,
 0 AS dispo_unit_id,
 CAST(NULL AS BIGNUMERIC) AS booking_fg,
 CAST(NULL AS BIGNUMERIC) AS blocking_id,
 CAST(NULL AS BIGNUMERIC) AS dsac_nr,
 CAST(NULL AS NUMERIC) AS group_nr,
 CAST(NULL AS BIGNUMERIC) AS print_nr,
 CAST(NULL AS BIGNUMERIC) AS satas_nr,
 CAST(NULL AS NUMERIC) AS pricegroup_act_price_val,
 CAST(NULL AS BIGNUMERIC) AS stc_location_id,
 CAST(NULL AS BIGNUMERIC) AS stc_slot_area_nr,
 CAST(NULL AS BIGNUMERIC) AS stc_slot_nr,
 CAST(NULL AS NUMERIC) AS pallet_part,
 CAST(NULL AS NUMERIC) AS pallet_part_euro,
 CAST(NULL AS NUMERIC) AS pallet_part_tiko,
 CAST(NULL AS STRING) AS comment_txt,
 CAST(NULL AS BIGNUMERIC) AS prot_receipt_status_id,
 3 AS dayend_status_id,
 CAST(NULL AS BIGNUMERIC) AS dur_del_cnt,
 CAST(NULL AS NUMERIC) AS wh_del_net_price,
 CAST(NULL AS NUMERIC) AS wh_del_gross_price,
 CAST(NULL AS NUMERIC) AS store_del_net_price,
 CAST(NULL AS NUMERIC) AS store_del_gross_price,
 CAST(NULL AS BIGNUMERIC) AS price_fg,
 CAST(NULL AS NUMERIC) AS wh_retail_net_price,
 CAST(NULL AS NUMERIC) AS price_act_wh_net,
 CAST(NULL AS NUMERIC) AS act_case_qty,
 0 AS del_case_qty,
 0 AS ordered_case_qty,
 ROUND(CAST(B.ship_qty * COALESCE(C.component_qty, 1) * - 1 AS NUMERIC), 4) AS del_piece_qty,
 CAST(NULL AS NUMERIC) AS act_del_piece_qty,
 CAST(CASE
   WHEN B.capt_qty * COALESCE(C.component_qty, 1) <> 0
   THEN B.ship_qty * COALESCE(C.component_qty, 1) / (B.capt_qty * COALESCE(C.component_qty, 1))
   ELSE 0
   END AS NUMERIC) AS case_size_dec,
 CAST(NULL AS NUMERIC) AS weight_qty,
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
 INNER JOIN ldl_p_lew_core_ac.v_order_record_1 AS P ON B.client_id = P.client_id AND B.order_record_id = P.order_record_id
   
 INNER JOIN ldl_p_lew_core_ac.v_map_mis_move_type_deliv_1 AS Q ON P.client_id = Q.client_id AND P.order_type_cd = Q.order_type_cd
     AND B.move_type_cd = Q.move_type_cd
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS CRY ON B.client_id = CRY.client_id AND CURRENT_DATE BETWEEN
     CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to AND CRY.deleted_fg
    = 0
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS CRZ ON CRY.client_id = CRZ.client_id AND CRY.x_rate_type_sid = CRZ
    .x_rate_type_sid AND CRZ.src_kurst = '@BEWE'
 INNER JOIN ldl_p_lew_core_ac.v_item_hist_1 AS IH ON B.client_id = IH.client_id AND COALESCE(C.item_sid, B.item_sid) = IH
    .item_sid AND CURRENT_DATE BETWEEN IH.dwh_valid_from AND IH.dwh_valid_to /* Zu ignorierende Artikelarten */
 LEFT JOIN ldl_p_lew_process_ac.v_item_type_ignore_1 AS ITI ON IH.client_id = ITI.client_id AND IH.item_type_sid = ITI.item_type_sid
      AND (ITI.client_id IN (33, 34) AND ITI.item_type_cd NOT IN ('ZKM', 'ZVM') OR ITI.client_id NOT IN (33, 34)) AND
   ITI.item_type_grp_cd = 'ANL'
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS ITMP ON B.client_id = ITMP.client_id AND ITMP.item_sid = COALESCE(C.item_sid
    , B.item_sid)
WHERE CASE
   WHEN Q.mis_deliv_type_id / 10 = 1 AND F.client_id IS NULL
   THEN 0
   ELSE 1
   END = 1
 AND MOD(CAST(Q.mis_deliv_type_id AS BIGNUMERIC), 10) IN (1, 2)
 AND ITI.item_type_cd IS NULL;