INSERT into core_rel.T_INTERNAL_ORGANIZATION_HIERARCHY_2
(
     INT_ORG_SID
    ,INT_ORG_HIERARCHY_TYPE_CD
    ,DWH_VALID_FROM_TMSP
    ,DWH_VALID_TO_TMSP
    ,DWH_VALID_FG
    ,PARENT_INT_ORG_SID
    ,DWH_CREATED_TMSP
    ,DWH_UPDATED_TMSP
    ,DWH_LOAD_ID
    ,DWH_NODE_CD
)
-- for all stores except those from Malta, Luxembourg and Canary Islands
SELECT
	k_st.PARTY_SID                         	as INT_ORG_SID
	,'CNTRY_ORG_STORE'                     	as INT_ORG_HIERARCHY_TYPE_CD -- new type of relationship, that we will create in the T_INTERNAL_ORGANIZATION_HIERARCHY_TYPE_2
	,to_timestamp('1900-01-01')				as DWH_VALID_FROM_TMSP
	,'9999-12-31 23:59:59.999999999' 		as DWH_VALID_TO_TMSP
	,TRUE 									as DWH_VALID_FG
	,k_cntr.PARTY_SID                     	as PARENT_INT_ORG_SID
	,CURRENT_TIMESTAMP                     	as DWH_CREATED_TMSP -- or could be k_st.DWH_CREATED_TMSP
	,CURRENT_TIMESTAMP                     	as DWH_UPDATED_TMSP -- or could be k_st.DWH_UPDATED_TMSP
	,-1                                     as DWH_LOAD_ID
	,'MANUAL'                               as DWH_NODE_CD
FROM meta.T_PARTY_KEY_2 k_st
    join meta.T_PARTY_KEY_2 k_cntr 
            on k_cntr.PARTY_NAT_KEY_NR = substr(k_st.PARTY_NAT_KEY_NR,1,2)
            and substr(k_st.PARTY_NAT_KEY_NR,1,2) not in ('MT', 'LU', 'CS')
            and k_cntr.PARTY_KEY_TYPE_CD = 'COUNTRY_2'
            and k_cntr.DWH_VALID_FG = TRUE
            
    left join core_rel.T_INTERNAL_ORGANIZATION_2 io_st
			on io_st.INT_ORG_SID = k_st.PARTY_SID
            and io_st.INT_ORG_TYPE_CD = 'STORE'
			and io_st.DWH_NODE_CD <> 'MANUAL (NKC)'
			
	left join core_rel.T_INTERNAL_ORGANIZATION_HIERARCHY_2 ioh
			on ioh.INT_ORG_SID = k_st.PARTY_SID
			and ioh.PARENT_INT_ORG_SID = k_cntr.PARTY_SID
			and ioh.INT_ORG_HIERARCHY_TYPE_CD = 'CNTRY_ORG_STORE'

WHERE 1=1
	and k_st.PARTY_KEY_TYPE_CD = 'STORE'
    and io_st.INT_ORG_SID is NULL
	and ioh.INT_ORG_SID is NULL
 QUALIFY row_number() over (partition by k_st.party_sid order by k_st.dwh_created_tmsp) = 1

UNION

--- for stores from Luxembourg (Country_2 Org should be BE, not LU)
 SELECT
	k_st.PARTY_SID                         	as INT_ORG_SID
	,'CNTRY_ORG_STORE'                     	as INT_ORG_HIERARCHY_TYPE_CD -- new type of relationship, that we will create in the T_INTERNAL_ORGANIZATION_HIERARCHY_TYPE_2
	,to_timestamp('1900-01-01')				as DWH_VALID_FROM_TMSP
	,'9999-12-31 23:59:59.999999999' 		as DWH_VALID_TO_TMSP
	,TRUE 									as DWH_VALID_FG
	,k_cntr.PARTY_SID                     	as PARENT_INT_ORG_SID
	,CURRENT_TIMESTAMP                     	as DWH_CREATED_TMSP -- or could be k_st.DWH_CREATED_TMSP
	,CURRENT_TIMESTAMP                     	as DWH_UPDATED_TMSP -- or could be k_st.DWH_UPDATED_TMSP
	,-1                                     as DWH_LOAD_ID
	,'MANUAL'                               as DWH_NODE_CD
FROM meta.T_PARTY_KEY_2 k_st
    join meta.T_PARTY_KEY_2 k_cntr 
            on k_cntr.PARTY_NAT_KEY_NR = 'BE'
            and substr(k_st.PARTY_NAT_KEY_NR,1,2) = 'LU'
            and k_cntr.PARTY_KEY_TYPE_CD = 'COUNTRY_2'
            and k_cntr.DWH_VALID_FG = TRUE
            
    left join core_rel.T_INTERNAL_ORGANIZATION_2 io_st
			on io_st.INT_ORG_SID = k_st.PARTY_SID
            and io_st.INT_ORG_TYPE_CD = 'STORE'
			and io_st.DWH_NODE_CD <> 'MANUAL (NKC)'
			
	left join core_rel.T_INTERNAL_ORGANIZATION_HIERARCHY_2 ioh
			on ioh.INT_ORG_SID = k_st.PARTY_SID
			and ioh.PARENT_INT_ORG_SID = k_cntr.PARTY_SID
			and ioh.INT_ORG_HIERARCHY_TYPE_CD = 'CNTRY_ORG_STORE'

