/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_STORE_STOCK_1
#----------------------------------------------------------------------------
# History:
#  1.0  2023-06-12    Ulrich ross          Remove eLWIS logic
#                                          https://dev.azure.com/schwarzit/schwarzit.biaid/_boards/board/t/Data%20Extraction%20And%20Export/Stories/?workitem=488527
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_store_stock_1 AS 
SELECT 
 client_id,
 wh_id,
 orig_store_nr,
 orig_item_nr,
 dwh_cal_dt AS dat_formdate,
 stock_calc_qty AS qty_stc_calc,
 dwh_cal_dt_14 AS dat_formdate_14,
 stock_calc_qty_14 AS qty_stc_calc_14,
 DATE(NULL) AS min_dat_formdate_14
FROM (
  SELECT 
   t7.client_id,
   t7.wh_id,
   t7.orig_store_nr,
   t7.orig_item_nr,
   MAX(t7.`A11869`) AS dwh_cal_dt,
   MAX(t7.`A118610`) AS stock_calc_qty,
   MAX(t7.`A118611`) AS dwh_cal_dt_14,
   MAX(t7.`A118612`) AS stock_calc_qty_14
  FROM (
    SELECT stc2.client_id,
     ST2WH.src_wh_id AS wh_id,
     ST2WH.src_orig_store_nr AS orig_store_nr,
     ROUND(CAST(ITM.src_orig_item_nr AS BIGNUMERIC), 0) AS orig_item_nr,
      CASE
      WHEN stc2.wk = 1
      THEN stc2.`_dwh_valid_to`
      ELSE NULL
      END AS `A11869`,
      CASE
      WHEN stc2.wk = 1
      THEN stc2.calc_qty
      ELSE NULL
      END AS `A118610`,
      CASE
      WHEN stc2.wk = 2
      THEN stc2.`_dwh_valid_to`
      ELSE NULL
      END AS `A118611`,
      CASE
      WHEN stc2.wk = 2
      THEN stc2.calc_qty + stc2.diff_qty_inv_calc
      ELSE NULL
      END AS `A118612`
    FROM (
      SELECT client_id,
        item_sid,
        loc_sid,
        calc_qty,
        diff_qty_inv_calc,
        LEAST(dwh_valid_to, DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) AS `_dwh_valid_to`,
        1 AS wk
       FROM ldl_p_lew_core_ac.v_item_location_stock_hist_1 AS STC
       WHERE dwh_valid_from <= DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
        AND DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY) <= dwh_valid_to
        AND src_space_switch = 3
       UNION ALL
       SELECT client_id,
        item_sid,
        loc_sid,
        calc_qty,
        diff_qty_inv_calc,
        LEAST(dwh_valid_to, DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) AS `_dwh_valid_to`,
        2 AS wk
       FROM ldl_p_lew_core_ac.v_item_location_stock_hist_1 AS STC
       WHERE dwh_valid_from <= DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY)
        AND DATE_SUB(CURRENT_DATE, INTERVAL 21 DAY) <= dwh_valid_to
        AND src_space_switch = 3
      ) AS stc2
     INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS ST2WH ON stc2.client_id = ST2WH.client_id AND stc2.loc_sid
         = ST2WH.loc_sid_store AND ST2WH.loc_sid_store <> ST2WH.loc_sid_wh
     INNER JOIN ldl_p_lew_core_ac.v_item_1 AS ITM ON stc2.client_id = ITM.client_id AND stc2.item_sid = ITM.item_sid
     INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS MIG ON stc2.client_id = MIG.client_id AND (stc2.`_dwh_valid_to`
          < MIG.migration_dat_valid_from OR stc2.`_dwh_valid_to` > MIG.migration_dat_valid_to)
    WHERE ITM.src_orig_item_nr IS NOT NULL
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(stc2.client_id AS STRING), CAST(ST2WH.src_wh_id AS STRING), CAST(ST2WH.src_orig_store_nr AS STRING)
          , ITM.src_orig_item_nr, stc2.wk ORDER BY stc2.`_dwh_valid_to` IS NULL, stc2.`_dwh_valid_to`)) = 1
  ) AS t7
  GROUP BY t7.client_id,
   t7.wh_id,
   t7.orig_store_nr,
   t7.orig_item_nr
) AS t9
WHERE t9.dwh_cal_dt IS NOT NULL;