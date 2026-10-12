CREATE OR REPLACE VIEW FE_MSTR_AUTODISPO.AUTDI_50 (
	ANZAHL
	,COUNTRY
	,STORE
	,PREV_DAY
	,ITEM_NR
	,ITEMDESC
	,ENTRYDATE
	,WAREHOUSEMIL
	,ORDERAREA
	,STD
	,STATUS
	,QUANTITY
	,CAPACITY
	,ORD_ORDER_TYPE
    ,ORD_STORECALCULATION_ID
	,STORE_WH
	,STORE_ADDRESS
	,ITEM_SUB_GROUP_NR
	,ITEM_FAMILY_GROUP_NR
	,ITEM_FAMILY_GROUP
	,ITEM_SUB_GROUP
	,REASON
	,SUB_REASON
	,REASONS
	) AS
	/* Version: 2.3
	** Author:	Dominik Pfarr
	** Date: 	2024-07-24
	** Changes:	 adding 2 new reasons for cooldown, adjust multiple reasons, filter on UWG instead of area_name; temp. remove cooldown; adding fpast; adjusting forecast error for today and past, remove chiller and min_max; adjusting partition by; check for fk_mil of last opening date - adjusted; Chiller and multireasons corrected again; reshape evaluation; re-include "other" as default reason; max(storecalculation_id)
	*/
	WITH last_open_day AS (
			SELECT m.country
				,m.store
				,m.item_nr
				,m.itemnr_long
				,m.entrydate
				,m.WAREHOUSEMIL
				,m.ORDERAREA
				,m.STD
				,m.STATUS
				,m.QUANTITY
				,m.CAPACITY
				,MAX(c.cal_dt) AS prev_day
			FROM CORE.T_ORACLE_V_FK_MIL M
			CROSS JOIN FE_MSTR_AUTODISPO.V_DIM_CALENDAR_DATE C
			LEFT JOIN CORE.T_ORACLE_V_SPECIALDAY SD
				ON m.country = sd.country
					AND m.store = sd.store
					AND cal_dt = sd.sp_Day
			WHERE cal_dt BETWEEN m.entrydate::DATE - 8 AND m.entrydate::DATE - 1
				AND entrydate::DATE >= (CURRENT_DATE - 90)
				AND m.quantity = 0
				AND (
					sd.store IS NULL
					OR sd.reports = 1
					)
			GROUP BY m.COUNTRY
				,m.STORE
				,m.ITEM_NR
				,m.itemnr_long
				,m.ENTRYDATE
				,m.WAREHOUSEMIL
				,m.ORDERAREA
				,m.STD
				,m.STATUS
				,m.QUANTITY
				,m.CAPACITY
			)
		,missing_items AS (
			SELECT v.country
				,v.store
				,v.item_nr
				,v.itemnr_long
				,v.entrydate
				,v.WAREHOUSEMIL
				,v.ORDERAREA
				,v.STD
				,v.STATUS
				,v.QUANTITY
				,v.CAPACITY
				,v.prev_day
				,SUM(sales_quantity) sales_quantity
				,SUM(forc_quantity) forc_quantity
			FROM last_open_day v
			LEFT JOIN CORE.T_ORACLE_V_FK_ORDER fo
				ON v.country = fo.country
					AND fo.ord_ITEM_NR = v.item_nr
					AND fo.ord_STORE_nr = v.STORE
					AND DATEADD(DAY, fo.ord_TIME_ID - 365.25 * (4712) - 2, '0000-01-01') = v.ENTRYDATE
					AND ORD_ORDER_TYPE = 'CALCULATION'
			LEFT JOIN CORE.T_ORACLE_V_fk_forecast f
				ON v.country = f.country
					AND f.forc_store_nr = v.STORE
					AND f.forc_item_nr = v.item_nr
					AND f.forc_type = 1
					AND DATEADD(DAY, f.forc_time_id - 365.25 * (4712) - 2, '0000-01-01') >= (CURRENT_DATE - 90)
					AND DATEADD(DAY, f.forc_time_id - 365.25 * (4712) - 2, '0000-01-01') BETWEEN DATEADD(DAY, fo.ord_gen_time_id - 365.25 * (4712) - 2, '0000-01-01') AND v.entrydate
					AND f.deleted = 0
			LEFT JOIN CORE.T_ORACLE_V_fk_sales s
				ON v.country = s.country
					AND s.SALES_ITEM_NR = v.item_nr
					AND s.SALES_STORE_NR = v.STORE
					AND DATEADD(DAY, s.sales_TIME_ID - 365.25 * (4712) - 2, '0000-01-01') BETWEEN DATEADD(DAY, fo.ord_gen_TIME_ID - 365.25 * (4712) - 2, '0000-01-01') AND v.entrydate
					AND f.forc_time_id = s.SALES_TIME_ID
					AND s.deleted = 0
			GROUP BY v.country
				,v.store
				,v.item_nr
				,v.itemnr_long
				,v.entrydate
				,v.WAREHOUSEMIL
				,v.ORDERAREA
				,v.STD
				,v.STATUS
				,v.QUANTITY
				,v.CAPACITY
				,v.prev_day
			)


