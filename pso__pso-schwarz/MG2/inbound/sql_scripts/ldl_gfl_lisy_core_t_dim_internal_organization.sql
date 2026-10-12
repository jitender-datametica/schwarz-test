
DELETE FROM core_dim.T_DIM_INTERNAL_ORGANIZATION;

-- Dummy row
INSERT into core_dim.T_DIM_INTERNAL_ORGANIZATION
(
    INT_ORG_SID
    ,DWH_VALID_FROM_TMSP
    ,DWH_VALID_TO_TMSP
    ,DWH_VALID_FG
    
    ,INT_ORG_TYPE_CD
    ,INT_ORG_TYPE_DESCR
    ,CURR_INT_ORG_NR
    ,INIT_INT_ORG_NR
    ,INT_ORG_NAME
	,LEGAL_NAME
    ,CURR_CD
    ,INT_ORG_STATUS_CD
    ,INT_ORG_STATUS_DESCR
	,STORE_REAL_ESTATE_TYPE_CD
	,STORE_REAL_ESTATE_TYPE_DESCR
    
    ,OPEN_DT
    ,PLANNED_OPEN_DT
    ,CLOSE_DT
	,COMP_PERIOD_START_DT
	,COMP_PERIOD_END_DT
    ,ISO_COUNTRY_CD
    ,COUNTRY_NAME
    ,CITY_NAME
    ,DISTRICT_NAME
    ,ZIP
    ,STREET_NAME
    ,HOUSE_NR
    ,LON
    ,LAT
    ,PO_BOX_NR
    ,PHONE_NR
    ,FAX_NR
    ,EMAIL_ADDR_TXT
    ,REPORTING_COUNTRY_CD
	,REPORTING_COUNTRY_NAME
	,OFFICIAL_LANG_CD
    
    ,IS_SALES_COMPANY_FG
    ,IS_DELIV_COMPANY_FG
    ,IS_COUNTRY_ORG_FG
    ,IS_EXPANSION_COMPANY_FG
    ,IS_BAL_SHEET_COMPANY_FG
    ,IS_OWNER_COMPANY_FG
    ,IS_TRUST_FG
    
    ,SALES_MGR_DISTRICT_SID
    ,SALES_MGR_DISTRICT_NR
    ,SALES_MGR_DISTRICT_NAME
    ,SALES_MGR_EMP_SID
    ,SALES_MGR_EMP_NR
    ,SALES_MGR_NAME
    
    ,ACCT_MGR_DISTRICT_SID
    ,ACCT_MGR_DISTRICT_NR
    ,ACCT_MGR_DISTRICT_NAME
    ,ACCT_MGR_EMP_SID
    ,ACCT_MGR_EMP_NR
    ,ACCT_MGR_NAME
    
    ,SALES_COMPANY_SID
    ,SALES_COMPANY_NR
    ,SALES_COMPANY_NAME
    ,SALES_COMPANY_DIRECTOR_EMP_SID
    ,SALES_COMPANY_DIRECTOR_EMP_NR
    ,SALES_COMPANY_DIRECTOR_NAME
    
    ,DELIV_COMPANY_SID
    ,DELIV_COMPANY_NR
    ,DELIV_COMPANY_NAME
    ,DELIV_COMPANY_DIRECTOR_EMP_SID
    ,DELIV_COMPANY_DIRECTOR_EMP_NR
    ,DELIV_COMPANY_DIRECTOR_NAME
    
    ,EXPANSION_COMPANY_SID
    ,EXPANSION_COMPANY_NR
    ,EXPANSION_COMPANY_NAME
    ,BAL_SHEET_COMPANY_SID
    ,BAL_SHEET_COMPANY_NR
    ,BAL_SHEET_COMPANY_NAME
    ,OWNER_COMPANY_SID
    ,OWNER_COMPANY_NR
    ,OWNER_COMPANY_NAME
    
    ,SALES_REGION_SID
    ,SALES_REGION_NR
    ,SALES_REGION_NAME
    ,SALES_REGION_MGR_EMP_SID
    ,SALES_REGION_MGR_EMP_NR
    ,SALES_REGION_MGR_NAME
    
    ,DELIV_REGION_SID
    ,DELIV_REGION_NR
    ,DELIV_REGION_NAME
    ,DELIV_REGION_MGR_EMP_SID
    ,DELIV_REGION_MGR_EMP_NR
    ,DELIV_REGION_MGR_NAME
    
    ,COUNTRY_ORG_SID
    ,COUNTRY_ORG_CD
    ,COUNTRY_ORG_NR
    ,COUNTRY_ORG_NAME
    ,COUNTRY_ORG_MGR_EMP_SID
    ,COUNTRY_ORG_MGR_EMP_NR
    ,COUNTRY_ORG_MGR_NAME
    
    ,COUNTRY_GRP_ORG_SID
    ,COUNTRY_GRP_ORG_NR
    ,COUNTRY_GRP_ORG_NAME
    ,COUNTRY_GRP_ORG_MGR_EMP_SID
    ,COUNTRY_GRP_ORG_MGR_EMP_NR
    ,COUNTRY_GRP_ORG_MGR_NAME
    
    ,DWH_CREATED_TMSP
    ,DWH_UPDATED_TMSP
    ,DWH_LOAD_ID
    ,DWH_NODE_CD
)
VALUES
(
-- technical cols
    -1,
    to_timestamp('1900-01-01'),
    to_timestamp('9999-12-31 23:59:59.999'),
    true,

    -- INT ORG main attributes
    '@',
    'Unbekannt',
    '@',
    '@',
    'Unbekannt',
	'Unbekannt',

    '@', -- curr_cd
    
    '@',
    'Unbekannt',
	'@',
    'Unbekannt',
    
    null,
    null,
    null,
	null,
	null,

    -- int org address
    '@',
    'Unbekannt',
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
	'@',
	'Unbekannt',
	'@',

    -- flags
    false,
    false,
    false,
    false,
    false,
    false,
    false,

    --hierarchy (SMD)
    -1,
    null,
    'Unbekannt',
    -1,
    null,
    'Unbekannt',
    
    -- hierarchy (AMD)
    -1,
    null,
    'Unbekannt',
    -1,
    null,
    'Unbekannt',

    -- hierarchy SalesComp
    -1,
    null,
    'Unbekannt',
    -1,
    null,
    'Unbekannt',
    
    -- hierarchy DelivComp
    -1,
    null,
    'Unbekannt',
    -1,
    null,
    'Unbekannt',

    -- hierarchy other Comps
    -1,
    null,
    'Unbekannt',
    -1,
    null,
    'Unbekannt',
    -1,
    null,
    'Unbekannt',

    -- hierarchy Sales Reg
    -1,
    null,
    'Unbekannt',
    -1,
    null,
    'Unbekannt',

    -- hierarchy Deliv Reg
    -1,
    null,
    'Unbekannt',
    -1,
    null,
    'Unbekannt',
    
    -- hierarchy Country Org
    -1,
    null,
    null,
    'Unbekannt',
    -1,
    null,
    'Unbekannt',

    -- hierarchy Country Group
    -1,
    null,
    'Unbekannt',
    -1,
    null,
    'Unbekannt',

    -- technical cols
    current_timestamp,
    current_timestamp,
    -1,
    'MANUAL'
);


