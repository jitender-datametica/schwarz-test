CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_WH_STOCK_DAY_CASE_SIZE_DELTA_2
AS
/* WaWi Part */
SELECT
  wh_stock_wawi.client_id                                      AS client_id
   ,wh_stock_wawi.wh_id                                          AS wh_id
   ,wh_stock_wawi.orig_item_nr                                   AS item_2
   ,wh_stock_wawi.case_size 									 AS case_size
   ,CAST(wh_stock_wawi.dat_formdate AS VARCHAR) AS stock_dat
   ,CAST(wh_stock_wawi.stock        AS DECIMAL(18,4))            AS stock
   ,CAST(NULL AS INTEGER) AS load_id /* keep NULL for timestamp delta (load_id from export job will be inserted into log table) */
     FROM
     (
       SELECT
          wh_stock.client_id AS client_id
   ,wh_stock.wh_id AS wh_id
   ,wh_stock.orig_item_nr AS orig_item_nr
   ,wh_stock.case_size AS case_size
   ,wh_stock.dat_formdate AS dat_formdate
   ,wh_stock.stock
       FROM
       (
         SELECT
            stc.client_id
   ,loc.src_wh_id             AS wh_id
   ,CAST(itm.src_orig_item_nr AS BIGINT)  AS orig_item_nr
   ,itm.src_case_size AS case_size
   ,stc.dat_formdate          AS dat_formdate
   ,SUM(stc.calc_qty)         AS stock
         FROM
         (
           SELECT
              stc0.client_id
   ,stc0.loc_sid
   ,stc0.item_sid
   ,stc0.dwh_valid_from AS dat_formdate
   ,stc0.calc_qty
   ,stc0.dwh_load_id
           FROM p_lew_core_ac.v_item_location_stock_hist_2 stc0
   INNER JOIN p_lew_process_ac.v_wfm_last_export_2 ex
   ON ex.last_export_tmsp <= stc0.dwh_updated
   AND ex.process_name = 'export_wfm_wh_stock_day_case_size'
   AND ex.process_specification = 'delta'
   AND stc0.dwh_valid_from BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE
   INNER JOIN p_lew_process_ac.v_wfm_export_specification_2 expo_spec
   ON ex.export_specification = expo_spec.export_specification
   AND stc0.client_id = expo_spec.client_id
) stc
   INNER JOIN p_lew_core_ac.v_item_2 itm
   ON stc.client_id = itm.client_id
   AND stc.item_sid = itm.item_sid
   INNER JOIN p_lew_core_ac.v_location_2 loc
   ON stc.client_id = loc.client_id
   AND stc.loc_sid = loc.loc_sid
   AND loc.wh_store_mark = 'B'
   INNER JOIN p_lew_core_ac.v_client_migration_per_2 mig
   ON mig.client_id = stc.client_id
   AND
   (
     stc.dat_formdate < mig.migration_dat_valid_from
     OR stc.dat_formdate > mig.migration_dat_valid_to
   )

 /*Filter WAWI Seite: Altbestaende aus ELWIS Zeit_2 fuer AT*/
 WHERE itm.src_orig_item_nr IS NOT NULL

 GROUP BY 1,2,3,4,5
) wh_stock

) AS wh_stock_wawi
;