CREATE OR REPLACE  VIEW p_lew_mart_lead_ac.v_agg_roc_stc_retail_price_wh_day_item_1 (
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
) AS SELECT 
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
 FROM  p_lew_mart_lead.v_agg_roc_stc_retail_price_wh_day_item_1;