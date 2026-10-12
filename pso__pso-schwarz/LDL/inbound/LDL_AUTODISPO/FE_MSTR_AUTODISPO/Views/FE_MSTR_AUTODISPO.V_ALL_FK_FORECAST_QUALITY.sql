CREATE OR REPLACE VIEW FE_MSTR_AUTODISPO.V_ALL_FK_FORECAST_QUALITY(
	COUNTRY
	, SOURCE_FLAG
	, STORE
	, DATE
	, WH
	, PROMOTION
	, IS_AMOUNT_ZERO
	, HOUR_LAST_SALE
	, ITEMNO
	, SPECIAL_PLACEMENT
	, V_MODEL
	, FORECAST_DAY
	, SOURCE_EXTRACTION_TMSP
	, SNFLK_INSERT_TMSP
	, SNFLK_UPDATE_TMSP
	, PFC
	, AMOUNT
	, OVER
	, UNDER
	, D_PFC
	, FORECAST_NO_RATIO
	, PFC_RARE_SALES
	, PFC_HIST
	, FILTERED_FC
	, PFC_BEFORE_TREND
) AS
	/* Version: 2.3
	** Author:	Dominik Pfarr
	** Date:    2023-08-09
	** Change:  Forecast left join sales - use for ADF only & nvl for IS_AMOUNT_ZERO
	*/
	WITH fc AS (
			SELECT country
				,source_flag --1
				,1 AS is_future
				,pfc
				,NULL AS forecast_no_ratio
				,NULL AS PFC_RARE_SALES
				,NULL AS pfc_before_trend
				,wh
				,store
				,date_::DATE AS DATE
				,itemno
				,promotion
				,NULL AS special_placement
				,v_model
				,NULL AS is_Trend
				,CURRENT_DATE - forecast_date::DATE AS FORECAST_DAY
				,'int' AS tab
				,SOURCE_EXTRACTION_TMSP
				,SNFLK_INSERT_TMSP
				,SNFLK_UPDATE_TMSP
			FROM CORE.T_INTERNAL_FORECAST_RESULTS
			WHERE DATE_::DATE >= CURRENT_DATE ()
			
			UNION ALL
			
			/*AI past*/
			SELECT INT.country
				,source_flag --1
				,0 AS is_future
				,pfc
				,NULL AS forecast_no_ratio
				,NULL AS PFC_RARE_SALES
				,NULL AS pfc_before_trend
				,INT.wh
				,INT.store
				,date_::DATE AS DATE
				,INT.itemno
				,promotion
				,NULL AS special_placement
				,v_model
				,NULL AS IS_TREND
				,FORECAST_DAY
				,'int' AS tab
				,INT.SOURCE_EXTRACTION_TMSP
				,INT.SNFLK_INSERT_TMSP
				,INT.SNFLK_UPDATE_TMSP
			FROM CORE.T_INTERNAL_FORECAST_RESULTS INT
			WHERE INT.DATE_::DATE < CURRENT_DATE ()
			
			UNION ALL
			
			/*HIVE future - with respect to their forecast day */
			SELECT frr.country
				,0 AS source_flag
				,1 AS is_future
				,pfc
				,pfc_model AS forecast_no_ratio
				,PFC_RARE_SALES
				,pfc_before_trend
				,wh
				,store
				,date_::DATE AS DATE
				,itemno
				,promotion
				,spec_placement AS special_placement
				,v_model
				,IS_TREND
				,fd.forecast_day
				,'frr' AS tab
				,frr.SOURCE_EXTRACTION_TMSP
				,frr.SNFLK_INSERT_TMSP
				,frr.SNFLK_UPDATE_TMSP
			FROM CORE.T_HIVE_FINAL_RESULTS_REDUCED frr
			JOIN FE_MSTR_AUTODISPO.V_ORACLE_DIM_FORECAST_DAY fd
				ON frr.country = fd.country
			WHERE DATE >= CURRENT_DATE ()
			
			UNION ALL
			
			/*HIVE past from Hist_Final_Results*/
			SELECT hfr.country
				,0 AS source_flag
				,0 AS is_future
				,pfc
				,pfc_model AS forecast_no_ratio
				,PFC_RARE_SALES
				,pfc_before_trend
				,wh
				,store
				,date_::DATE AS DATE
				,itemno
				,promotion
				,spec_placement AS special_placement
				,v_model
				,IS_TREND
				,FORECAST_DAY
				,'hfr' AS tab
				,SOURCE_EXTRACTION_TMSP
				,SNFLK_INSERT_TMSP
				,SNFLK_UPDATE_TMSP
			FROM CORE.T_HIVE_HIST_FINAL_RESULTS_REDUCED hfr
			WHERE DATE < CURRENT_DATE ()
			)
		,sal AS (
			SELECT fqr.COUNTRY
				,0 AS source_flag
				,store
				,wh
				,date_::DATE AS DATE
				,itemno
				,amount
				,CASE 
					WHEN AMOUNT = 0
						THEN 1
					ELSE 0
					END AS IS_AMOUNT_ZERO
				,TO_TIME(SALE_LAST_TIME_INT) AS hour_last_sale
				,promotion
				,special_placement
				,v_model
				,IS_TREND
				,fd.FORECAST_DAY
				,'fqr' AS tab
				,fqr.SOURCE_EXTRACTION_TMSP
				,fqr.SNFLK_INSERT_TMSP
				,fqr.SNFLK_UPDATE_TMSP
			FROM CORE.T_HIVE_V_FORECAST_QUALITY_REDUCED fqr
			JOIN FE_MSTR_AUTODISPO.V_ORACLE_DIM_FORECAST_DAY fd
				ON fqr.country = fd.country
			WHERE fqr.forecast_Day = 1
			
			UNION ALL
			
			/*sales from fk_sales for Internal Forecast*/
			SELECT s.COUNTRY
				,1 AS source_flag
				,sales_store_nr AS store
				,st.store_wh AS wh
				,s.date_::DATE AS DATE
				,s.sales_item_nr AS itemno
				,s.sales_quantity AS amount
				,CASE 
					WHEN sales_quantity = 0
						THEN 1
					ELSE 0
					END AS IS_AMOUNT_ZERO
				,NULL AS hour_last_sale
				,NULL AS promotion
				,NULL AS special_placement
				,NULL AS v_model
				,NULL AS IS_TREND
				,fd.FORECAST_DAY
				,'ora' AS tab
				,s.SOURCE_EXTRACTION_TMSP
				,s.SNFLK_INSERT_TMSP
				,s.SNFLK_UPDATE_TMSP
			FROM CORE.T_ORACLE_V_FK_SALES s
			JOIN CORE.T_ORACLE_V_DIM_STORE st
				ON s.sales_store_nr = st.store_nr
					AND s.country = st.country
					AND st.deleted = 0
			JOIN FE_MSTR_AUTODISPO.V_ORACLE_DIM_FORECAST_DAY fd
				ON s.country = fd.country
			WHERE s.deleted = 0
			)

