/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MOV_ITEM_DELIVERY_2
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
#  1.8  17.01.2018    Murtenthaler.Martin      WAWI-Item_2 if possible
#  1.9  31.01.2018    Wieber.Harald            Release 2.3
# 1.10  04.04.2018    Arnold.Arne              Umstellung auf V_STORE_TO_WAREHOUSE_LASTKNOWN_2
# 1.11  19.04.2018    Knopp,Timo               Adaptation after changing core tables map_mis_mov_type(_deliv) to map_mis_movE_type(_deliv)
# 1.12  12.06.2018    Meister,Ulrich           Konsolidierung der Aenderungen
# 1.13  24.07.2018    Michael Ueding           Referenz Item_2 Mapping geaendert
# 1.14  11.12.2019    Michael Ueding           Ersetzen Legacy mit Core Objekt 
# 1.15  13.01.2020    Ulrich Meister           changed to replace n_-View approach, Patch 20191218_2333_MCD_mart_views_WH_MOVE_DWH20 IDMO-2570, DWH-7995
# 1.16  22.02.2021    Prasanna Ranjan          REP2-9080 - Include item_2 types ZKM and ZVM from USA and Serbia 
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MOV_ITEM_DELIVERY_2 COMMENT = ''
(
  client_id               COMMENT ''
  ,item_id                COMMENT ''
  ,dat_formdate           COMMENT ''
  ,receipt_id_del         COMMENT ''
  ,store_id               COMMENT ''
  ,wh_id                  COMMENT ''
  ,vat_id                 COMMENT ''
  ,order_area_cd          COMMENT ''
  ,dat_dayend             COMMENT ''
  ,deliverytype_id        COMMENT ''
  ,dispo_unit_id          COMMENT ''
  ,booking_fg             COMMENT ''
  ,blocking_cd            COMMENT ''
  ,dsac_nr                COMMENT ''
  ,group_nr               COMMENT ''
  ,print_nr               COMMENT ''
  ,satas_nr               COMMENT ''
  ,pricegroup_act_price   COMMENT ''
  ,stc_location_id        COMMENT ''
  ,stc_slot_area          COMMENT ''
  ,stc_slot_id            COMMENT ''
  ,pallet_part            COMMENT ''
  ,pallet_part_euro       COMMENT ''
  ,pallet_part_tiko       COMMENT ''
  ,comment_del            COMMENT ''
  ,status_prot_receipt    COMMENT ''
  ,status_dayend          COMMENT ''
  ,dur_del                COMMENT ''
  ,price_wh_del           COMMENT ''
  ,price_wh_net_del       COMMENT ''
  ,price_str_del          COMMENT ''
  ,price_str_net_del      COMMENT ''
  ,price_fg               COMMENT ''
  ,price_retail_wh        COMMENT ''
  ,price_retail_wh_net    COMMENT ''
  ,qty_case_act           COMMENT ''
  ,qty_case_del           COMMENT ''
  ,qty_case_order         COMMENT ''
  ,qty_piece_del          COMMENT ''
  ,qty_piece_act_del      COMMENT ''
  ,case_size_dec          COMMENT ''
  ,weight                 COMMENT ''
  ,currency_iso_cd        COMMENT ''
  ,wh_id_del              COMMENT ''
)

AS

