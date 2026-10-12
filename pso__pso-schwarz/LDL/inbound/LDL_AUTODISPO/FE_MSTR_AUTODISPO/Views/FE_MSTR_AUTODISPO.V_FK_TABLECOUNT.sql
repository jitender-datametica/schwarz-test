CREATE OR REPLACE VIEW FE_MSTR_AUTODISPO.V_FK_TABLECOUNT(
	COUNTRY
	,DATE_LOAD
	,SRC
	,TABELLE
	,THRESHOLD
	,DATE
	,SNFLK_UPDATE_TMSP
	,ROWCOUNT
	,ROWCOUNT_LASTWEEK
) AS
	/* Version: 1.3
	** Author:	Dominik Pfarr
	** Date: 	2024-06-14
	** Changes:	adding THRESHOLD; generating SQL from XLS; adjusting tablenames
	*/
WITH base
AS (
	SELECT country
		,cal_dt
		,tabelle
		,THRESHOLD
		,src
	FROM FE_MSTR_AUTODISPO.V_ORACLE_DIM_COUNTRY c
	CROSS JOIN FE_MSTR_AUTODISPO.V_DIM_CALENDAR_DATE
	CROSS JOIN (
		SELECT 'FK_DELIVERY' AS tabelle
			,'Oracle' AS src
			,1 AS THRESHOLD
		FROM DUAL
		
		UNION
		
		SELECT 'FK_EXCLUDED' AS tabelle
			,'Oracle' AS src
			,0 AS THRESHOLD
		FROM DUAL
		
		UNION
		
		SELECT 'FK_FORECAST' AS tabelle
			,'Oracle' AS src
			,.2 AS THRESHOLD
		FROM DUAL
		
		UNION
		
		SELECT 'FK_MIL' AS tabelle
			,'Oracle' AS src
			,1 AS THRESHOLD
		FROM DUAL
		
		UNION
		
		SELECT 'FK_MINMAX' AS tabelle
			,'Oracle' AS src
			,0 AS THRESHOLD
		FROM DUAL
		
		UNION
		
		SELECT 'FK_OPTIMIZATION' AS tabelle
			,'Oracle' AS src
			,0 AS THRESHOLD
		FROM DUAL
		
		UNION
		
		SELECT 'FK_ORDER' AS tabelle
			,'Oracle' AS src
			,0 AS THRESHOLD
		FROM DUAL
		
		UNION
		
		SELECT 'FK_REBUILDS' AS tabelle
			,'Oracle' AS src
			,10 AS THRESHOLD
		FROM DUAL
		
		UNION
		
		SELECT 'FK_SALES' AS tabelle
			,'Oracle' AS src
			,.2 AS THRESHOLD
		FROM DUAL
		
		UNION
		
		SELECT 'FK_STOCK' AS tabelle
			,'Oracle' AS src
			,1 AS THRESHOLD
		FROM DUAL
		
		UNION
		
		SELECT 'FK_STORE_STOCK' AS tabelle
			,'Oracle' AS src
			,0.2 AS THRESHOLD
		FROM DUAL
		
		UNION
		
		SELECT 'FK_STORE_TREND_NEW' AS tabelle
			,'Oracle' AS src
			,0 AS THRESHOLD
		FROM DUAL
		
		UNION
		
		SELECT 'FK_SUPPLIER_FINAL_ORDER' AS tabelle
			,'Oracle' AS src
			,1 AS THRESHOLD
		FROM DUAL
		
		UNION
		
		SELECT 'FK_SUPPLIER_ORDER' AS tabelle
			,'Oracle' AS src
			,1 AS THRESHOLD
		FROM DUAL
		
		UNION
		
		SELECT 'FK_TO_COUNT' AS tabelle
			,'Oracle' AS src
			,1 AS THRESHOLD
		FROM DUAL
		
		UNION
		
		SELECT 'FK_WH_DELIVERY' AS tabelle
			,'Oracle' AS src
			,1 AS THRESHOLD
		FROM DUAL
		
		UNION
		
		SELECT 'FINAL_RESULTS_REDUCED' AS tabelle
			,'HIVE' AS src
			,0.1 AS THRESHOLD
		FROM DUAL
		
		UNION
		
		SELECT 'FORECAST_QUALITY_REDUCED' AS tabelle
			,'HIVE' AS src
			,0.2 AS THRESHOLD
		FROM DUAL
		
		UNION
		
		SELECT 'INTERNAL_FORECAST' AS tabelle
			,'AI' AS src
			,0.1 AS THRESHOLD
		FROM DUAL
		)
	WHERE (
			cal_dt BETWEEN CURRENT_DATE - 2
				AND CURRENT_DATE
			)
		OR (
			cal_dt BETWEEN CURRENT_DATE - 9
				AND CURRENT_DATE - 7
			)
	)
	,daten
