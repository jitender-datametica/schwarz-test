INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(   
        INT_ORG_SID,
        INT_ORG_HIERARCHY_TYPE_CD,
        PARENT_INT_ORG_SID,
        DWH_MAPPING_TMSP,
        DWH_ENDING_TMSP,
        --
        SOURCE_SYSTEM,
        EXTRACTION_DT,
        TF_ERROR_FG,
        DELETED_FG,
        RECORD_ID,
        FILENAME,
        DWH_NODE_CD,
        DWH_LOAD_ID
)
select src.INT_ORG_SID
     , src.INT_ORG_HIERARCHY_TYPE_CD
     , src.PARENT_INT_ORG_SID
     , CASE WHEN src.DERIVED_VALID_FROM_TMSP IS NOT NULL THEN src.DERIVED_VALID_FROM_TMSP 
            WHEN src.LVL  = 'SMD' and tgt.int_org_sid is null THEN nvl(io.OPEN_DT, '1900-01-01 00:00:00.000000000')
            WHEN src.LVL != 'SMD' and tgt.int_org_sid is null THEN '1900-01-01 00:00:00.000000000'
            ELSE nvl(src.EXTRACTION_TMSP, '1900-01-01 00:00:00.000000000')
        END AS DWH_MAPPING_TMSP 
     , coalesce(src.DERIVED_VALID_TO_TMSP, tgt.DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999999999') AS DWH_ENDING_TMSP         
     , 'OSO' AS SOURCE_SYSTEM
     , CURRENT_DATE AS EXTRACTION_DT
     , 0 AS TF_ERROR_FG
     , 0 AS DELETED_FG
     , 0 AS RECORD_ID
     , 't_${SRC_INPUT_TABLE}' AS FILENAME
     --, 'OSO' AS DWH_NODE_CD
     , src.DWH_NODE_CD
     , '${LOAD_ID}' AS DWH_LOAD_ID
  from etl.t_tcache_oso_internal_organization_hierarchy_2 as src  
  left join core_rel.t_internal_organization_hierarchy_2 as tgt
    on src.INT_ORG_HIERARCHY_TYPE_CD = tgt.INT_ORG_HIERARCHY_TYPE_CD
   and src.INT_ORG_SID = tgt.INT_ORG_SID
   and src.DWH_NODE_CD = tgt.DWH_NODE_CD
   and src.EXTRACTION_TMSP between DWH_VALID_FROM_TMSP and DWH_VALID_TO_TMSP   
  left join core_rel.T_INTERNAL_ORGANIZATION_2 io  
    on src.INT_ORG_SID = io.INT_ORG_SID
   and io.INT_ORG_TYPE_CD = 'STORE'
   and io.DWH_VALID_FG = TRUE
;