SELECT
   a.client_id
  ,itmp.item_sid_map AS item_id
  ,a.dwh_cal_dt AS dat_formdate
  ,a.receipt_id AS receipt_id_del
  ,a.loc_sid_store                AS store_id
  ,d.src_wh_id                 AS wh_id
  ,a.vat_id
  ,a.order_area_cd
  ,a.dayend_dt AS dat_dayend
  ,a.delivery_type_id AS deliverytype_id
  ,a.dispo_unit_id
  ,Cast(2 AS SMALLINT) AS booking_fg /* in neuer STruktur nicht mehr vorhanden, in alter Struktur immer mit Wert 2*/
  ,a.blocking_id AS blocking_cd
  ,Cast(NULL AS INTEGER) AS dsac_nr /* in neuer STruktur nicht mehr vorhanden*/
  ,a.group_nr
  ,a.print_nr
  ,a.satas_nr
  ,a.pricegroup_act_price_val AS pricegroup_act_price
  ,a.stc_location_id
  ,a.stc_slot_area_nr AS stc_slot_area
  ,a.stc_slot_nr AS stc_slot_id
  ,a.pallet_rate AS pallet_part
  ,to_number(NULL,18,4) AS pallet_part_euro /* in neuer STruktur nicht mehr vorhanden*/
  ,to_number(NULL,18,4) AS pallet_part_tiko /* in neuer STruktur nicht mehr vorhanden*/
  ,a.comment_txt AS comment_del
  ,a.prot_receipt_status_id AS status_prot_receipt
  ,Cast(0 AS SMALLINT) AS status_dayend /* in neuer STruktur nicht mehr vorhanden, in alter Struktur ueberwiegend mit Wert 0*/
  ,a.dur_del_cnt AS dur_del
  ,a.wh_del_net_price / cry.exchange_rate        AS price_wh_del
  ,a.wh_del_gross_price / cry.exchange_rate    AS price_wh_net_del
  ,a.store_del_net_price / cry.exchange_rate       AS price_str_del
  ,a.store_del_gross_price / cry.exchange_rate   AS price_str_net_del
  ,a.price_fg
  ,a.wh_retail_net_price  / cry.exchange_rate    AS price_retail_wh
  ,a.wh_retail_gross_price / cry.exchange_rate AS price_retail_wh_net
  ,a.act_case_qty AS qty_case_act
  ,a.del_case_qty AS qty_case_del
  ,a.ordered_case_qty AS qty_case_order
  ,a.del_piece_qty AS qty_piece_del
  ,a.act_del_piece_qty AS qty_piece_act_del
  ,a.case_size_dec
  ,a.weight_qty AS weight
  ,cry.curr_cd_from                          AS currency_iso_cd
  ,e.src_wh_id                               AS wh_id_del
FROM P_LEW_CORE_AC.v_item_delivery_2 AS a

INNER JOIN P_LEW_BIL_AC.v_store_to_warehouse_lastknown_2 AS b
ON b.client_id = a.client_id
  AND b.loc_sid_store = a.loc_sid_store

INNER JOIN P_LEW_CORE_AC.v_item_group_2 AS c
ON c.client_id = b.client_id
  AND c.src_matkl='@ALL'

INNER JOIN  P_LEW_CORE_AC.v_location_2 AS d
ON d.client_id = b.client_id
  AND d.loc_sid = b.loc_sid_wh

LEFT JOIN  P_LEW_CORE_AC.v_location_2 AS e
ON e.client_id = a.client_id
  AND e.loc_sid = a.loc_sid_wh

INNER JOIN P_LEW_CORE_AC.v_exchange_rate_known_hist_2 AS cry
ON cry.client_id = a.client_id
  AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
  AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
  AND cry.deleted_fg = 0

INNER JOIN P_LEW_CORE_AC.v_exchange_rate_type_2 AS crz
ON crz.client_id = cry.client_id
  AND crz.x_rate_type_sid = cry.x_rate_type_sid
  AND crz.src_kurst = '@BEWE'

INNER JOIN P_LEW_CORE_AC.v_item_map_key_2 itmp
ON itmp.client_id = a.client_id
  AND itmp.item_sid = a.item_sid

UNION /*UNION ALL has been replaced by UNION to avoid duplicates at all as in coex_view*/
 
