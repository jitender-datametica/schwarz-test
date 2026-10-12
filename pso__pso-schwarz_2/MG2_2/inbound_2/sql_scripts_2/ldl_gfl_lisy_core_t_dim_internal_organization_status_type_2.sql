DELETE FROM  core_dim.t_dim_internal_organization_status_type_2; 

-- Dummy_2 row
insert into core_dim.t_dim_internal_organization_status_type_2 (
    int_org_status_cd
    , int_org_status_descr
    , int_org_status_descr_de
    , int_org_status_descr_en
    , dwh_created_tmsp
    , dwh_updated_tmsp
    , dwh_load_id
    , dwh_node_cd
    )
values (
    '@'
    , 'Unbekannt'
    , 'Unbekannt'
    , 'Unknown'
    , current_timestamp
    , current_timestamp
    , -1
    , 'MANUAL'
    )
;

INSERT into core_dim.T_DIM_INTERNAL_ORGANIZATION_STATUS_TYPE_2(
    int_org_status_cd
    , int_org_status_descr
    , int_org_status_descr_de
    , int_org_status_descr_en
    , dwh_created_tmsp
    , dwh_updated_tmsp
    , dwh_load_id
    , dwh_node_cd
    )
SELECT
    PARTY_STATUS_TYPE_CD                                        as INT_ORG_STATUS_CD
    ,max(DECODE(LANG_CD, 'DE', PARTY_STATUS_TYPE_DESCR, null))  as INT_ORG_STATUS_DESCR
    ,max(DECODE(LANG_CD, 'DE', PARTY_STATUS_TYPE_DESCR, null))  as INT_ORG_STATUS_DESCR_DE
    ,max(DECODE(LANG_CD, 'EN', PARTY_STATUS_TYPE_DESCR, null))  as INT_ORG_STATUS_DESCR_EN
	,current_timestamp()        as DWH_CREATED_TMSP
    ,current_timestamp()        as DWH_CREATED_TMSP
    ,-1                         as DWH_LOAD_ID
    ,'P_LEW_CORE'               as DWH_NODE_CD 
FROM core_rel.T_PARTY_STATUS_TYPE_2
GROUP BY PARTY_STATUS_TYPE_CD
;