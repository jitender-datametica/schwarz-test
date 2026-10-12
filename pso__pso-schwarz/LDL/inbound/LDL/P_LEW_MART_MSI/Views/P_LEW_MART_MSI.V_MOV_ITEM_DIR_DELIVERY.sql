/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MOV_ITEM_DIR_DELIVERY
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  25.09.2017    Martin Murtenthaler neue Versionn
#  1.2  08.11.2017    Meister.Ulrich neue Version
#  1.3  09.11.2017    Meister.Ulrich Bestimmung Betriebsgesellschaften angepasst
#  1.4  09.11.2017    Meister.Ulrich Bestimmung zugeordnete Betriebsgesellschaft angepasst
#  1.5  10.11.2017    Meister.Ulrich trim added for orig_receipt_nr_dir_del to avoid leading blanks
#  1.6  15.11.2017    Wieber.Harald            Release 1.1
#  1.7  17.01.2018    Murtenthaler.Martin      WAWI-Item if possible
#  1.8  31.01.2018    Wieber.Harald            Release 2.3
#  1.9  04.04.2018    Arnold.Arne              Umstellung auf V_STORE_TO_WAREHOUSE_LASTKNOWN
# 1.10  19.04.2018    Knopp,Timo               Adaptation after changing core tables map_mis_mov_type(_deliv) to map_mis_movE_type(_deliv)
# 1.11  13.06.2018    Meister,Ulrich           Konsolidierung der Aenderungen
# 1.12  24.07.2018    Michael Ueding           Referenz Item Mapping geaendert
# 1.13  16.12.2019    Michael Ueding           Ersetzen Legacy mit Core Objekt 
# 1.14  13.01.2020    Ulrich Meister           changed to replace n_-View approach, Patch 20191218_2333_MCD_mart_views_WH_MOVE_DWH20 IDMO-2570, DWH-7995
# 1.15  10.11.2020    Torsten Bachmann         join to v_supplier_map_key added
#                                              PatchNo: 2652, REP3-7579
# 1.16  22.02.2021    Prasanna Ranjan          REP2-9080 - Include item types ZKM and ZVM from USA and Serbia 
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MOV_ITEM_DIR_DELIVERY COMMENT = ''
(
  client_id                    COMMENT ''
  ,store_id                    COMMENT ''
  ,item_id                     COMMENT ''
  ,dat_dayend                  COMMENT ''
  ,dir_del_id                  COMMENT ''
  ,wh_id                       COMMENT ''
  ,supplier_id                 COMMENT ''
  ,vat_id                      COMMENT ''
  ,order_area_cd               COMMENT ''
  ,orig_receipt_nr_dir_del     COMMENT ''
  ,rcv_pos_id                  COMMENT ''
  ,dat_formdate                COMMENT ''
  ,dat_booking                 COMMENT ''
  ,dat_rcv_mdd                 COMMENT ''
  ,status_dayend               COMMENT ''
  ,status_dir_del              COMMENT ''
  ,act_price_item_cd           COMMENT ''
  ,dd_matched_fg               COMMENT ''
  ,dispo_unit_desc             COMMENT ''
  ,dispo_unit_id               COMMENT ''
  ,mdd_user                    COMMENT ''
  ,mdd_return_fg               COMMENT ''
  ,group_nr                    COMMENT ''
  ,comment_dir_del             COMMENT ''
  ,price_act_wh                COMMENT ''
  ,price_act_wh_net            COMMENT ''
  ,price_cd                    COMMENT ''
  ,price_wh_dir_del            COMMENT ''
  ,price_wh_net_dir_del        COMMENT ''
  ,price_str_dir_del           COMMENT ''
  ,price_str_net_dir_del       COMMENT ''
  ,qty_case_dir_del            COMMENT ''
  ,case_size_dec               COMMENT ''
  ,currency_iso_cd             COMMENT ''
  ,wh_id_del                   COMMENT ''
)

AS

