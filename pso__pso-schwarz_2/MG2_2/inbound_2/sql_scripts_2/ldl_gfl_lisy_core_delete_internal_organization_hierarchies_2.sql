
-- if we get information for the store for this type of relationship from lisy
-- DELETE relationships of type 'DELIVCMP_STORE' from non-lisy sources

DELETE FROM core_rel.T_INTERNAL_ORGANIZATION_HIERARCHY_2
WHERE 1=1  
    and upper(DWH_NODE_CD) <> 'LISY'
    and INT_ORG_HIERARCHY_TYPE_CD = 'DELIVCMP_STORE' 
    
    and INT_ORG_SID in 
    (
        -- get the SID only if LISY sends us information to which company the CURRENT building of the store is related
        SELECT curr_store.INT_ORG_SID
        FROM core_rel.T_INTERNAL_ORGANIZATION_2 curr_store
            join (
                SELECT *
                FROM eval.lisy_cds_account
                WHERE 1=1
                    and igl_accounttypecode in (285540000, 285540009) // real estate associated with stores and special sale stores
                    and igl_number is not NULL // only objects with assigned object number should b"""""""";""""
                    and (igl_neodate is not null or igl_closingdate is not null) 
                QUALIFY row_number() over (partition by igl_number order by extraction_ts desc) = 1  

            ) src on upper(substr(igl_number, 1, 2)) ||'|'||to_number(substr(igl_number,3,5))  = upper(substr(INT_ORG_NR, 1, 2)) ||'|'||to_number(substr(INT_ORG_NR,3,5))
        WHERE 1=1
            and curr_store.dwh_valid_fg = TRUE
            and curr_store.INT_ORG_TYPE_CD = 'STORE'
            and src.IGL_DELIVERYASSOCID is not null
    )
;


-- if we get information for the store for this type of relationship from lisy
-- DELETE relationships of type EXPCMP_STORE from non-lisy sources

DELETE FROM core_rel.T_INTERNAL_ORGANIZATION_HIERARCHY_2
WHERE 1=1  
    and upper(DWH_NODE_CD) <> 'LISY'
    and INT_ORG_HIERARCHY_TYPE_CD = 'EXPCMP_STORE' 
    
    and INT_ORG_SID in 
    (
        -- get the SID only if LISY sends us information to which company the CURRENT building of the store is related
        SELECT curr_store.INT_ORG_SID
        FROM core_rel.T_INTERNAL_ORGANIZATION_2 curr_store
            join (
                SELECT *
                FROM eval.lisy_cds_account
                WHERE 1=1
                    and igl_accounttypecode in (285540000, 285540009) // real estate associated with stores and special sale stores
                    and igl_number is not NULL // only objects with assigned object number should b"""""""";""""
                    and (igl_neodate is not null or igl_closingdate is not null) 
                QUALIFY row_number() over (partition by igl_number order by extraction_ts desc) = 1  

            ) src on upper(substr(igl_number, 1, 2)) ||'|'||to_number(substr(igl_number,3,5))  = upper(substr(INT_ORG_NR, 1, 2)) ||'|'||to_number(substr(INT_ORG_NR,3,5))
        WHERE 1=1
            and curr_store.dwh_valid_fg = TRUE
            and curr_store.INT_ORG_TYPE_CD = 'STORE'
            and src.igl_expassocid is not null
    )
;

-- if we get information for the store for this type of relationship from lisy
-- DELETE relationships of type EXPCMP_STORE from non-lisy sources

DELETE FROM core_rel.T_INTERNAL_ORGANIZATION_HIERARCHY_2
WHERE 1=1  
    and upper(DWH_NODE_CD) <> 'LISY'
    and INT_ORG_HIERARCHY_TYPE_CD = 'OWNERCMP_STORE' 
    
    and INT_ORG_SID in 
    (
        -- get the SID only if LISY sends us information to which company the CURRENT building of the store is related
        SELECT curr_store.INT_ORG_SID
        FROM core_rel.T_INTERNAL_ORGANIZATION_2 curr_store
            join (
                SELECT *
                FROM eval.lisy_cds_account
                WHERE 1=1
                    and igl_accounttypecode in (285540000, 285540009) // real estate associated with stores and special sale stores
                    and igl_number is not NULL // only objects with assigned object number should b"""""""";""""
                    and (igl_neodate is not null or igl_closingdate is not null) 
                QUALIFY row_number() over (partition by igl_number order by extraction_ts desc) = 1  

            ) src on upper(substr(igl_number, 1, 2)) ||'|'||to_number(substr(igl_number,3,5))  = upper(substr(INT_ORG_NR, 1, 2)) ||'|'||to_number(substr(INT_ORG_NR,3,5))
        WHERE 1=1
            and curr_store.dwh_valid_fg = TRUE
            and curr_store.INT_ORG_TYPE_CD = 'STORE'
            and src.IGL_OWNERASSOCID is not null
    )
;


-- if we get information for the store for this type of relationship from lisy
-- DELETE relationships of type EXPCMP_STORE from non-lisy sources

DELETE FROM core_rel.T_INTERNAL_ORGANIZATION_HIERARCHY_2
WHERE 1=1  
    and upper(DWH_NODE_CD) <> 'LISY'
    and INT_ORG_HIERARCHY_TYPE_CD = 'BALSHCMP_STORE' 
    
    and INT_ORG_SID in 
    (
        -- get the SID only if LISY sends us information to which company the CURRENT building of the store is related
        SELECT curr_store.INT_ORG_SID
        FROM core_rel.T_INTERNAL_ORGANIZATION_2 curr_store
            join (
                SELECT *
                FROM eval.lisy_cds_account
                WHERE 1=1
                    and igl_accounttypecode in (285540000, 285540009) // real estate associated with stores and special sale stores
                    and igl_number is not NULL // only objects with assigned object number should b"""""""";""""
                    and (igl_neodate is not null or igl_closingdate is not null) 
                QUALIFY row_number() over (partition by igl_number order by extraction_ts desc) = 1  

            ) src on upper(substr(igl_number, 1, 2)) ||'|'||to_number(substr(igl_number,3,5))  = upper(substr(INT_ORG_NR, 1, 2)) ||'|'||to_number(substr(INT_ORG_NR,3,5))
        WHERE 1=1
            and curr_store.dwh_valid_fg = TRUE
            and curr_store.INT_ORG_TYPE_CD = 'STORE'
            and src.IGL_ACCOUNTINGASSOCID is not null
    )
;
