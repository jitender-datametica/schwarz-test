create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_FACT_STATISTICS_BY_COUNTRY_MONTH_1(
	COUNTRY_ORG_SID COMMENT 'the unique identifier (surrogate key) for the country_1, for which statistics have been calculated.',
	COUNTRY_ORG_CD COMMENT 'the code of the business country_1 for which this country_1 organization is responsible. (the business country_1 is not identical to a political country.)',
	STAT_TYPE_CD COMMENT 'the code identifying the kind of metric which is calculated for internal companies.',
	CAL_MONTH COMMENT 'The calendar_1 month of the is entered',
	STAT_VAL COMMENT 'the calculated statistics amount for the given month, statistics type and internal company. (depending on the statistics type this may be a net or a gross value.)',
	STAT_BYTD_VAL COMMENT 'the business-year-to-date sum of the calculated statistics amount  ',
	STAT_PY_VAL COMMENT 'the previous year of the calculated statistics amount  ',
	STAT_PY_BYTD_VAL COMMENT 'the previous business-year-to-date sum of the calculated statistics amount  ',
	PLAN_VAL COMMENT 'the planned statistics amount for the given month, statistics type and internal company. (depending on the statistics type this may be a net or a gross value.)',
	PLAN_BYTD_VAL COMMENT 'the business-year-to-date sum of the planned statistics amount  ',
	PLAN_PY_VAL COMMENT 'the previous year of the planned statistics amount  ',
	PLAN_PY_BYTD_VAL COMMENT 'the previous business-year-to-date sum of the calculated statistics amount  ',
	CURR_CD COMMENT 'The code identifying the currency according to ISO-4217.',
	CURR_GROUP_FG COMMENT 'Flag for Group Currency',
	CURR_LOCAL_FG COMMENT 'Flag for Local Currency',
	STAT_MEAS COMMENT 'the calculated statistics measure for the given month, statistics type and internal company.',
	STAT_BYTD_MEAS COMMENT 'the calculated statistics measure for the given month, statistics type and internal company.',
	STAT_PY_MEAS COMMENT 'the business-year-to-date sum of the calculated statistics amount  ',
	STAT_PY_BYTD_MEAS COMMENT 'the previous business-year-to-date sum of the calculated statistics amount  ',
	PLAN_MEAS COMMENT 'the planned statistics amount for the given month, statistics type and internal company. (depending on the statistics type this may be a net or a gross value.)',
	PLAN_BYTD_MEAS COMMENT 'the business-year-to-date sum of the planned statistics amount  ',
	PLAN_PY_MEAS COMMENT 'the previous year of the planned statistics amount  ',
	PLAN_PY_BYTD_MEAS COMMENT 'the previous business-year-to-date sum of the calculated statistics amount  ',
	UOM_CD COMMENT 'the code identifying the unit_1 of measure for the statistics measure.',
	DWH_CREATED_TMSP COMMENT 'the point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'the point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'the unique identifier of the batch load which has done the last update to this record. (closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'the code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='Various derived metrics can be calculated on the level of a month and an internal company. These values are not necessarily in sync with the underlying base events. The table contains separate columns for each domain of statistics values. Depending on the statistics type, one of them is filled.'
 as
SELECT
main.int_company_sid AS country_org_sid
,main.country_org_cd AS country_org_cd
,main.stat_type_cd AS stat_type_cd
,main.cal_month AS cal_month
,main.stat_val / fer.exchange_rate AS  stat_val
,main.stat_bytd_val / fer.exchange_rate AS stat_bytd_val
,main.stat_py_val / fer.exchange_rate AS stat_py_val
,main.stat_py_bytd_val / fer.exchange_rate AS stat_py_bytd_val
,main.plan_val  / fer.exchange_rate AS plan_val
,main.plan_bytd_val / fer.exchange_rate AS plan_bytd_val
,main.plan_py_val / fer.exchange_rate AS plan_py_val
,main.plan_py_bytd_val / fer.exchange_rate AS plan_py_bytd_val
,fer.src_curr_cd AS curr_cd
,DECODE(fer.src_curr_cd,'EUR',1,0) AS curr_group_fg
,DECODE(fer.src_curr_cd,fer.tgt_curr_cd,1,0) AS curr_local_fg
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
FROM CORE_DIM.V_FACT_COMPANY_STATISTICS_BY_MONTH_1 main
INNER JOIN  CORE_DIM.T_FACT_EXCHANGE_RATE_1 fer
ON main.curr_cd = fer.tgt_curr_cd
WHERE exchange_rate_type_cd = 'BEW_ISK'
AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
AND fer.active_fg = TRUE
AND main.stat_type_cd IN (255,256,257,258,259,260,261);