SELECT
   Cast(b.client_id AS SMALLINT) AS client_id
  ,itmp.item_sid_map AS item_id
  ,b.dwh_cal_dt AS dwh_cal_dt
  ,Cast(0 AS VARCHAR(20)) AS receipt_id
  ,b.loc_sid AS store_id
  ,j.src_wh_id  AS wh_id
  ,Coalesce(d.vat_id, -2) AS vat_id
  ,Cast(NULL AS VARCHAR(5)) AS order_area_cd
  ,Cast(b.dwh_created AS DATE) AS dayend_dt
  ,MOD(q.mis_deliv_type_id, 10) AS delivery_type_id
  ,Cast(0 AS INTEGER) AS dispo_unit_id
  ,Cast(NULL AS SMALLINT) AS booking_fg
  ,Cast(NULL AS SMALLINT) AS blocking_id
  ,Cast(NULL AS INTEGER) AS dsac_nr
  ,to_number(NULL,18,0) AS group_nr
  ,Cast(NULL AS SMALLINT) AS print_nr
  ,Cast(NULL AS INTEGER) AS satas_nr
  ,to_number(NULL,18,4) AS pricegroup_act_price_val
  ,Cast(NULL AS SMALLINT) AS stc_location_id
  ,Cast(NULL AS INTEGER) AS stc_slot_area_nr
  ,Cast(NULL AS INTEGER) AS stc_slot_nr
  ,to_number(NULL,18,4) AS pallet_part
  ,to_number(NULL,18,4) AS pallet_part_euro
  ,to_number(NULL,18,4) AS pallet_part_tiko
  ,Cast(NULL AS VARCHAR(50)) AS comment_txt
  ,Cast(NULL AS SMALLINT) AS prot_receipt_status_id
  ,Cast(3 AS SMALLINT) AS dayend_status_id
  ,Cast(NULL AS INTEGER) AS dur_del_cnt
  ,to_number(NULL,18,4) AS wh_del_net_price
  ,to_number(NULL,19,5) AS wh_del_gross_price
  ,to_number(NULL,18,4) AS store_del_net_price
  ,to_number(NULL,19,5) AS store_del_gross_price
  ,Cast(NULL AS SMALLINT) AS price_fg
  ,to_number(NULL,18,4) AS wh_retail_net_price
  ,to_number(NULL,19,5) AS price_act_wh_net
  ,to_number(NULL,18,4) AS act_case_qty
  ,to_number(0,18,4) AS del_case_qty
  ,to_number(0,18,4) AS ordered_case_qty
  ,to_number(b.ship_qty * Coalesce(c.component_qty, 1) * (-1),18,4) AS del_piece_qty
  ,to_number(NULL,18,4) AS act_del_piece_qty
  ,to_number
   (
     CASE WHEN (b.capt_qty * Coalesce(c.component_qty, 1)) <> 0
          THEN ((b.ship_qty * Coalesce(c.component_qty, 1))/(b.capt_qty * Coalesce(c.component_qty, 1))) 
          ELSE 0
     END 
     ,9,4
   ) AS case_size_dec
  ,to_number(NULL,18,5) AS weight_qty
  ,cry.curr_cd_from AS currency_iso_cd
  ,Cast(-2147483647 AS INTEGER) AS wh_id_del
FROM P_LEW_CORE_AC.v_item_movement_record_pos_2 AS b

LEFT JOIN
(
  SELECT
     ca.client_id
    ,ca.item_sid
    ,ca.item_bom_sid
  FROM P_LEW_CORE_AC.v_item_bom_2 AS ca
  
  LEFT JOIN  P_LEW_CORE_AC.v_item_bom_2 AS cb
  ON cb.client_id = ca.client_id
    AND cb.item_sid = ca.item_sid
    AND cb.src_werks = '@ALL'
    AND cb.deleted_fg = 0
    AND (cb.src_stlnr > ca.src_stlnr OR (cb.src_stlnr = ca.src_stlnr AND cb.item_bom_sid > ca.item_bom_sid))
  
  WHERE ca.src_werks = '@ALL'
    AND ca.deleted_fg = 0
    AND cb.client_id IS NULL
) c0
ON c0.client_id = b.client_id
AND c0.item_sid=b.item_sid

LEFT JOIN P_LEW_CORE_AC.v_item_bom_pos_hist_2 AS c
ON c.client_id = c0.client_id
  AND c.item_bom_sid = c0.item_bom_sid
  AND CURRENT_DATE BETWEEN c.dwh_valid_from AND c.dwh_valid_to
  AND c.deleted_fg = 0

LEFT JOIN P_LEW_BIL_AC.v_item_vat_act_2 AS d
ON d.client_id = b.client_id
  AND d.item_sid = Coalesce(c.item_sid, b.item_sid) 

