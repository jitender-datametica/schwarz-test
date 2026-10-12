/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_STORE_STOCK
#----------------------------------------------------------------------------
# History:
#  1.0  2023-06-12    Ulrich ross          Remove eLWIS logic
#                                          https://dev.azure.com/schwarzit/schwarzit.biaid/_boards/board/t/Data%20Extraction%20And%20Export/Stories/?workitem=488527
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_STORE_STOCK
AS
SELECT
   client_id       /* CR: country_iso_cd to client_id */
  ,wh_id
  ,orig_store_nr
  ,orig_item_nr
  ,dwh_cal_dt             AS dat_formdate
  ,stock_calc_qty         AS qty_stc_calc
  ,dwh_cal_dt_14          AS dat_formdate_14
  ,stock_calc_qty_14      AS qty_stc_calc_14
  ,min_dat_formdate_14
FROM
(
  SELECT
     client_id
    ,wh_id
    ,orig_store_nr
    ,orig_item_nr
    ,MAX(CASE WHEN wk=1 THEN _dwh_valid_to ELSE NULL END)                  AS dwh_cal_dt
    ,MAX(CASE WHEN wk=1 THEN calc_qty ELSE NULL END)                       AS stock_calc_qty
    ,MAX(CASE WHEN wk=2 THEN _dwh_valid_to ELSE NULL END)                  AS dwh_cal_dt_14
    ,MAX(CASE WHEN wk=2 THEN (calc_qty + diff_qty_inv_calc) ELSE NULL END) AS stock_calc_qty_14
    ,CAST(NULL AS DATE)                                                    AS min_dat_formdate_14  /* eLWIS column */
  FROM
  (
    SELECT
       stc2.client_id                         AS client_id
      ,st2wh.src_wh_id                        AS wh_id
      ,st2wh.src_orig_store_nr                AS orig_store_nr
      ,CAST(itm.src_orig_item_nr AS BIGINT)   AS orig_item_nr
      ,stc2._dwh_valid_to
      ,stc2.calc_qty
      ,stc2.diff_qty_inv_calc
      ,stc2.wk
    FROM
    (
      SELECT
         client_id
        ,item_sid
        ,loc_sid
        ,stc.calc_qty
        ,stc.diff_qty_inv_calc
        ,LEAST(stc.dwh_valid_to, CURRENT_DATE-1 ) AS _dwh_valid_to
        ,1                                        AS wk
      FROM p_lew_core_ac.v_item_location_stock_hist stc
      WHERE dwh_valid_from <= CURRENT_DATE-1
        AND CURRENT_DATE - 7 <= dwh_valid_to
        AND src_space_switch=3
      UNION ALL
      SELECT
         client_id
        ,item_sid
        ,loc_sid
        ,stc.calc_qty
        ,stc.diff_qty_inv_calc
        ,LEAST(stc.dwh_valid_to, CURRENT_DATE-1 )  AS _dwh_valid_to
        ,2                                        AS wk
      FROM p_lew_core_ac.v_item_location_stock_hist stc
      WHERE dwh_valid_from <= CURRENT_DATE-14
        AND CURRENT_DATE - 21 <= dwh_valid_to
        AND src_space_switch=3
    ) stc2
  INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown st2wh
  ON st2wh.client_id     = stc2.client_id
  AND st2wh.loc_sid_store = stc2.loc_sid
  /* Exclude stores which represent a warehouse */
  AND st2wh.loc_sid_store <> st2wh.loc_sid_wh

  INNER JOIN p_lew_core_ac.v_item itm
  ON itm.client_id = stc2.client_id
  AND itm.item_sid  = stc2.item_sid

  /* Um nur auf die NICHT-SAP-Länder zu filtern */
  INNER JOIN p_lew_core_ac.v_client_migration_per mig
  ON mig.client_id = stc2.client_id
  AND (    stc2._dwh_valid_to < mig.migration_dat_valid_from
       OR stc2._dwh_valid_to > mig.migration_dat_valid_to
     )

  /*Filter WAWI Seite: Altbestaende aus ELWIS Zeit fuer AT*/
  WHERE itm.src_orig_item_nr IS NOT NULL
  QUALIFY ROW_NUMBER() OVER (
  PARTITION BY
      stc2.client_id
     ,st2wh.src_wh_id
     ,st2wh.src_orig_store_nr
     ,itm.src_orig_item_nr
     ,stc2.wk
  ORDER BY
      stc2._dwh_valid_to DESC NULLS LAST
     )= 1
  ) x
  GROUP BY 1,2,3,4
  /* original SQL was wk1 LEFT OUTER JOIN wk2. Set wk1 as base. */
  HAVING MAX(CASE WHEN wk=1 THEN _dwh_valid_to END) IS NOT NULL
) uni
;