SELECT 
	
f.COUNTRY
,f.SOURCE_FLAG
,f.STORE
,f.DATE::DATE AS DATE
,f.WH
,f.PROMOTION
,NVL(IS_AMOUNT_ZERO,0)
,HOUR_LAST_SALE
,f.ITEMNO
,f.SPECIAL_PLACEMENT
,f.V_MODEL
,f.FORECAST_DAY
,f.SOURCE_EXTRACTION_TMSP
,f.SNFLK_INSERT_TMSP
,f.SNFLK_UPDATE_TMSP
,f.PFC
,AMOUNT

	,GREATEST(0, pfc - amount) OVER
	,LEAST(0, pfc - amount) UNDER
	,CASE 
		WHEN f.DATE < CURRENT_DATE
			THEN ABS(NVL((f.pfc), 0) - NVL((amount), 0))
		ELSE NULL
		END AS D_PFC
	,0 AS forecast_no_ratio
	,f.pfc_rare_sales
	,CASE 
		WHEN f.DATE < CURRENT_DATE
			THEN pfc
		ELSE NULL
		END AS pfc_hist
	,CASE 
		WHEN amount <> 0
			AND f.DATE < CURRENT_DATE
			THEN pfc
		ELSE NULL
		END AS filtered_fc
	,f.pfc_before_trend

FROM fc f

LEFT JOIN sal s
	ON f.country = s.country
		AND f.itemno = s.itemno
		AND f.store::INT = s.store::INT
		AND f.forecast_day = s.forecast_day
		AND f.DATE::DATE = s.DATE::DATE
		AND f.source_flag = s.source_flag;