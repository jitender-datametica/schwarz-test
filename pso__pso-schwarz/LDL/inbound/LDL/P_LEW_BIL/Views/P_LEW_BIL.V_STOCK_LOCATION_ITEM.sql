create or replace view LDL_PRODUCTION.P_LEW_BIL.V_STOCK_LOCATION_ITEM(
	CLIENT_ID,
	LOC_SID,
	ITEM_SID,
	DWH_CAL_DT,
	STOCK_CALC_QTY,
	STOCK_INV_QTY,
	STOCK_REAL_QTY,
	STOCK_INV_DIFF_CALC,
	PRICE,
	PRICE_NET,
	SRC_SPACE_SWITCH,
	STORE_STORAGE_QTY,
	DWH_VALID_FROM,
	DWH_VALID_TO
) as
SELECT
	 fes.client_id AS client_id
	,fes.loc_sid   AS loc_sid
	,fes.item_sid  AS item_sid
	,fes.dwh_cal_dt AS dwh_cal_dt
	,SUM(fes.stock_calc_qty) AS stock_calc_qty
	,SUM(fes.stock_inv_qty) AS stock_inv_qty
	,SUM(fes.stock_real_qty) AS stock_real_qty
	,SUM(fes.stock_inv_diff_calc) AS stock_inv_diff_calc
	,SUM(fes.price) AS price
	,SUM(fes.price_net) AS price_net
	,SUM(fes.src_space_switch) AS src_space_switch
	,SUM(fes.store_storage_qty) AS store_storage_qty
	,MAX(fes.dwh_valid_from) AS dwh_valid_from
	,MAX(fes.dwh_valid_to) AS dwh_valid_to
FROM
(
	SELECT
	hist.client_id AS client_id
	,hist.loc_sid AS loc_sid
	,hist.item_sid AS item_sid
	,cal.cal_dt AS dwh_cal_dt
	,hist.calc_qty AS stock_calc_qty
	,hist.inv_qty AS stock_inv_qty
	,CASE WHEN ZeroIfNull(diff_qty_inv_calc)=0 THEN hist.calc_qty ELSE hist.inv_qty END AS stock_real_qty
	,hist.diff_qty_inv_calc AS stock_inv_diff_calc
	,hist.price AS price
	,hist.price_net AS price_net
	,hist.src_space_switch
	,NULL AS store_storage_qty
	,hist.dwh_valid_from
	,hist.dwh_valid_to
	FROM p_lew_core_ac.v_cal_calendarday AS cal
		INNER JOIN p_lew_core_ac.v_item_location_stock_hist AS hist
		ON cal.cal_dt BETWEEN hist.dwh_valid_from AND hist.dwh_valid_to
	UNION ALL
	SELECT
	stk.client_id AS client_id
	,stk.loc_sid AS loc_sid
	,stk.item_sid AS item_sid
	,cal.cal_dt AS dwh_cal_dt
	,NULL AS stock_calc_qty
	,NULL AS stock_inv_qty
	,NULL AS stock_real_qty
	,NULL AS stock_inv_diff_calc
	,NULL AS price
	,NULL AS price_net
	,NULL src_space_switch
	,stk.store_storage_qty AS store_storage_qty
	,NULL dwh_valid_from
	,NULL dwh_valid_to
	FROM  p_lew_core_ac.v_cal_calendarday AS cal
		INNER JOIN p_lew_core_ac.v_item_store_storage_stock_hist AS stk
		ON cal.cal_dt BETWEEN stk.dwh_valid_from AND stk.dwh_valid_to
) fes
GROUP BY fes.client_id, fes.loc_sid, fes.item_sid,fes.dwh_cal_dt
;