SELECT
   a.client_id
  ,a.loc_sid_store                               AS store_id
  ,itmp.item_sid_map                          AS item_id
  ,a.dayend_dt AS dat_dayend
  ,a.dir_del_id
  ,d.src_wh_id                                AS wh_id
  ,COALESCE (supmap.sup_sid_map, a.orig_supplier_nr) AS supplier_id
  ,a.vat_id
  ,a.order_area_cd
  ,TRIM(a.orig_receipt_nr)            AS orig_receipt_nr_dir_del
  ,a.rcv_pos_id
  ,a.dwh_cal_dt AS dat_formdate
  ,Cast(NULL AS DATE)          AS dat_booking /* in alter Struktur immer der Wert NULL */
  ,a.mdd_rcv_dt AS dat_rcv_mdd
  ,a.dayend_status_id AS status_dayend
  ,a.dir_del_status_id AS status_dir_del
  ,a.act_price_item_id AS act_price_item_cd
  ,a.dd_matched_fg
  ,Cast('Kolli' AS VARCHAR(35)) AS dispo_unit_desc /* Bezeichnung in neuer Struktur nicht mehr vorhanden */
  ,a.dispo_unit_id
  ,a.mdd_user_name AS mdd_user
  ,a.mdd_return_id AS mdd_return_fg
  ,to_number(NULL,18,0) AS group_nr /* in alter Struktur immer der Wert NULL */
  ,a.comment_txt AS comment_dir_del
  ,a.wh_act_gross_price / cry.exchange_rate        AS price_act_wh
  ,a.wh_act_net_price / cry.exchange_rate        AS price_act_wh_net
  ,Cast(NULL AS SMALLINT) AS price_cd /* in alter Struktur immer der Wert NULL */
  ,a.wh_del_gross_price / cry.exchange_rate        AS price_wh_dir_del
  ,a.wh_del_net_price / cry.exchange_rate        AS price_wh_net_dir_del
  ,a.store_del_gross_price / cry.exchange_rate        AS price_str_dir_del
  ,a.store_del_net_price / cry.exchange_rate        AS price_str_net_dir_del
  ,a.case_qty AS qty_case_dir_del
  ,a.case_size_dec
  ,cry.curr_cd_from                           AS currency_iso_cd
  ,e.src_wh_id                                AS wh_id_del
FROM P_LEW_CORE_AC.v_item_direct_delivery a

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

INNER JOIN P_LEW_CORE_AC.v_exchange_rate_known_hist AS cry
ON cry.client_id = a.client_id
  AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
  AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
  AND cry.deleted_fg = 0

INNER JOIN P_LEW_CORE_AC.v_exchange_rate_type crz
ON crz.client_id = cry.client_id
AND crz.x_rate_type_sid = cry.x_rate_type_sid
AND crz.src_kurst = '@BEWE'

INNER JOIN P_LEW_CORE_AC.v_item_map_key itmp
ON itmp.client_id = a.client_id
  AND itmp.item_sid = a.item_sid

LEFT OUTER JOIN P_LEW_CORE_AC.v_supplier_map_key supmap
    ON a.client_id = supmap.client_id
   AND a.orig_supplier_nr = supmap.wawi_dwh_orig_supplier_nr

 /* replaced by UNION to eliminate duplicates: UNION ALL */
