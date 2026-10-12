create or replace view LDL_DATA_PRODUCTION.META.V_DV_GF_VS_MIS_EJR_PRODUCT_RETAIL_LINE_1(
	TABLE_NAME,
	COUNTRY_CD,
	BUSDT_YYYYMM,
	GF_ROW_CNT,
	GF_VAL,
	MIS_ROW_CNT,
	MIS_VAL,
	DIFF_ROW_CNT,
	DIFF_VAL,
	DIFF_ROW_CNT_PCT,
	DIFF_VAL_PCT,
	FAILED_CNT,
	FAILED_VAL,
	TOTAL
) COMMENT='Comparison of MIS and GF_1 EJR tables on country_1 level for the past three months which returns several kpi’s concerning divergencies in row count (always) and value (only when possible)\ninput datasets:\ncore_rel.t_product_retail_line_1\np_lew_core.t_pos_receiptline_1\np_lew_core.t_client_1'
 as select table_name , country_cd , busdt_yyyymm , gf_row_cnt , gf_val , mis_row_cnt , mis_val , diff_row_cnt , diff_val , case when gf_row_cnt <> 0 then ( diff_row_cnt / gf_row_cnt * 100) else 0 end as diff_row_cnt_pct , case when gf_val <> 0 then ( diff_val / gf_val * 100) else 0 end as diff_val_pct , case when diff_row_cnt_pct <= -1 then 1 else 0 end as failed_cnt , case when diff_val_pct <= -1 then 1 else 0 end as failed_val , 1 as total from ( select 't_product_retail_line_1' as table_name , coalesce(gf.country_cd, mis.country_cd) as country_cd , coalesce(gf.busdt_yyyymm, mis.busdt_yyyymm) as busdt_yyyymm , gf.row_cnt as gf_row_cnt , gf.val as gf_val , mis.row_cnt as mis_row_cnt , mis.val as mis_val , gf.row_cnt - mis.row_cnt as diff_row_cnt , gf.val - mis.val as diff_val from ( select t_prl.country_org_cd as country_cd , year(t_prl.bus_dt) * 100 + month(t_prl.bus_dt) as busdt_yyyymm , count(*) as row_cnt , ( sum( case when lower(t_prl.prod_retail_line_type_cd) in ('s', 'sd', 'd', 'rd') then coalesce(t_prl.retail_line_net_val, 0) else 0 end ) + sum( case when lower(t_prl.prod_retail_line_type_cd) in ('r') then coalesce(t_prl.retail_line_net_val, 0) else 0 end ) ) as val from  core_rel.t_product_retail_line_1 as t_prl where t_prl.bus_dt between date_trunc(month,dateadd(month, -2, current_date)) and dateadd(day, -1, current_date) group by t_prl.country_org_cd , year(t_prl.bus_dt) , month(t_prl.bus_dt) ) as gf_1 full outer join ( select case when upper(t_c.src_country_lidl_cd) = 'CS' then 'ES' else t_c.src_country_lidl_cd end as country_cd , year(t_prl.dwh_cal_dt) * 100 + month(t_prl.dwh_cal_dt) as busdt_yyyymm , count(*) as row_cnt , sum( round(zeroifnull(t_prl.sales_val) * 100 / coalesce(nullifzero(t_prl.vat_pct_val)+100, 100), 5) ) as val from  LDL_PRODUCTION.p_lew_core.t_pos_receiptline_1 as t_prl inner join LDL_PRODUCTION.p_lew_core.t_client_1 as t_c on  t_c.client_id = t_prl.client_id where t_prl.transaction_type_cd in ('101','102','120','121','122','123','141','142','170','172','180','182','201','202','220','221','222','223','270','272','280','282') and t_prl.dwh_cal_dt between date_trunc(month,dateadd(month, -2, current_date)) and dateadd(day, -1, current_date) group by case when upper(t_c.src_country_lidl_cd) = 'CS' then 'ES' else t_c.src_country_lidl_cd end , year(t_prl.dwh_cal_dt) , month(t_prl.dwh_cal_dt) ) as mis on  mis.country_cd   = gf.country_cd and mis.busdt_yyyymm = gf.busdt_yyyymm );