LEFT JOIN P_LEW_BIL_AC.v_warehouse_2 AS f 
ON f.client_id = b.client_id
  AND f.loc_sid_wh = b.loc_sid_counterparty
  AND f.bges_active_fg = 1 /*warehouse ist Betriebsgesellschaft*/
  AND CURRENT_DATE BETWEEN f.dwh_valid_from AND f.dwh_valid_to

INNER JOIN P_LEW_CORE_AC.v_location_2 AS g
ON g.client_id = b.client_id
  AND g.loc_sid=b.loc_sid
  AND g.wh_store_mark='A'
  AND g.global_loc_type_cd = '0'  /* Bedingung aus p_core_biz.v_s_loc_store */
  AND g.global_loc_ctry_cd <> 'ZV'      /* Aehnlich einer Bedingung aus p_core_biz.v_s_loc_store */     
  AND g.opening_dt IS NOT NULL

INNER JOIN P_LEW_CORE_AC.v_location_hist_2 AS h
ON h.client_id = b.client_id
  AND h.loc_sid=b.loc_sid
  AND (h.test_store_fg = 0 OR h.test_store_fg IS NULL)
  AND CURRENT_DATE BETWEEN h.dwh_valid_from AND h.dwh_valid_to

INNER JOIN P_LEW_BIL_AC.v_store_to_warehouse_lastknown_2 AS i
ON i.client_id = b.client_id
  AND i.loc_sid_store = b.loc_sid

INNER JOIN P_LEW_CORE_AC.v_item_group_2 AS ii
ON ii.client_id = i.client_id
  AND ii.src_matkl='@ALL'

INNER JOIN  P_LEW_CORE_AC.v_location_2 AS j
ON j.client_id = i.client_id
  AND j.loc_sid = i.loc_sid_wh

INNER JOIN P_LEW_CORE_AC.v_order_record_2 AS p
ON p.client_id = b.client_id
  AND p.order_record_id=b.order_record_id

INNER JOIN P_LEW_CORE_AC.v_map_mis_move_type_deliv_2 AS q
ON q.client_id = p.client_id
  AND q.order_type_cd = p.order_type_cd
  AND q.move_type_cd = b.move_type_cd

INNER JOIN P_LEW_CORE_AC.v_exchange_rate_known_hist_2 AS cry
ON cry.client_id = b.client_id
  AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
  AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to 
  AND cry.deleted_fg = 0

INNER JOIN P_LEW_CORE_AC.v_exchange_rate_type_2 AS crz
ON crz.client_id = cry.client_id
  AND crz.x_rate_type_sid = cry.x_rate_type_sid
  AND crz.src_kurst = '@BEWE'

INNER JOIN P_LEW_CORE_AC.v_item_hist_2 AS ih
ON b.client_id = ih.client_id 
  AND Coalesce(c.item_sid, b.item_sid) =ih.item_sid 
  AND CURRENT_DATE BETWEEN ih.dwh_valid_from AND ih.dwh_valid_to

/* Zu ignorierende Artikelarten */
LEFT OUTER JOIN P_LEW_PROCESS_AC.v_item_type_ignore_2 AS iti
ON iti.client_id = ih.client_id 
  AND iti.item_type_sid = ih.item_type_sid
  AND 
      (
        (
         iti.client_id IN (33, 34) 
         AND iti.item_type_cd  NOT IN ('ZKM', 'ZVM')
        )
        OR iti.client_id NOT IN (33, 34)
      ) 
  AND iti.item_type_grp_cd = 'ANL'
 
INNER JOIN P_LEW_CORE_AC.v_item_map_key_2 itmp
ON itmp.client_id = b.client_id
  AND itmp.item_sid = Coalesce(c.item_sid, b.item_sid)

WHERE 
  CASE WHEN (q.mis_deliv_type_id / 10) = 1 AND f.client_id IS NULL /* Auswertung 10er-Stelle (Resultat Division ist Integer ungerundet)*/
       THEN 0
       ELSE 1
  END = 1
  AND MOD(q.mis_deliv_type_id, 10) IN (1,2)
  AND iti.item_type_cd IS NULL /* Ungefilterte Artikelarten */
;