SELECT 1 AS ANZAHL
	,A.COUNTRY
	,A.STORE
	,a.prev_day
	,A.ITEM_NR
	,A.ITEMDESC
	,A.ENTRYDATE
	,A.WAREHOUSEMIL
	,A.ORDERAREA
	,A.STD
	,A.STATUS
	,A.QUANTITY
	,A.CAPACITY
	,A.ORD_ORDER_TYPE
    ,A.ORD_STORECALCULATION_ID
	,A.STORE_WH
	,A.STORE_ADDRESS
	,A.ITEM_SUB_GROUP_NR
	,A.ITEM_FAMILY_GROUP_NR
	,A.ITEM_FAMILY_GROUP
	,A.ITEM_SUB_GROUP
	,CASE 
		WHEN ARRAY_SIZE(ARRAY_CONSTRUCT_COMPACT(std_err, wh_err, forc_err, status_err)) > 1
			THEN 'Multiple reasons'
		WHEN std_err IS NOT NULL
			THEN 'Store STD error'
		WHEN wh_err IS NOT NULL
			THEN 'WH STD'
		WHEN forc_err IS NOT NULL
			THEN 'Forecast error'
		WHEN status_err IS NOT NULL
			THEN 'Inactive status'
		ELSE 'Other'
		END Reason
	,CASE 
		WHEN ARRAY_SIZE(ARRAY_CONSTRUCT_COMPACT(std_err, wh_err, forc_err, status_err)) > 1
			THEN 'Multiple reasons'
		WHEN ARRAY_SIZE(ARRAY_CONSTRUCT_COMPACT(std_err, wh_err, forc_err, status_err)) = 1
			THEN ARRAY_TO_STRING(ARRAY_CONSTRUCT_COMPACT(std_err, wh_err, forc_err, status_err), ', ')
		ELSE 'Other'
		END SUB_REASON
	,CASE 
		WHEN ARRAY_SIZE(ARRAY_CONSTRUCT_COMPACT(std_err, wh_err, forc_err, status_err)) > 1
			THEN ARRAY_TO_STRING(ARRAY_CONSTRUCT_COMPACT(std_err, wh_err, forc_err, status_err), ', ')
		END REASONS
