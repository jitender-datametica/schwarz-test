
CREATE
	OR REPLACE VIEW FE_MSTR_BCBI.V_SNOWFLAKE_PERFORMANCE_BCBID_1 (
	DATE_START_TIME
	,YEAR_START_TIME
	,MONAT_START_TIME
	,WEEK_START_TIME
	,DAY_START_TIME
	,DAYNAME_START_TIME
	,STUNDE_START_TIME
	,MINUTE_START_TIME
	,CLUSTER_NUMBER
	,TYP
	,ANZAHL_QUERIES
	,PROV_TIME_SEC
	,OVERLOAD_TIME_SEC
	) AS

SELECT TO_DATE(start_time) AS date_start_time
	,YEAR(start_time) AS year_start_time
	,MONTH(start_time) AS monat_start_time
	,WEEK(start_time) AS week_start_time
	,DAY(start_time) AS day_start_time
	,DAYNAME(start_time) AS dayname_start_time
	,HOUR(start_time) AS stunde_start_time
	,MINUTE(start_time) AS minute_start_time
	,cluster_number
	,CASE 
		WHEN query_type = 'ALTER_SESSION'
			THEN 'Query_Tag'
		ELSE 'Rest'
		END AS typ
	,COUNT(query_id) AS anzahl_queries
	,(SUM(queued_provisioning_time) / 1000)::Number(18, 2) AS prov_time_sec
	,(SUM(queued_overload_time) / 1000)::Number(18, 2) AS overload_time_sec
FROM SIT_ACCOUNT_USAGE.ACCOUNT_USAGE_VIEWS.QUERY_HISTORY_1
WHERE 1 = 1
	AND warehouse_name = 'WH_LDL_P_MSTR_LEAD'
	AND start_time >= CURRENT_DATE - 400
GROUP BY 1
	,2
	,3
	,4
	,5
	,6
	,7
	,8
	,9
	,10
ORDER BY 1 ASC
	,2 ASC
	,3 ASC
	,4 ASC;