WHERE 1=1
	and k_st.PARTY_KEY_TYPE_CD = 'STORE'
    and io_st.INT_ORG_SID is NULL
    and ioh.INT_ORG_SID is NULL
 QUALIFY row_number() over (partition by k_st.party_sid order by k_st.dwh_created_tmsp) = 1

UNION

--- for stores from Canary Islands (Country_2 Org should be ES, not CS)
 SELECT
	k_st.PARTY_SID                         	as INT_ORG_SID
	,'CNTRY_ORG_STORE'                     	as INT_ORG_HIERARCHY_TYPE_CD -- new type of relationship, that we will create in the T_INTERNAL_ORGANIZATION_HIERARCHY_TYPE_2
	,to_timestamp('1900-01-01')				as DWH_VALID_FROM_TMSP
	,'9999-12-31 23:59:59.999999999' 		as DWH_VALID_TO_TMSP
	,TRUE 									as DWH_VALID_FG
	,k_cntr.PARTY_SID                     	as PARENT_INT_ORG_SID
	,CURRENT_TIMESTAMP                     	as DWH_CREATED_TMSP -- or could be k_st.DWH_CREATED_TMSP
	,CURRENT_TIMESTAMP                     	as DWH_UPDATED_TMSP -- or could be k_st.DWH_UPDATED_TMSP
	,-1                                     as DWH_LOAD_ID
	,'MANUAL'                               as DWH_NODE_CD
FROM meta.T_PARTY_KEY_2 k_st
    join meta.T_PARTY_KEY_2 k_cntr 
            on k_cntr.PARTY_NAT_KEY_NR = 'ES'
            and substr(k_st.PARTY_NAT_KEY_NR,1,2) = 'CS'
            and k_cntr.PARTY_KEY_TYPE_CD = 'COUNTRY_2'
            and k_cntr.DWH_VALID_FG = TRUE
            
    left join core_rel.T_INTERNAL_ORGANIZATION_2 io_st
			on io_st.INT_ORG_SID = k_st.PARTY_SID
            and io_st.INT_ORG_TYPE_CD = 'STORE'
			and io_st.DWH_NODE_CD <> 'MANUAL (NKC)'
			
	left join core_rel.T_INTERNAL_ORGANIZATION_HIERARCHY_2 ioh
			on ioh.INT_ORG_SID = k_st.PARTY_SID
			and ioh.PARENT_INT_ORG_SID = k_cntr.PARTY_SID
			and ioh.INT_ORG_HIERARCHY_TYPE_CD = 'CNTRY_ORG_STORE'

WHERE 1=1
	and k_st.PARTY_KEY_TYPE_CD = 'STORE'
    and io_st.INT_ORG_SID is NULL
	and ioh.INT_ORG_SID is NULL
 QUALIFY row_number() over (partition by k_st.party_sid order by k_st.dwh_created_tmsp) = 1

UNION

--- for stores from Malta (which got in from a source different than P_LEW_CORE)
 SELECT
	k_st.PARTY_SID                         	as INT_ORG_SID
	,'CNTRY_ORG_STORE'                     	as INT_ORG_HIERARCHY_TYPE_CD -- new type of relationship, that we will create in the T_INTERNAL_ORGANIZATION_HIERARCHY_TYPE_2
	,to_timestamp('1900-01-01')				as DWH_VALID_FROM_TMSP
	,'9999-12-31 23:59:59.999999999' 		as DWH_VALID_TO_TMSP
	,TRUE 									as DWH_VALID_FG
	,k_cntr.PARTY_SID                     	as PARENT_INT_ORG_SID
	,CURRENT_TIMESTAMP                     	as DWH_CREATED_TMSP -- or could be k_st.DWH_CREATED_TMSP
	,CURRENT_TIMESTAMP                     	as DWH_UPDATED_TMSP -- or could be k_st.DWH_UPDATED_TMSP
	,-1                                     as DWH_LOAD_ID
	,'MANUAL'                               as DWH_NODE_CD
FROM meta.T_PARTY_KEY_2 k_st
    join meta.T_PARTY_KEY_2 k_cntr 
            on k_cntr.PARTY_NAT_KEY_NR = 'MT'
            and substr(k_st.PARTY_NAT_KEY_NR,1,2) = 'MT'
            and k_cntr.PARTY_KEY_TYPE_CD = 'COUNTRY_2'
            and k_cntr.DWH_VALID_FG = TRUE
            
    left join core_rel.T_INTERNAL_ORGANIZATION_2 io_st
			on io_st.INT_ORG_SID = k_st.PARTY_SID
            and io_st.INT_ORG_TYPE_CD = 'STORE'
			and io_st.DWH_NODE_CD <> 'MANUAL (NKC)'
			
	left join core_rel.T_INTERNAL_ORGANIZATION_HIERARCHY_2 ioh
			on ioh.INT_ORG_SID = k_st.PARTY_SID
			and ioh.PARENT_INT_ORG_SID = k_cntr.PARTY_SID
			and ioh.INT_ORG_HIERARCHY_TYPE_CD = 'CNTRY_ORG_STORE'

WHERE 1=1
	and k_st.PARTY_KEY_TYPE_CD = 'STORE'
    and k_st.DWH_NODE_CD <> 'P_LEW_CORE'
    and io_st.INT_ORG_SID is NULL
	and ioh.INT_ORG_SID is NULL
 QUALIFY row_number() over (partition by k_st.party_sid order by k_st.dwh_created_tmsp) = 1
;
