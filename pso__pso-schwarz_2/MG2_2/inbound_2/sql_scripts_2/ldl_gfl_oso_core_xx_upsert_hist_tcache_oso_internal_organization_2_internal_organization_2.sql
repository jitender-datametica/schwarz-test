INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
( 
       INT_ORG_SID
	 , INT_ORG_TYPE_CD
	 , INT_ORG_NR
	 , INT_ORG_NAME
	 , OPEN_DT
	 , PLANNED_OPEN_DT
	 , CLOSE_DT
	 , CURR_CD
	 , HOLIDAY_STORE_FG
	 , LEGAL_NAME
	 , VAT_NR
	 , COUNTRY_ORG_CD
	 , COMMENT_TXT
	 , IS_SALES_COMPANY_FG
	 , IS_DELIV_COMPANY_FG
	 , IS_COUNTRY_ORG_FG
	 , IS_EXPANSION_COMPANY_FG
	 , IS_BAL_SHEET_COMPANY_FG
	 , IS_OWNER_COMPANY_FG
	 , IS_TRUST_FG
	 , INT_ORG_SHORT_NAME
	 , COUNTRY_ORG_NAME
     /*  */
     , DWH_MAPPING_TMSP 
     , DWH_ENDING_TMSP         
     , SOURCE_SYSTEM
     , EXTRACTION_DT
     , TF_ERROR_FG
     , DELETED_FG
     , RECORD_ID
     , FILENAME
     , DWH_NODE_CD
     , DWH_LOAD_ID)
select src.INT_ORG_SID
	 , src.INT_ORG_TYPE_CD
	 , src.INT_ORG_NR
	 , src.INT_ORG_NAME
	 , src.OPEN_DT
	 , src.PLANNED_OPEN_DT
	 , src.CLOSE_DT
	 , src.CURR_CD
	 , src.HOLIDAY_STORE_FG
	 , src.LEGAL_NAME
	 , src.VAT_NR
	 , src.COUNTRY_ORG_CD
	 , src.COMMENT_TXT
	 , src.IS_SALES_COMPANY_FG
	 , src.IS_DELIV_COMPANY_FG
	 , src.IS_COUNTRY_ORG_FG
	 , src.IS_EXPANSION_COMPANY_FG
	 , src.IS_BAL_SHEET_COMPANY_FG
	 , src.IS_OWNER_COMPANY_FG
	 , src.IS_TRUST_FG
	 , src.INT_ORG_SHORT_NAME
	 , src.COUNTRY_ORG_NAME
     /*  */
     , CASE
                WHEN  tgt.int_org_sid is null THEN to_timestamp('1900-01-01') -- no historical record exists, therefore we take the default 1900-01-01 as start of validity_2
                ELSE  src.EXTRACTION_TMSP  -- there are some historical records, so if there is a change in some attribute, it is valid from this moment
        END AS DWH_MAPPING_TMSP 
     , COALESCE(TGT.DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999999999') AS DWH_ENDING_TMSP         
     , 'OSO' AS SOURCE_SYSTEM
     , CURRENT_DATE AS EXTRACTION_DT
     , 0 AS TF_ERROR_FG
     , 0 AS DELETED_FG
     , 0 AS RECORD_ID
     , 't_${SRC_INPUT_TABLE}' AS FILENAME
     , 'OSO' AS DWH_NODE_CD
     , '${LOAD_ID}' AS DWH_LOAD_ID
  from etl.t_tcache_oso_internal_organization_2 as src  
  left join core_rel.t_internal_organization_2 as tgt
    on src.INT_ORG_SID = tgt.INT_ORG_SID
   and src.DWH_NODE_CD = tgt.DWH_NODE_CD
   and src.EXTRACTION_TMSP between DWH_VALID_FROM_TMSP and DWH_VALID_TO_TMSP   
QUALIFY ROW_NUMBER() OVER (PARTITION BY SRC.INT_ORG_SID, SRC.INT_ORG_TYPE_CD ORDER BY DWH_MAPPING_TMSP DESC) = 1 -- FROM THE FILTERED STORES, WE TAKE THE LATEST RECORD AS PER EXTRACTION DATE   
;
