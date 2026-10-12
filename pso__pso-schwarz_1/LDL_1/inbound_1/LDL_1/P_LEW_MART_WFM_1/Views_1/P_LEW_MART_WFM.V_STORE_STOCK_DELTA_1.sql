CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_STORE_STOCK_DELTA_1
AS
   SELECT
   client_id                AS client_id
   ,wh_id                   AS wh_id
   ,orig_store_nr           AS store
   ,orig_item_nr            AS item_1
   ,dwh_cal_dt              AS stock_dat
   ,stock_calc_qty          AS qty_stc_calc
   ,CAST(NULL AS INTEGER)   AS load_id
   ,CASE WHEN ZEROIFNULL(diff_qty_inv_calc)=0 THEN stock_calc_qty ELSE inv_qty END AS qty_stc_real

   FROM
   (
       SELECT   stc.client_id            AS client_id 
               ,st2wh.src_wh_id          AS wh_id
               ,st2wh.src_orig_store_nr  AS orig_store_nr
               ,CAST(itm.src_orig_item_nr AS BIGINT)   AS orig_item_nr
               ,stc.dwh_valid_from  AS dwh_cal_dt
               ,stc.calc_qty AS stock_calc_qty
               ,stc.diff_qty_inv_calc AS diff_qty_inv_calc
               ,stc.inv_qty AS inv_qty

       FROM p_lew_core_ac.v_item_location_stock_hist_1 stc
      
       INNER JOIN p_lew_process_ac.v_wfm_last_export_1 ex
       ON ex.last_export_tmsp <= stc.dwh_updated
       AND ex.process_name = 'export_wfm_store_stock'
       AND ex.process_specification = 'delta'
       AND stc.dwh_valid_from BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE
       AND stc.src_space_switch=3
   
       INNER JOIN p_lew_process_ac.v_wfm_export_specification_1 expo_spec
       ON ex.export_specification = expo_spec.export_specification
       AND stc.client_id = expo_spec.client_id
  
       INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown_1 st2wh
       ON st2wh.client_id     = stc.client_id
       AND st2wh.loc_sid_store = stc.loc_sid
       AND st2wh.loc_sid_store <> st2wh.loc_sid_wh /* Exclude stores which represent a warehouse */
   
       INNER JOIN p_lew_core_ac.v_item_1 itm
       ON itm.client_id = stc.client_id
       AND itm.item_sid  = stc.item_sid
   
       INNER JOIN p_lew_core_ac.v_client_migration_per_1 mig
       ON mig.client_id = stc.client_id
       AND (    stc.dwh_valid_from < mig.migration_dat_valid_from
                OR stc.dwh_valid_from > mig.migration_dat_valid_to
           )
  
        WHERE itm.src_orig_item_nr IS NOT NULL   /*Filter WAWI Seite: Altbestaende aus ELWIS Zeit_1 fuer AT*/
    ) uni
;