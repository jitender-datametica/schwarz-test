/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MOV_ITEM_DELIVERY_ALL
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
#  1.8  17.01.2018    Murtenthaler.Martin      WAWI-Item if possible
#  1.9  31.01.2018    Wieber,Harald            Release 2.3
# 1.10  04.04.2018    Arnold,Arne              Umstellung auf V_STORE_TO_WAREHOUSE_LASTKNOWN
# 1.11  07.05.2018    Knopp,Timo               Umstellung auf lew_core_ac.v_map_mis_move_type_deliv
# 1.12  13.06.2018    Meister,Ulrich           Konsolidierung der Aenderungen
# 1.13  24.07.2018    Michael Ueding           Referenz Item Mapping geaendert
# 1.14  16.12.2019    Michael Ueding           Ersetzen Legacy mit Core Objekt 
# 1.15  13.01.2020    Ulrich Meister           changed to replace n_-View approach, Patch 20191218_2333_MCD_mart_views_WH_MOVE_DWH20 IDMO-2570, DWH-7995
# 1.16  09.11.2020    Torsten Bachmann         join to v_supplier_map_key added
#                                              PatchNo: 2652, REP3-7579
# 1.17  22.02.2021    Prasanna Ranjan          REP2-9080 - Include item types ZKM and ZVM from USA and Serbia 
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MOV_ITEM_DELIVERY_ALL COMMENT = 'View'
(
 client_id                   COMMENT ''
 ,item_id                    COMMENT ''
 ,dat_formdate               COMMENT ''
 ,receipt_id_del             COMMENT ''
 ,store_id                   COMMENT ''
 ,wh_id                      COMMENT ''
 ,vat_id                     COMMENT ''
 ,order_area_cd              COMMENT ''
 ,dat_dayend                 COMMENT ''
 ,deliverytype_id            COMMENT ''
 ,dispo_unit_id              COMMENT ''
 ,booking_fg                 COMMENT ''
 ,blocking_cd                COMMENT ''
 ,dsac_nr                    COMMENT ''
 ,group_nr                   COMMENT ''
 ,print_nr                   COMMENT ''
 ,satas_nr                   COMMENT ''
 ,pricegroup_act_price       COMMENT ''
 ,stc_location_id            COMMENT ''
 ,stc_slot_area              COMMENT ''
 ,stc_slot_id                COMMENT ''
 ,pallet_part                COMMENT ''
 ,pallet_part_euro           COMMENT ''
 ,pallet_part_tiko           COMMENT ''
 ,comment_del                COMMENT ''
 ,status_prot_receipt        COMMENT ''
 ,status_dayend              COMMENT ''
 ,dur_del                    COMMENT ''
 ,price_wh_del               COMMENT ''
 ,price_wh_net_del           COMMENT ''
 ,price_str_del              COMMENT ''
 ,price_str_net_del          COMMENT ''
 ,price_fg                   COMMENT ''
 ,price_retail_wh            COMMENT ''
 ,price_retail_wh_net        COMMENT ''
 ,val_pr_diff_del            COMMENT ''
 ,val_pr_diff_net_del        COMMENT ''
 ,qty_case_act               COMMENT ''
 ,qty_case_del               COMMENT ''
 ,qty_case_order             COMMENT ''
 ,qty_piece_del              COMMENT ''
 ,qty_piece_act_del          COMMENT ''
 ,supplier_id                COMMENT 'gemappte Systemgenierierte ID des Lieferanten (sup_sid_map in Core.v_supplier_map_key)'
 ,orig_receipt_nr_dir_del    COMMENT ''
 ,rcv_pos_id                 COMMENT ''
 ,dat_booking                COMMENT ''
 ,dat_rcv_mdd                COMMENT ''
 ,dd_matched_fg              COMMENT ''
 ,mdd_user                   COMMENT ''
 ,mdd_return_fg              COMMENT ''
 ,case_size_real             COMMENT ''
 ,currency_iso_cd            COMMENT ''
 ,rate_currency_exchange     COMMENT ''
 ,case_size                  COMMENT ''
 ,wh_id_del                  COMMENT ''
 ,byr                        COMMENT ''
 ,cy_week                    COMMENT ''
 ,src_fg                     COMMENT ''

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
 ,2 AS booking_fg /* in neuer STruktur nicht mehr vorhanden, in alter Struktur immer mit Wert 2*/
 ,a.blocking_id AS blocking_cd
 ,a.dsac_nr
 ,a.group_nr
 ,a.print_nr
 ,a.satas_nr
 ,a.pricegroup_act_price_val AS pricegroup_act_price
 ,a.stc_location_id
 ,a.stc_slot_area_nr AS stc_slot_area
 ,a.stc_slot_nr AS stc_slot_id
 ,a.pallet_rate AS pallet_part
 ,a.euro_pallet_rate AS pallet_part_euro
 ,a.frozen_food_pallet_rate AS pallet_part_tiko
 ,a.comment_txt AS comment_del
 ,a.prot_receipt_status_id AS status_prot_receipt
 ,a.dayend_status_id AS status_dayend
 ,a.dur_del_cnt AS dur_del
 ,a.wh_del_gross_price / cry.exchange_rate        AS price_wh_del
 ,a.wh_del_net_price / cry.exchange_rate    AS price_wh_net_del
 ,a.store_del_gross_price / cry.exchange_rate       AS price_str_del
 ,a.store_del_net_price / cry.exchange_rate   AS price_str_net_del
 ,a.price_fg
 ,a.wh_retail_gross_price / cry.exchange_rate     AS price_retail_wh
 ,a.wh_retail_net_price / cry.exchange_rate AS price_retail_wh_net
 ,(to_number((ZeroIfNull(a.store_del_gross_price)-ZeroIfNull(a.wh_del_gross_price)),18,4)
  *to_number((((ZeroIfNull(a.del_case_qty) + ZeroIfNull(a.ordered_case_qty)) * Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.del_piece_qty)),18,4)) / cry.exchange_rate AS val_pr_diff_del
 ,(to_number((ZeroIfNull(a.store_del_net_price)-ZeroIfNull(a.wh_del_net_price)),19,5)
  *to_number((((ZeroIfNull(a.del_case_qty) + ZeroIfNull(a.ordered_case_qty)) * Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.del_piece_qty)),19,5)) / cry.exchange_rate AS val_pr_diff_net_del
 ,a.act_case_qty AS qty_case_act
 ,a.del_case_qty AS qty_case_del
 ,a.ordered_case_qty AS qty_case_order
 ,a.del_piece_qty AS qty_piece_del
 ,a.act_del_piece_qty AS qty_piece_act_del
 ,Cast(-1 AS INTEGER)         AS supplier_id
 ,Cast('' AS VARCHAR(15))     AS orig_receipt_nr_dir_del
 ,to_number(-1,15)     AS rcv_pos_id
 ,Cast(NULL AS DATE)          AS dat_booking
 ,Cast(NULL AS DATE)          AS dat_rcv_mdd
 ,Cast(-1 AS SMALLINT)        AS dd_matched_fg
 ,Cast('' AS VARCHAR(10))     AS mdd_user
 ,Cast(-1 AS SMALLINT)        AS mdd_return_fg
 ,to_number(NULL,10,3) AS case_size_real
 ,cry.curr_cd_from            AS currency_iso_cd
 ,cry.exchange_rate           AS rate_currency_exchange
 ,Coalesce(f2.case_size_dec,to_Number(f.src_case_size,9,4)) AS case_size
 ,e.src_wh_id                 AS wh_id_del
 ,g.busyear                   AS byr
 ,g.cy_week
 ,Cast(0 AS BYTEINT)          AS src_fg
FROM P_LEW_CORE_AC.v_item_delivery AS a

INNER JOIN P_LEW_BIL_AC.v_store_to_warehouse_lastknown AS b
ON b.client_id = a.client_id
AND b.loc_sid_store = a.loc_sid_store

INNER JOIN P_LEW_CORE_AC.v_item_group AS c
ON c.client_id = b.client_id
AND c.src_matkl='@ALL'

INNER JOIN P_LEW_CORE_AC.v_location AS d
ON d.client_id = b.client_id
AND d.loc_sid = b.loc_sid_wh

LEFT OUTER JOIN  P_LEW_CORE_AC.v_location AS e
ON e.client_id = a.client_id
AND e.loc_sid = a.loc_sid_wh

INNER JOIN P_LEW_BIL_AC.v_item AS f
ON f.client_id = a.client_id
AND f.item_sid = a.item_sid

LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_itm_item_act AS f2
ON f2.client_id = a.client_id
AND f2.item_sid = a.item_sid

INNER JOIN P_LEW_CORE_AC.v_cal_calendarday AS g
ON g.cal_dt = a.dwh_cal_dt

INNER JOIN P_LEW_CORE_AC.v_exchange_rate_known_hist AS cry
ON cry.client_id = a.client_id
AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
AND cry.deleted_fg = 0

INNER JOIN P_LEW_CORE_AC.v_exchange_rate_type AS crz
ON crz.client_id = cry.client_id
AND crz.x_rate_type_sid = cry.x_rate_type_sid
AND crz.src_kurst = '@BEWE'

INNER JOIN P_LEW_CORE_AC.v_item_map_key itmp
ON itmp.client_id = a.client_id
  AND itmp.item_sid = a.item_sid

 /*replaced by UNIION to eliminate duplicates: UNION ALL*/
UNION
SELECT
  a.client_id
 ,itmp.item_sid_map AS item_id
 ,a.dwh_cal_dt AS dat_formdate
 ,Cast(a.dir_del_id AS VARCHAR(20))          AS dir_del_id
 ,a.loc_sid_store                               AS store_id
 ,d.src_wh_id                                AS wh_id
 ,a.vat_id
 ,a.order_area_cd
 ,a.dayend_dt AS dat_dayend
 ,Cast(3 AS INTEGER)                         AS deliverytype_id
 ,a.dispo_unit_id
 ,Cast(-1 AS SMALLINT)                       AS booking_fg
 ,Cast(-1 AS SMALLINT)                       AS blocking_cd
 ,Cast(-1 AS INTEGER)                        AS dsac_nr
 ,NULL AS group_nr /* in alter Struktur immer der Wert NULL */
 ,Cast(-1 AS SMALLINT)                       AS print_nr
 ,Cast(-1 AS INTEGER)                        AS satas_nr
 ,to_number(a.act_price_item_id,18,4) AS act_price_item_cd
 ,Cast(-1 AS SMALLINT)                       AS stc_location_id
 ,Cast(-1 AS INTEGER)                        AS stc_slot_area
 ,Cast(-1 AS INTEGER)                        AS stc_slot_id
 ,to_number(-1,18,4)                  AS pallet_part
 ,to_number(-1,18,4)                  AS pallet_part_euro
 ,to_number(-1,18,4)                  AS pallet_part_tiko
 ,a.comment_txt AS comment_dir_del
 ,a.dir_del_status_id AS status_dir_del
 ,a.dayend_status_id AS status_dayend
 ,Cast(-1 AS INTEGER)                        AS dur_del
 ,a.wh_del_gross_price / cry.exchange_rate AS price_wh_dir_del 
 ,a.wh_del_net_price / cry.exchange_rate AS price_wh_net_dir_del 
 ,a.store_del_gross_price / cry.exchange_rate AS price_str_dir_del 
 ,a.store_del_net_price / cry.exchange_rate
 ,NULL AS price_cd /* in alter Struktur immer der Wert NULL */
 ,a.wh_act_gross_price / cry.exchange_rate AS price_act_wh 
 ,a.wh_act_net_price / cry.exchange_rate AS price_act_wh_net 
 ,(to_number((ZeroIfNull(a.store_del_gross_price)-ZeroIfNull(a.wh_del_gross_price)),18,4)
  *to_number(((ZeroIfNull(a.case_qty) * Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.piece_qty)),18,4)) / cry.exchange_rate AS val_pr_diff_del
 ,(to_number((ZeroIfNull(a.store_del_net_price)-ZeroIfNull(a.wh_del_net_price)),19,5)
  *to_number(((ZeroIfNull(a.case_qty) * Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.piece_qty)),19,5)) / cry.exchange_rate AS val_pr_diff_net_del
 ,to_number(NULL,18,4)                AS qty_case_act
 ,a.case_qty AS qty_case_dir_del
 ,to_number(NULL,18,4)                AS qty_case_order
 ,a.piece_qty AS qty_piece_dir_del
 ,to_number(NULL,18,4)                AS qty_piece_act_del
 ,a.orig_supplier_nr AS supplier_id
 ,a.orig_receipt_nr AS orig_receipt_nr_dir_del
 ,a.rcv_pos_id
 ,Cast(NULL AS DATE)          AS dat_booking /* in alter Struktur immer der Wert NULL */
 ,a.mdd_rcv_dt AS dat_rcv_mdd
 ,a.dd_matched_fg
 ,a.mdd_user_name AS mdd_user
 ,a.mdd_return_id AS mdd_return_fg
 ,to_number(NULL,10,3)                AS case_size_real
 ,cry.curr_cd_from                           AS currency_iso_cd
 ,cry.exchange_rate                          AS rate_currency_exchange
 ,Coalesce(f2.case_size_dec,to_Number(f.src_case_size,9,4)) AS case_size
 ,e.src_wh_id                                AS wh_id_del
 ,g.busyear                                  AS byr
 ,g.cy_week
 ,Cast(0 AS BYTEINT)          AS src_fg
FROM P_LEW_CORE_AC.v_item_direct_delivery AS a

INNER JOIN P_LEW_BIL_AC.v_store_to_warehouse_lastknown AS b
ON b.client_id = a.client_id
AND b.loc_sid_store = a.loc_sid_store

INNER JOIN P_LEW_CORE_AC.v_item_group AS c
ON c.client_id = b.client_id
AND c.src_matkl='@ALL'

INNER JOIN  P_LEW_CORE_AC.v_location AS d
ON d.client_id = b.client_id
AND d.loc_sid = b.loc_sid_wh

LEFT OUTER JOIN  P_LEW_CORE_AC.v_location AS e
ON e.client_id = a.client_id
AND e.loc_sid = a.loc_sid_wh

INNER JOIN P_LEW_CORE_AC.v_item AS f
ON f.client_id = a.client_id
AND f.item_sid = a.item_sid

LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_itm_item_act AS f2
ON f2.client_id = a.client_id
AND f2.item_sid = a.item_sid

INNER JOIN P_LEW_CORE_AC.v_cal_calendarday AS g
ON g.cal_dt = a.dwh_cal_dt

INNER JOIN P_LEW_CORE_AC.v_exchange_rate_known_hist AS cry
ON cry.client_id = a.client_id
AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
AND cry.deleted_fg = 0

INNER JOIN P_LEW_CORE_AC.v_exchange_rate_type AS crz
ON crz.client_id = cry.client_id
AND crz.x_rate_type_sid = cry.x_rate_type_sid
AND crz.src_kurst = '@BEWE'

INNER JOIN P_LEW_CORE_AC.v_item_map_key itmp
ON itmp.client_id = a.client_id
  AND itmp.item_sid = a.item_sid

 /*replaced by UNIION to eliminate duplicates: UNION ALL */
UNION
SELECT
  a.client_id
 ,itmp.item_sid_map AS item_id
 ,a.dwh_cal_dt AS dat_formdate
 ,Cast(a.fv_del_id AS VARCHAR(20))          AS fv_del_id
 ,a.loc_sid_store                              AS store_id
 ,d.src_wh_id                               AS wh_id
 ,a.vat_id
 ,a.order_area_cd
 ,a.dayend_dt AS dat_dayend
 ,Cast(4 AS INTEGER)                        AS deliverytype_id
 ,Cast(-1 AS INTEGER)                       AS dispo_unit_id
 ,2 AS booking_fg /* in neuer STruktur nicht mehr vorhanden, in alter Struktur immer mit Wert 2 */
 ,Cast(-1 AS SMALLINT)                      AS blocking_cd
 ,NULL AS dsac_nr /* in neuer Struktur nicht mehr vorhanden, in alter Struktur immer der Wert NULL */
 ,to_number(-1,18,0)                 AS group_nr
 ,Cast(-1 AS SMALLINT)                      AS print_nr
 ,NULL AS satas_nr
 ,to_number(a.price_grp_id_store,18,4) AS pricegroup_store
 ,a.layer_order_nr /* in neuer Struktur nicht mehr vorhanden, in alter Struktur immer der Wert NULL */
 ,Cast(-1 AS INTEGER)                       AS stc_slot_area
 ,a.slot_nr
 ,to_number(-1,18,4)                 AS pallet_part
 ,to_number(-1,18,4)                 AS pallet_part_euro
 ,to_number(-1,18,4)                 AS pallet_part_tiko
 ,Cast('' AS VARCHAR(50))                   AS comment_del
 ,Cast(-1 AS SMALLINT)                      AS status_prot_receipt
 ,NULL AS status_dayend /* in neuer Struktur nicht mehr vorhanden, in alter Struktur immer der Wert NULL */
 ,a.dur_del_cnt AS dur_fv_del
 ,a.wh_gross_price / cry.exchange_rate AS price_wh_fv 
 ,a.wh_net_price / cry.exchange_rate AS price_wh_net_fv 
 ,a.store_gross_price / cry.exchange_rate AS price_str_fv 
 ,a.store_net_price / cry.exchange_rate AS price_str_net_fv 
 ,Cast(-1 AS SMALLINT)                      AS price_fg
 ,a.old_retail_gross_price / cry.exchange_rate AS price_retail_fv_del_old 
 ,a.old_retail_net_price / cry.exchange_rate AS price_retail_net_fv_del_old 
 ,(to_number((ZeroIfNull(a.store_gross_price)-ZeroIfNull(a.wh_gross_price)),18,4) *
to_number((((ZeroIfNull(a.case_qty) + ZeroIfNull(NULL))* 
Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.piece_qty)),18,4)) /
cry.exchange_rate AS val_pr_diff_del
 ,(to_number((ZeroIfNull(a.store_net_price)-ZeroIfNull(a.wh_net_price)),19,5) *
to_number((((ZeroIfNull(a.case_qty) + ZeroIfNull(NULL)) * 
Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.piece_qty)),19,5))
/ cry.exchange_rate AS val_pr_diff_net_del
 ,to_number(NULL,18,4)               AS qty_case_act
 ,a.case_qty AS qty_case_fv_del
 ,to_number(NULL,18,4)               AS qty_case_order
 ,to_number(NULL,18,4)               AS qty_piece_del
 ,to_number(NULL,18,4)               AS qty_piece_act_del
 ,Cast(-1 AS INTEGER)                       AS supplier_id
 ,Cast('' AS VARCHAR(15))                   AS orig_receipt_nr_dir_del
 ,to_number(-1,15)                   AS rcv_pos_id
 ,Cast(NULL AS DATE)                        AS dat_booking
 ,Cast(NULL AS DATE)                        AS dat_rcv_mdd
 ,Cast(-1 AS SMALLINT)                      AS dd_matched_fg
 ,Cast('' AS VARCHAR(10))                   AS mdd_user
 ,Cast(-1 AS SMALLINT)                      AS mdd_return_fg
 ,a.case_size_dec AS case_size_real
 ,cry.curr_cd_from                           AS currency_iso_cd
 ,cry.exchange_rate                          AS rate_currency_exchange
 ,Coalesce(f2.case_size_dec,to_Number(f.src_case_size,9,4)) AS case_size
 ,e.src_wh_id                               AS wh_id_del
 ,g.busyear                                 AS byr
 ,g.cy_week
 ,Cast(0 AS BYTEINT)                        AS src_fg
FROM P_LEW_CORE_AC.v_item_fruits_vegetables_delivery AS a

INNER JOIN P_LEW_BIL_AC.v_store_to_warehouse_lastknown AS b
ON b.client_id = a.client_id
AND b.loc_sid_store = a.loc_sid_store

INNER JOIN P_LEW_CORE_AC.v_item_group AS c
ON c.client_id = b.client_id
AND c.src_matkl='@ALL'

INNER JOIN  P_LEW_CORE_AC.v_location AS d
ON d.client_id = b.client_id
AND d.loc_sid = b.loc_sid_wh

LEFT OUTER JOIN  P_LEW_CORE_AC.v_location AS e
ON e.client_id = a.client_id
AND e.loc_sid = a.loc_sid_wh

INNER JOIN P_LEW_CORE_AC.v_item AS f
ON f.client_id = a.client_id
AND f.item_sid = a.item_sid

LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_itm_item_act AS f2
ON f2.client_id = a.client_id
AND f2.item_sid = a.item_sid

INNER JOIN P_LEW_CORE_AC.v_cal_calendarday AS g
ON g.cal_dt = a.dwh_cal_dt

INNER JOIN P_LEW_CORE_AC.v_exchange_rate_known_hist AS cry
ON cry.client_id = a.client_id
AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
AND cry.deleted_fg = 0

INNER JOIN P_LEW_CORE_AC.v_exchange_rate_type AS crz
ON crz.client_id = cry.client_id
AND crz.x_rate_type_sid = cry.x_rate_type_sid
AND crz.src_kurst = '@BEWE'

INNER JOIN P_LEW_CORE_AC.v_item_map_key itmp
ON itmp.client_id = a.client_id
  AND itmp.item_sid = a.item_sid

 /*replaced by UNIION to eliminate duplicates: UNION ALL */
UNION
SELECT
  Cast(b.client_id AS SMALLINT) AS client_id
 ,itmp.item_sid_map AS item_id
 ,b.dwh_cal_dt AS dat_formdate
 ,Cast(0 AS VARCHAR(20)) AS receipt_id_del
 ,b.loc_sid AS store_id
 ,j.src_wh_id  AS wh_id
 ,Coalesce(d.vat_id, -2) AS vat_id
 ,Cast(NULL AS VARCHAR(5)) AS order_area_cd
 ,Cast(b.dwh_created AS DATE) AS dat_dayend
 ,MOD(q.mis_deliv_type_id, 10) AS deliverytype_id
 ,Cast(0 AS INTEGER) AS dispo_unit_id
 ,Cast(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN -1 ELSE NULL
       END AS SMALLINT) AS booking_fg
 ,Cast(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN -1 ELSE NULL
       END AS SMALLINT) AS blocking_cd
 ,Cast(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN -1 ELSE NULL
       END AS INTEGER) dsac_nr
 ,to_number(NULL,18,0) AS group_nr
 ,Cast(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN -1 ELSE NULL
       END AS SMALLINT) AS print_nr
 ,Cast(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN -1 ELSE NULL
       END AS INTEGER) AS satas_nr
 ,to_number(NULL,18,4) AS pricegroup_act_price
 ,Cast(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN -1 ELSE NULL
       END AS SMALLINT) AS stc_location_id
 ,Cast(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN -1 ELSE NULL
       END AS INTEGER) AS stc_slot_area
 ,Cast(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN -1 ELSE NULL
       END AS INTEGER) AS stc_slot_id
 ,to_number(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN -1 ELSE NULL
       END,18,4) AS pallet_part
 ,to_number(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN -1 ELSE NULL
       END,18,4) AS pallet_part_euro
 ,to_number(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN -1 ELSE NULL
       END,18,4) AS pallet_part_tiko
 ,Cast(NULL AS VARCHAR(50)) AS comment_del
 ,Cast(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN 3 ELSE NULL
       END AS SMALLINT) AS status_prot_receipt
 ,Cast(3 AS SMALLINT) AS status_dayend
 ,Cast(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN -1 ELSE NULL
       END AS INTEGER) AS dur_del
 ,to_number(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN m.cond_val_eff_calc ELSE NULL
       END,18,4) / cry.exchange_rate
 ,Cast(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN m.net_val_eff_calc ELSE NULL
       END AS DECIMAL(19,5)) / cry.exchange_rate
 ,to_number(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN l.cond_val_eff_calc ELSE NULL
       END,18,4) / cry.exchange_rate
 ,to_number(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN l.net_val_eff_calc ELSE NULL
       END,19,5) / cry.exchange_rate
 ,Cast(NULL AS SMALLINT) AS price_fg
 ,to_number(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN m.cond_val_eff_calc ELSE NULL
       END,18,4) / cry.exchange_rate
 ,to_number(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN m.net_val_eff_calc ELSE NULL
       END,19,5) / cry.exchange_rate
 ,to_number(NULL,18,4)                      AS val_pr_diff_del
 ,to_number(NULL,19,5)                      AS val_pr_diff_net_del
 ,to_number(NULL,18,4)     AS qty_case_act
 ,to_number(0,18,4) AS qty_case_del
 ,to_number(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN NULL ELSE 0
       END,18,4) AS qty_case_order
 ,to_number(b.ship_qty * Coalesce(c.component_qty, 1) * (-1),18,4) AS qty_piece_del
 ,to_number(NULL,18,4) AS qty_piece_act_del

 ,CASE
      WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN supmap.sup_sid_map ELSE -1
  END AS supplier_id
 ,Cast(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN Cast(Cast(b.order_record_id AS BIGINT)AS VARCHAR(15)) ELSE ''
       END AS VARCHAR(15)) AS orig_receipt_nr_dir_del
 ,Cast(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN b.order_record_pos_id ELSE -1
       END AS DECIMAL(15,0)) AS rcv_pos_id

 ,CASE
      WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN b.dwh_cal_dt ELSE NULL
  END AS dat_booking
 ,Cast(NULL AS DATE) AS dat_rcv_mdd
 ,Cast(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN 0 ELSE -1
       END AS SMALLINT) AS dd_matched_fg
 ,Cast(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN NULL ELSE ''
       END AS VARCHAR(10)) AS mdd_user
 ,Cast(
       CASE
           WHEN MOD(q.mis_deliv_type_id,10) = 3 THEN 0 ELSE -1
       END AS SMALLINT) AS mdd_return_fg
 ,to_number(NULL,10,3) AS case_size_real
 ,cry.curr_cd_from                           AS currency_iso_cd
 ,cry.exchange_rate                          AS rate_currency_exchange
 ,iuomh.conv_to_base_numerator AS case_size
 ,j.src_wh_id AS wh_id_del
 ,s.busyear AS byr
 ,s.cy_week
 ,1 AS src_fg
FROM P_LEW_CORE_AC.v_item_movement_record_pos AS b
LEFT OUTER JOIN
(
SELECT
     ca.client_id
    ,ca.item_sid
    ,ca.item_bom_sid
    FROM P_LEW_CORE_AC.v_item_bom AS ca
    LEFT OUTER JOIN  P_LEW_CORE_AC.v_item_bom AS cb
    ON cb.client_id = ca.client_id
    AND cb.item_sid = ca.item_sid
    AND cb.src_werks = '@ALL'
    AND cb.deleted_fg = 0
    AND (cb.src_stlnr > ca.src_stlnr OR (cb.src_stlnr = ca.src_stlnr AND cb.item_bom_sid > ca.item_bom_sid))
    WHERE ca.src_werks = '@ALL'
        AND  ca.deleted_fg = 0
        AND  cb.client_id IS NULL
) c0
ON c0.client_id = b.client_id
AND c0.item_sid=b.item_sid
LEFT OUTER JOIN P_LEW_CORE_AC.v_item_bom_pos_hist AS c
ON c.client_id = c0.client_id
AND c.item_bom_sid=c0.item_bom_sid
AND CURRENT_DATE BETWEEN c.dwh_valid_from AND c.dwh_valid_to
AND c.deleted_fg = 0

LEFT OUTER JOIN P_LEW_BIL_AC.v_item_vat_act AS d
ON d.client_id = b.client_id
AND d.item_sid=Coalesce(c.item_sid, b.item_sid)

INNER JOIN P_LEW_CORE_AC.v_item_hist AS e
ON e.client_id = b.client_id
AND  e.item_sid =b.item_sid
AND CURRENT_DATE BETWEEN e.dwh_valid_from AND e.dwh_valid_to

LEFT OUTER JOIN P_LEW_BIL_AC.v_warehouse AS f
ON f.client_id = b.client_id
AND f.loc_sid_wh=b.loc_sid_counterparty
AND f.bges_active_fg=1 /* warehouse ist Betriebsgesellschaft */
AND CURRENT_DATE BETWEEN f.dwh_valid_from AND f.dwh_valid_to

INNER JOIN P_LEW_CORE_AC.v_location AS g
ON g.client_id = b.client_id
AND g.loc_sid=b.loc_sid
AND g.wh_store_mark='A'
AND g.global_loc_type_cd = '0'  /* Bedingung aus p_core_biz.v_s_loc_store */
AND g.global_loc_ctry_cd <> 'ZV'      /* Aehnlich einer Bedingung aus p_core_biz.v_s_loc_store */
AND g.opening_dt IS NOT NULL

INNER JOIN P_LEW_CORE_AC.v_location_hist AS h
ON h.client_id = b.client_id
AND h.loc_sid=b.loc_sid
AND (h.test_store_fg = 0 OR h.test_store_fg IS NULL)
AND CURRENT_DATE BETWEEN h.dwh_valid_from AND h.dwh_valid_to

INNER JOIN P_LEW_BIL_AC.v_store_to_warehouse_lastknown AS i
ON i.client_id = b.client_id
AND i.loc_sid_store = b.loc_sid

INNER JOIN P_LEW_CORE_AC.v_item_group AS ii
ON ii.client_id = i.client_id
AND ii.src_matkl='@ALL'

INNER JOIN  P_LEW_CORE_AC.v_location AS j
ON j.client_id = i.client_id
AND j.loc_sid=i.loc_sid_wh

INNER JOIN P_LEW_CORE_AC.v_item AS ka
ON ka.client_id = b.client_id
AND ka.item_sid=Coalesce(c.item_sid, b.item_sid)

LEFT OUTER JOIN P_LEW_CORE_AC.v_item_unit_of_measurement iuom
  ON  iuom.client_id=ka.client_id
  AND iuom.item_sid=ka.item_sid
  AND iuom.log_var_cd=ka.log_var_cd

LEFT OUTER JOIN P_LEW_CORE_AC.v_item_unit_of_measurement_hist iuomh
  ON  iuom.client_id=iuomh.client_id
  AND iuom.item_sid=iuomh.item_sid
  AND iuom.uom_sid=iuomh.uom_sid
  AND CURRENT_DATE BETWEEN iuomh.dwh_valid_from AND iuomh.dwh_valid_to

INNER JOIN P_LEW_CORE_AC.v_item_hist AS k
ON k.client_id = ka.client_id
AND k.item_sid=ka.item_sid
AND CURRENT_DATE BETWEEN k.dwh_valid_from AND k.dwh_valid_to

LEFT OUTER JOIN P_LEW_BIL_AC.v_item_loc_sales_cond_denorm AS l
ON l.client_id = k.client_id
AND l.item_sid=k.item_sid
AND l.uom_sid_cond=k.uom_sid_base
AND l.loc_sid=b.loc_sid
AND b.dwh_cal_dt BETWEEN l.dwh_valid_from AND l.dwh_valid_to

LEFT OUTER JOIN P_LEW_BIL_AC.v_item_loc_sales_cond_denorm AS m
ON m.client_id = k.client_id
AND m.item_sid=k.item_sid
AND m.uom_sid_cond=k.uom_sid_base
AND m.loc_sid=i.loc_sid_wh
AND b.dwh_cal_dt BETWEEN m.dwh_valid_from AND m.dwh_valid_to

INNER JOIN P_LEW_CORE_AC.v_order_record AS p
ON p.client_id = b.client_id
AND p.order_record_id=b.order_record_id

INNER JOIN P_LEW_CORE_AC.v_map_mis_move_type_deliv AS q
ON q.client_id = p.client_id
AND q.order_type_cd = p.order_type_cd
AND q.move_type_cd = b.move_type_cd

INNER JOIN P_LEW_CORE_AC.v_cal_calendarday AS s
ON s.cal_dt = b.dwh_cal_dt

INNER JOIN P_LEW_CORE_AC.v_exchange_rate_known_hist AS cry
ON cry.client_id = b.client_id
AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
AND cry.deleted_fg = 0

INNER JOIN P_LEW_CORE_AC.v_exchange_rate_type AS crz
ON crz.client_id = cry.client_id
AND crz.x_rate_type_sid = cry.x_rate_type_sid
AND crz.src_kurst = '@BEWE'

/* Zu ignorierende Artikelarten */
LEFT OUTER JOIN P_LEW_PROCESS_AC.v_item_type_ignore AS iti
ON iti.client_id = e.client_id 
  AND iti.item_type_sid = e.item_type_sid
  AND 
    (
      (
       iti.client_id IN (33, 34) 
       AND iti.item_type_cd  NOT IN ('ZKM', 'ZVM')
      )
      OR iti.client_id NOT IN (33, 34)
    ) 
  AND iti.item_type_grp_cd = 'ANL'

INNER JOIN P_LEW_CORE_AC.v_item_map_key itmp
ON itmp.client_id = b.client_id
  AND itmp.item_sid = Coalesce(b.item_sid, c.item_sid)

INNER JOIN P_LEW_CORE_AC.v_supplier_map_key supmap
ON b.client_id = supmap.client_id
  AND b.sup_sid = supmap.sup_sid

WHERE 
  CASE WHEN (q.mis_deliv_type_id / 10) = 1 AND f.client_id IS NULL /* Auswertung 10er-Stelle (Resultat Division ist Integer ungerundet) */
       THEN 0
       ELSE 1
  END = 1
  AND iti.item_type_cd IS NULL /* Ungefilterte Artikelarten */
;