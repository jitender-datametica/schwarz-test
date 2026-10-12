create or replace view V_FACT_TURNOVER_BY_STORE_DAY_ITEM_FAMILY_2(
	CAL_DT COMMENT 'The business date to which the measures are related.',
	BUS_YEAR,
	STORE_SID COMMENT 'The unique identifier (surrogate key) for the store, which has generated the revenue.',
	SALES_COMPANY_SID,
	SALES_COMPANY_NR,
	DELIV_COMPANY_SID,
	DELIV_COMPANY_NR,
	ITEM_FAM_SID,
	ITEM_FAM_NR,
	COUNTRY_ORG_SID COMMENT 'The unique identifier (surrogate key) for the country_2 organization. This is on the one hand related to the country_2 organization which is responsible for the store which has sold the product, and on the other hand to the country_2 organization which has defined the local properties of the product.',
	COUNTRY_ORG_CD COMMENT 'The code of the business country_2 for which the related country_2 organization is responsible. (The business country_2 is not identical to a political country.) This is on the one hand related to the country_2 organization which is responsible for the store which has sold the product, and on the other hand to the country_2 organization which has defined the local properties of the product.',
	TURNOVER_NET_VAL COMMENT 'The net turnover which was generated for this sales_2 variant of the product in the given store on the given day. (This is the amount according to the cash register.)',
	TURNOVER_GROSS_VAL COMMENT 'The gross turnover which was generated for this sales_2 variant of the product in the given store on the given day. (This is the amount according to the cash register.)',
	TURNOVER_BYTD_NET_VAL,
	TURNOVER_PY_NET_VAL,
	TURNOVER_PY_BYTD_NET_VAL,
	TURNOVER_PY_SWDAY_NET_VAL,
	TURNOVER_PY_SWDAY_BYTD_NET_VAL,
	CURR_CD COMMENT 'The code identifying the currency according to ISO-4217.',
	CURR_GROUP_FG COMMENT 'Flag for Group Currency',
	CURR_LOCAL_FG COMMENT 'Flag for Local Currency',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='An aggregate fact holding gross and net turnover per day, product and store. Turnover amounts are taken from the cash register.'
 as
SELECT
  main.bus_dt AS cal_dt
, main.bus_year
, main.store_sid AS store_sid
, main.sales_company_sid
, main.sales_company_nr
, main.deliv_company_sid
, main.deliv_company_nr
, main.item_fam_sid
, main.item_fam_nr
, main.country_org_sid AS country_org_sid
, main.country_org_cd AS country_org_cd
, main.turnover_net_val / fer.exchange_rate AS turnover_net_val
, main.turnover_gross_val / fer.exchange_rate AS turnover_gross_val
, main.turnover_bytd_net_val / fer.exchange_rate AS turnover_bytd_net_val
, main.turnover_py_net_val / fer.exchange_rate AS turnover_py_net_val
, main.turnover_py_bytd_net_val / fer.exchange_rate AS turnover_py_bytd_net_val
, main.turnover_py_swday_net_val / fer.exchange_rate AS turnover_py_swday_net_val
, main.turnover_py_swday_bytd_net_val / fer.exchange_rate AS turnover_py_swday_bytd_net_val
, fer.src_curr_cd AS curr_cd
, DECODE(fer.src_curr_cd,'EUR',1,0) AS curr_group_fg
, DECODE(fer.src_curr_cd,fer.TGT_CURR_CD,1,0) AS curr_local_fg
, main.dwh_created_tmsp AS dwh_created_tmsp
, main.dwh_updated_tmsp AS dwh_updated_tmsp
, main.dwh_load_id AS dwh_load_id
, main.dwh_node_cd AS dwh_node_cd
FROM CORE_DIM.V_FACT_TURNOVER_BY_STORE_DAY_ITEM_FAMILY_2 main
INNER JOIN  CORE_DIM.T_FACT_EXCHANGE_RATE_2 fer
ON main.curr_cd = fer.tgt_curr_cd
WHERE exchange_rate_type_cd = 'BEW_ISK'
AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
AND fer.active_fg = TRUE;