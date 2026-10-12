DELETE FROM ETL.T_R2D_INTERNAL_ORGANIZATION_MANAGER_2;

INSERT INTO ETL.T_R2D_INTERNAL_ORGANIZATION_MANAGER_2
(
    INT_ORG_SID
    ,JOB_ROLE_TYPE_CD
    ,DWH_VALID_FROM_TMSP
    ,DWH_VALID_TO_TMSP
    ,INT_ORG_MGR_SID
    ,INT_ORG_MGR_NR
    ,INT_ORG_MGR_FIRST_NAME
    ,INT_ORG_MGR_LAST_NAME
    ,INT_ORG_MGR_FULL_NAME
)
with
int_org_mgr_dedup as 
(
    select
    *
    from core_rel.t_employee_job_role_2
    qualify row_number() over (partition by job_role_sid order by DWH_VALID_FROM_TMSP desc) = 1
)

, int_org_manager as 
(
    SELECT 
        jr.INT_ORG_SID
        ,jr.JOB_ROLE_TYPE_CD
        ,min(
            greatest(
                io.DWH_VALID_FROM_TMSP
                ,jr.DWH_VALID_FROM_TMSP
                ,per.DWH_VALID_FROM_TMSP
                )
            )as VAL_FROM
        
        ,per.PERSON_SID                as INT_ORG_MGR_SID
        ,per.EMP_NR                    as INT_ORG_MGR_NR
        ,per.FIRST_NAME                as INT_ORG_MGR_FIRST_NAME
        ,per.FAMILY_NAME               as INT_ORG_MGR_LAST_NAME
        ,CASE
    			when per.family_name = 'VW' then 'VW'
    			else ltrim(nvl(INITCAP(REGEXP_REPLACE(per.FIRST_NAME, '[0-9]', '')) || ' ' || INITCAP(REGEXP_REPLACE(per.FAMILY_NAME, '[0-9]', '')),'Unbekannt'))
    		end		                   as INT_ORG_MGR_FULL_NAME
        
    FROM core_rel.T_INTERNAL_ORGANIZATION_2 io 
        join core_rel.T_JOB_ROLE_2 jr
                    on jr.INT_ORG_SID = io.INT_ORG_SID
                    and jr.DWH_VALID_FROM_TMSP <= io.DWH_VALID_TO_TMSP
                    and jr.DWH_VALID_TO_TMSP >= io.DWH_VALID_FROM_TMSP
        join int_org_mgr_dedup ejr
                    on ejr.JOB_ROLE_SID = jr.JOB_ROLE_SID
        join core_rel.T_PERSON_2 per 
                    on per.PERSON_SID = ejr.EMP_SID 
                    and per.DWH_VALID_FROM_TMSP <= least(
                                                        jr.DWH_VALID_TO_TMSP
                                                        ,io.DWH_VALID_TO_TMSP
                                                    )
                    and per.DWH_VALID_TO_TMSP >= greatest(
                                                        jr.DWH_VALID_FROM_TMSP
                                                        ,io.DWH_VALID_FROM_TMSP
                                                    ) 
    WHERE 1=1
        and jr.JOB_ROLE_TYPE_CD in
        (
            'SALES_MANAGER'             -- for Sales_2 Manager Districts
            ,'ACCOUNT_MANAGER'          -- for Account_2 Manager Districts
            ,'COMPANY_MANAGER'          -- for Companies (some companies are also Contry Organizations and for one INT_ORG_SID we have two roles)
            ,'REGION_MANAGER'           -- for Organizational Regions
            ,'COUNTRY_ORG_MANAGER'      -- for Country_2 Organizations
            ,'COUNTRY_GRP_MANAGER'      -- for Country_2 Groups
        )
	    
		--temp just for test_2 to see how lisy-only data looks 
		and (
				(io.INT_ORG_TYPE_CD in ('STORE', 'COMPANY') and io.DWH_NODE_CD <> 'P_LEW_CORE')
				or io.INT_ORG_TYPE_CD not in ('STORE', 'COMPANY')
			)  
    GROUP BY 
         jr.INT_ORG_SID
        ,jr.JOB_ROLE_TYPE_CD
        ,INT_ORG_MGR_SID
        ,INT_ORG_MGR_NR
        ,INT_ORG_MGR_FIRST_NAME
        ,INT_ORG_MGR_LAST_NAME
        ,INT_ORG_MGR_FULL_NAME
)

SELECT
    INT_ORG_SID
    ,JOB_ROLE_TYPE_CD
    ,VAL_FROM as DWH_VALID_FROM_TMSP
    ,nvl(dateadd(ms, -1, lead(VAL_FROM) OVER (PARTITION BY INT_ORG_SID, JOB_ROLE_TYPE_CD ORDER BY VAL_FROM)), '9999-12-31 23:59:59.999999999') as DWH_VALID_TO_TMSP
    ,INT_ORG_MGR_SID
    ,INT_ORG_MGR_NR
    ,INT_ORG_MGR_FIRST_NAME
    ,INT_ORG_MGR_LAST_NAME
    ,INT_ORG_MGR_FULL_NAME
FROM int_org_manager
GROUP BY 
    INT_ORG_SID
    ,JOB_ROLE_TYPE_CD
    ,VAL_FROM
    ,INT_ORG_MGR_SID
    ,INT_ORG_MGR_NR
    ,INT_ORG_MGR_FIRST_NAME
    ,INT_ORG_MGR_LAST_NAME 
    ,INT_ORG_MGR_FULL_NAME
;
