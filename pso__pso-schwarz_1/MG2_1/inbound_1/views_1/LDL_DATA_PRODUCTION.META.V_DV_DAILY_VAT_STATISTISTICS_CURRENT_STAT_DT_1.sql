create or replace view LDL_DATA_PRODUCTION.META.V_DV_DAILY_VAT_STATISTISTICS_CURRENT_STAT_DT_1(
	STORE_SID,
	COUNTRY_ORG_SID,
	COUNTRY_ORG_CD,
	REAL_ESTATE_SID,
	STAT_DT,
	BUS_DT,
	CURR_STAT_FG,
	GEO_AREA_SID,
	TAX_CLASS_CD,
	VAT_STAT_CALC_METHOD_CD,
	TURNOVER_GROSS_VAL,
	VAT_VAL,
	CURR_CD,
	DWH_CREATED_TMSP,
	DWH_UPDATED_TMSP,
	DWH_LOAD_ID,
	DWH_NODE_CD,
	RANK,
	FAILED_LATEST_STAT_DT_NOT_CURRENT,
	FAILED_PREVIOUS_STAT_DT_BUT_CURRENT,
	TOTAL
) COMMENT='only one current record  with curr_stat_fg = true (for max (stat_dt)) for the combinaison of the follwoing keys:\nstore_sid,real_estate_sid,bus_dt,geo_area_sid,\ntax_class_cd, vat_stat_calc_method_cd'
 as SELECT store_sid, country_org_sid, country_org_cd, real_estate_sid, stat_dt, bus_dt, curr_stat_fg, geo_area_sid, tax_class_cd, vat_stat_calc_method_cd, turnover_gross_val, vat_val, curr_cd, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd, RANK() OVER (PARTITION BY store_sid, real_estate_sid, bus_dt, geo_area_sid, tax_class_cd, vat_stat_calc_method_cd ORDER BY stat_dt DESC, curr_stat_fg DESC) as RANK, CASE WHEN RANK = 1 AND curr_stat_fg != TRUE THEN 1 ELSE 0 END AS failed_latest_stat_dt_not_current, CASE WHEN RANK > 1 AND curr_stat_fg != FALSE THEN 1 ELSE 0 END AS failed_previous_stat_dt_but_current, 1 as TOTAL FROM core_rel.t_daily_vat_statistics_1;