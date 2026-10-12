DELETE FROM CORE_DIM.T_FACT_REAL_ESTATE_EVENT_1;

INSERT INTO CORE_DIM.T_FACT_REAL_ESTATE_EVENT_1 (
   bus_dt
   ,real_estate_sid
   ,real_estate_type_cd
   ,country_org_cd   
   ,reporting_country_cd
   ,real_estate_event_type_cd
   ,real_estate_event_reason_cd
   ,dwh_created_tmsp   
   ,dwh_updated_tmsp     
   ,dwh_load_id
   ,dwh_node_cd
) 
with 
bld_contact_signing as
(
	SELECT
		least(
			nvl(re.precontract_dt, re.contract_dt)
			,nvl(re.contract_dt, re.precontract_dt)
		) 									as bus_dt
		,re.real_estate_sid
        ,re.real_estate_nr
		,re.real_estate_type_cd
		,'CS' 								as real_estate_event_type_cd
		, '@' 								as real_estate_event_reason_cd
	FROM core_rel.t_real_estate_1 re_1
	WHERE re.DWH_VALID_FG = true
        AND bus_dt IS NOT NULL
)
,bld_openings as
(
	SELECT
		to_date(res.dwh_valid_from_tmsp) 	as bus_dt
		,re.real_estate_sid
        ,re.real_estate_nr
		,re.real_estate_type_cd
		,'OP' 								as real_estate_event_type_cd
		, '@' 								as real_estate_event_reason_cd
	FROM core_rel.t_real_estate_1 re_1
		join core_rel.t_real_estate_status_1 res
			on re.real_estate_sid = res.real_estate_sid
			and res.real_estate_status_categ_cd = 'BS'
			and res.real_estate_status_cd = 'OP'
	WHERE 1=1
		and re.DWH_VALID_FG = TRUE
		and re.OPEN_DT is not NULL
)
,bld_store_closure as
(
	SELECT
		re.close_dt 						as bus_dt
		,re.real_estate_sid
        ,re.real_estate_nr
		,re.real_estate_type_cd
		,'CL' 								as real_estate_event_type_cd
		,res.real_estate_status_reason_cd 	as real_estate_event_reason_cd
	FROM core_rel.t_real_estate_1 re_1
		join core_rel.t_real_estate_status_1 res
			on re.real_estate_sid = res.real_estate_sid
			and res.real_estate_status_categ_cd = 'BS'
			and res.real_estate_status_cd = 'CL'
	WHERE 1=1
		and re.DWH_VALID_FG = TRUE
		and re.CLOSE_DT is not NULL

)
,bld_temp_closure as
(
	SELECT
		to_date(res.dwh_valid_from_tmsp) 	as bus_dt
		,re.real_estate_sid
        ,re.real_estate_nr
		,re.real_estate_type_cd
		,'TC' 								as real_estate_event_type_cd
		,res.real_estate_status_reason_cd 	as real_estate_event_reason_cd
	FROM core_rel.t_real_estate_1 re_1
		join core_rel.t_real_estate_status_1 res
			on re.real_estate_sid = res.real_estate_sid
			and res.real_estate_status_categ_cd = 'BS'
			and res.real_estate_status_cd = 'TC'
	WHERE re.DWH_VALID_FG = TRUE

)    
,bld_proj_cancellation as
(
	SELECT
		re.project_cancel_dt		 		as bus_dt
		,re.real_estate_sid
        ,re.real_estate_nr
		,re.real_estate_type_cd
		,'CN' 								as real_estate_event_type_cd
		,res.real_estate_status_reason_cd 	as real_estate_event_reason_cd
	FROM core_rel.t_real_estate_1 re_1
		join core_rel.t_real_estate_status_1 res
			on re.real_estate_sid = res.real_estate_sid
			and res.real_estate_status_categ_cd = 'BS'
			and res.real_estate_status_cd = 'CN'
	WHERE re.DWH_VALID_FG = TRUE
        and re.project_cancel_dt is not null

)
,bld_final_settlement as
(       
	select
		re.project_term_dt					as bus_dt
	   ,re.real_estate_sid
        ,re.real_estate_nr
	   ,re.real_estate_type_cd
	   ,'TE' 								as real_estate_event_type_cd
	   , '@' 								as real_estate_event_reason_cd
	from core_rel.t_real_estate_1 re_1
		join core_rel.t_real_estate_status_1 res
			on re.real_estate_sid = res.real_estate_sid
			and res.real_estate_status_categ_cd = 'BS'
			and res.real_estate_status_cd = 'TE'
	WHERE re.DWH_VALID_FG = TRUE
        and re.project_term_dt is not null
)
,all_events as
(
	SELECT * FROM bld_contact_signing
	UNION ALL
	SELECT * FROM bld_openings
	UNION ALL
	SELECT * FROM bld_store_closure
	UNION ALL
	SELECT * FROM bld_temp_closure
	UNION ALL
	SELECT * FROM bld_proj_cancellation
	UNION ALL
	SELECT * FROM bld_final_settlement
)
SELECT 
    ae.BUS_DT
    ,ae.REAL_ESTATE_SID
    ,ae.REAL_ESTATE_TYPE_CD
    -- temporary workaround until we implement relationship between building and company that owns it in T_INTERNAL_ORGANIZATION_REAL_ESTATE_1
    ,decode(substr(ae.REAL_ESTATE_NR,1,2)
        ,'CS', 'ES'
        ,'LU', 'BE'
        ,substr(ae.REAL_ESTATE_NR,1,2)) as COUNTRY_ORG_CD
    ,nvl(sa.REPORTING_COUNTRY_CD, '@')
    ,ae.REAL_ESTATE_EVENT_TYPE_CD
    ,nvl(ae.REAL_ESTATE_EVENT_REASON_CD, '@') as REAL_ESTATE_EVENT_REASON_CD
    
	,current_timestamp 			as DWH_CREATED_TMSP   
    ,current_timestamp 			as DWH_UPDATED_TMSP     
    ,-1							as DWH_LOAD_ID
    ,'CORE_REL'					as DWH_NODE_CD
FROM all_events ae
    left join etl.t_r2d_real_estate_street_address_1 sa
			on sa.real_estate_sid = ae.real_estate_sid
			and current_date between sa.dwh_valid_from_tmsp and sa.dwh_valid_to_tmsp
;
