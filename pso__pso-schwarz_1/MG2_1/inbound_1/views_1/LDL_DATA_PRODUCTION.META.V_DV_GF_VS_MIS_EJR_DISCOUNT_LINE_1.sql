create or replace view LDL_DATA_PRODUCTION.META.V_DV_GF_VS_MIS_EJR_DISCOUNT_LINE_1(
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
) COMMENT='Comparison of MIS and GF_1 EJR tables on country_1 level for the past three months which returns several kpi’s concerning divergencies in row count (always) and value (only when possible)\ninput datasets:\ncore_rel.t_discount_line_1\np_lew_core.t_pos_receiptline_1\np_lew_core.t_client_1'
 as select table_name , country_cd , busdt_yyyymm , gf_row_cnt , gf_val , mis_row_cnt , mis_val , diff_row_cnt , diff_val , case when gf_row_cnt <> 0 then ( diff_row_cnt / gf_row_cnt * 100) else 0 end as diff_row_cnt_pct , case when gf_val <> 0 then ( diff_val / gf_val * 100) else 0 end as diff_val_pct , case when diff_row_cnt_pct <= -1 then 1 else 0 end as failed_cnt , case when diff_val_pct <= -1 then 1 else 0 end as failed_val , 1 as total from ( select 't_discount_line_1' as table_name , coalesce(gf.country_cd, mis.country_cd) as country_cd , coalesce(gf.busdt_yyyymm, mis.busdt_yyyymm) as busdt_yyyymm , gf.row_cnt as gf_row_cnt , gf.val as gf_val , mis.row_cnt as mis_row_cnt , mis.val as mis_val , gf.row_cnt - mis.row_cnt as diff_row_cnt , gf.val - mis.val as diff_val from ( select t_dl.country_org_cd as country_cd , year(t_dl.bus_dt) * 100 + month(t_dl.bus_dt) as busdt_yyyymm , count(*) as row_cnt , sum(coalesce(discount_val, 0)) as val from  core_rel.t_discount_line_1 as t_dl where t_dl.bus_dt between date_trunc(month,dateadd(month, -2, current_date)) and dateadd(day, -1, current_date) and retail_event_line_scenario_id not in ( '199', '299' ) group by t_dl.country_org_cd , year(t_dl.bus_dt) , month(t_dl.bus_dt) ) as gf_1 full outer join ( select case when upper(t_c.src_country_lidl_cd) = 'CS' then 'ES' else t_c.src_country_lidl_cd end as country_cd , year(t_prl.dwh_cal_dt) * 100 + month(t_prl.dwh_cal_dt) as busdt_yyyymm , count(*) as row_cnt , sum(coalesce(t_prl.discount_val, 0)) as val from  LDL_PRODUCTION.p_lew_core.t_pos_receiptline_1 as t_prl inner join LDL_PRODUCTION.p_lew_core.t_client_1 as t_c on  t_c.client_id = t_prl.client_id where t_prl.transaction_type_cd in ('401','402','441','442','470','472','480','482','501','502','570','572','580','582','601','602','641','642','670','672','680','682','701','702','770','772','780','782') and t_prl.dwh_cal_dt between date_trunc(month,dateadd(month, -2, current_date)) and dateadd(day, -1, current_date) group by case when upper(t_c.src_country_lidl_cd) = 'CS' then 'ES' else t_c.src_country_lidl_cd end , year(t_prl.dwh_cal_dt) , month(t_prl.dwh_cal_dt) ) as mis on  mis.country_cd   = gf.country_cd and mis.busdt_yyyymm = gf.busdt_yyyymm );