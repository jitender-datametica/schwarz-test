create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_FACT_COUNTRY_STATISTICS_BY_MONTH_GROUP_CURR_2(
	REPORTING_COUNTRY_CD COMMENT 'The code which identifies the reporting country.',
	COUNTRY_ORG_SID COMMENT 'The unique identifier (surrogate key) for the country_2 organization.',
	COUNTRY_ORG_CD COMMENT 'the code of the business country_2 for which this country_2 organization is responsible. (the business country_2 is not identical to a political country.)',
	STAT_TYPE_CD COMMENT 'The code identifying the kind of metric which is calculated for the reporting country.',
	CAL_MONTH COMMENT 'The identifier of a calendar_2 month in the form YYYYMM. E.g. 202101 für January 2021.',
	AVAILABILITY_FG COMMENT 'a flag showing if there are data available for given month',
	STAT_VAL COMMENT 'The calculated statistics amount for the given month, statistics type and reporting country. (Depending on the statistics type this may be a net or a gross value.)',
	STAT_BYTD_VAL COMMENT 'The business-year-to-date sum of the statistics amount for the given reporting country_2 and statistics type, which has been calculated up to the given month. (Depending on the statistics type this may be a net or a gross value.)',
	STAT_PY_VAL COMMENT 'The statistics amount for the given reporting country_2 and statistics type, which has been calculated for the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)',
	STAT_PY_BYTD_VAL COMMENT 'The business-year-to-date sum of the statistics amount for the given reporting country_2 and statistics type, which has been calculated up to the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)',
	PLAN_VAL COMMENT 'The planned amount for the given month, statistics type and reporting country. (Depending on the statistics type this may be a net or a gross value.)',
	PLAN_BYTD_VAL COMMENT 'The business-year-to-date sum of the amount for the given reporting country_2 and statistics type, which has been planned up to the given month. (Depending on the statistics type this may be a net or a gross value.)',
	PLAN_PY_VAL COMMENT 'The statistics amount for the given reporting country_2 and statistics type, which was planned for the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)',
	PLAN_PY_BYTD_VAL COMMENT 'The business-year-to-date sum of the amount for the given reporting country_2 and statistics type, which has was planned up to the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)',
	STAT_MEAS COMMENT 'The calculated statistics measure for the given month, statistics type and reporting country. (The measure is expressed in the indicated unit_2 of measure.)',
	STAT_BYTD_MEAS COMMENT 'The business-year-to-date sum of the statistics measure for the given reporting country_2 and statistics type, which has been calculated up to the given month. (The measure is expressed in the indicated unit_2 of measure.)',
	STAT_PY_MEAS COMMENT 'The statistics measure for the given reporting country_2 and statistics type, which has been calculated for the equivalent month one year ago. (The measure is expressed in the indicated unit_2 of measure.)',
	STAT_PY_BYTD_MEAS COMMENT 'The business-year-to-date sum of the statistics measure for the given reporting country_2 and statistics type, which has been calculated up to the equivalent month one year ago. (The measure is expressed in the indicated unit_2 of measure.)',
	PLAN_MEAS COMMENT 'The planned measure for the given month, statistics type and reporting country. (The measure is expressed in the indicated unit_2 of measure.)',
	PLAN_BYTD_MEAS COMMENT 'The business-year-to-date sum of the measure for the given reporting country_2 and statistics type, which has been planned up to the given month. (The measure is expressed in the indicated unit_2 of measure.)',
	PLAN_PY_MEAS COMMENT 'The statistics measure for the given reporting country_2 and statistics type, which was planned for the equivalent month one year ago.  (The measure is expressed in the indicated unit_2 of measure.)',
	PLAN_PY_BYTD_MEAS COMMENT 'The business-year-to-date sum of the measure for the given reporting country_2 and statistics type, which has was planned up to the equivalent month one year ago.  (The measure is expressed in the indicated unit_2 of measure.)',
	UOM_CD COMMENT 'The code identifying the unit_2 of measure for the statistics measure.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) as SELECT 
  main.reporting_country_cd AS reporting_country_cd
,main.country_org_sid AS country_org_sid
,main.country_org_cd AS country_org_cd
,main.stat_type_cd AS stat_type_cd
,main.cal_month AS cal_month
,DECODE(main.stat_val,0,0,1 ) AS availability_fg
,main.stat_val / fer.exchange_rate AS  stat_val
,main.stat_bytd_val / fer.exchange_rate AS stat_bytd_val
,main.stat_py_val / fer.exchange_rate AS stat_py_val
,main.stat_py_bytd_val / fer.exchange_rate AS stat_py_bytd_val
,main.plan_val  / fer.exchange_rate AS plan_val
,main.plan_bytd_val / fer.exchange_rate AS plan_bytd_val
,main.plan_py_val / fer.exchange_rate AS plan_py_val
,main.plan_py_bytd_val / fer.exchange_rate AS plan_py_bytd_val
,main.stat_meas AS stat_meas
,main.stat_bytd_meas AS stat_bytd_meas
,main.stat_py_meas AS stat_py_meas
,main.stat_py_bytd_meas AS stat_py_bytd_meas
,main.plan_meas AS plan_meas
,main.plan_bytd_meas  AS plan_bytd_meas
,main.plan_py_meas AS plan_py_meas
,main.plan_py_bytd_meas AS plan_py_bytd_meas
,main.uom_cd AS uom_cd
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd
FROM CORE_DIM.V_FACT_COUNTRY_STATISTICS_BY_MONTH_2 main
INNER JOIN  CORE_DIM.T_FACT_EXCHANGE_RATE_2 fer
ON main.curr_cd = fer.tgt_curr_cd
WHERE exchange_rate_type_cd = 'BEW_ISK'
AND fer.src_curr_cd = 'EUR' 
AND fer.active_fg = TRUE
AND main.stat_type_cd IN (255,256,257,258,259,260,261);