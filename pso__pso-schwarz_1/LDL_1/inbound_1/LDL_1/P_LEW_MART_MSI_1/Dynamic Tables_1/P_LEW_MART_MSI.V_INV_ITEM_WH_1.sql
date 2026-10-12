
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_INV_ITEM_WH_1   
/*
   #DescStart# 
   #$Revision: 9096 $, $LastChangedBy: aarnold $   
   #SubjectAreas#: Inventur_1   
   #DescEnd#   
   */ 
   (  
      client_id   
   ,  wh_id 
   ,  item_id  
   ,  dat_dayend  
   ,  dat_formdate   
   ,  inv_id   
   ,  inv_type 
   ,  inv_desc 
   ,  byr   
   ,  inv_eval_fg 
   ,  store_place 
   ,  aisle_desc  
   ,  slot_nr  
   ,  diff_qty_inv_wh   
   ,  price_retail_inv_wh  
   ,  price_retail_net_inv_wh 
   ,  qty_case_inv_wh   
   ,  qty_piece_inv_wh  
   ,  qty_expected_inv_wh  
   ,  qty_total_inv_wh  
   ,  qty_ramp_inv_wh   
   ,  case_size_dec  
   ,  store_id 
   ,  currency_iso_cd   
   )  

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

   AS 
      SELECT   
        stw.client_id                                           AS client_id, 
      wh.src_wh_id AS wh_id,  
      stw.item_sid                                            AS item_id,  
      stw.dat_dayend                                          AS dat_dayend,  
      stw.dat_formdate                                        AS dat_formdate,   
      stw.inv_id                                              AS inv_id,   
      stw.inv_type                                            AS inv_type, 
      stw.inv_desc                                            AS inv_desc, 
      stw.busyear                                             AS byr,   
      stw.inv_eval_fg                                         AS inv_eval_fg, 
      stw.store_place                                         AS store_place, 
      stw.aisle_desc                                          AS aisle_desc,  
      stw.slot_nr                                             AS slot_nr,  
      stw.diff_qty_inv_wh                                     AS diff_qty_inv_wh,   
      stw.price_retail_inv_wh / rate_currency_exchange        AS price_retail_inv_wh,  
      stw.price_retail_net_inv_wh / rate_currency_exchange    AS price_retail_net_inv_wh, 
      stw.qty_case_inv_wh                                     AS qty_case_inv_wh,   
      stw.qty_piece_inv_wh                                    AS qty_piece_inv_wh,  
      stw.qty_expected_inv_wh                                 AS qty_expected_inv_wh,  
      stw.qty_total_inv_wh                                    AS qty_total_inv_wh,  
      stw.qty_ramp_inv_wh                                     AS qty_ramp_inv_wh,   
      stw.case_size_dec                                       AS case_size_dec,  
      osk.st_loc_sid                                          AS store_id, 
      cry.currency_iso_cd                                     AS currency_iso_cd 
   
   
   
      FROM p_lew_core_ac.v_wawi_inv_item_wh_1 AS stw 
      INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh 
      ON wh.client_id = stw.client_id  
      AND wh.loc_sid_wh =  stw.wh_loc_sid 
      AND wh.dwh_actual_fg = 1   
      INNER JOIN p_lew_core_ac.v_wawi_org_store_skey_1 osk 
      ON     osk.client_id = stw.client_id   
      AND   
       osk.orig_store_nr  = wh.src_wh_id /* MJD: changed from = stw.wh_loc_sid */   
      AND   
       CURRENT_DATE BETWEEN osk.dat_rec_start AND osk.dat_rec_end 
      INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS cry   
      ON     STW.client_id = cry.client_id   
      AND   
       CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end 
      AND   
       STW.inv_type = 'F'  
;
