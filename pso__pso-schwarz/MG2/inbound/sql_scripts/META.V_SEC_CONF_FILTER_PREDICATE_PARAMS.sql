create or replace view V_SEC_CONF_FILTER_PREDICATE_PARAMS(
	SF_ROLE_USER_NAME,
	PREDICATE_PARAM_NAME,
	VALUE,
	VALUE_TYPE,
	CONF_TMSP
) as
  SELECT DISTINCT 
      main.sf_role_user_name 
    , pt.predicate_param_name 
    , DECODE(pt.predicate_param_name 
                ,'acc_mgr_nr'
				, main.account_manager_nr 
                ,'bench_std'
				, '1' 
                ,'bench_type' 
				, DECODE(main.role_level 
                  ,'SALES_MANAGER'
									,'2' 
                  ,'ACCOUNT_MANAGER'
									,'3' 
                  ,'COMPANY'
									,'4' 
                  ,'REGION'
									,'5' 
                  ,'COUNTRY'
									,'6' 
                  ,'7') 
                ,'country_iso'
				, main.country_iso_cd 
        ,'deliv_company_nr'
				,main.deliv_company_nr 
        ,'sales_company_nr'
				,main.sales_company_nr 
         ,'sales_mgr_nr'
				,main.sales_manager_nr             
    ) AS VALUE 
    , DECODE(pt.predicate_param_name,'bench_std','INT32','bench_type','INT32','STRING') AS value_type 
    , main.dwh_updated_tmsp
  FROM META.v_sec_rap_sf_role_user main
  CROSS JOIN META.T_SEC_CONF_PREDICATE_PARAMETER pt
  WHERE VALUE <> '';