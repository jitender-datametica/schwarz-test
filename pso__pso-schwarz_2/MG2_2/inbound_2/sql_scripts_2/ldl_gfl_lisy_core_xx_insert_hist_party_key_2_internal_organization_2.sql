/*
Summary: We insert Store records in CORE_REL for Store keys that exist in META but not in CORE_REL yet
*/
INSERT into core_rel.T_INTERNAL_ORGANIZATION_2
(
	INT_ORG_SID
	,DWH_VALID_FROM_TMSP
	,DWH_VALID_TO_TMSP
	,DWH_VALID_FG
	,INT_ORG_TYPE_CD
	,INT_ORG_NR
	,INT_ORG_NAME
	,OPEN_DT
	,PLANNED_OPEN_DT
	,CLOSE_DT
	,CURR_CD
	,HOLIDAY_STORE_FG
	,LEGAL_NAME
	,VAT_NR
	,COUNTRY_ORG_CD
	,COMMENT_TXT
	,IS_SALES_COMPANY_FG
	,IS_DELIV_COMPANY_FG
	,IS_COUNTRY_ORG_FG
	,IS_EXPANSION_COMPANY_FG
	,IS_BAL_SHEET_COMPANY_FG
	,IS_OWNER_COMPANY_FG
	,IS_TRUST_FG
	,INT_ORG_SHORT_NAME
	,COUNTRY_ORG_NAME
	,DWH_CREATED_TMSP
	,DWH_UPDATED_TMSP
	,DWH_LOAD_ID
	,DWH_NODE_CD
)
SELECT
	pk.PARTY_SID                           	as INT_ORG_SID
	,'1900-01-01'							as DWH_VALID_FROM_TMSP
	,pk.DWH_VALID_TO_TMSP
	,pk.DWH_VALID_FG
	,pk.PARTY_KEY_TYPE_CD                  	as INT_ORG_TYPE_CD -- we are using directly the TYPE from the key table, so we can do this for types other than STORE, but we should think about the hierarchy_2
	,replace(pk.PARTY_NAT_KEY_NR, '|', '') 	as INT_ORG_NR
	,'Unbekannt (Nicht in LISY)'         	as INT_ORG_NAME
    
	,NULL                                  	as OPEN_DT
	,NULL                                  	as PLANNED_OPEN_DT
	,NULL                                  	as CLOSE_DT
	,NULL                                  	as CURR_CD
	,NULL                                  	as HOLIDAY_STORE_FG
	,NULL                                	as LEGAL_NAME
	,NULL                                  	as VAT_NR
	,NULL                                  	as COUNTRY_ORG_CD
	,'Default Record - created by NKC '    	as COMMENT_TXT
	,NULL                                  	as IS_SALES_COMPANY_FG
	,NULL                                  	as IS_DELIV_COMPANY_FG
	,NULL                                  	as IS_COUNTRY_ORG_FG
	,NULL                                  	as IS_EXPANSION_COMPANY_FG
	,NULL                                  	as IS_BAL_SHEET_COMPANY_FG
	,NULL                                  	as IS_OWNER_COMPANY_FG
	,NULL                                  	as IS_TRUST_FG
	,NULL                                  	as INT_ORG_SHORT_NAME
	,NULL                                  	as COUNTRY_ORG_NAME
	,CURRENT_TIMESTAMP                     	as DWH_CREATED_TMSP -- or could be pk.DWH_CREATED_TMSP
	,CURRENT_TIMESTAMP                     	as DWH_UPDATED_TMSP -- or could be pk.DWH_UPDATED_TMSP
	,pk.DWH_LOAD_ID
	,'MANUAL (NKC)'							as DWH_NODE_CD
FROM meta.T_PARTY_KEY_2 pk
	left join core_rel.T_INTERNAL_ORGANIZATION_2 io
			on io.INT_ORG_SID = pk.PARTY_SID
            and io.INT_ORG_TYPE_CD = 'STORE'
WHERE 1=1
	and pk.PARTY_KEY_TYPE_CD = 'STORE' -- we can add "COMPANY" here too, but we have to decide will we create default COMPANY-to-COUNTRY_2 relation in the hierarchy_2
    and io.INT_ORG_SID is NULL
QUALIFY row_number() over (partition by pk.party_sid order by pk.dwh_created_tmsp) = 1 -- this condition is added to make sure we avoid any duplicates caused by the keys we create artificially for BE + LU and ES + CS 
;