AS (
	SELECT country
		,snflk_update_TMSP::DATE AS date_load
		,DATEADD(DAY, del_time_id - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_DELIVERY' AS tabelle
		,'Oracle' AS src
		,COUNT(*) AS ROWCOUNT
		,NULL AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_DELIVERY
	WHERE date_load BETWEEN CURRENT_DATE - 2
			AND CURRENT_DATE
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,DATEADD(DAY, 7, snflk_update_TMSP::DATE) AS date_load
		,DATEADD(DAY, del_time_id - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_DELIVERY' AS tabelle
		,'Oracle' AS src
		,NULL AS ROWCOUNT
		,COUNT(*) AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_DELIVERY
	WHERE snflk_update_TMSP::DATE BETWEEN CURRENT_DATE - 9
			AND CURRENT_DATE - 7
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,snflk_update_TMSP::DATE AS date_load
		,DATEADD(DAY, ex_from_time_id - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_EXCLUDED' AS tabelle
		,'Oracle' AS src
		,COUNT(*) AS ROWCOUNT
		,NULL AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_EXCLUDED
	WHERE date_load BETWEEN CURRENT_DATE - 2
			AND CURRENT_DATE
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,DATEADD(DAY, 7, snflk_update_TMSP::DATE) AS date_load
		,DATEADD(DAY, ex_from_time_id - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_EXCLUDED' AS tabelle
		,'Oracle' AS src
		,NULL AS ROWCOUNT
		,COUNT(*) AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_EXCLUDED
	WHERE snflk_update_TMSP::DATE BETWEEN CURRENT_DATE - 9
			AND CURRENT_DATE - 7
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,snflk_update_TMSP::DATE AS date_load
		,DATEADD(DAY, forc_time_id - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_FORECAST' AS tabelle
		,'Oracle' AS src
		,COUNT(*) AS ROWCOUNT
		,NULL AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_FORECAST
	WHERE date_load BETWEEN CURRENT_DATE - 2
			AND CURRENT_DATE
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,DATEADD(DAY, 7, snflk_update_TMSP::DATE) AS date_load
		,DATEADD(DAY, forc_time_id - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_FORECAST' AS tabelle
		,'Oracle' AS src
		,NULL AS ROWCOUNT
		,COUNT(*) AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_FORECAST
	WHERE snflk_update_TMSP::DATE BETWEEN CURRENT_DATE - 9
			AND CURRENT_DATE - 7
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,snflk_update_TMSP::DATE AS date_load
		,entrydate::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_MIL' AS tabelle
		,'Oracle' AS src
		,COUNT(*) AS ROWCOUNT
		,NULL AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_MIL
	WHERE date_load BETWEEN CURRENT_DATE - 2
			AND CURRENT_DATE
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,DATEADD(DAY, 7, snflk_update_TMSP::DATE) AS date_load
		,entrydate::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_MIL' AS tabelle
		,'Oracle' AS src
		,NULL AS ROWCOUNT
		,COUNT(*) AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_MIL
	WHERE snflk_update_TMSP::DATE BETWEEN CURRENT_DATE - 9
			AND CURRENT_DATE - 7
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,snflk_update_TMSP::DATE AS date_load
		,DATEADD(DAY, MM_GEN_TIME_ID - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_MINMAX' AS tabelle
		,'Oracle' AS src
		,COUNT(*) AS ROWCOUNT
		,NULL AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_MINMAX
	WHERE date_load BETWEEN CURRENT_DATE - 2
			AND CURRENT_DATE
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,DATEADD(DAY, 7, snflk_update_TMSP::DATE) AS date_load
		,DATEADD(DAY, MM_GEN_TIME_ID - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_MINMAX' AS tabelle
		,'Oracle' AS src
		,NULL AS ROWCOUNT
		,COUNT(*) AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_MINMAX
	WHERE snflk_update_TMSP::DATE BETWEEN CURRENT_DATE - 9
			AND CURRENT_DATE - 7
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,snflk_update_TMSP::DATE AS date_load
		,DATEADD(DAY, opt_time_id - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_OPTIMIZATION' AS tabelle
		,'Oracle' AS src
		,COUNT(*) AS ROWCOUNT
		,NULL AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_OPTIMIZATION
	WHERE date_load BETWEEN CURRENT_DATE - 2
			AND CURRENT_DATE
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,DATEADD(DAY, 7, snflk_update_TMSP::DATE) AS date_load
		,DATEADD(DAY, opt_time_id - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_OPTIMIZATION' AS tabelle
		,'Oracle' AS src
		,NULL AS ROWCOUNT
		,COUNT(*) AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_OPTIMIZATION
	WHERE snflk_update_TMSP::DATE BETWEEN CURRENT_DATE - 9
			AND CURRENT_DATE - 7
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,snflk_update_TMSP::DATE AS date_load
		,DATEADD(DAY, ord_time_id - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_ORDER' AS tabelle
		,'Oracle' AS src
		,COUNT(*) AS ROWCOUNT
		,NULL AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_ORDER
	WHERE date_load BETWEEN CURRENT_DATE - 2
			AND CURRENT_DATE
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,DATEADD(DAY, 7, snflk_update_TMSP::DATE) AS date_load
		,DATEADD(DAY, ord_time_id - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_ORDER' AS tabelle
		,'Oracle' AS src
		,NULL AS ROWCOUNT
		,COUNT(*) AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_ORDER
	WHERE snflk_update_TMSP::DATE BETWEEN CURRENT_DATE - 9
			AND CURRENT_DATE - 7
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,snflk_update_TMSP::DATE AS date_load
		,DATEADD(DAY, rb_datefrom - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_REBUILDS' AS tabelle
		,'Oracle' AS src
		,COUNT(*) AS ROWCOUNT
		,NULL AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_REBUILDS
	WHERE date_load BETWEEN CURRENT_DATE - 2
			AND CURRENT_DATE
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,DATEADD(DAY, 7, snflk_update_TMSP::DATE) AS date_load
		,DATEADD(DAY, rb_datefrom - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_REBUILDS' AS tabelle
		,'Oracle' AS src
		,NULL AS ROWCOUNT
		,COUNT(*) AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_REBUILDS
	WHERE snflk_update_TMSP::DATE BETWEEN CURRENT_DATE - 9
			AND CURRENT_DATE - 7
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,snflk_update_TMSP::DATE AS date_load
		,DATEADD(DAY, sales_time_id - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_SALES' AS tabelle
		,'Oracle' AS src
		,COUNT(*) AS ROWCOUNT
		,NULL AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_SALES
	WHERE date_load BETWEEN CURRENT_DATE - 2
			AND CURRENT_DATE
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,DATEADD(DAY, 7, snflk_update_TMSP::DATE) AS date_load
		,DATEADD(DAY, sales_time_id - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_SALES' AS tabelle
		,'Oracle' AS src
		,NULL AS ROWCOUNT
		,COUNT(*) AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_SALES
	WHERE snflk_update_TMSP::DATE BETWEEN CURRENT_DATE - 9
			AND CURRENT_DATE - 7
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,snflk_update_TMSP::DATE AS date_load
		,DATEADD(DAY, stock_time_id - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_STOCK' AS tabelle
		,'Oracle' AS src
		,COUNT(*) AS ROWCOUNT
		,NULL AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_STOCK
	WHERE date_load BETWEEN CURRENT_DATE - 2
			AND CURRENT_DATE
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,DATEADD(DAY, 7, snflk_update_TMSP::DATE) AS date_load
		,DATEADD(DAY, stock_time_id - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_STOCK' AS tabelle
		,'Oracle' AS src
		,NULL AS ROWCOUNT
		,COUNT(*) AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_STOCK
	WHERE snflk_update_TMSP::DATE BETWEEN CURRENT_DATE - 9
			AND CURRENT_DATE - 7
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,snflk_update_TMSP::DATE AS date_load
		,DATEADD(DAY, FSS_TIME_ID - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_STORE_STOCK' AS tabelle
		,'Oracle' AS src
		,COUNT(*) AS ROWCOUNT
		,NULL AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_STORE_STOCK
	WHERE date_load BETWEEN CURRENT_DATE - 2
			AND CURRENT_DATE
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,DATEADD(DAY, 7, snflk_update_TMSP::DATE) AS date_load
		,DATEADD(DAY, FSS_TIME_ID - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_STORE_STOCK' AS tabelle
		,'Oracle' AS src
		,NULL AS ROWCOUNT
		,COUNT(*) AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_STORE_STOCK
	WHERE snflk_update_TMSP::DATE BETWEEN CURRENT_DATE - 9
			AND CURRENT_DATE - 7
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,snflk_update_TMSP::DATE AS date_load
		,snflk_update_TMSP::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_STORE_TREND_NEW' AS tabelle
		,'Oracle' AS src
		,COUNT(*) AS ROWCOUNT
		,NULL AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_STORE_TREND_NEW
	WHERE date_load BETWEEN CURRENT_DATE - 2
			AND CURRENT_DATE
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,DATEADD(DAY, 7, snflk_update_TMSP::DATE) AS date_load
		,snflk_update_TMSP::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_STORE_TREND_NEW' AS tabelle
		,'Oracle' AS src
		,NULL AS ROWCOUNT
		,COUNT(*) AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_STORE_TREND_NEW AT(offset => - 60 * 60 * 24 * 7)
	WHERE snflk_update_TMSP::DATE BETWEEN CURRENT_DATE - 9
			AND CURRENT_DATE - 7
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,snflk_update_TMSP::DATE AS date_load
		,GENERATION_DATE::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_SUPPLIER_FINAL_ORDER' AS tabelle
		,'Oracle' AS src
		,COUNT(*) AS ROWCOUNT
		,NULL AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_SUPPLIER_FINAL_ORDER
	WHERE date_load BETWEEN CURRENT_DATE - 2
			AND CURRENT_DATE
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,DATEADD(DAY, 7, snflk_update_TMSP::DATE) AS date_load
		,GENERATION_DATE::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_SUPPLIER_FINAL_ORDER' AS tabelle
		,'Oracle' AS src
		,NULL AS ROWCOUNT
		,COUNT(*) AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_SUPPLIER_FINAL_ORDER
	WHERE snflk_update_TMSP::DATE BETWEEN CURRENT_DATE - 9
			AND CURRENT_DATE - 7
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,snflk_update_TMSP::DATE AS date_load
		,ORDER_SENT_DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_SUPPLIER_ORDER' AS tabelle
		,'Oracle' AS src
		,COUNT(*) AS ROWCOUNT
		,NULL AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_SUPPLIER_ORDER
	WHERE date_load BETWEEN CURRENT_DATE - 2
			AND CURRENT_DATE
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,DATEADD(DAY, 7, snflk_update_TMSP::DATE) AS date_load
		,ORDER_SENT_DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_SUPPLIER_ORDER' AS tabelle
		,'Oracle' AS src
		,NULL AS ROWCOUNT
		,COUNT(*) AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_SUPPLIER_ORDER
	WHERE snflk_update_TMSP::DATE BETWEEN CURRENT_DATE - 9
			AND CURRENT_DATE - 7
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,snflk_update_TMSP::DATE AS date_load
		,countingdate::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_TO_COUNT' AS tabelle
		,'Oracle' AS src
		,COUNT(*) AS ROWCOUNT
		,NULL AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_TO_COUNT
	WHERE date_load BETWEEN CURRENT_DATE - 2
			AND CURRENT_DATE
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,DATEADD(DAY, 7, snflk_update_TMSP::DATE) AS date_load
		,countingdate::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_TO_COUNT' AS tabelle
		,'Oracle' AS src
		,NULL AS ROWCOUNT
		,COUNT(*) AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_TO_COUNT
	WHERE snflk_update_TMSP::DATE BETWEEN CURRENT_DATE - 9
			AND CURRENT_DATE - 7
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,snflk_update_TMSP::DATE AS date_load
		,DATEADD(DAY, wdel_time_id - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_WH_DELIVERY' AS tabelle
		,'Oracle' AS src
		,COUNT(*) AS ROWCOUNT
		,NULL AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_WH_DELIVERY
	WHERE date_load BETWEEN CURRENT_DATE - 2
			AND CURRENT_DATE
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,DATEADD(DAY, 7, snflk_update_TMSP::DATE) AS date_load
		,DATEADD(DAY, wdel_time_id - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FK_WH_DELIVERY' AS tabelle
		,'Oracle' AS src
		,NULL AS ROWCOUNT
		,COUNT(*) AS rowcount_lastweek
	FROM CORE.T_ORACLE_V_FK_WH_DELIVERY
	WHERE snflk_update_TMSP::DATE BETWEEN CURRENT_DATE - 9
			AND CURRENT_DATE - 7
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,snflk_update_TMSP::DATE AS date_load
		,date_::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FINAL_RESULTS_REDUCED' AS tabelle
		,'HIVE' AS src
		,COUNT(*) AS ROWCOUNT
		,NULL AS rowcount_lastweek
	FROM CORE.T_HIVE_FINAL_RESULTS_REDUCED
	WHERE date_load BETWEEN CURRENT_DATE - 2
			AND CURRENT_DATE
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,DATEADD(DAY, 7, snflk_update_TMSP::DATE) AS date_load
		,date_::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FINAL_RESULTS_REDUCED' AS tabelle
		,'HIVE' AS src
		,NULL AS ROWCOUNT
		,COUNT(*) AS rowcount_lastweek
	FROM CORE.T_HIVE_FINAL_RESULTS_REDUCED AT(offset => - 60 * 60 * 24 * 7)
	WHERE snflk_update_TMSP::DATE BETWEEN CURRENT_DATE - 9
			AND CURRENT_DATE - 7
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,snflk_update_TMSP::DATE AS date_load
		,date_::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FORECAST_QUALITY_REDUCED' AS tabelle
		,'HIVE' AS src
		,COUNT(*) AS ROWCOUNT
		,NULL AS rowcount_lastweek
	FROM CORE.T_HIVE_V_FORECAST_QUALITY_REDUCED
	WHERE date_load BETWEEN CURRENT_DATE - 2
			AND CURRENT_DATE
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,DATEADD(DAY, 7, snflk_update_TMSP::DATE) AS date_load
		,date_::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'FORECAST_QUALITY_REDUCED' AS tabelle
		,'HIVE' AS src
		,NULL AS ROWCOUNT
		,COUNT(*) AS rowcount_lastweek
	FROM CORE.T_HIVE_V_FORECAST_QUALITY_REDUCED AT(offset => - 60 * 60 * 24 * 7)
	WHERE snflk_update_TMSP::DATE BETWEEN CURRENT_DATE - 9
			AND CURRENT_DATE - 7
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,snflk_update_TMSP::DATE AS date_load
		,date_::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'INTERNAL_FORECAST' AS tabelle
		,'AI' AS src
		,COUNT(*) AS ROWCOUNT
		,NULL AS rowcount_lastweek
	FROM CORE.T_INTERNAL_FORECAST_RESULTS
	WHERE date_load BETWEEN CURRENT_DATE - 2
			AND CURRENT_DATE
	GROUP BY country
		,date_load
		,DATE
	
	UNION
	
	SELECT country
		,DATEADD(DAY, 7, snflk_update_TMSP::DATE) AS date_load
		,date_::DATE DATE
		,MAX(snflk_update_TMSP)::timestamp_ntz snflk_update_TMSTP
		,'INTERNAL_FORECAST' AS tabelle
		,'AI' AS src
		,NULL AS ROWCOUNT
		,COUNT(*) AS rowcount_lastweek
	FROM CORE.T_INTERNAL_FORECAST_RESULTS
	WHERE snflk_update_TMSP::DATE BETWEEN CURRENT_DATE - 9
			AND CURRENT_DATE - 7
	GROUP BY country
		,date_load
		,DATE
	)
SELECT b.country
	,b.cal_dt AS date_load
	,b.src
	,b.tabelle
	,b.THRESHOLD
	,t.DATE
	,MAX(snflk_update_TMSTP) snflk_update_TMSP
	,SUM(ROWCOUNT) ROWCOUNT
	,SUM(rowcount_lastweek) rowcount_lastweek
FROM base b
LEFT JOIN daten t ON b.country = t.country
	AND b.cal_dt = t.date_load
	AND b.tabelle = t.tabelle
	AND b.src = t.src
GROUP BY b.country
	,b.cal_dt
	,b.src
	,b.tabelle
	,b.THRESHOLD
	,t.DATE
ORDER BY DATE DESC
	,b.tabelle ASC
	,country ASC;