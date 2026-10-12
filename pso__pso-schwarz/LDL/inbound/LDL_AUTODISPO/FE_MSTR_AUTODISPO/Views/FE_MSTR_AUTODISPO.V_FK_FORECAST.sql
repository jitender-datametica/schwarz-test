CREATE OR REPLACE VIEW FE_MSTR_AUTODISPO.V_FK_FORECAST(
	COUNTRY
	, SOURCE_FLAG
	, IS_FUTURE
	, PFC
	, FORECAST_NO_RATIO
	, PFC_RARE_SALES
	, PFC_BEFORE_TREND
	, WH
	, STORE
	, DATE
	, ITEMNO
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
	/* Version: 1.3
	** Author:	Dominik Pfarr
	** Date: 	2023-06-05
	** Changes:	adding pfc_rare_sales
	*/
    
/*AI future - identify most recent forecast*/
(
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
		FROM  CORE.T_INTERNAL_FORECAST_RESULTS 
			WHERE DATE_::DATE >= CURRENT_DATE () 
		
		)

UNION ALL

/*AI past*/
(
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
	)

UNION ALL

/*HIVE future - with respect to their forecast day */
(
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
	JOIN FE_MSTR_AUTODISPO.V_ORACLE_DIM_FORECAST_DAY fd ON frr.country = fd.country
	WHERE DATE >= CURRENT_DATE ()
	)

UNION ALL

/*HIVE past from Hist_Final_Results*/
(
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
	);