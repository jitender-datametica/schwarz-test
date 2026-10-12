/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.v_prisma_salesq_2
#----------------------------------------------------------------------------
# History:
#  1.0  29.04.2022    Ross, Ulrich            Init
#  1.1  01.07.2022    Ross, Ulrich            Add view v_client_migration_per_2 to seperate eLWIS and WAWI
#  1.2  10.11.2022    Ross, Ulrich            Anpassen Berechnung sales_piece_qty u. sales_weight_qty
#  1.3  09.01.2022    Ross, Ulrich            Anpassen Logik bei View v_client_migration_per_2
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_prisma_salesq_2 (client_id, store_id, dat_formdate, uhrzeit, cashier_id,
int_itemgroup_cd, subitemgroup_id, sales_q, dwh_created) AS
/* # Nur EU Daten #
  # In der View v_pos_receiptline_2 ist die Spalte pos.main_item_grp_cd mit dem main_item_grp_cd befüllt.
  # Für US Daten ist die Spalte pos.main_item_grp_cd aber mit dem SubItemGroup Code befüllt */
/* # Nur US Daten # */ SELECT client_id,
 store_id,
 dat_formdate,
 uhrzeit,
 cashier_id,
 int_itemgroup_cd,
 CAST(subitemgroup_id AS BIGNUMERIC) AS subitemgroup_id,
 IFNULL(CAST(sales_piece_qty + sales_weight_qty AS NUMERIC), 0) AS sales_q,
 dwh_created
FROM (SELECT POS.client_id,
    POS.loc_sid AS store_id,
    POS.dwh_cal_dt AS dat_formdate,
       CASE
       WHEN EXTRACT(HOUR FROM CAST(POS.receipt_tmsp AS TIME)) <= 9
       THEN '0' || CAST(EXTRACT(HOUR FROM CAST(POS.receipt_tmsp AS TIME)) AS STRING)
       ELSE CAST(EXTRACT(HOUR FROM CAST(POS.receipt_tmsp AS TIME)) AS STRING)
       END || ':' || CASE
      WHEN EXTRACT(MINUTE FROM CAST(POS.receipt_tmsp AS TIME)) < 15
      THEN '00'
      WHEN EXTRACT(MINUTE FROM CAST(POS.receipt_tmsp AS TIME)) < 30
      THEN '15'
      WHEN EXTRACT(MINUTE FROM CAST(POS.receipt_tmsp AS TIME)) < 45
      THEN '30'
      ELSE '45'
      END AS uhrzeit,
    POS.cashier_id,
    item.int_itemgroup_cd,
    item.subitemgroup_id,
    SUM(CASE
      WHEN POS.weight_item_fg = 0
      THEN POS.sales_piece_qty
      ELSE 0
      END) AS sales_piece_qty,
    SUM(CASE
      WHEN POS.weight_item_fg = 1
      THEN POS.sales_weight_qty
      ELSE 0
      END) AS sales_weight_qty,
    POS.dwh_created
   FROM ldl_p_lew_core_ac.v_pos_receiptline_2 AS POS
    INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS CMP ON POS.client_id = CMP.client_id AND CMP.active_fg = 0
     AND (POS.dwh_cal_dt > CMP.migration_dat_valid_to OR CMP.migration_dat_valid_from = CMP.migration_dat_valid_to)
    INNER JOIN (SELECT ITEM.client_id,
      ITEM.item_sid,
      ITEM.subitemgroup_id,
      SIG.int_itemgroup_cd
     FROM ldl_p_lew_mart_cs.v_gen_item_asis_2 AS ITEM_2
      INNER JOIN ldl_p_lew_mart_cs.v_cs_subitemgroup_2 AS SIG ON ITEM.client_id = SIG.client_id AND ITEM.subitemgroup_id = CAST(SIG.subitemgroup_cd AS FLOAT64)
        
     GROUP BY ITEM.client_id,
      ITEM.item_sid,
      ITEM.subitemgroup_id,
      SIG.int_itemgroup_cd) AS item_2 ON POS.client_id = item.client_id AND POS.item_sid = item.item_sid
   WHERE POS.turnover_relevant_fg = 1
   GROUP BY POS.client_id,
    store_id,
    dat_formdate,
    uhrzeit,
    POS.cashier_id,
    item.int_itemgroup_cd,
    item.subitemgroup_id,
    POS.dwh_created
   UNION ALL
   SELECT POS.client_id,
    POS.loc_sid AS store_id,
    POS.dwh_cal_dt AS dat_formdate,
       CASE
       WHEN EXTRACT(HOUR FROM CAST(POS.receipt_tmsp AS TIME)) <= 9
       THEN '0' || CAST(EXTRACT(HOUR FROM CAST(POS.receipt_tmsp AS TIME)) AS STRING)
       ELSE CAST(EXTRACT(HOUR FROM CAST(POS.receipt_tmsp AS TIME)) AS STRING)
       END || ':' || CASE
      WHEN EXTRACT(MINUTE FROM CAST(POS.receipt_tmsp AS TIME)) < 15
      THEN '00'
      WHEN EXTRACT(MINUTE FROM CAST(POS.receipt_tmsp AS TIME)) < 30
      THEN '15'
      WHEN EXTRACT(MINUTE FROM CAST(POS.receipt_tmsp AS TIME)) < 45
      THEN '30'
      ELSE '45'
      END AS uhrzeit,
    POS.cashier_id,
    t6.int_itemgroup_cd,
    ROUND(CAST(POS.main_item_grp_cd AS BIGNUMERIC), 0) AS subitemgroup_id,
    SUM(CASE
      WHEN POS.weight_item_fg = 0
      THEN POS.sales_piece_qty
      ELSE 0
      END) AS sales_piece_qty,
    SUM(CASE
      WHEN POS.weight_item_fg = 1
      THEN POS.sales_weight_qty
      ELSE 0
      END) AS sales_weight_qty,
    POS.dwh_created
   FROM ldl_p_lew_core_ac.v_pos_receiptline_2 AS POS
    INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS CMP ON POS.client_id = CMP.client_id AND POS.dwh_cal_dt
      BETWEEN CMP.migration_dat_valid_from AND CMP.migration_dat_valid_to
    INNER JOIN (SELECT client_id,
      mainitemgroup_cd,
      subitemgroup_cd,
      int_itemgroup_cd
     FROM ldl_p_lew_mart_cs.v_cs_subitemgroup_2
     GROUP BY client_id,
      subitemgroup_cd,
      mainitemgroup_cd,
      int_itemgroup_cd) AS t6 ON POS.client_id = t6.client_id AND POS.main_item_grp_cd = t6.subitemgroup_cd
   WHERE POS.turnover_relevant_fg = 1
   GROUP BY POS.client_id,
    store_id,
    dat_formdate,
    uhrzeit,
    POS.cashier_id,
    t6.int_itemgroup_cd,
    subitemgroup_id,
    POS.dwh_created) AS erg;