UNION
SELECT
   Cast(b.client_id AS SMALLINT) AS client_id
  ,b.loc_sid AS store_id
  ,itmp.item_sid_map AS item_id
  ,Cast(b.dwh_created AS DATE) AS dat_dayend
  ,to_number(0,15,0) AS receipt_id_del
  ,j.src_wh_id  AS wh_id
  
  ,CASE
       WHEN MOD(q.mis_deliv_type_id, 10) = 3 THEN supmap.sup_sid_map ELSE -1
   END AS supplier_id
  ,Coalesce(d.vat_id, -2) AS vat_id
  ,Cast(NULL AS VARCHAR(5)) AS order_area_cd
  ,Trim(Cast(Cast(b.order_record_id AS BIGINT) AS VARCHAR(15)))  AS orig_receipt_nr_dir_del
  ,to_number(b.order_record_pos_id,15,0) AS rcv_pos_id
  ,b.dwh_cal_dt AS dat_formdate
  ,b.dwh_cal_dt AS dat_booking
  ,Cast(NULL AS DATE) AS dat_rcv_mdd
  ,Cast(3 AS SMALLINT) AS status_dayend
  ,Cast(3 AS SMALLINT) AS status_prot_receipt
  ,Cast(NULL AS INTEGER) AS pricegroup_act_price
  ,Cast(0 AS SMALLINT) AS dd_matched_fg
  ,Cast('Kolli' AS VARCHAR(35)) AS dispo_unit_desc
  ,Cast(0 AS INTEGER) AS dispo_unit_id
  ,Cast(NULL AS VARCHAR(10)) AS mdd_user
  ,Cast(0 AS SMALLINT) AS mdd_return_fg
  ,to_number(NULL,18,0) AS group_nr
  ,Cast(NULL AS VARCHAR(50)) AS comment_del
  ,to_number(m.cond_val_eff_calc,18,4) / cry.exchange_rate AS price_retail_wh
  ,to_number(m.net_val_eff_calc,19,5) / cry.exchange_rate AS price_act_wh_net
  ,Cast(NULL AS SMALLINT) AS price_cd
  ,to_number(m.cond_val_eff_calc,18,4) / cry.exchange_rate AS price_wh_del
  ,to_number(m.net_val_eff_calc,19,5) / cry.exchange_rate AS price_wh_net_del
  ,to_number(l.cond_val_eff_calc,18,4) / cry.exchange_rate AS price_str_del
  ,to_number(l.net_val_eff_calc,19,5) / cry.exchange_rate AS price_str_net_del
  ,to_number(0,18,4) AS qty_case_del
  ,to_number(
        CASE
            WHEN (b.capt_qty * Coalesce(c.component_qty, 1)) <> 0
            THEN ((b.ship_qty * Coalesce(c.component_qty, 1))/(b.capt_qty * Coalesce(c.component_qty, 1))) 
            ELSE 0
        END 
        ,9,4) AS case_size_dec
  ,cry.curr_cd_from                          AS currency_iso_cd
  ,Cast(-2147483647 AS INTEGER) AS wh_id_del
FROM P_LEW_CORE_AC.v_item_movement_record_pos b
LEFT OUTER JOIN
(
SELECT
     ca.client_id
    ,ca.item_sid
    ,ca.item_bom_sid
    FROM P_LEW_CORE_AC.v_item_bom ca
    LEFT OUTER JOIN  P_LEW_CORE_AC.v_item_bom cb
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

LEFT OUTER JOIN P_LEW_CORE_AC.v_item_bom_pos_hist c
ON c.client_id = c0.client_id
AND c.item_bom_sid=c0.item_bom_sid
AND CURRENT_DATE BETWEEN c.dwh_valid_from AND c.dwh_valid_to
AND c.deleted_fg = 0

LEFT OUTER JOIN P_LEW_BIL_AC.v_item_vat_act AS d
ON d.client_id = b.client_id
AND d.item_sid=Coalesce(c.item_sid, b.item_sid) 

LEFT OUTER JOIN P_LEW_BIL_AC.v_warehouse AS f 
ON f.client_id = b.client_id
AND f.loc_sid_wh=b.loc_sid_counterparty
AND f.bges_active_fg=1    /* warehouse ist Betriebsgesellschaft */
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

INNER JOIN P_LEW_CORE_AC.v_exchange_rate_known_hist AS cry
ON cry.client_id = b.client_id
AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
AND cry.deleted_fg = 0

INNER JOIN P_LEW_CORE_AC.v_exchange_rate_type AS crz
ON crz.client_id = cry.client_id
AND crz.x_rate_type_sid = cry.x_rate_type_sid
AND crz.src_kurst = '@BEWE'

LEFT OUTER JOIN P_LEW_PROCESS_AC.v_item_type_ignore AS iti
ON iti.client_id=k.client_id 
AND iti.item_type_sid=k.item_type_sid
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
  AND itmp.item_sid = COALESCE(b.item_sid, c.item_sid)

INNER JOIN P_LEW_CORE_AC.v_supplier_map_key supmap
    ON b.client_id = supmap.client_id
   AND b.sup_sid   = supmap.sup_sid

WHERE MOD(q.mis_deliv_type_id, 10) = 3
    AND  iti.item_type_sid IS NULL
 /* Ungefilterte Artikelarten */
;