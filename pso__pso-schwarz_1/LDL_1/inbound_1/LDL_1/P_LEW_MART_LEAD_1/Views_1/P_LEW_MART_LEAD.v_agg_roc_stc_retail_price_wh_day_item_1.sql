CREATE OR REPLACE  VIEW p_lew_mart_lead.v_agg_roc_stc_retail_price_wh_day_item_1 (
	 client_id
	,wh_id
	,item_sid
	,dwh_cal_dt
    ,currency_iso_cd
	,stock_fg
	,item_group_fg
	,qty_piece_stc_wh_roc
    ,qty_piece_stc_wh
	,current_retail_net_price 
	,last_retail_net_price
    ,roc_stc_in_retail_price
    ,stc_in_retail_price
   
) AS 
 SELECT 
     wdi.client_id
	,wh.src_wh_id AS wh_id
	,wdi.item_sid
	,wdi.dwh_cal_dt 
    ,cry.curr_cd_from                                                                         AS currency_iso_cd
	,wdi.stock_fg
	,wdi.item_group_fg
	,iwd.qty_piece_stc_wh                                                                    AS qty_piece_stc_wh_roc
    ,wdi.qty_piece_stc_wh                                                                    AS qty_piece_stc_wh
	,NULLIFZERO(wdi.current_wh_stc_retail_net_price / cry.exchange_rate::DECIMAL(19,5) )      AS current_retail_net_price
	,NULLIFZERO(wdi.last_wh_stc_retail_net_price / cry.exchange_rate::DECIMAL(19,5) )         AS last_retail_net_price
    ,iwd.qty_piece_stc_wh * last_retail_net_price                                             AS roc_stc_in_retail_price
	,wdi.qty_piece_stc_wh * last_retail_net_price                                             AS stc_in_retail_price
    
        
FROM p_lew_bil_ac.v_agg_roc_wh_day_item_1 wdi
INNER JOIN p_lew_bil_ac.v_warehouse_1 wh	
   ON (wdi.client_id=wh.client_id	
   AND wdi.loc_sid_wh=wh.loc_sid_wh)
      AND wh.dwh_actual_fg  = 1	
   AND wh.bges_active_fg = 1
LEFT JOIN p_lew_mart_msi.v_itm_item_wh_day_roc_1 iwd
 ON (wdi.client_id = iwd.client_id
AND wh.src_wh_id = iwd.wh_id
AND wdi.item_sid = iwd.item_id
AND wdi.dwh_cal_dt = iwd.dat_formdate
AND iwd.flags_combined = '0000')
INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_1 AS cry	
   ON  wdi.client_id = cry.client_id	
   /*	
   # latest rate (point in history)	
   */	
   AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt	
   /*	
   # latest history (version)	
   */	
   AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to	
  INNER JOIN p_lew_core_ac.v_exchange_rate_type_1 AS ert	
   ON  cry.client_id       = ert.client_id	
   AND cry.x_rate_type_sid = ert.x_rate_type_sid	
   /*	
   # reporting rate (slow moving)	
   */	
   AND ert.src_kurst       = '@BEWE'	
   /*	
   # selection of partitions	
   */	

   WHERE wdi.dwh_cal_dt <= CURRENT_DATE	
     AND wdi.client_id < 41	
 GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13;