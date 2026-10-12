create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_FACT_WRITE_OFF_BY_STORE_DAY_PRODUCT_GROUP_CURR_1(
	CAL_DT COMMENT 'The business date to which the meASures are related.',
	STORE_SID COMMENT 'The unique identifier (surrogate key) for the store, which hAS generated the revenue.',
	INT_ORG_TYPE_CD COMMENT 'The code identifying the discriminators for internal organizations.',
	PROD_SID COMMENT 'The unique identifier (surrogate key) for the product.',
	LOGISTIC_VARIANT_SID COMMENT 'The unique identifier (surrogate key) for the logistic variant of a product.',
	COUNTRY_ORG_SID COMMENT 'The unique identifier (surrogate key) for the country_1 organization. This is on the one hand related to the country_1 organization which is responsible for the store which hAS sold the product, and on the other hand to the country_1 organization which hAS defined the local properties of the product.',
	COUNTRY_ORG_CD COMMENT 'The code of the business country_1 for which the related country_1 organization is responsible. (The business country_1 is not identical to a political country.) This is on the one hand related to the country_1 organization which is responsible for the store which hAS sold the product, and on the other hand to the country_1 organization which hAS defined the local properties of the product.',
	WRITE_OFF_NET_VAL COMMENT 'The total net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on that day because of any reason. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)',
	WRITE_OFF_FOR_BREAKAGE_NET_VAL COMMENT 'The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on that day because of breakage. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)',
	WRITE_OFF_FOR_SELL_BY_DT_NET_VAL COMMENT 'The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on that day, because the sell-by-date has been exceeded. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)',
	WRITE_OFF_FOR_DELIV_QUALITY_NET_VAL COMMENT 'The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on that day because of quality issues of delivered products. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)',
	WRITE_OFF_FOR_DEFECTIVE_NON_FOOD_NET_VAL COMMENT 'The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on that day because of defective non-food produts. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)',
	WRITE_OFF_FOR_DONATIONS_NET_VAL COMMENT 'The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on that day because of donations to charitable organizations. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)',
	WRITE_OFF_FOR_TAKEN_PROD_NET_VAL COMMENT 'The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on that day, because products were taken, e.g. for the purpose of quality sampling. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)',
	WRITE_OFF_FOR_FORCE_MAJEURE_NET_VAL COMMENT 'The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on that day, because of force majeure. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)',
	WRITE_OFF_FOR_DISCOUNTS_NET_VAL COMMENT 'The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on that day because of discounts. Discounts can be given for perishable products in case the sell-by-date is near. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)',
	WRITE_OFF_FOR_STOCK_CLEARANCE_NET_VAL COMMENT 'The net amount in the given currency which was written off in this internal organization (i.e. store or warehouse) on that day because of stock clearance. (In case the internal organization references a warehouse, this is only that portion of the write-offs which happened directly in the warehouse. Write-offs in stores which are managed by this warehouse, are not included.)',
	WRITE_OFF_FOR_OTHER_REASONS_NET_VAL COMMENT 'This is a sum of main.write_off_for_donations_net_val + main.write_off_for taken_prod_net_val + main.write_off_for_force_majeure_net_val ',
	CURR_CD COMMENT 'The code identifying the currency according to ISO-4217.',
	CURR_GROUP_FG COMMENT 'Flag for Group Currency',
	CURR_LOCAL_FG COMMENT 'Flag for Local Currency',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record wAS created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record wAS created or lASt updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which hAS done the lASt update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record wAS loaded.'
) as 
  SELECT
  main.bus_dt AS cal_dt
, main.int_org_sid AS store_sid
, main.int_org_type_cd AS int_org_type_cd
, main.prod_sid AS prod_sid
, main.logistic_variant_sid AS logistic_variant_sid
, main.country_org_sid AS country_org_sid
, main.country_org_cd AS country_org_cd
, main.write_off_net_val / fer.exchange_rate AS write_off_net_val
, main.write_off_for_breakage_net_val / fer.exchange_rate AS write_off_for_breakage_net_val
, main.write_off_for_sell_by_dt_net_val / fer.exchange_rate AS write_off_for_sell_by_dt_net_val
, main.write_off_for_deliv_quality_net_val / fer.exchange_rate AS write_off_for_deliv_quality_net_val
, main.write_off_for_defective_non_food_net_val / fer.exchange_rate AS write_off_for_defective_non_food_net_val
, main.write_off_for_donations_net_val / fer.exchange_rate AS write_off_for_donations_net_val
, main.write_off_for_taken_prod_net_val / fer.exchange_rate AS write_off_for_taken_prod_net_val
, main.write_off_for_force_majeure_net_val / fer.exchange_rate AS write_off_for_force_majeure_net_val
, main.write_off_for_discounts_net_val / fer.exchange_rate AS write_off_for_discounts_net_val
, main.write_off_for_stock_clearance_net_val / fer.exchange_rate AS write_off_for_stock_clearance_net_val
,((COALESCE (main.write_off_for_donations_net_val,0) + COALESCE (main.write_off_for_taken_prod_net_val,0) + COALESCE (main.write_off_for_force_majeure_net_val,0))/fer.exchange_rate) AS write_off_for_other_reasons_net_val
, fer.src_curr_cd AS curr_cd
, DECODE(fer.src_curr_cd,'EUR',1,0) AS curr_group_fg
, DECODE(fer.src_curr_cd,fer.TGT_CURR_CD,1,0) AS curr_local_fg
, main.dwh_created_tmsp AS dwh_created_tmsp
, main.dwh_updated_tmsp AS dwh_updated_tmsp
, main.dwh_load_id AS dwh_load_id
, main.dwh_node_cd AS dwh_node_cd
FROM CORE_DIM.T_FACT_WRITE_OFF_BY_ORGANIZATION_DAY_PRODUCT_1 main
INNER JOIN  CORE_DIM.T_FACT_EXCHANGE_RATE_1 fer
ON main.curr_cd = fer.tgt_curr_cd
WHERE exchange_rate_type_cd = 'BEW_ISK'
AND (fer.src_curr_cd = 'EUR')
AND fer.active_fg = TRUE;