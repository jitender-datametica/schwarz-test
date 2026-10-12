INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
   (
        INT_ORG_SID, 
        INT_ORG_NATURAL_KEY,
        INT_ORG_KEY_TYPE_CD,
        INT_ORG_TYPE_CD,
        REAL_ESTATE_NATURAL_KEY,
        REAL_ESTATE_KEY_TYPE_CD,
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
        IO.INT_ORG_SID AS INT_ORG_SID,
        UPPER(VLXMLCNTR)||'|'||TO_NUMBER(VLXMSTORE) AS INT_ORG_NATURAL_KEY,
        'STORE' AS INT_ORG_KEY_TYPE_CD,
        'STORE' AS INT_ORG_TYPE_CD ,
        'DUMMY_2|DUMMY_2' REAL_ESTATE_NATURAL_KEY,
        'DUMMY_2' REAL_ESTATE_KEY_TYPE_CD,
        TO_DATE(SRC.calday,'YYYYMMDD') AS CAL_DT,
        SRC.kyf_id ||'|'||'STR' AS PLANNED_VAL_TYPE_NATURAL_KEY,
        'PVAL' AS PLANNED_VAL_TYPE_KEY_TYPE_CD,
        SRC.vlxmstore AS plan_pos_nr,
        SUM(SRC.kyf_all) AS planned_kpi_meas,
        MAX(SRC.EXTRACTION_DATE) AS EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'         AS  FILENAME,
        'SAP_HANA_PLAN'                AS  DWH_NODE_CD,
        '${LOAD_ID}'                   AS DWH_LOAD_ID 
FROM 
   (
     SELECT VLXMLCNTR, CALDAY, KYF_ID, KYF_TYPE, KYF_ALL, VLXMSTORE, EXTRACTION_DATE, VLXMVERS
     FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}
     WHERE calday != 00000000 -- filter out invalid delivered business dates
     AND kyf_id = 152 -- 157 is "Daily Revenue Value"
     AND kyf_type = 2 -- 2:"Target/Plan", 1: "Actual"
     AND kyf_all IS NOT NULL -- eliminated empty target values
 --    AND vlxmvers = 'S2324' -- so far this revision ID is the most complete (contains data for highest number of stores)
     QUALIFY row_number() over (partition by vlxmlcntr, vlxmstore, calday ORDER BY EXTRACTION_DATE desc, URGUNIT asc) = 1
     -- For Stores we get two rows per day for the plan turonver.
     -- One is asociated with Sales_2 Company (60/VGES) and the other is associated with Delivery Company (50/BGES)
     -- They always have the same value so we just take one. 
     -- BGES hAS priority over VGES because in LISY we have links between stores and delivery companies
   ) SRC
/*SID Lookup is done outside graph, because the key table can deliver more than one sid for the same natural key which in this case is correct*/   
INNER JOIN (
     SELECT INT_ORG_NR, MAX(INT_ORG_SID) AS INT_ORG_SID FROM CORE_REL.T_INTERNAL_ORGANIZATION_2 
     WHERE UPPER(INT_ORG_TYPE_CD) = 'STORE'
     GROUP BY INT_ORG_NR) IO -- Only here for a dedupe
ON UPPER(IO.INT_ORG_NR) = UPPER(VLXMLCNTR)||TO_NUMBER(VLXMSTORE)    
GROUP BY INT_ORG_SID,
         INT_ORG_NATURAL_KEY,
         INT_ORG_KEY_TYPE_CD,
         INT_ORG_TYPE_CD,
         REAL_ESTATE_NATURAL_KEY,
         REAL_ESTATE_KEY_TYPE_CD,
         CAL_DT,
         PLANNED_VAL_TYPE_NATURAL_KEY,
         PLANNED_VAL_TYPE_KEY_TYPE_CD,
         PLAN_POS_NR;         
