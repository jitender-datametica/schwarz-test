CREATE OR REPLACE VIEW FE_MSTR_AUTODISPO.V_FK_SALES_2(
	COUNTRY_2
	, SOURCE_FLAG
	, STORE
	, WH
	, DATE
	, ITEMNO
	, AMOUNT
	, IS_AMOUNT_ZERO
	, HOUR_LAST_SALE
	, PROMOTION
	, SPECIAL_PLACEMENT
	, V_MODEL
	, IS_TREND
	, FORECAST_DAY
	, TAB
	, SOURCE_EXTRACTION_TMSP
	, SNFLK_INSERT_TMSP
	, SNFLK_UPDATE_TMSP
) AS
	/* Version: 1.1
	** Author:	Dominik Pfarr
	** Date: 	2023-02-28
	** Changes:	Changing view for forecast_days to oracle
	*/
    
 /*sales_2 from HIVE, multiplied for all forecast days */
(
		SELECT fqr.COUNTRY_2
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
		FROM CORE.T_HIVE_V_FORECAST_QUALITY_REDUCED_2 fqr
		JOIN FE_MSTR_AUTODISPO.V_ORACLE_DIM_FORECAST_DAY_2 fd ON fqr.country_2 = fd.country_2
		WHERE fqr.forecast_Day = 1
		)

UNION ALL

/*sales_2 from fk_sales for Internal Forecast*/
(
	SELECT s.COUNTRY_2
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
	FROM CORE.T_ORACLE_V_FK_SALES_2 s
	JOIN CORE.T_ORACLE_V_DIM_STORE_2 st ON s.sales_store_nr = st.store_nr
		AND s.country_2 = st.country_2
		AND st.deleted = 0
	JOIN FE_MSTR_AUTODISPO.V_ORACLE_DIM_FORECAST_DAY_2 fd ON s.country_2 = fd.country_2
	WHERE s.deleted = 0
	);