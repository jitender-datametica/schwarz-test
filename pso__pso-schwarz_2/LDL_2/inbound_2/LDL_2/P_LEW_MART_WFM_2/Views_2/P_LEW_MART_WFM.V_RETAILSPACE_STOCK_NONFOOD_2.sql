CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_RETAILSPACE_STOCK_NONFOOD_2(
	CLIENT_ID
   ,COUNTRY_LIDL_CD
   ,ORIG_STORE_NR
   ,LOC_SID
   ,WH_ID
   ,ORIG_ITEM_NR
   ,ITEM_SID
   ,STOCK_REAL_QTY
   ,VALID_FROM_STOCKREAL
   ,VALID_TO_STOCKREAL
   ,STORE_STORAGE_QTY
   ,VALID_FROM_STORESTORAGE
   ,VALID_TO_STORESTORAGE
) AS

WITH storage_stock AS(
SELECT
   stk.client_id                                    AS client_id
  ,cntry.src_country_lidl_cd                        AS country_lidl_cd
  ,sm.orig_store_nr                                 AS orig_store_nr
  ,stk.loc_sid                                      AS loc_sid
  ,st2wh.src_wh_id                                  AS wh_id
  ,item.orig_item_nr                                AS orig_item_nr
  ,stk.item_sid                                     AS item_sid
  ,stk.store_storage_qty                            AS store_storage_qty
  ,max_dat.dwh_valid_from_max                       AS valid_from_storestorage
  ,stk.dwh_valid_to                                 AS valid_to_storestorage
  
FROM p_lew_core_ac.v_item_store_storage_stock_hist_2  AS stk

INNER JOIN 
  ( SELECT client_id,loc_sid,item_sid,MAX(dwh_valid_from) AS dwh_valid_from_max
    FROM p_lew_core_ac.v_item_store_storage_stock_hist_2
    GROUP BY 1,2,3
  ) AS max_dat

  ON stk.client_id = max_dat.client_id
  AND stk.loc_sid = max_dat.loc_sid
  AND stk.item_sid = max_dat.item_sid
  AND stk.dwh_valid_from = max_dat.dwh_valid_from_max
  
INNER JOIN P_LEW_MART_MSI_AC.v_org_store_merge_2 AS sm_2
  ON stk.client_id = sm.client_id
  AND stk.loc_sid = sm.store_id
  
INNER JOIN p_lew_mart_lead_ac.v_itm_item_2 AS item_2
  ON stk.client_id = item.client_id 
  AND stk.item_sid = item.item_id  
  
INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS st2wh
  ON st2wh.client_id     = stk.client_id
  AND st2wh.loc_sid_store = stk.loc_sid
  AND st2wh.loc_sid_store <> st2wh.loc_sid_wh
   -- Exclude stores which represent a warehouse 
  
INNER JOIN p_lew_core_ac.v_country_2 AS cntry 
  ON stk.client_id = cntry.country_sid    

LEFT JOIN p_lew_core_ac.v_wawi_itm_item_act_2 AS item_act
  ON stk.item_sid = item_act.item_sid
  AND stk.client_id = item_act.client_id
  
LEFT JOIN p_lew_core_ac.v_wawi_itm_subitemgroup_2 AS suig
  ON suig.client_id = item_act.client_id
  AND suig.subitemgroup_id = item_act.subitemgroup_id
  AND CURRENT_DATE - 1 BETWEEN suig.dat_rec_start AND suig.dat_rec_end
  
WHERE sm.aspect_id = 1
  AND sm.dashboard_relevant_fg = 1
  AND suig.itemgroup_int_id = 70                
  AND CURRENT_DATE - 1 BETWEEN stk.dwh_valid_from AND stk.dwh_valid_to     
 
)

SELECT 
   ss.client_id
  ,ss.country_lidl_cd
  ,ss.orig_store_nr
  ,ss.loc_sid
  ,ss.wh_id
  ,ss.orig_item_nr
  ,ss.item_sid
  ,CASE WHEN ZeroIfNull(diff_qty_inv_calc)=0 THEN hist.calc_qty ELSE hist.inv_qty END AS stock_real_qty
  ,max_dat.dwh_valid_from_max AS valid_from_stockreal
  ,hist.dwh_valid_to AS valid_to_stockreal
  ,ss.store_storage_qty
  ,ss.valid_from_storestorage
  ,ss.valid_to_storestorage
  
FROM storage_stock AS ss

INNER JOIN p_lew_core_ac.v_item_location_stock_hist_2 AS hist
  ON ss.client_id = hist.client_id
  AND ss.loc_sid = hist.loc_sid
  AND ss.item_sid = hist.item_sid
  
INNER JOIN 
  ( SELECT hist.client_id,hist.loc_sid,hist.item_sid,MAX(hist.dwh_valid_from) AS dwh_valid_from_max
    FROM storage_stock AS ss
    LEFT JOIN p_lew_core_ac.v_item_location_stock_hist_2 AS hist
      ON ss.client_id = hist.client_id
      AND ss.loc_sid = hist.loc_sid
      AND ss.item_sid = hist.item_sid
    WHERE hist.dwh_valid_from > CURRENT_DATE - 200
    GROUP BY 1,2,3
  ) AS max_dat
    
  ON hist.client_id = max_dat.client_id
  AND hist.loc_sid = max_dat.loc_sid
  AND hist.item_sid = max_dat.item_sid
  AND hist.dwh_valid_from = max_dat.dwh_valid_from_max   

  --NEU
  INNER JOIN P_LEW_MART_MSI_AC.v_org_store_merge_2 AS sm_2
    ON hist.client_id = sm.client_id
    AND hist.loc_sid = sm.store_id

  LEFT JOIN p_lew_core_ac.v_wawi_itm_item_act_2 AS item_act
    ON hist.item_sid = item_act.item_sid
    AND hist.client_id = item_act.client_id
  
  LEFT JOIN p_lew_core_ac.v_wawi_itm_subitemgroup_2 AS suig
    ON suig.client_id = item_act.client_id
    AND suig.subitemgroup_id = item_act.subitemgroup_id
    AND CURRENT_DATE - 1 BETWEEN suig.dat_rec_start AND suig.dat_rec_end
  --NEU ENDE    
   
  WHERE hist.dwh_valid_from > CURRENT_DATE - 200  
    AND suig.itemgroup_int_id = 70
    AND sm.aspect_id = 1
    AND sm.dashboard_relevant_fg = 1
;