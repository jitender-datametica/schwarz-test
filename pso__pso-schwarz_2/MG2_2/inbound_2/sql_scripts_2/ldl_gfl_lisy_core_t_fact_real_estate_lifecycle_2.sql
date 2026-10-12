DELETE FROM  core_dim.t_fact_real_estate_lifecycle_2;

INSERT INTO core_dim.t_fact_real_estate_lifecycle_2
(
	REAL_ESTATE_SID
	,REAL_ESTATE_NR
	,REAL_ESTATE_NAME
	,REAL_ESTATE_TYPE_CD
	,REAL_ESTATE_STATUS_CD
	,PRECONTRACT_DT
	,CONTRACT_DT
	,CONSTRUCTION_START_DT
	,CONSTRUCTION_END_DT
	,PLANNED_OPEN_DT
	,OPEN_DT
	,OPENING_REASON_CD
	,TEMP_CLOSING_START_DT
	,TEMP_CLOSING_END_DT
	,CLOSED_BUS_DAYS_CNT
	,TEMP_CLOSING_REASON_CD
	,PLANNED_CLOSE_DT
	,CLOSE_DT
	,CLOSING_REASON_CD
	,PROJECT_CANCEL_DT
	,PROJECT_CANCEL_REASON_CD
	,PROJECT_TERM_DT
	,DWH_CREATED_TMSP
	,DWH_UPDATED_TMSP
	,DWH_LOAD_ID
	,DWH_NODE_CD
)
with 
re_status as 
(
	SELECT 
		res.real_estate_sid
		,res.real_estate_status_cd
		,res.real_estate_status_reason_cd
		,res.comment_txt
		,dwh_valid_fg
    FROM core_rel.T_REAL_ESTATE_STATUS_2 res
	WHERE res.real_estate_status_categ_cd = 'BS'
	QUALIFY row_number() over (
				partition by res.real_estate_sid, res.real_estate_status_cd 
				order by res.dwh_valid_from_tmsp desc) = 1
),
tmp_closed as 
(
	SELECT 
		REAL_ESTATE_SID
		,CLOSED_FROM_DT
		,CLOSED_UNTIL_DT
		,CLOSED_BUS_DAYS_CNT
	FROM core_rel.T_REAL_ESTATE_CLOSING_PLAN_2
	-- last temp closure
	QUALIFY ROW_NUMBER () over (partition by REAL_ESTATE_SID order by CLOSED_FROM_DT desc, CLOSED_UNTIL_DT desc) = 1
)           
SELECT 
	re.real_estate_sid 							as real_estate_sid
	,re.real_estate_nr 							as real_estate_nr
	,re.real_estate_name 						as real_estate_name
	,nvl(re.real_estate_type_cd, '@') 			as real_estate_type_cd
	
	,nvl(curr_res.REAL_ESTATE_STATUS_CD, '@') 	as real_estate_status_cd
	
	
	,case 
		when re.precontract_dt between min_dt and max_dt then re.precontract_dt
		else null end 						as precontract_dt
	,case 
		when re.contract_dt between min_dt and max_dt then re.contract_dt
		else null end						as contract_dt
	,case 
		when re.construction_start_dt between min_dt and max_dt then re.construction_start_dt
		else null end 						as construction_start_dt
	,case 
		when re.construction_end_dt between min_dt and max_dt then re.construction_end_dt
        else null end 						as construction_end_dt
	,case 
		when re.planned_open_dt between min_dt and max_dt then re.planned_open_dt
        else null end 						as planned_open_dt
	,case 
		when re.open_dt between min_dt and max_dt then re.open_dt
		else null end 						as open_dt
	,nvl(rs_op.real_estate_status_reason_cd, '@')	as opening_reason_cd
    
	,case 
		when tmp_closed.closed_from_dt between min_dt and max_dt then tmp_closed.closed_from_dt
		else null end 						as temp_closing_start_dt
	,case 
		when tmp_closed.closed_until_dt between min_dt and max_dt then tmp_closed.closed_until_dt
		else null end 						as temp_closing_end_dt
	,nvl(tmp_closed.closed_bus_days_cnt, 0) 		as closed_busines_days_cnt
	,nvl(rs_tc.real_estate_status_reason_cd, '@')	as temp_closing_reason_cd
	
	,case 
		when re.planned_close_dt between min_dt and max_dt then re.planned_close_dt
        else null end 								as planned_close_dt
	,case 
		when re.close_dt between min_dt and max_dt then re.close_dt
		else null end 								as close_dt
	,nvl(rs_cl.real_estate_status_reason_cd, '@') 	as closing_reason_cd
   
	,case 
		when re.project_cancel_dt between min_dt and max_dt then re.project_cancel_dt
		else null end 								as project_cancel_dt
	,nvl(rs_cn.real_estate_status_reason_cd, '@')	as project_cancel_reason_cd
	,case 
		when re.project_term_dt between min_dt and max_dt then re.project_term_dt
		else null end 								as project_term_dt
		
	,re.dwh_created_tmsp 							as dwh_created_tmsp
	,current_timestamp 								as dwh_updated_tmsp 
	,1 												as dwh_load_id
	,'P_LEW_CORE' 									as dwh_node_cd   
FROM core_rel.t_real_estate_2 re_2
	left join core_rel.T_REAL_ESTATE_STATUS_2 curr_res
			on curr_res.REAL_ESTATE_SID = re.REAL_ESTATE_SID
			and curr_res.REAL_ESTATE_STATUS_CATEG_CD = 'BS'
			and curr_res.DWH_VALID_FG = TRUE
	LEFT JOIN re_status rs_op 
			ON re.real_estate_sid = rs_op.real_estate_sid
			AND rs_op.real_estate_status_cd = 'OP'
	LEFT JOIN re_status rs_cl 
			ON re.real_estate_sid = rs_cl.real_estate_sid
			AND rs_cl.real_estate_status_cd = 'CL'
	LEFT JOIN re_status rs_cn 
			ON re.real_estate_sid = rs_cn.real_estate_sid
			AND rs_cn.real_estate_status_cd = 'CN'
	LEFT JOIN re_status rs_tc 
			ON re.real_estate_sid = rs_tc.real_estate_sid
			AND rs_tc.real_estate_status_cd = 'TC'
			
	LEFT JOIN tmp_closed ON re.real_estate_sid = tmp_closed.real_estate_sid
	
	cross join
	(
		select 
			min(calendar_date) min_dt,
			max(calendar_date) max_dt
         from eval.tmp_date_time_2
      ) db
WHERE  re.dwh_valid_fg = 1; 