--- All types of internal organizations except stores
INSERT into core_dim.T_DIM_INTERNAL_ORGANIZATION
(
    INT_ORG_SID
    ,DWH_VALID_FROM_TMSP
    ,DWH_VALID_TO_TMSP
    ,DWH_VALID_FG
    
    ,INT_ORG_TYPE_CD
    ,INT_ORG_TYPE_DESCR
    ,CURR_INT_ORG_NR
    ,INIT_INT_ORG_NR
    ,INT_ORG_NAME
	,LEGAL_NAME

    ,CURR_CD
    
    ,INT_ORG_STATUS_CD
    ,INT_ORG_STATUS_DESCR
	,STORE_REAL_ESTATE_TYPE_CD
	,STORE_REAL_ESTATE_TYPE_DESCR
    
    ,OPEN_DT
    ,PLANNED_OPEN_DT
    ,CLOSE_DT
	,COMP_PERIOD_START_DT
	,COMP_PERIOD_END_DT
    ,ISO_COUNTRY_CD
    ,COUNTRY_NAME
    ,CITY_NAME
    ,DISTRICT_NAME
    ,ZIP
    ,STREET_NAME
    ,HOUSE_NR
    ,LON
    ,LAT
    ,PO_BOX_NR
    ,PHONE_NR
    ,FAX_NR
    ,EMAIL_ADDR_TXT
    ,REPORTING_COUNTRY_CD
	,REPORTING_COUNTRY_NAME
	,OFFICIAL_LANG_CD
    
    ,IS_SALES_COMPANY_FG
    ,IS_DELIV_COMPANY_FG
    ,IS_COUNTRY_ORG_FG
    ,IS_EXPANSION_COMPANY_FG
    ,IS_BAL_SHEET_COMPANY_FG
    ,IS_OWNER_COMPANY_FG
    ,IS_TRUST_FG
    
    ,SALES_MGR_DISTRICT_SID
    ,SALES_MGR_DISTRICT_NR
    ,SALES_MGR_DISTRICT_NAME
    ,SALES_MGR_EMP_SID
    ,SALES_MGR_EMP_NR
    ,SALES_MGR_NAME
    
    ,ACCT_MGR_DISTRICT_SID
    ,ACCT_MGR_DISTRICT_NR
    ,ACCT_MGR_DISTRICT_NAME
    ,ACCT_MGR_EMP_SID
    ,ACCT_MGR_EMP_NR
    ,ACCT_MGR_NAME
    
    ,SALES_COMPANY_SID
    ,SALES_COMPANY_NR
    ,SALES_COMPANY_NAME
    ,SALES_COMPANY_DIRECTOR_EMP_SID
    ,SALES_COMPANY_DIRECTOR_EMP_NR
    ,SALES_COMPANY_DIRECTOR_NAME
    
    ,DELIV_COMPANY_SID
    ,DELIV_COMPANY_NR
    ,DELIV_COMPANY_NAME
    ,DELIV_COMPANY_DIRECTOR_EMP_SID
    ,DELIV_COMPANY_DIRECTOR_EMP_NR
    ,DELIV_COMPANY_DIRECTOR_NAME
    
    ,EXPANSION_COMPANY_SID
    ,EXPANSION_COMPANY_NR
    ,EXPANSION_COMPANY_NAME
    ,BAL_SHEET_COMPANY_SID
    ,BAL_SHEET_COMPANY_NR
    ,BAL_SHEET_COMPANY_NAME
    ,OWNER_COMPANY_SID
    ,OWNER_COMPANY_NR
    ,OWNER_COMPANY_NAME
    
    ,SALES_REGION_SID
    ,SALES_REGION_NR
    ,SALES_REGION_NAME
    ,SALES_REGION_MGR_EMP_SID
    ,SALES_REGION_MGR_EMP_NR
    ,SALES_REGION_MGR_NAME
    
    ,DELIV_REGION_SID
    ,DELIV_REGION_NR
    ,DELIV_REGION_NAME
    ,DELIV_REGION_MGR_EMP_SID
    ,DELIV_REGION_MGR_EMP_NR
    ,DELIV_REGION_MGR_NAME
    
    ,COUNTRY_ORG_SID
    ,COUNTRY_ORG_CD
    ,COUNTRY_ORG_NR
    ,COUNTRY_ORG_NAME
    ,COUNTRY_ORG_MGR_EMP_SID
    ,COUNTRY_ORG_MGR_EMP_NR
    ,COUNTRY_ORG_MGR_NAME
    
    ,COUNTRY_GRP_ORG_SID
    ,COUNTRY_GRP_ORG_NR
    ,COUNTRY_GRP_ORG_NAME
    ,COUNTRY_GRP_ORG_MGR_EMP_SID
    ,COUNTRY_GRP_ORG_MGR_EMP_NR
    ,COUNTRY_GRP_ORG_MGR_NAME
    
    ,DWH_CREATED_TMSP
    ,DWH_UPDATED_TMSP
    ,DWH_LOAD_ID
    ,DWH_NODE_CD
)
with 
validity_listing(INT_ORG_SID, DWH_MAPPING_TMSP) as
(
    -- IntOrg
    SELECT 
        io.INT_ORG_SID
        ,io.DWH_VALID_FROM_TMSP
    FROM core_rel.T_INTERNAL_ORGANIZATION io
	 WHERE 1=1
		and io.INT_ORG_TYPE_CD <> 'STORE' 
		--temp just for test to see how lisy-only data looks 
		-- and (
				-- (io.INT_ORG_TYPE_CD = 'COMPANY' and io.DWH_NODE_CD <> 'P_LEW_CORE')
				-- or io.INT_ORG_TYPE_CD <> 'COMPANY'
			-- )
    UNION
    SELECT 
        io.INT_ORG_SID
        ,decode(io.DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999',  io.DWH_VALID_TO_TMSP, DATEADD(ns, 1, io.DWH_VALID_TO_TMSP))
    FROM core_rel.T_INTERNAL_ORGANIZATION io
     
	WHERE 1=1
		and io.INT_ORG_TYPE_CD <> 'STORE'
		--temp just for test to see how lisy-only data looks		
		-- and (
				-- (io.INT_ORG_TYPE_CD = 'COMPANY' and io.DWH_NODE_CD <> 'P_LEW_CORE')
				-- or io.INT_ORG_TYPE_CD <> 'COMPANY'
			-- )
    UNION
    SELECT 
        io.INT_ORG_SID
        ,'1900-01-01'::TIMESTAMP
    FROM core_rel.T_INTERNAL_ORGANIZATION io
    WHERE 1=1
		and io.INT_ORG_TYPE_CD <> 'STORE' 
		--temp just for test to see how lisy-only data looks 
		-- and (
				-- (io.INT_ORG_TYPE_CD = 'COMPANY' and io.DWH_NODE_CD <> 'P_LEW_CORE')
				-- or io.INT_ORG_TYPE_CD <> 'COMPANY'
			-- )

    UNION
    
    -- IntOrg Hierachy
    SELECT 
        fh.CHILD_ORG_SID
        ,fh.DWH_VALID_FROM_TMSP
    FROM etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY fh
    UNION
    SELECT 
        fh.CHILD_ORG_SID
        ,decode(fh.DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999',  fh.DWH_VALID_TO_TMSP, DATEADD(ns, 1, fh.DWH_VALID_TO_TMSP))
    FROM etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY fh

    UNION

    -- Street Address
    SELECT 
        sa.INT_ORG_SID
        ,sa.DWH_VALID_FROM_TMSP
    FROM etl.T_R2D_INTERNAL_ORGANIZATION_STREET_ADDRESS sa
    UNION
    SELECT 
        sa.INT_ORG_SID
        ,decode(sa.DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999',  sa.DWH_VALID_TO_TMSP, DATEADD(ns, 1, sa.DWH_VALID_TO_TMSP))
    FROM etl.T_R2D_INTERNAL_ORGANIZATION_STREET_ADDRESS sa
    
    UNION

    -- Phone
    SELECT 
        ph.INT_ORG_SID
        ,ph.DWH_VALID_FROM_TMSP
    FROM etl.T_R2D_INTERNAL_ORGANIZATION_PHONE ph
    UNION
    SELECT 
        ph.INT_ORG_SID
        ,decode(ph.DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999',  ph.DWH_VALID_TO_TMSP, DATEADD(ns, 1, ph.DWH_VALID_TO_TMSP))
    FROM etl.T_R2D_INTERNAL_ORGANIZATION_PHONE ph

    UNION

    -- Status
    SELECT 
        st.INT_ORG_SID
        ,st.DWH_VALID_FROM_TMSP
    FROM etl.T_R2D_INTERNAL_ORGANIZATION_STATUS st
    UNION
    SELECT 
        st.INT_ORG_SID
        ,decode(st.DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999',  st.DWH_VALID_TO_TMSP, DATEADD(ns, 1, st.DWH_VALID_TO_TMSP))
    FROM etl.T_R2D_INTERNAL_ORGANIZATION_STATUS st

    UNION

    -- Manager
    SELECT 
        m.INT_ORG_SID
        ,m.DWH_VALID_FROM_TMSP
    FROM etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER m
    UNION
    SELECT 
        m.INT_ORG_SID
        ,decode(m.DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999',  m.DWH_VALID_TO_TMSP, DATEADD(ns, 1, m.DWH_VALID_TO_TMSP))
    FROM etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER m
    
	UNION
	
	-- Real Estate
	SELECT 
        r.INT_ORG_SID
        ,r.DWH_VALID_FROM_TMSP
    FROM etl.T_R2D_REAL_ESTATE_INTERNAL_ORGANIZATION r
    UNION
    SELECT 
        r.INT_ORG_SID
        ,decode(r.DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999',  r.DWH_VALID_TO_TMSP, DATEADD(ns, 1, r.DWH_VALID_TO_TMSP))
    FROM etl.T_R2D_REAL_ESTATE_INTERNAL_ORGANIZATION r
	
)
SELECT 
    vl.INT_ORG_SID
    ,vl.DWH_MAPPING_TMSP as VAL_FROM
    ,lead(dateadd(ns, -1, vl.DWH_MAPPING_TMSP),1,'9999-12-31 23:59:59.999') 
                over (partition by vl.INT_ORG_SID order by vl.DWH_MAPPING_TMSP asc)    as VAL_TO
    ,(current_timestamp between val_from and val_to) as DWH_VALID_FG

    ,nvl(iot_de.INT_ORG_TYPE_CD, '@')                    	as INT_ORG_TYPE_CD
    ,nvl(iot_de.INT_ORG_TYPE_DESCR, 'Unbekannt')        	as INT_ORG_TYPE_DESCR
    ,nvl(io.INT_ORG_NR, '@')                                as CURR_INT_ORG_NR
    ,first_value(io.INT_ORG_NR ignore nulls) 
        over(partition by vl.INT_ORG_SID 
            ORDER BY vl.DWH_MAPPING_TMSP)                   as INIT_INT_ORG_NR
    ,nvl(io.INT_ORG_NAME, 'Unbekannt')                    	as INT_ORG_NAME
    ,nvl(io.LEGAL_NAME, 'Unbekannt')                        as LEGAL_NAME

    ,nvl(io_co.CURR_CD, '@')                                as CURR_CD
    
    ,nvl(io_st.INT_ORG_STATUS_CD, '@')                    	as INT_ORG_STATUS_CD
    ,nvl(io_st.INT_ORG_STATUS_DESCR_DE, 'Unbekannt')      	as INT_ORG_STATUS_DESCR
	,nvl(reio.STORE_REAL_ESTATE_TYPE_CD, '@') 						as STORE_REAL_ESTATE_TYPE_CD
	,nvl(reio.STORE_REAL_ESTATE_TYPE_DESCR, 'Unbekannt') 			as STORE_REAL_ESTATE_TYPE_DESCR 	
    ,io.OPEN_DT
    ,io.PLANNED_OPEN_DT
    ,io.CLOSE_DT
	,null												as COMP_PERIOD_START_DT 
	,null												as COMP_PERIOD_END_DT
	
    ,nvl(io_sa.ISO_COUNTRY_CD, '@')                        as ISO_COUNTRY_CD
    ,nvl(io_sa.COUNTRY_NAME, 'Unbekannt')                  as COUNTRY_NAME
    ,io_sa.CITY_NAME
    ,io_sa.DISTRICT_NAME
    ,io_sa.ZIP
    ,io_sa.STREET_NAME
    ,io_sa.HOUSE_NR
    ,io_sa.LON
    ,io_sa.LAT
    ,NULL                                               as PO_BOX_NR
    ,io_tel.PHONE_NR
    ,NULL                                               as FAX_NR
    ,NULL                                               as EMAIL_ADDR_TXT
    ,nvl(io_sa.REPORTING_COUNTRY_CD,'@')				as REPORTING_COUNTRY_CD
    ,nvl(io_sa.REPORTING_COUNTRY_NAME, 'Unbekannt')		as REPORTING_COUNTRY_NAME
	,nvl(io_lang.LANG_CD, '@')							as OFFICIAL_LANG_CD

    ,nvl(io.IS_SALES_COMPANY_FG, false)                as IS_SALES_COMPANY_FG
    ,nvl(io.IS_DELIV_COMPANY_FG, false)                as IS_DELIV_COMPANY_FG
    ,nvl(io.IS_COUNTRY_ORG_FG, false)                  as IS_COUNTRY_ORG_FG
    ,nvl(io.IS_EXPANSION_COMPANY_FG, false)            as IS_EXPANSION_COMPANY_FG
    ,nvl(io.IS_BAL_SHEET_COMPANY_FG, false)            as IS_BAL_SHEET_COMPANY_FG
    ,nvl(io.IS_OWNER_COMPANY_FG, false)                as IS_OWNER_COMPANY_FG
    ,nvl(io.IS_TRUST_FG, false)                        as IS_TRUST_FG

    -- Sales Manager Attributes >>
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'SALES_MANAGER' THEN vl.INT_ORG_SID
            ELSE nvl(smd.PARENT_ORG_SID, -1)
        END as SALES_MGR_DISTRICT_SID
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'SALES_MANAGER' THEN io.INT_ORG_NR
            ELSE smd.PARENT_ORG_NR
        END as SALES_MGR_DISTRICT_NR
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'SALES_MANAGER' THEN nvl(io.INT_ORG_NAME, 'Unbekannt')
            ELSE nvl(smd.PARENT_ORG_NAME, 'Unbekannt')
        END as SALES_MGR_DISTRICT_NAME
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'SALES_MANAGER' THEN nvl(io_mgr.INT_ORG_MGR_SID, -1)
            ELSE nvl(smd_mgr.INT_ORG_MGR_SID, -1)
        END as SALES_MGR_EMP_SID
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'SALES_MANAGER' THEN io_mgr.INT_ORG_MGR_NR
            ELSE smd_mgr.INT_ORG_MGR_NR
        END as SALES_MGR_EMP_NR
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'SALES_MANAGER' THEN nvl(io_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
            ELSE nvl(smd_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
        END as SALES_MGR_NAME
    -- Sales Manager Attributes <<

    
    -- Account Manager Attributes >>
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'ACCOUNT_MANAGER' THEN vl.INT_ORG_SID
            ELSE nvl(amd.PARENT_ORG_SID, -1)
        END as ACCT_MGR_DISTRICT_SID
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'ACCOUNT_MANAGER' THEN io.INT_ORG_NR
            ELSE amd.PARENT_ORG_NR
        END as ACCT_MGR_DISTRICT_NR
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'ACCOUNT_MANAGER' THEN nvl(io.INT_ORG_NAME, 'Unbekannt')
            ELSE nvl(amd.PARENT_ORG_NAME, 'Unbekannt')
        END as ACCT_MGR_DISTRICT_NAME
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'ACCOUNT_MANAGER' THEN nvl(io_mgr.INT_ORG_MGR_SID, -1)
            ELSE nvl(amd_mgr.INT_ORG_MGR_SID, -1)
        END as ACCT_MGR_EMP_SID
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'ACCOUNT_MANAGER' THEN io_mgr.INT_ORG_MGR_NR
            ELSE amd_mgr.INT_ORG_MGR_NR
        END as ACCT_MGR_EMP_NR
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'ACCOUNT_MANAGER' THEN nvl(io_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
            ELSE nvl(amd_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
        END as ACCT_MGR_NAME
    -- Account Manager Attributes <<
    

    -- Sales Company Attributes >
    ,CASE
            WHEN io.IS_SALES_COMPANY_FG=TRUE THEN io.INT_ORG_SID
            ELSE nvl(sc.PARENT_ORG_SID,-1)
        END 												as SALES_COMPANY_SID
    ,CASE
            WHEN io.IS_SALES_COMPANY_FG=TRUE THEN io.INT_ORG_NR
            ELSE sc.PARENT_ORG_NR
        END as SALES_COMPANY_NR  
    ,CASE
            WHEN io.IS_SALES_COMPANY_FG=TRUE THEN io.INT_ORG_NAME
            ELSE nvl(sc.PARENT_ORG_NAME,'Unbekannt')
        END 												as SALES_COMPANY_NAME
    ,CASE
            WHEN io.IS_SALES_COMPANY_FG=TRUE THEN nvl(io_mgr.INT_ORG_MGR_SID,-1)
            ELSE nvl(sc_mgr.INT_ORG_MGR_SID,-1)
        END 												as SALES_COMPANY_DIRECTOR_EMP_SID
    ,CASE
            WHEN io.IS_SALES_COMPANY_FG=TRUE THEN io_mgr.INT_ORG_MGR_NR
            ELSE sc_mgr.INT_ORG_MGR_NR
        END as SALES_COMPANY_DIRECTOR_EMP_NR
    ,CASE
            WHEN io.IS_SALES_COMPANY_FG=TRUE THEN nvl(io_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
            ELSE nvl(sc_mgr.INT_ORG_MGR_FULL_NAME,'Unbekannt')
        END 												as SALES_COMPANY_DIRECTOR_NAME
    -- Sales Company Attributes <
    
    
    -- Delivery Company Attributes >
    ,CASE
            WHEN io.IS_DELIV_COMPANY_FG=TRUE THEN io.INT_ORG_SID
            ELSE nvl(delc.PARENT_ORG_SID,-1)
        END 												as DELIV_COMPANY_SID
    ,CASE
            WHEN io.IS_DELIV_COMPANY_FG=TRUE THEN io.INT_ORG_NR
            ELSE delc.PARENT_ORG_NR
        END                                                 as DELIV_COMPANY_NR  
    ,CASE
            WHEN io.IS_DELIV_COMPANY_FG=TRUE THEN io.INT_ORG_NAME
            ELSE nvl(delc.PARENT_ORG_NAME,'Unbekannt')
        END 												as DELIV_COMPANY_NAME
    ,CASE
            WHEN io.IS_DELIV_COMPANY_FG=TRUE THEN nvl(io_mgr.INT_ORG_MGR_SID,-1)
            ELSE nvl(delc_mgr.INT_ORG_MGR_SID,-1)
        END 												as DELIV_COMPANY_DIRECTOR_EMP_SID
    ,CASE
            WHEN io.IS_DELIV_COMPANY_FG=TRUE THEN io_mgr.INT_ORG_MGR_NR
            ELSE delc_mgr.INT_ORG_MGR_NR
        END                                                 as DELIV_COMPANY_DIRECTOR_EMP_NR
    ,CASE
            WHEN io.IS_DELIV_COMPANY_FG=TRUE THEN nvl(io_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
            ELSE nvl(delc_mgr.INT_ORG_MGR_FULL_NAME,'Unbekannt')
        END 												as DELIV_COMPANY_DIRECTOR_NAME
    -- Delivery Company Attributes <
    
    
    -- Expansion Company Attributes >
    ,CASE
            WHEN io.IS_EXPANSION_COMPANY_FG=TRUE THEN io.INT_ORG_SID
            ELSE nvl(expc.PARENT_ORG_SID,-1)
        END 												as EXPANSION_COMPANY_SID
    ,CASE
            WHEN io.IS_EXPANSION_COMPANY_FG=TRUE THEN io.INT_ORG_NR
            ELSE expc.PARENT_ORG_NR
        END                                                 as EXPANSION_COMPANY_NR  
    ,CASE
            WHEN io.IS_EXPANSION_COMPANY_FG=TRUE THEN io.INT_ORG_NAME
            ELSE nvl(expc.PARENT_ORG_NAME,'Unbekannt')
        END 												as EXPANSION_COMPANY_NAME
    -- Expansion Company Attributes <
    
    
    -- Balance Sheet Company Attributes >
    ,CASE
            WHEN io.IS_BAL_SHEET_COMPANY_FG=TRUE THEN io.INT_ORG_SID
            ELSE nvl(balc.PARENT_ORG_SID,-1)
        END 												as BAL_SHEET_COMPANY_SID
    ,CASE
            WHEN io.IS_BAL_SHEET_COMPANY_FG=TRUE THEN io.INT_ORG_NR
            ELSE balc.PARENT_ORG_NR
        END                                                 as BAL_SHEET_COMPANY_NR  
    ,CASE
            WHEN io.IS_BAL_SHEET_COMPANY_FG=TRUE THEN io.INT_ORG_NAME
            ELSE nvl(balc.PARENT_ORG_NAME,'Unbekannt')
        END 												as BAL_SHEET_COMPANY_NAME
    -- Balance Sheet Company Attributes <
    
    
    -- Owner Company Attributes >
    ,CASE
            WHEN io.IS_OWNER_COMPANY_FG=TRUE THEN io.INT_ORG_SID
            ELSE nvl(owc.PARENT_ORG_SID,-1)
        END 												as OWNER_COMPANY_SID
    ,CASE
            WHEN io.IS_OWNER_COMPANY_FG=TRUE THEN io.INT_ORG_NR
            ELSE owc.PARENT_ORG_NR
        END                                                 as OWNER_COMPANY_NR  
    ,CASE
            WHEN io.IS_OWNER_COMPANY_FG=TRUE THEN io.INT_ORG_NAME
            ELSE nvl(owc.PARENT_ORG_NAME,'Unbekannt')
        END 												as OWNER_COMPANY_NAME
    -- Owner Company Attributes <

    -- Sales Region Attributes >>
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN vl.INT_ORG_SID
            ELSE nvl(s_reg.PARENT_ORG_SID, -1)
        END as SALES_REGION_SID
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN io.INT_ORG_NR
            ELSE s_reg.PARENT_ORG_NR
        END as SALES_REGION_NR
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN nvl(io.INT_ORG_NAME, 'Unbekannt')
            ELSE nvl(s_reg.PARENT_ORG_NAME, 'Unbekannt')
        END as SALES_REGION_NAME
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN nvl(io_mgr.INT_ORG_MGR_SID, -1)
            ELSE nvl(s_reg_mgr.INT_ORG_MGR_SID, -1)
        END as SALES_REGION_MGR_EMP_SID
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN io_mgr.INT_ORG_MGR_NR
            ELSE s_reg_mgr.INT_ORG_MGR_NR
        END as SALES_REGION_MGR_EMP_NR
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN nvl(io_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
            ELSE nvl(s_reg_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
        END as SALES_REGION_MGR_NAME
    -- Sales Region Attributes <<


    -- Delivery Region Attributes >> 
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN vl.INT_ORG_SID
            ELSE nvl(d_reg.PARENT_ORG_SID, -1)
        END as DELIV_REGION_SID
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN io.INT_ORG_NR
            ELSE d_reg.PARENT_ORG_NR
        END as DELIV_REGION_NR
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN nvl(io.INT_ORG_NAME, 'Unbekannt')
            ELSE nvl(d_reg.PARENT_ORG_NAME, 'Unbekannt')
        END as DELIV_REGION_NAME
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN nvl(io_mgr.INT_ORG_MGR_SID, -1)
            ELSE nvl(d_reg_mgr.INT_ORG_MGR_SID, -1)
        END as DELIV_REGION_MGR_EMP_SID
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN io_mgr.INT_ORG_MGR_NR
            ELSE d_reg_mgr.INT_ORG_MGR_NR
        END as DELIV_REGION_MGR_EMP_NR
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN nvl(io_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
            ELSE nvl(d_reg_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
        END as DELIV_REGION_MGR_NAME
    -- Delivery Region Attributes <<


    -- Country Company Attributes >
    ,CASE
            WHEN io.IS_COUNTRY_ORG_FG=TRUE THEN io.INT_ORG_SID
            ELSE nvl(co.PARENT_ORG_SID,-1)
        END 												as COUNTRY_ORG_SID
    ,CASE
            WHEN io.IS_COUNTRY_ORG_FG=TRUE THEN io.COUNTRY_ORG_CD
            ELSE co.PARENT_COUNTRY_ORG_CD
        END                                                 as COUNTRY_ORG_CD
    ,CASE
            WHEN io.IS_COUNTRY_ORG_FG=TRUE THEN io.INT_ORG_NR
            ELSE co.PARENT_ORG_NR
        END                                                 as COUNTRY_ORG_NR
    ,CASE
        WHEN io.IS_COUNTRY_ORG_FG=TRUE THEN io.COUNTRY_ORG_NAME
        ELSE COALESCE(io_co.COUNTRY_ORG_NAME, 'Unbekannt')
    END                                                 as COUNTRY_ORG_NAME
    ,CASE
            WHEN io.IS_COUNTRY_ORG_FG=TRUE THEN nvl(io_mgr.INT_ORG_MGR_SID,-1)
            ELSE nvl(co_mgr.INT_ORG_MGR_SID,-1)
        END 												as COUNTRY_ORG_MGR_EMP_SID
    ,CASE
            WHEN io.IS_COUNTRY_ORG_FG=TRUE THEN io_mgr.INT_ORG_MGR_NR
            ELSE co_mgr.INT_ORG_MGR_NR
        END                                                 as COUNTRY_ORG_MGR_EMP_NR
    ,CASE
            WHEN io.IS_COUNTRY_ORG_FG=TRUE THEN nvl(io_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
            ELSE nvl(co_mgr.INT_ORG_MGR_FULL_NAME,'Unbekannt')
        END 												as COUNTRY_ORG_MGR_NAME
    -- Country Company Attributes <

    
    -- Country Group Attributes >>
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'COUNTRY_GRP' THEN vl.INT_ORG_SID
            ELSE nvl(cg.PARENT_ORG_SID, -1)
        END as COUNTRY_GRP_ORG_SID
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'COUNTRY_GRP' THEN io.INT_ORG_NR
            ELSE cg.PARENT_ORG_NR
        END as COUNTRY_GRP_ORG_NR
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'COUNTRY_GRP' THEN nvl(io.INT_ORG_NAME, 'Unbekannt')
            ELSE nvl(cg.PARENT_ORG_NAME, 'Unbekannt')
        END as COUNTRY_GRP_ORG_NAME
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'COUNTRY_GRP' THEN nvl(io_mgr.INT_ORG_MGR_SID, -1)
            ELSE nvl(cg_mgr.INT_ORG_MGR_SID, -1)
        END as COUNTRY_GRP_ORG_MGR_EMP_SID
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'COUNTRY_GRP' THEN io_mgr.INT_ORG_MGR_NR
            ELSE cg_mgr.INT_ORG_MGR_NR
        END as COUNTRY_GRP_ORG_MGR_EMP_NR
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'COUNTRY_GRP' THEN nvl(io_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
            ELSE nvl(cg_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
        END as COUNTRY_GRP_ORG_MGR_NAME
    -- Country Group Attributes <<

    ,current_timestamp
    ,current_timestamp
    ,-1
    ,'CORE_REL'
FROM validity_listing vl
    
    join core_rel.T_INTERNAL_ORGANIZATION io 
                on io.INT_ORG_SID = vl.INT_ORG_SID
                and vl.DWH_MAPPING_TMSP between io.DWH_VALID_FROM_TMSP and io.DWH_VALID_TO_TMSP
    left join etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER io_mgr
                on io_mgr.INT_ORG_SID = vl.INT_ORG_SID
                and vl.DWH_MAPPING_TMSP between io_mgr.DWH_VALID_FROM_TMSP and io_mgr.DWH_VALID_TO_TMSP

    left join core_rel.T_INTERNAL_ORGANIZATION_TYPE iot_de
                on iot_de.INT_ORG_TYPE_CD = io.INT_ORG_TYPE_CD
                and iot_de.LANG_CD = 'DE'
	left join core_rel.T_INTERNAL_ORGANIZATION_LANGUAGE io_lang
				on io_lang.INT_ORG_SID = vl.INT_ORG_SID
				and io_lang.LANG_USG_TYPE_CD = 'OFFICIAL'
                and vl.DWH_MAPPING_TMSP between io_lang.DWH_VALID_FROM_TMSP and io_lang.DWH_VALID_TO_TMSP
		
    left join etl.T_R2D_INTERNAL_ORGANIZATION_STATUS io_st
                on io_st.INT_ORG_SID = vl.INT_ORG_SID
                and vl.DWH_MAPPING_TMSP between io_st.DWH_VALID_FROM_TMSP and io_st.DWH_VALID_TO_TMSP
    left join etl.T_R2D_INTERNAL_ORGANIZATION_STREET_ADDRESS io_sa
                on io_sa.INT_ORG_SID = vl.INT_ORG_SID
                and vl.DWH_MAPPING_TMSP between io_sa.DWH_VALID_FROM_TMSP and io_sa.DWH_VALID_TO_TMSP
    left join etl.T_R2D_INTERNAL_ORGANIZATION_PHONE io_tel
                on io_tel.INT_ORG_SID = vl.INT_ORG_SID
                and vl.DWH_MAPPING_TMSP between io_tel.DWH_VALID_FROM_TMSP and io_tel.DWH_VALID_TO_TMSP
				
	-- Real Estate attributes
	left join etl.T_R2D_REAL_ESTATE_INTERNAL_ORGANIZATION reio
				on reio.INT_ORG_SID = vl.INT_ORG_SID
				and vl.DWH_MAPPING_TMSP between reio.DWH_VALID_FROM_TMSP and reio.DWH_VALID_TO_TMSP

    -- Sales Manager District
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY smd
                on smd.CHILD_ORG_SID = vl.INT_ORG_SID
                and smd.PARENT_ORG_TYPE_CD = 'SALES_MANAGER'
                and smd.TOP_HIERARCHY_TYPE_CD = 'SALES_STORE' -- *See Note1
                and vl.DWH_MAPPING_TMSP between smd.DWH_VALID_FROM_TMSP and smd.DWH_VALID_TO_TMSP
    left join etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER smd_mgr
                on smd_mgr.INT_ORG_SID = smd.PARENT_ORG_SID
                and smd_mgr.JOB_ROLE_TYPE_CD = 'SALES_MANAGER'
                and vl.DWH_MAPPING_TMSP between smd_mgr.DWH_VALID_FROM_TMSP and smd_mgr.DWH_VALID_TO_TMSP

    -- Account Manager District
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY amd
                on amd.CHILD_ORG_SID = vl.INT_ORG_SID
                and amd.PARENT_ORG_TYPE_CD = 'ACCOUNT_MANAGER'
                and amd.TOP_HIERARCHY_TYPE_CD = 'ACCOUNT_SALES' -- *See Note1
                and vl.DWH_MAPPING_TMSP between amd.DWH_VALID_FROM_TMSP and amd.DWH_VALID_TO_TMSP
    left join etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER amd_mgr
                on amd_mgr.INT_ORG_SID = amd.PARENT_ORG_SID
                and amd_mgr.JOB_ROLE_TYPE_CD = 'ACCOUNT_MANAGER'
                and vl.DWH_MAPPING_TMSP between amd_mgr.DWH_VALID_FROM_TMSP and amd_mgr.DWH_VALID_TO_TMSP

    -- Sales Company
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY sc
                on sc.CHILD_ORG_SID = vl.INT_ORG_SID
                and sc.TOP_HIERARCHY_TYPE_CD = 'COMPANY_ACCOUNT' -- *See Note1
                and sc.PARENT_ORG_TYPE_CD = 'COMPANY'
                and vl.DWH_MAPPING_TMSP between sc.DWH_VALID_FROM_TMSP and sc.DWH_VALID_TO_TMSP
    left join etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER sc_mgr
                on sc_mgr.INT_ORG_SID = sc.PARENT_ORG_SID
                and sc_mgr.JOB_ROLE_TYPE_CD = 'COMPANY_MANAGER'
                and vl.DWH_MAPPING_TMSP between sc_mgr.DWH_VALID_FROM_TMSP and sc_mgr.DWH_VALID_TO_TMSP

    -- Delivery Company
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY delc
                on delc.CHILD_ORG_SID = vl.INT_ORG_SID
                and delc.TOP_HIERARCHY_TYPE_CD = 'DELIVCMP_STORE' -- *See Note1
                and delc.PARENT_ORG_TYPE_CD = 'COMPANY'
                and vl.DWH_MAPPING_TMSP between delc.DWH_VALID_FROM_TMSP and delc.DWH_VALID_TO_TMSP
    left join etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER delc_mgr
                on delc_mgr.INT_ORG_SID = delc.PARENT_ORG_SID
                and delc_mgr.JOB_ROLE_TYPE_CD = 'COMPANY_MANAGER'
                and vl.DWH_MAPPING_TMSP between delc_mgr.DWH_VALID_FROM_TMSP and delc_mgr.DWH_VALID_TO_TMSP

    -- Expansion Company
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY expc
                on expc.CHILD_ORG_SID = vl.INT_ORG_SID
                and expc.TOP_HIERARCHY_TYPE_CD = 'EXPCMP_STORE' -- *See Note1
                and expc.PARENT_ORG_TYPE_CD = 'COMPANY'
                and vl.DWH_MAPPING_TMSP between expc.DWH_VALID_FROM_TMSP and expc.DWH_VALID_TO_TMSP

    -- balance Sheet Company
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY balc
                on balc.CHILD_ORG_SID = vl.INT_ORG_SID
                and balc.TOP_HIERARCHY_TYPE_CD = 'BALSHCMP_STORE' -- *See Note1
                and balc.PARENT_ORG_TYPE_CD = 'COMPANY'
                and vl.DWH_MAPPING_TMSP between balc.DWH_VALID_FROM_TMSP and balc.DWH_VALID_TO_TMSP

    -- Owner Company
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY owc
                on owc.CHILD_ORG_SID = vl.INT_ORG_SID
                and owc.TOP_HIERARCHY_TYPE_CD = 'OWNERCMP_STORE' -- *See Note1
                and owc.PARENT_ORG_TYPE_CD = 'COMPANY'
                and vl.DWH_MAPPING_TMSP between owc.DWH_VALID_FROM_TMSP and owc.DWH_VALID_TO_TMSP

    -- Sales Region
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY s_reg
                on s_reg.CHILD_ORG_SID = vl.INT_ORG_SID
                and s_reg.PARENT_ORG_TYPE_CD = 'REGION'
                and vl.DWH_MAPPING_TMSP between s_reg.DWH_VALID_FROM_TMSP and s_reg.DWH_VALID_TO_TMSP
                and io.INT_ORG_TYPE_CD <> 'STORE' and s_reg.TOP_HIERARCHY_TYPE_CD = 'REGION_COMPANY'    
    left join etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER s_reg_mgr
                on s_reg_mgr.INT_ORG_SID = s_reg.PARENT_ORG_SID
                and s_reg_mgr.JOB_ROLE_TYPE_CD = 'REGION_MANAGER'
                and vl.DWH_MAPPING_TMSP between s_reg_mgr.DWH_VALID_FROM_TMSP and s_reg_mgr.DWH_VALID_TO_TMSP

    -- Delivery Region
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY d_reg
                on d_reg.CHILD_ORG_SID = vl.INT_ORG_SID
                and d_reg.PARENT_ORG_TYPE_CD = 'REGION'
                and vl.DWH_MAPPING_TMSP between d_reg.DWH_VALID_FROM_TMSP and d_reg.DWH_VALID_TO_TMSP
                and io.INT_ORG_TYPE_CD <> 'STORE' and d_reg.TOP_HIERARCHY_TYPE_CD = 'REGION_COMPANY'              
    left join etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER d_reg_mgr
                on d_reg_mgr.INT_ORG_SID = d_reg.PARENT_ORG_SID
                and d_reg_mgr.JOB_ROLE_TYPE_CD = 'REGION_MANAGER'
                and vl.DWH_MAPPING_TMSP between d_reg_mgr.DWH_VALID_FROM_TMSP and d_reg_mgr.DWH_VALID_TO_TMSP

    -- Country Organization
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY co
                on co.CHILD_ORG_SID = vl.INT_ORG_SID
                and co.TOP_HIERARCHY_TYPE_CD = 'CNTRY_ORG_REGION' -- *See Note1
                and co.PARENT_ORG_TYPE_CD = 'COMPANY'
                and vl.DWH_MAPPING_TMSP between co.DWH_VALID_FROM_TMSP and co.DWH_VALID_TO_TMSP
    -- taking CURR_CD from here is fine only because we assume one Country Org never changes it's currency.
    -- if it does, CURR_CD should be included in T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY to build proper time intervals
    left join core_rel.T_INTERNAL_ORGANIZATION io_co
                on io_co.INT_ORG_SID = co.PARENT_ORG_SID
                and vl.DWH_MAPPING_TMSP between io_co.DWH_VALID_FROM_TMSP and io_co.DWH_VALID_TO_TMSP
    left join etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER co_mgr
                on co_mgr.INT_ORG_SID = co.PARENT_ORG_SID
                and co_mgr.JOB_ROLE_TYPE_CD = 'COMPANY_MANAGER'
                and vl.DWH_MAPPING_TMSP between co_mgr.DWH_VALID_FROM_TMSP and co_mgr.DWH_VALID_TO_TMSP
    
            

    -- Country Group
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY cg
                on cg.CHILD_ORG_SID = vl.INT_ORG_SID
                and cg.TOP_HIERARCHY_TYPE_CD = 'CNTRY_GRP_CNTRY_ORG' -- *See Note1
                and cg.PARENT_ORG_TYPE_CD = 'COUNTRY_GRP'
                and
                (
                    -- if a company has a parent which is Region we treat it as  Sales/Delivery company, which means Country Group is 3 levels above
                    (io.INT_ORG_TYPE_CD = 'COMPANY' and nvl(s_reg.CHILD_ORG_SID,d_reg.CHILD_ORG_SID) is not null and cg.LEVELS_ABOVE_LEAF = 3)
                    -- if a company has no parent of type Region then it must be Country Organization, which means the Country Group is 1 level above
                    or (io.INT_ORG_TYPE_CD = 'COMPANY' and nvl(s_reg.CHILD_ORG_SID,d_reg.CHILD_ORG_SID) is null and io.IS_COUNTRY_ORG_FG = TRUE and cg.LEVELS_ABOVE_LEAF = 1)
                    or (io.INT_ORG_TYPE_CD <> 'COMPANY')
                )
                and vl.DWH_MAPPING_TMSP between cg.DWH_VALID_FROM_TMSP and cg.DWH_VALID_TO_TMSP
    left join etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER cg_mgr
                on cg_mgr.INT_ORG_SID = cg.PARENT_ORG_SID
                and cg_mgr.JOB_ROLE_TYPE_CD = 'COUNTRY_GRP_MANAGER'
                and vl.DWH_MAPPING_TMSP between cg_mgr.DWH_VALID_FROM_TMSP and cg_mgr.DWH_VALID_TO_TMSP
WHERE vl.DWH_MAPPING_TMSP < '9999-12-31 23:59:59.999'
	and io.INT_ORG_TYPE_CD <> 'STORE'
;



--- Stores
INSERT into core_dim.T_DIM_INTERNAL_ORGANIZATION
(
    INT_ORG_SID
    ,DWH_VALID_FROM_TMSP
    ,DWH_VALID_TO_TMSP
    ,DWH_VALID_FG
    
    ,INT_ORG_TYPE_CD
    ,INT_ORG_TYPE_DESCR
    ,CURR_INT_ORG_NR
    ,INIT_INT_ORG_NR
    ,INT_ORG_NAME
	,LEGAL_NAME

    ,CURR_CD
    
    ,INT_ORG_STATUS_CD
    ,INT_ORG_STATUS_DESCR
	,STORE_REAL_ESTATE_TYPE_CD
	,STORE_REAL_ESTATE_TYPE_DESCR
    
    ,OPEN_DT
    ,PLANNED_OPEN_DT
    ,CLOSE_DT
	,COMP_PERIOD_START_DT
	,COMP_PERIOD_END_DT
    ,ISO_COUNTRY_CD
    ,COUNTRY_NAME
    ,CITY_NAME
    ,DISTRICT_NAME
    ,ZIP
    ,STREET_NAME
    ,HOUSE_NR
    ,LON
    ,LAT
    ,PO_BOX_NR
    ,PHONE_NR
    ,FAX_NR
    ,EMAIL_ADDR_TXT
    ,REPORTING_COUNTRY_CD
	,REPORTING_COUNTRY_NAME
	,OFFICIAL_LANG_CD
    
    ,IS_SALES_COMPANY_FG
    ,IS_DELIV_COMPANY_FG
    ,IS_COUNTRY_ORG_FG
    ,IS_EXPANSION_COMPANY_FG
    ,IS_BAL_SHEET_COMPANY_FG
    ,IS_OWNER_COMPANY_FG
    ,IS_TRUST_FG
    
    ,SALES_MGR_DISTRICT_SID
    ,SALES_MGR_DISTRICT_NR
    ,SALES_MGR_DISTRICT_NAME
    ,SALES_MGR_EMP_SID
    ,SALES_MGR_EMP_NR
    ,SALES_MGR_NAME
    
    ,ACCT_MGR_DISTRICT_SID
    ,ACCT_MGR_DISTRICT_NR
    ,ACCT_MGR_DISTRICT_NAME
    ,ACCT_MGR_EMP_SID
    ,ACCT_MGR_EMP_NR
    ,ACCT_MGR_NAME
    
    ,SALES_COMPANY_SID
    ,SALES_COMPANY_NR
    ,SALES_COMPANY_NAME
    ,SALES_COMPANY_DIRECTOR_EMP_SID
    ,SALES_COMPANY_DIRECTOR_EMP_NR
    ,SALES_COMPANY_DIRECTOR_NAME
    
    ,DELIV_COMPANY_SID
    ,DELIV_COMPANY_NR
    ,DELIV_COMPANY_NAME
    ,DELIV_COMPANY_DIRECTOR_EMP_SID
    ,DELIV_COMPANY_DIRECTOR_EMP_NR
    ,DELIV_COMPANY_DIRECTOR_NAME
    
    ,EXPANSION_COMPANY_SID
    ,EXPANSION_COMPANY_NR
    ,EXPANSION_COMPANY_NAME
    ,BAL_SHEET_COMPANY_SID
    ,BAL_SHEET_COMPANY_NR
    ,BAL_SHEET_COMPANY_NAME
    ,OWNER_COMPANY_SID
    ,OWNER_COMPANY_NR
    ,OWNER_COMPANY_NAME
    
    ,SALES_REGION_SID
    ,SALES_REGION_NR
    ,SALES_REGION_NAME
    ,SALES_REGION_MGR_EMP_SID
    ,SALES_REGION_MGR_EMP_NR
    ,SALES_REGION_MGR_NAME
    
    ,DELIV_REGION_SID
    ,DELIV_REGION_NR
    ,DELIV_REGION_NAME
    ,DELIV_REGION_MGR_EMP_SID
    ,DELIV_REGION_MGR_EMP_NR
    ,DELIV_REGION_MGR_NAME
    
    ,COUNTRY_ORG_SID
    ,COUNTRY_ORG_CD
    ,COUNTRY_ORG_NR
    ,COUNTRY_ORG_NAME
    ,COUNTRY_ORG_MGR_EMP_SID
    ,COUNTRY_ORG_MGR_EMP_NR
    ,COUNTRY_ORG_MGR_NAME
    
    ,COUNTRY_GRP_ORG_SID
    ,COUNTRY_GRP_ORG_NR
    ,COUNTRY_GRP_ORG_NAME
    ,COUNTRY_GRP_ORG_MGR_EMP_SID
    ,COUNTRY_GRP_ORG_MGR_EMP_NR
    ,COUNTRY_GRP_ORG_MGR_NAME
    
    ,DWH_CREATED_TMSP
    ,DWH_UPDATED_TMSP
    ,DWH_LOAD_ID
    ,DWH_NODE_CD
)
with 
validity_listing(INT_ORG_SID, DWH_MAPPING_TMSP) as
(
    -- IntOrg
    SELECT 
        io.INT_ORG_SID
        ,io.DWH_VALID_FROM_TMSP
    FROM core_rel.T_INTERNAL_ORGANIZATION io
	WHERE 1=1
		and io.INT_ORG_TYPE_CD = 'STORE' 
		--temp just for test to see how lisy-only data looks
		--and io.DWH_NODE_CD <> 'P_LEW_CORE'
		
    UNION
    SELECT 
        io.INT_ORG_SID
        ,decode(io.DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999',  io.DWH_VALID_TO_TMSP, DATEADD(ns, 1, io.DWH_VALID_TO_TMSP))
    FROM core_rel.T_INTERNAL_ORGANIZATION io
    WHERE 1=1
		and io.INT_ORG_TYPE_CD = 'STORE' 
		--temp just for test to see how lisy-only data looks 
		--and io.DWH_NODE_CD <> 'P_LEW_CORE'
		
    UNION
    SELECT 
        io.INT_ORG_SID
        ,'1900-01-01'::TIMESTAMP
    FROM core_rel.T_INTERNAL_ORGANIZATION io
	WHERE 1=1
		and io.INT_ORG_TYPE_CD = 'STORE'
		--temp just for test to see how lisy-only data looks
		--and io.DWH_NODE_CD <> 'P_LEW_CORE'

    UNION
    
    -- IntOrg Hierachy
    SELECT 
        fh.CHILD_ORG_SID
        ,fh.DWH_VALID_FROM_TMSP
    FROM etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY fh
    UNION
    SELECT 
        fh.CHILD_ORG_SID
        ,decode(fh.DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999',  fh.DWH_VALID_TO_TMSP, DATEADD(ns, 1, fh.DWH_VALID_TO_TMSP))
    FROM etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY fh

    UNION

    -- Street Address
    SELECT 
        sa.INT_ORG_SID
        ,sa.DWH_VALID_FROM_TMSP
    FROM etl.T_R2D_INTERNAL_ORGANIZATION_STREET_ADDRESS sa
    UNION
    SELECT 
        sa.INT_ORG_SID
        ,decode(sa.DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999',  sa.DWH_VALID_TO_TMSP, DATEADD(ns, 1, sa.DWH_VALID_TO_TMSP))
    FROM etl.T_R2D_INTERNAL_ORGANIZATION_STREET_ADDRESS sa
    
    UNION

    -- Phone
    SELECT 
        ph.INT_ORG_SID
        ,ph.DWH_VALID_FROM_TMSP
    FROM etl.T_R2D_INTERNAL_ORGANIZATION_PHONE ph
    UNION
    SELECT 
        ph.INT_ORG_SID
        ,decode(ph.DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999',  ph.DWH_VALID_TO_TMSP, DATEADD(ns, 1, ph.DWH_VALID_TO_TMSP))
    FROM etl.T_R2D_INTERNAL_ORGANIZATION_PHONE ph

    UNION

    -- Status
    SELECT 
        st.INT_ORG_SID
        ,st.DWH_VALID_FROM_TMSP
    FROM etl.T_R2D_INTERNAL_ORGANIZATION_STATUS st
    UNION
    SELECT 
        st.INT_ORG_SID
        ,decode(st.DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999',  st.DWH_VALID_TO_TMSP, DATEADD(ns, 1, st.DWH_VALID_TO_TMSP))
    FROM etl.T_R2D_INTERNAL_ORGANIZATION_STATUS st

    UNION

    -- Manager
    SELECT 
        m.INT_ORG_SID
        ,m.DWH_VALID_FROM_TMSP
    FROM etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER m
    UNION
    SELECT 
        m.INT_ORG_SID
        ,decode(m.DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999',  m.DWH_VALID_TO_TMSP, DATEADD(ns, 1, m.DWH_VALID_TO_TMSP))
    FROM etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER m
    
	UNION
	
	-- Real Estate
	SELECT 
        r.INT_ORG_SID
        ,r.DWH_VALID_FROM_TMSP
    FROM etl.T_R2D_REAL_ESTATE_INTERNAL_ORGANIZATION r
    UNION
    SELECT 
        r.INT_ORG_SID
        ,decode(r.DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999',  r.DWH_VALID_TO_TMSP, DATEADD(ns, 1, r.DWH_VALID_TO_TMSP))
    FROM etl.T_R2D_REAL_ESTATE_INTERNAL_ORGANIZATION r
	
)
SELECT 
    vl.INT_ORG_SID
    ,vl.DWH_MAPPING_TMSP as VAL_FROM
    ,lead(dateadd(ns, -1, vl.DWH_MAPPING_TMSP),1,'9999-12-31 23:59:59.999') 
                over (partition by vl.INT_ORG_SID order by vl.DWH_MAPPING_TMSP asc)    as VAL_TO
    ,(current_timestamp between val_from and val_to) as DWH_VALID_FG

    ,nvl(iot_de.INT_ORG_TYPE_CD, '@')                    	as INT_ORG_TYPE_CD
    ,nvl(iot_de.INT_ORG_TYPE_DESCR, 'Unbekannt')        	as INT_ORG_TYPE_DESCR
    ,nvl(io.INT_ORG_NR, '@')                                as CURR_INT_ORG_NR
    ,first_value(io.INT_ORG_NR ignore nulls) 
        over(partition by vl.INT_ORG_SID 
            ORDER BY vl.DWH_MAPPING_TMSP)                   as INIT_INT_ORG_NR
    ,nvl(io.INT_ORG_NAME, 'Unbekannt')                    	as INT_ORG_NAME
    ,nvl(io.LEGAL_NAME, 'Unbekannt')                        as LEGAL_NAME

    ,nvl(io_co.CURR_CD, '@')                                as CURR_CD
    
    ,nvl(io_st.INT_ORG_STATUS_CD, '@')                    	as INT_ORG_STATUS_CD
    ,nvl(io_st.INT_ORG_STATUS_DESCR_DE, 'Unbekannt')      	as INT_ORG_STATUS_DESCR
	,nvl(reio.STORE_REAL_ESTATE_TYPE_CD, '@') 						as STORE_REAL_ESTATE_TYPE_CD
	,nvl(reio.STORE_REAL_ESTATE_TYPE_DESCR, 'Unbekannt') 			as STORE_REAL_ESTATE_TYPE_DESCR 	
    ,io.OPEN_DT
    ,io.PLANNED_OPEN_DT
    ,io.CLOSE_DT
	
	,io.OPEN_DT - DayOfWeekISO(io.OPEN_DT) + 1 + 364 + 7 					AS COMP_PERIOD_START_DT  -- Monday of the week + 52 weeks + 1 week
	,least(io.CLOSE_DT - DayOfWeekISO(io.CLOSE_DT) + 7,DATE'9999-12-31')	AS COMP_PERIOD_END_DT    -- Sunday of the week
    
    ,nvl(io_sa.ISO_COUNTRY_CD, '@')                        as ISO_COUNTRY_CD
    ,nvl(io_sa.COUNTRY_NAME, 'Unbekannt')                  as COUNTRY_NAME
    ,io_sa.CITY_NAME
    ,io_sa.DISTRICT_NAME
    ,io_sa.ZIP
    ,io_sa.STREET_NAME
    ,io_sa.HOUSE_NR
    ,io_sa.LON
    ,io_sa.LAT
    ,NULL                                               as PO_BOX_NR
    ,io_tel.PHONE_NR
    ,NULL                                               as FAX_NR
    ,NULL                                               as EMAIL_ADDR_TXT
    ,nvl(io_sa.REPORTING_COUNTRY_CD,'@')				as REPORTING_COUNTRY_CD
    ,nvl(io_sa.REPORTING_COUNTRY_NAME, 'Unbekannt')		as REPORTING_COUNTRY_NAME
	,nvl(io_lang.LANG_CD, '@')							as OFFICIAL_LANG_CD

    ,nvl(io.IS_SALES_COMPANY_FG, false)                as IS_SALES_COMPANY_FG
    ,nvl(io.IS_DELIV_COMPANY_FG, false)                as IS_DELIV_COMPANY_FG
    ,nvl(io.IS_COUNTRY_ORG_FG, false)                  as IS_COUNTRY_ORG_FG
    ,nvl(io.IS_EXPANSION_COMPANY_FG, false)            as IS_EXPANSION_COMPANY_FG
    ,nvl(io.IS_BAL_SHEET_COMPANY_FG, false)            as IS_BAL_SHEET_COMPANY_FG
    ,nvl(io.IS_OWNER_COMPANY_FG, false)                as IS_OWNER_COMPANY_FG
    ,nvl(io.IS_TRUST_FG, false)                        as IS_TRUST_FG

    -- Sales Manager Attributes >>
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'SALES_MANAGER' THEN vl.INT_ORG_SID
            ELSE nvl(smd.PARENT_ORG_SID, -1)
        END as SALES_MGR_DISTRICT_SID
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'SALES_MANAGER' THEN io.INT_ORG_NR
            ELSE smd.PARENT_ORG_NR
        END as SALES_MGR_DISTRICT_NR
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'SALES_MANAGER' THEN nvl(io.INT_ORG_NAME, 'Unbekannt')
            ELSE nvl(smd.PARENT_ORG_NAME, 'Unbekannt')
        END as SALES_MGR_DISTRICT_NAME
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'SALES_MANAGER' THEN nvl(io_mgr.INT_ORG_MGR_SID, -1)
            ELSE nvl(smd_mgr.INT_ORG_MGR_SID, -1)
        END as SALES_MGR_EMP_SID
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'SALES_MANAGER' THEN io_mgr.INT_ORG_MGR_NR
            ELSE smd_mgr.INT_ORG_MGR_NR
        END as SALES_MGR_EMP_NR
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'SALES_MANAGER' THEN nvl(io_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
            ELSE nvl(smd_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
        END as SALES_MGR_NAME
    -- Sales Manager Attributes <<

    
    -- Account Manager Attributes >>
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'ACCOUNT_MANAGER' THEN vl.INT_ORG_SID
            ELSE nvl(amd.PARENT_ORG_SID, -1)
        END as ACCT_MGR_DISTRICT_SID
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'ACCOUNT_MANAGER' THEN io.INT_ORG_NR
            ELSE amd.PARENT_ORG_NR
        END as ACCT_MGR_DISTRICT_NR
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'ACCOUNT_MANAGER' THEN nvl(io.INT_ORG_NAME, 'Unbekannt')
            ELSE nvl(amd.PARENT_ORG_NAME, 'Unbekannt')
        END as ACCT_MGR_DISTRICT_NAME
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'ACCOUNT_MANAGER' THEN nvl(io_mgr.INT_ORG_MGR_SID, -1)
            ELSE nvl(amd_mgr.INT_ORG_MGR_SID, -1)
        END as ACCT_MGR_EMP_SID
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'ACCOUNT_MANAGER' THEN io_mgr.INT_ORG_MGR_NR
            ELSE amd_mgr.INT_ORG_MGR_NR
        END as ACCT_MGR_EMP_NR
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'ACCOUNT_MANAGER' THEN nvl(io_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
            ELSE nvl(amd_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
        END as ACCT_MGR_NAME
    -- Account Manager Attributes <<
    

    -- Sales Company Attributes >
    ,CASE
            WHEN io.IS_SALES_COMPANY_FG=TRUE THEN io.INT_ORG_SID
            ELSE nvl(sc.PARENT_ORG_SID,-1)
        END 												as SALES_COMPANY_SID
    ,CASE
            WHEN io.IS_SALES_COMPANY_FG=TRUE THEN io.INT_ORG_NR
            ELSE sc.PARENT_ORG_NR
        END as SALES_COMPANY_NR  
    ,CASE
            WHEN io.IS_SALES_COMPANY_FG=TRUE THEN io.INT_ORG_NAME
            ELSE nvl(sc.PARENT_ORG_NAME,'Unbekannt')
        END 												as SALES_COMPANY_NAME
    ,CASE
            WHEN io.IS_SALES_COMPANY_FG=TRUE THEN nvl(io_mgr.INT_ORG_MGR_SID,-1)
            ELSE nvl(sc_mgr.INT_ORG_MGR_SID,-1)
        END 												as SALES_COMPANY_DIRECTOR_EMP_SID
    ,CASE
            WHEN io.IS_SALES_COMPANY_FG=TRUE THEN io_mgr.INT_ORG_MGR_NR
            ELSE sc_mgr.INT_ORG_MGR_NR
        END as SALES_COMPANY_DIRECTOR_EMP_NR
    ,CASE
            WHEN io.IS_SALES_COMPANY_FG=TRUE THEN nvl(io_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
            ELSE nvl(sc_mgr.INT_ORG_MGR_FULL_NAME,'Unbekannt')
        END 												as SALES_COMPANY_DIRECTOR_NAME
    -- Sales Company Attributes <
    
    
    -- Delivery Company Attributes >
    ,CASE
            WHEN io.IS_DELIV_COMPANY_FG=TRUE THEN io.INT_ORG_SID
            ELSE nvl(delc.PARENT_ORG_SID,-1)
        END 												as DELIV_COMPANY_SID
    ,CASE
            WHEN io.IS_DELIV_COMPANY_FG=TRUE THEN io.INT_ORG_NR
            ELSE delc.PARENT_ORG_NR
        END                                                 as DELIV_COMPANY_NR  
    ,CASE
            WHEN io.IS_DELIV_COMPANY_FG=TRUE THEN io.INT_ORG_NAME
            ELSE nvl(delc.PARENT_ORG_NAME,'Unbekannt')
        END 												as DELIV_COMPANY_NAME
    ,CASE
            WHEN io.IS_DELIV_COMPANY_FG=TRUE THEN nvl(io_mgr.INT_ORG_MGR_SID,-1)
            ELSE nvl(delc_mgr.INT_ORG_MGR_SID,-1)
        END 												as DELIV_COMPANY_DIRECTOR_EMP_SID
    ,CASE
            WHEN io.IS_DELIV_COMPANY_FG=TRUE THEN io_mgr.INT_ORG_MGR_NR
            ELSE delc_mgr.INT_ORG_MGR_NR
        END                                                 as DELIV_COMPANY_DIRECTOR_EMP_NR
    ,CASE
            WHEN io.IS_DELIV_COMPANY_FG=TRUE THEN nvl(io_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
            ELSE nvl(delc_mgr.INT_ORG_MGR_FULL_NAME,'Unbekannt')
        END 												as DELIV_COMPANY_DIRECTOR_NAME
    -- Delivery Company Attributes <
    
    
    -- Expansion Company Attributes >
    ,CASE
            WHEN io.IS_EXPANSION_COMPANY_FG=TRUE THEN io.INT_ORG_SID
            ELSE nvl(expc.PARENT_ORG_SID,-1)
        END 												as EXPANSION_COMPANY_SID
    ,CASE
            WHEN io.IS_EXPANSION_COMPANY_FG=TRUE THEN io.INT_ORG_NR
            ELSE expc.PARENT_ORG_NR
        END                                                 as EXPANSION_COMPANY_NR  
    ,CASE
            WHEN io.IS_EXPANSION_COMPANY_FG=TRUE THEN io.INT_ORG_NAME
            ELSE nvl(expc.PARENT_ORG_NAME,'Unbekannt')
        END 												as EXPANSION_COMPANY_NAME
    -- Expansion Company Attributes <
    
    
    -- Balance Sheet Company Attributes >
    ,CASE
            WHEN io.IS_BAL_SHEET_COMPANY_FG=TRUE THEN io.INT_ORG_SID
            ELSE nvl(balc.PARENT_ORG_SID,-1)
        END 												as BAL_SHEET_COMPANY_SID
    ,CASE
            WHEN io.IS_BAL_SHEET_COMPANY_FG=TRUE THEN io.INT_ORG_NR
            ELSE balc.PARENT_ORG_NR
        END                                                 as BAL_SHEET_COMPANY_NR  
    ,CASE
            WHEN io.IS_BAL_SHEET_COMPANY_FG=TRUE THEN io.INT_ORG_NAME
            ELSE nvl(balc.PARENT_ORG_NAME,'Unbekannt')
        END 												as BAL_SHEET_COMPANY_NAME
    -- Balance Sheet Company Attributes <
    
    
    -- Owner Company Attributes >
    ,CASE
            WHEN io.IS_OWNER_COMPANY_FG=TRUE THEN io.INT_ORG_SID
            ELSE nvl(owc.PARENT_ORG_SID,-1)
        END 												as OWNER_COMPANY_SID
    ,CASE
            WHEN io.IS_OWNER_COMPANY_FG=TRUE THEN io.INT_ORG_NR
            ELSE owc.PARENT_ORG_NR
        END                                                 as OWNER_COMPANY_NR  
    ,CASE
            WHEN io.IS_OWNER_COMPANY_FG=TRUE THEN io.INT_ORG_NAME
            ELSE nvl(owc.PARENT_ORG_NAME,'Unbekannt')
        END 												as OWNER_COMPANY_NAME
    -- Owner Company Attributes <

    -- Sales Region Attributes >>
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN vl.INT_ORG_SID
            ELSE nvl(s_reg.PARENT_ORG_SID, -1)
        END as SALES_REGION_SID
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN io.INT_ORG_NR
            ELSE s_reg.PARENT_ORG_NR
        END as SALES_REGION_NR
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN nvl(io.INT_ORG_NAME, 'Unbekannt')
            ELSE nvl(s_reg.PARENT_ORG_NAME, 'Unbekannt')
        END as SALES_REGION_NAME
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN nvl(io_mgr.INT_ORG_MGR_SID, -1)
            ELSE nvl(s_reg_mgr.INT_ORG_MGR_SID, -1)
        END as SALES_REGION_MGR_EMP_SID
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN io_mgr.INT_ORG_MGR_NR
            ELSE s_reg_mgr.INT_ORG_MGR_NR
        END as SALES_REGION_MGR_EMP_NR
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN nvl(io_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
            ELSE nvl(s_reg_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
        END as SALES_REGION_MGR_NAME
    -- Sales Region Attributes <<


    -- Delivery Region Attributes >> 
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN vl.INT_ORG_SID
            ELSE nvl(d_reg.PARENT_ORG_SID, -1)
        END as DELIV_REGION_SID
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN io.INT_ORG_NR
            ELSE d_reg.PARENT_ORG_NR
        END as DELIV_REGION_NR
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN nvl(io.INT_ORG_NAME, 'Unbekannt')
            ELSE nvl(d_reg.PARENT_ORG_NAME, 'Unbekannt')
        END as DELIV_REGION_NAME
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN nvl(io_mgr.INT_ORG_MGR_SID, -1)
            ELSE nvl(d_reg_mgr.INT_ORG_MGR_SID, -1)
        END as DELIV_REGION_MGR_EMP_SID
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN io_mgr.INT_ORG_MGR_NR
            ELSE d_reg_mgr.INT_ORG_MGR_NR
        END as DELIV_REGION_MGR_EMP_NR
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'REGION' THEN nvl(io_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
            ELSE nvl(d_reg_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
        END as DELIV_REGION_MGR_NAME
    -- Delivery Region Attributes <<


    -- Country Company Attributes >
    ,CASE
            WHEN io.IS_COUNTRY_ORG_FG=TRUE THEN io.INT_ORG_SID
            ELSE COALESCE(co_sl.PARENT_ORG_SID, co_dv.PARENT_ORG_SID, co_dir.PARENT_ORG_SID, -1)
        END 												as COUNTRY_ORG_SID
    ,CASE
            WHEN io.IS_COUNTRY_ORG_FG=TRUE THEN io.COUNTRY_ORG_CD
            ELSE COALESCE(co_sl.PARENT_COUNTRY_ORG_CD, co_dv.PARENT_COUNTRY_ORG_CD, co_dir.PARENT_COUNTRY_ORG_CD, '@')
        END                                                 as COUNTRY_ORG_CD
    ,CASE
            WHEN io.IS_COUNTRY_ORG_FG=TRUE THEN io.INT_ORG_NR
            ELSE COALESCE(co_sl.PARENT_ORG_NR, co_dv.PARENT_ORG_NR, co_dir.PARENT_ORG_NR, '@')
        END                                                 as COUNTRY_ORG_NR
    ,CASE
        WHEN io.IS_COUNTRY_ORG_FG=TRUE THEN io.COUNTRY_ORG_NAME
        ELSE COALESCE(io_co.COUNTRY_ORG_NAME, 'Unbekannt')
    END                                                 as COUNTRY_ORG_NAME
    ,CASE
            WHEN io.IS_COUNTRY_ORG_FG=TRUE THEN nvl(io_mgr.INT_ORG_MGR_SID,-1)
            ELSE nvl(co_mgr.INT_ORG_MGR_SID,-1)
        END 												as COUNTRY_ORG_MGR_EMP_SID
    ,CASE
            WHEN io.IS_COUNTRY_ORG_FG=TRUE THEN io_mgr.INT_ORG_MGR_NR
            ELSE co_mgr.INT_ORG_MGR_NR
        END                                                 as COUNTRY_ORG_MGR_EMP_NR
    ,CASE
            WHEN io.IS_COUNTRY_ORG_FG=TRUE THEN nvl(io_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
            ELSE nvl(co_mgr.INT_ORG_MGR_FULL_NAME,'Unbekannt')
        END 												as COUNTRY_ORG_MGR_NAME
    -- Country Company Attributes <

    
    -- Country Group Attributes >>
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'COUNTRY_GRP' THEN vl.INT_ORG_SID
            ELSE COALESCE(cg_sl.PARENT_ORG_SID, cg_dv.PARENT_ORG_SID, cg_dir.PARENT_ORG_SID, -1) 
        END as COUNTRY_GRP_ORG_SID
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'COUNTRY_GRP' THEN io.INT_ORG_NR
            ELSE COALESCE(cg_sl.PARENT_ORG_NR, cg_dv.PARENT_ORG_NR, cg_dir.PARENT_ORG_NR, '@') 
        END as COUNTRY_GRP_ORG_NR
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'COUNTRY_GRP' THEN nvl(io.INT_ORG_NAME, 'Unbekannt')
            ELSE COALESCE(cg_sl.PARENT_ORG_NAME, cg_dv.PARENT_ORG_NAME, cg_dir.PARENT_ORG_NAME, 'Unbekannt')
        END as COUNTRY_GRP_ORG_NAME
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'COUNTRY_GRP' THEN nvl(io_mgr.INT_ORG_MGR_SID, -1)
            ELSE nvl(cg_mgr.INT_ORG_MGR_SID, -1)
        END as COUNTRY_GRP_ORG_MGR_EMP_SID
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'COUNTRY_GRP' THEN io_mgr.INT_ORG_MGR_NR
            ELSE cg_mgr.INT_ORG_MGR_NR
        END as COUNTRY_GRP_ORG_MGR_EMP_NR
    ,CASE
            WHEN io.INT_ORG_TYPE_CD = 'COUNTRY_GRP' THEN nvl(io_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
            ELSE nvl(cg_mgr.INT_ORG_MGR_FULL_NAME, 'Unbekannt')
        END as COUNTRY_GRP_ORG_MGR_NAME
    -- Country Group Attributes <<

    ,current_timestamp
    ,current_timestamp
    ,-1
    ,'CORE_REL'
FROM validity_listing vl
    
    join core_rel.T_INTERNAL_ORGANIZATION io 
                on io.INT_ORG_SID = vl.INT_ORG_SID
                and vl.DWH_MAPPING_TMSP between io.DWH_VALID_FROM_TMSP and io.DWH_VALID_TO_TMSP
    left join etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER io_mgr
                on io_mgr.INT_ORG_SID = vl.INT_ORG_SID
                and vl.DWH_MAPPING_TMSP between io_mgr.DWH_VALID_FROM_TMSP and io_mgr.DWH_VALID_TO_TMSP

    left join core_rel.T_INTERNAL_ORGANIZATION_TYPE iot_de
                on iot_de.INT_ORG_TYPE_CD = io.INT_ORG_TYPE_CD
                and iot_de.LANG_CD = 'DE'
	left join core_rel.T_INTERNAL_ORGANIZATION_LANGUAGE io_lang
				on io_lang.INT_ORG_SID = vl.INT_ORG_SID
				and io_lang.LANG_USG_TYPE_CD = 'OFFICIAL'
                and vl.DWH_MAPPING_TMSP between io_lang.DWH_VALID_FROM_TMSP and io_lang.DWH_VALID_TO_TMSP
		
    left join etl.T_R2D_INTERNAL_ORGANIZATION_STATUS io_st
                on io_st.INT_ORG_SID = vl.INT_ORG_SID
                and vl.DWH_MAPPING_TMSP between io_st.DWH_VALID_FROM_TMSP and io_st.DWH_VALID_TO_TMSP
    left join etl.T_R2D_INTERNAL_ORGANIZATION_STREET_ADDRESS io_sa
                on io_sa.INT_ORG_SID = vl.INT_ORG_SID
                and vl.DWH_MAPPING_TMSP between io_sa.DWH_VALID_FROM_TMSP and io_sa.DWH_VALID_TO_TMSP
    left join etl.T_R2D_INTERNAL_ORGANIZATION_PHONE io_tel
                on io_tel.INT_ORG_SID = vl.INT_ORG_SID
                and vl.DWH_MAPPING_TMSP between io_tel.DWH_VALID_FROM_TMSP and io_tel.DWH_VALID_TO_TMSP
				
	-- Real Estate attributes
	left join etl.T_R2D_REAL_ESTATE_INTERNAL_ORGANIZATION reio
				on reio.INT_ORG_SID = vl.INT_ORG_SID
				and vl.DWH_MAPPING_TMSP between reio.DWH_VALID_FROM_TMSP and reio.DWH_VALID_TO_TMSP

    -- Sales Manager District
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY smd
                on smd.CHILD_ORG_SID = vl.INT_ORG_SID
                and smd.PARENT_ORG_TYPE_CD = 'SALES_MANAGER'
                and smd.TOP_HIERARCHY_TYPE_CD = 'SALES_STORE' -- *See Note1
                and vl.DWH_MAPPING_TMSP between smd.DWH_VALID_FROM_TMSP and smd.DWH_VALID_TO_TMSP
    left join etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER smd_mgr
                on smd_mgr.INT_ORG_SID = smd.PARENT_ORG_SID
                and smd_mgr.JOB_ROLE_TYPE_CD = 'SALES_MANAGER'
                and vl.DWH_MAPPING_TMSP between smd_mgr.DWH_VALID_FROM_TMSP and smd_mgr.DWH_VALID_TO_TMSP

    -- Account Manager District
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY amd
                on amd.CHILD_ORG_SID = vl.INT_ORG_SID
                and amd.PARENT_ORG_TYPE_CD = 'ACCOUNT_MANAGER'
                and amd.TOP_HIERARCHY_TYPE_CD = 'ACCOUNT_SALES' -- *See Note1
                and vl.DWH_MAPPING_TMSP between amd.DWH_VALID_FROM_TMSP and amd.DWH_VALID_TO_TMSP
    left join etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER amd_mgr
                on amd_mgr.INT_ORG_SID = amd.PARENT_ORG_SID
                and amd_mgr.JOB_ROLE_TYPE_CD = 'ACCOUNT_MANAGER'
                and vl.DWH_MAPPING_TMSP between amd_mgr.DWH_VALID_FROM_TMSP and amd_mgr.DWH_VALID_TO_TMSP

    -- Sales Company
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY sc
                on sc.CHILD_ORG_SID = vl.INT_ORG_SID
                and sc.TOP_HIERARCHY_TYPE_CD = 'COMPANY_ACCOUNT' -- *See Note1
                and sc.PARENT_ORG_TYPE_CD = 'COMPANY'
                and vl.DWH_MAPPING_TMSP between sc.DWH_VALID_FROM_TMSP and sc.DWH_VALID_TO_TMSP
    left join etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER sc_mgr
                on sc_mgr.INT_ORG_SID = sc.PARENT_ORG_SID
                and sc_mgr.JOB_ROLE_TYPE_CD = 'COMPANY_MANAGER'
                and vl.DWH_MAPPING_TMSP between sc_mgr.DWH_VALID_FROM_TMSP and sc_mgr.DWH_VALID_TO_TMSP

    -- Delivery Company
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY delc
                on delc.CHILD_ORG_SID = vl.INT_ORG_SID
                and delc.TOP_HIERARCHY_TYPE_CD = 'DELIVCMP_STORE' -- *See Note1
                and delc.PARENT_ORG_TYPE_CD = 'COMPANY'
                and vl.DWH_MAPPING_TMSP between delc.DWH_VALID_FROM_TMSP and delc.DWH_VALID_TO_TMSP
    left join etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER delc_mgr
                on delc_mgr.INT_ORG_SID = delc.PARENT_ORG_SID
                and delc_mgr.JOB_ROLE_TYPE_CD = 'COMPANY_MANAGER'
                and vl.DWH_MAPPING_TMSP between delc_mgr.DWH_VALID_FROM_TMSP and delc_mgr.DWH_VALID_TO_TMSP

    -- Expansion Company
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY expc
                on expc.CHILD_ORG_SID = vl.INT_ORG_SID
                and expc.TOP_HIERARCHY_TYPE_CD = 'EXPCMP_STORE' -- *See Note1
                and expc.PARENT_ORG_TYPE_CD = 'COMPANY'
                and vl.DWH_MAPPING_TMSP between expc.DWH_VALID_FROM_TMSP and expc.DWH_VALID_TO_TMSP

    -- balance Sheet Company
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY balc
                on balc.CHILD_ORG_SID = vl.INT_ORG_SID
                and balc.TOP_HIERARCHY_TYPE_CD = 'BALSHCMP_STORE' -- *See Note1
                and balc.PARENT_ORG_TYPE_CD = 'COMPANY'
                and vl.DWH_MAPPING_TMSP between balc.DWH_VALID_FROM_TMSP and balc.DWH_VALID_TO_TMSP

    -- Owner Company
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY owc
                on owc.CHILD_ORG_SID = vl.INT_ORG_SID
                and owc.TOP_HIERARCHY_TYPE_CD = 'OWNERCMP_STORE' -- *See Note1
                and owc.PARENT_ORG_TYPE_CD = 'COMPANY'
                and vl.DWH_MAPPING_TMSP between owc.DWH_VALID_FROM_TMSP and owc.DWH_VALID_TO_TMSP

    -- Sales Region
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY s_reg
                on s_reg.CHILD_ORG_SID = vl.INT_ORG_SID
                and s_reg.PARENT_ORG_TYPE_CD = 'REGION'
				and io.INT_ORG_TYPE_CD = 'STORE' 
				and s_reg.INT_ORG_HIERACHY_PATH = 'SALES_STORE | ACCOUNT_SALES | COMPANY_ACCOUNT | REGION_COMPANY'
                and vl.DWH_MAPPING_TMSP between s_reg.DWH_VALID_FROM_TMSP and s_reg.DWH_VALID_TO_TMSP
                
				
    left join etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER s_reg_mgr
                on s_reg_mgr.INT_ORG_SID = s_reg.PARENT_ORG_SID
                and s_reg_mgr.JOB_ROLE_TYPE_CD = 'REGION_MANAGER'
                and vl.DWH_MAPPING_TMSP between s_reg_mgr.DWH_VALID_FROM_TMSP and s_reg_mgr.DWH_VALID_TO_TMSP

    -- Delivery Region
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY d_reg
                on d_reg.CHILD_ORG_SID = vl.INT_ORG_SID
                and d_reg.PARENT_ORG_TYPE_CD = 'REGION'
				and io.INT_ORG_TYPE_CD = 'STORE' 
				and d_reg.INT_ORG_HIERACHY_PATH = 'DELIVCMP_STORE | REGION_COMPANY'
                and vl.DWH_MAPPING_TMSP between d_reg.DWH_VALID_FROM_TMSP and d_reg.DWH_VALID_TO_TMSP
 
				
    left join etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER d_reg_mgr
                on d_reg_mgr.INT_ORG_SID = d_reg.PARENT_ORG_SID
                and d_reg_mgr.JOB_ROLE_TYPE_CD = 'REGION_MANAGER'
                and vl.DWH_MAPPING_TMSP between d_reg_mgr.DWH_VALID_FROM_TMSP and d_reg_mgr.DWH_VALID_TO_TMSP

    -- Country Organization
		-- from Sales Path
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY co_sl
                on co_sl.CHILD_ORG_SID = vl.INT_ORG_SID
                and co_sl.TOP_HIERARCHY_TYPE_CD = 'CNTRY_ORG_REGION' -- *See Note1
                and co_sl.INT_ORG_HIERACHY_PATH = 'SALES_STORE | ACCOUNT_SALES | COMPANY_ACCOUNT | REGION_COMPANY | CNTRY_ORG_REGION'
                and co_sl.PARENT_ORG_TYPE_CD = 'COMPANY'
                and vl.DWH_MAPPING_TMSP between co_sl.DWH_VALID_FROM_TMSP and co_sl.DWH_VALID_TO_TMSP
    
		-- from Delivery Path
	left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY co_dv
                on co_dv.CHILD_ORG_SID = vl.INT_ORG_SID
                and co_dv.TOP_HIERARCHY_TYPE_CD = 'CNTRY_ORG_REGION' -- *See Note1
                and co_dv.INT_ORG_HIERACHY_PATH = 'DELIVCMP_STORE | REGION_COMPANY | CNTRY_ORG_REGION'
                and co_dv.PARENT_ORG_TYPE_CD = 'COMPANY'
                and vl.DWH_MAPPING_TMSP between co_dv.DWH_VALID_FROM_TMSP and co_dv.DWH_VALID_TO_TMSP
				
				
		-- from Direct Relationship, created by NKC
	left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY co_dir
                on co_dir.CHILD_ORG_SID = vl.INT_ORG_SID
                and co_dir.TOP_HIERARCHY_TYPE_CD = 'CNTRY_ORG_STORE' -- *See Note1
                and co_dir.INT_ORG_HIERACHY_PATH = 'CNTRY_ORG_STORE'
                and co_dir.PARENT_ORG_TYPE_CD = 'COMPANY'
                and vl.DWH_MAPPING_TMSP between co_dir.DWH_VALID_FROM_TMSP and co_dir.DWH_VALID_TO_TMSP
    
	
	-- taking CURR_CD from here is fine only because we assume one Country Org never changes it's currency.
    -- if it does, CURR_CD should be included in T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY to build proper time intervals
    left join core_rel.T_INTERNAL_ORGANIZATION io_co
                on io_co.INT_ORG_SID = COALESCE(co_sl.PARENT_ORG_SID, co_dv.PARENT_ORG_SID, co_dir.PARENT_ORG_SID)
                and vl.DWH_MAPPING_TMSP between io_co.DWH_VALID_FROM_TMSP and io_co.DWH_VALID_TO_TMSP
    left join etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER co_mgr
                on co_mgr.INT_ORG_SID = COALESCE(co_sl.PARENT_ORG_SID, co_dv.PARENT_ORG_SID, co_dir.PARENT_ORG_SID)
                and co_mgr.JOB_ROLE_TYPE_CD = 'COMPANY_MANAGER'
                and vl.DWH_MAPPING_TMSP between co_mgr.DWH_VALID_FROM_TMSP and co_mgr.DWH_VALID_TO_TMSP
    
            

    -- Country Group taken from sales path
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY cg_sl
                on cg_sl.CHILD_ORG_SID = vl.INT_ORG_SID
                and cg_sl.TOP_HIERARCHY_TYPE_CD = 'CNTRY_GRP_CNTRY_ORG' -- *See Note1
                and cg_sl.PARENT_ORG_TYPE_CD = 'COUNTRY_GRP'
                and cg_sl.LEVELS_ABOVE_LEAF = 6
                and vl.DWH_MAPPING_TMSP between cg_sl.DWH_VALID_FROM_TMSP and cg_sl.DWH_VALID_TO_TMSP
				
    -- Country Group taken from delivery path
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY cg_dv
                on cg_dv.CHILD_ORG_SID = vl.INT_ORG_SID
                and cg_dv.TOP_HIERARCHY_TYPE_CD = 'CNTRY_GRP_CNTRY_ORG' -- *See Note1
                and cg_dv.PARENT_ORG_TYPE_CD = 'COUNTRY_GRP'
                and cg_dv.LEVELS_ABOVE_LEAF = 4
                and vl.DWH_MAPPING_TMSP between cg_dv.DWH_VALID_FROM_TMSP and cg_dv.DWH_VALID_TO_TMSP
				
				
	-- Country Group taken from direct store-2-country relationship, created by NKC
    left join etl.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY cg_dir
                on cg_dir.CHILD_ORG_SID = vl.INT_ORG_SID
                and cg_dir.TOP_HIERARCHY_TYPE_CD = 'CNTRY_GRP_CNTRY_ORG' -- *See Note1
                and cg_dir.PARENT_ORG_TYPE_CD = 'COUNTRY_GRP'
                and cg_dir.LEVELS_ABOVE_LEAF = 2
                and vl.DWH_MAPPING_TMSP between cg_dir.DWH_VALID_FROM_TMSP and cg_dir.DWH_VALID_TO_TMSP
				
    left join etl.T_R2D_INTERNAL_ORGANIZATION_MANAGER cg_mgr
                on cg_mgr.INT_ORG_SID = COALESCE(cg_sl.PARENT_ORG_SID, cg_dv.PARENT_ORG_SID, cg_dir.PARENT_ORG_SID)
                and cg_mgr.JOB_ROLE_TYPE_CD = 'COUNTRY_GRP_MANAGER'
                and vl.DWH_MAPPING_TMSP between cg_mgr.DWH_VALID_FROM_TMSP and cg_mgr.DWH_VALID_TO_TMSP
WHERE vl.DWH_MAPPING_TMSP < '9999-12-31 23:59:59.999'
	and io.INT_ORG_TYPE_CD = 'STORE'
;
