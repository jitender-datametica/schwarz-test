INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
   (
        INT_ORG_SID,
        INT_ORG_NATURAL_KEY ,
        INT_ORG_KEY_TYPE_CD,
        INT_ORG_TYPE_CD ,
        REAL_ESTATE_NATURAL_KEY ,
        REAL_ESTATE_KEY_TYPE_CD ,
        CAL_DT,
        PLANNED_VAL_TYPE_NATURAL_KEY,
        PLANNED_VAL_TYPE_KEY_TYPE_CD,
        plan_pos_nr,
        planned_kpi_meas,
        EXTRACTION_DT,
        DWH_MAPPING_TMSP,
        TF_ERROR_FG,
        DELETED_FG,
        RECORD_ID,
        FILENAME,
        DWH_NODE_CD,
        DWH_LOAD_ID
  )
SELECT
         io.int_org_sid AS INT_ORG_SID,
         --UPPER(VLXMLCNTR)||'|'||TO_NUMBER(VLXMWRNFL) AS INT_ORG_NATURAL_KEY,
         NULL AS INT_ORG_NATURAL_KEY,
        'COMPANY' AS INT_ORG_KEY_TYPE_CD,
        'COMPANY' AS INT_ORG_TYPE_CD ,
        'DUMMY_2|DUMMY_2' REAL_ESTATE_NATURAL_KEY,
        'DUMMY_2' REAL_ESTATE_KEY_TYPE_CD,
        TO_DATE(SRC.calday,'YYYYMMDD'),
        SRC.kyf_id ||'|'||decode(SRC.URGUNIT, 50, 'WH_DLV', 60, 'WH_SLS') AS PLANNED_VAL_TYPE_NATURAL_KEY,
        'PVAL' AS PLANNED_VAL_TYPE_KEY_TYPE_CD,
        SRC.VLXMLCNTR AS plan_pos_nr,
        SRC.kyf_all AS planned_kpi_meas,
        SRC.EXTRACTION_DATE AS EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'         AS  FILENAME,
        'SAP_HANA_PLAN'                AS  DWH_NODE_CD,
        '${LOAD_ID}'                   AS DWH_LOAD_ID 
FROM 
(
        SELECT VLXMLCNTR, CALDAY, KYF_ID, KYF_TYPE, KYF_ALL,EXTRACTION_DATE, VLXMVERS, URGUNIT    
        FROM etl.t_tcache_saphana_cv_mo_umsatz_kunde_2
        WHERE calday != 00000000 -- filter out invalid delivered business dates
        AND kyf_id = 152 -- 152 is Customer Count
        AND kyf_type = 2 -- 2:"Target/Plan", 1: "Actual"
        AND kyf_all IS NOT NULL -- eliminated empty target values
        AND URGUNIT in (50,60) -- targets for Delivery(50)/Sales_2(60) Companies
        AND vlxmvers = 'S2324' -- so far this revision ID is the most complete (contains data for highest number of stores)
        -- exclude rows which can be associated with Stores
        -- what is left we will associate with Companies
        QUALIFY row_number() over (partition by vlxmlcntr, calday  ORDER BY EXTRACTION_DATE desc, URGUNIT asc) = 1
        -- For Stores we often get two (some thimes 3) rows per day for the plan turonver.
        -- One is asociated with Sales_2 Company (60/VGES) and the other is associated with Delivery Company (50/BGES). The Company numbers could be the same or different.
        -- If company numbers are the same we take only 1 row, if they are different we take both rows and link them to the respective companies. So we deduplicate by Store,Day AND COMPANY
        -- Duplicated rows have the same  value so we just take one. 
        -- BGES has priority over VGES because in LISY we have links between stores and delivery companies
) SRC
/*SID Lookup is done outside graph, because the key table can deliver more than one sid for the same natural key which in this case is correct*/   
INNER JOIN core_rel.t_internal_organization_2 io
 ON io.DWH_VALID_FG = TRUE
 and UPPER(io.country_org_cd) = UPPER(SRC.VLXMLCNTR) -- There are some rogue countrty codes in the data, we discard them via this join.
 and io.is_country_org_fg = TRUE
;



