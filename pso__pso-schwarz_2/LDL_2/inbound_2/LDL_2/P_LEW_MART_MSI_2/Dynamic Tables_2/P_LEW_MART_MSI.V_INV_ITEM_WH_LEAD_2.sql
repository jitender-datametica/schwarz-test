
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_INV_ITEM_WH_LEAD_2 
/*
#DescStart# 
#$Revision: 9097 $, $LastChangedBy: aarnold $   
#SubjectAreas# Inventur_2 
#DescEnd#   
*/ 
(  
   client_id   
  ,wh_id 
  ,item_id  
  ,dat_dayend  
  ,dat_formdate   
  ,inv_id   
  ,inv_type 
  ,inv_desc 
  ,byr   
  ,inv_eval_fg 
  ,store_place 
  ,aisle_desc  
  ,slot_nr  
  ,diff_qty_inv_wh   
  ,price_retail_inv_wh  
  ,price_retail_net_inv_wh 
  ,diff_inv_wh_val   
  ,diff_inv_wh_net_val  
  ,qty_case_inv_wh   
  ,qty_piece_inv_wh  
  ,qty_expected_inv_wh  
  ,qty_total_inv_wh  
  ,qty_ramp_inv_wh   
  ,case_size_dec  
  ,currency_iso_cd   
)  

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS 
   SELECT   
      inv.client_id, 
   inv.wh_id,  
   itmp.item_sid_map AS item_id, 
   inv.dat_dayend,   
   inv.dat_formdate, 
   inv.inv_id, 
   inv.inv_type,  
   inv.inv_desc,  
   inv.byr, 
   inv.inv_eval_fg,  
   inv.store_place,  
   inv.aisle_desc,   
   inv.slot_nr,   
   inv.diff_qty_inv_wh, 
   inv.price_retail_inv_wh,   
   inv.price_retail_net_inv_wh,  
   inv.diff_inv_wh_val, 
   inv.diff_inv_wh_net_val,   
   inv.qty_case_inv_wh, 
   inv.qty_piece_inv_wh,   
   inv.qty_expected_inv_wh,   
   inv.qty_total_inv_wh,   
   inv.qty_ramp_inv_wh, 
   inv.case_size_dec,   
   inv.currency_iso_cd  
     FROM   
     (   
       SELECT  
          stw.client_id,   
   wh.src_wh_id AS wh_id,  
   stw.item_sid,  
   stw.dat_dayend,   
   stw.dat_formdate, 
   stw.inv_id, 
   stw.inv_type,  
   stw.inv_desc,  
   stw.busyear    AS byr,  
   stw.inv_eval_fg,  
   stw.store_place,  
   stw.aisle_desc,   
   stw.slot_nr,   
   stw.diff_qty_inv_wh, 
   stw.price_retail_inv_wh     / curr.rate_currency_exchange AS price_retail_inv_wh,   
   stw.price_retail_net_inv_wh / curr.rate_currency_exchange AS price_retail_net_inv_wh,  
   ZeroIfNull(stw.diff_qty_inv_wh * stw.price_retail_inv_wh)      AS diff_inv_wh_val,  
   ZeroIfNull(stw.diff_qty_inv_wh * stw.price_retail_net_inv_wh)  AS diff_inv_wh_net_val, 
   stw.qty_case_inv_wh, 
   stw.qty_piece_inv_wh,   
   stw.qty_expected_inv_wh,   
   stw.qty_total_inv_wh,   
   stw.qty_ramp_inv_wh, 
   stw.case_size_dec,   
   curr.currency_iso_cd 
       FROM p_lew_core_ac.v_wawi_inv_item_wh_2 AS stw   
   INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh 
   ON stw.client_id = wh.client_id  
   AND stw.wh_loc_sid = wh.loc_sid_wh  
   AND wh.dwh_actual_fg = 1   
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS curr    /*  Waehrungsumrechner  */  
   ON stw.client_id = curr.client_id   
   AND CURRENT_DATE BETWEEN curr.dat_rec_start AND curr.dat_rec_end  
   
 WHERE stw.inv_type = 'F'  
   
 UNION   
   
 SELECT  
    inv.client_id,   
   inv.wh_id                  AS wh_id,   
   inv.item_id                AS item_sid,   
   inv.dat_formdate           AS dat_dayend, 
   inv.dat_formdate, 
   CAST(1 AS INTEGER)         AS inv_id,  
   CAST(NULL  AS VARCHAR(5))  AS inv_type,   
   CAST(NULL  AS VARCHAR(35)) AS inv_desc,   
   NULL                       AS byr,  
   NULL                       AS inv_eval_fg,   
   NULL                       AS store_place,   
   CAST(NULL  AS VARCHAR(35)) AS aisle_desc, 
   NULL                       AS slot_nr, 
   inv.diff_inv_stc_calc_cnt                       AS diff_qty_inv_wh,  
   inv.gross_prcs_calc / b.exchange_rate          AS price_retail_inv_wh,  
   inv.net_prcs_calc   / b.exchange_rate           AS price_retail_net_inv_wh,   
   inv.diff_inv_stc_calc_val / b.exchange_rate     AS diff_inv_wh_val,  
   inv.diff_inv_stc_calc_net_val / b.exchange_rate AS diff_inv_wh_net_val, 
   NULL                       AS qty_case_inv_wh,  
   NULL                       AS qty_piece_inv_wh, 
   NULL                       AS qty_expected_inv_wh, 
   NULL                       AS qty_total_inv_wh, 
   NULL                       AS qty_ramp_inv_wh,  
   NULL                       AS case_size_dec, 
   b.curr_cd_from             AS currency_iso_cd   
       FROM p_lew_mart_msi.v_agg_inv_item_wh_day_2 AS inv  
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_2 AS b /* Waehrungsumrechner */   
   ON b.client_id = inv.client_id   
   AND CURRENT_DATE BETWEEN b.active_from_dt AND b.active_to_dt   
   AND CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to   
   INNER JOIN p_lew_core_ac.v_exchange_rate_type_2 AS c 
   ON c.client_id = b.client_id  
   AND c.x_rate_type_sid = b.x_rate_type_sid 
   AND c.src_kurst = '@BEWE'  
) AS inv 
   INNER JOIN p_lew_core_ac.v_item_map_key_2 itmp 
   ON itmp.client_id = inv.client_id   
   AND itmp.item_sid = inv.item_sid 
;