FROM (
	SELECT m.*
	   	,fo.ord_order_type
        ,fo.ord_storecalculation_id
		,mil.quantity AS prev_quantity
		,mil.std AS prev_std
		,ds.STORE_WH
		,ds.STORE_ADDRESS
		,di.item_name ITEMDESC
		,di.ITEM_SUB_GROUP_NR
		,di.ITEM_FAMILY_GROUP_NR
		,di.ITEM_FAMILY_GROUP
		,di.ITEM_SUB_GROUP
		,CASE 
			WHEN m.STATUS > 9
				THEN 'ADS'
			WHEN ex_item_nr IS NOT NULL
				THEN 'Excluded'
			WHEN m.STATUS IN (5, 6)
				THEN 'New'
			WHEN m.STATUS = 7
				THEN 'Allocation'
			END status_err
		,CASE 
			WHEN (m.quantity - m.STD) - (prev_quantity - prev_STD) > m.capacity * 0.3
				THEN 'Store reporting'
			WHEN (ABS(m.quantity - m.STD) > m.capacity * 0.33)
				THEN 'Store STD error'
			END STD_err
		,CASE 
			WHEN (fd.del_amount * fo.ord_case_size < fo.ORD_PIECES_QUANTITY)
				THEN 'Order modification'
			WHEN (
					opt.opt_type_name = 'Warehouse Stock'
					AND (opt_after IS NOT NULL)
					AND (opt_after <> opt_before)
					)
				THEN 'WH STD'
			WHEN stock_item_nr IS NOT NULL
				THEN 'limited WH STD'
			END wh_err
		,CASE 
			WHEN (
					(s.SALES_QUANTITY > f.forc_quantity)
					AND ((s.SALES_QUANTITY - f.forc_quantity) / DECODE(NVL(f.forc_quantity, 0), 0, - 1, f.forc_quantity)) > 0.2
					)
				THEN 'Forecast error today'
			WHEN (
					(s.SALES_QUANTITY > fminus.forc_quantity)
					AND ((s.SALES_QUANTITY - fminus.forc_quantity) / DECODE(NVL(fminus.forc_quantity, 0), 0, - 1, fminus.forc_quantity)) > 0.2
					)
				THEN 'Forecast error today'
			WHEN (
					(m.SALES_QUANTITY > m.forc_quantity)
					AND ((m.SALES_QUANTITY - m.forc_quantity) / DECODE(NVL(m.forc_quantity, 0), 0, - 1, m.forc_quantity)) > 0.2
					)
				THEN 'Forecast error past'
			END forc_err
	FROM missing_items m
	LEFT JOIN CORE.T_ORACLE_V_FK_MIL mil
		ON m.country = mil.country
			AND m.store = mil.store
			AND m.ITEMNR_LONG = mil.ITEMNR_LONG
			AND m.prev_day = mil.entrydate
	INNER JOIN CORE.T_ORACLE_V_dim_item di
		ON di.ITEM_NR = m.item_nr
			AND m.COUNTRY = di.COUNTRY
	INNER JOIN CORE.T_ORACLE_V_dim_store ds
		ON ds.STORE_NR = m.STORE
			AND m.COUNTRY = ds.COUNTRY
			AND ds.deleted = 0
	LEFT JOIN CORE.T_ORACLE_V_fk_sales s
		ON s.SALES_ITEM_NR = m.item_nr
			AND s.SALES_STORE_NR = m.STORE
			AND DATEADD(DAY, s.SALES_TIME_ID - 365.25 * (4712) - 2, '0000-01-01') = m.ENTRYDATE
			AND m.COUNTRY = s.COUNTRY
			AND s.deleted = 0
	LEFT JOIN FE_MSTR_AUTODISPO.V_ORACLE_FK_ORDER fo
		ON fo.ITEM_NR = m.item_nr
			AND fo.STORE = m.STORE
			AND fo.DATE = m.ENTRYDATE
			AND ORD_ORDER_TYPE = 'CALCULATION'
			AND m.COUNTRY = fo.COUNTRY
	LEFT JOIN CORE.T_ORACLE_V_fk_delivery fd
		ON fd.DEL_ITEM_NR = m.item_nr
			AND fd.DEL_STORE_NR = m.STORE
			AND DATEADD(DAY, fd.DEL_TIME_ID - 365.25 * (4712) - 2, '0000-01-01') = m.ENTRYDATE
			AND m.COUNTRY = fd.COUNTRY
	LEFT JOIN CORE.T_ORACLE_V_fk_forecast fminus
		ON fminus.forc_store_nr = m.STORE
			AND fminus.forc_item_nr = m.item_nr
			AND DATEADD(DAY, fminus.forc_forc_time_id - 365.25 * (4712) - 2, '0000-01-01') = fo.generation_date
			AND DATEADD(DAY, fminus.forc_time_id - 365.25 * (4712) - 2, '0000-01-01') >= CURRENT_DATE - 90
			AND DATEADD(DAY, fminus.forc_time_id - 365.25 * (4712) - 2, '0000-01-01') = m.entrydate
			AND m.COUNTRY = fminus.COUNTRY
			AND fminus.deleted = 0
	LEFT JOIN CORE.T_ORACLE_V_fk_forecast f
		ON f.forc_store_nr = m.STORE
			AND f.forc_item_nr = m.item_nr
			AND DATEADD(DAY, f.forc_forc_time_id - 365.25 * (4712) - 2, '0000-01-01') >= CURRENT_DATE - 90
			AND DATEADD(DAY, f.forc_time_id - 365.25 * (4712) - 2, '0000-01-01') >= CURRENT_DATE - 90
			AND DATEADD(DAY, f.forc_forc_time_id - 365.25 * (4712) - 2, '0000-01-01') = m.entrydate
			AND DATEADD(DAY, f.forc_time_id - 365.25 * (4712) - 2, '0000-01-01') = m.entrydate
			AND m.COUNTRY = f.COUNTRY
			AND f.deleted = 0
	LEFT JOIN CORE.T_ORACLE_V_fk_optimization opt
		ON opt.opt_store_nr = m.STORE
			AND opt.opt_item_nr = m.item_nr
			AND DATEADD(DAY, opt.opt_time_id - 365.25 * (4712) - 2, '0000-01-01') = m.entrydate
			AND opt.opt_order_type = 'CALCULATION'
			AND m.COUNTRY = opt.COUNTRY
			AND opt.deleted = 0
	LEFT JOIN CORE.T_ORACLE_V_fk_excluded ex
		ON ex_store_nr = m.STORE
			AND ex_item_nr = m.item_nr
			AND m.entrydate BETWEEN DATEADD(DAY, ex_from_time_id - 365.25 * (4712) - 2, '0000-01-01') AND DATEADD(DAY, ex_to_time_id - 365.25 * (4712) - 2, '0000-01-01')
			AND m.COUNTRY = ex.COUNTRY
			AND ex.deleted = 0
	LEFT JOIN CORE.T_ORACLE_V_fk_stock fs
		ON DATEADD(DAY, stock_time_id - 365.25 * (4712) - 2, '0000-01-01')::DATE = fo.generation_date
			AND stock_item_nr = m.item_nr
			AND stock_ware_id = store_wh
			AND m.COUNTRY = fs.COUNTRY
			AND stock_quantity <= 0
	    QUALIFY ROW_NUMBER() OVER (PARTITION BY m.country, m.item_nr, m.store, m.entrydate ORDER BY ord_storecalculation_id DESC) = 1
	) A;