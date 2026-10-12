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
        PLAN_POS_NR,
        PLANNED_KPI_MEAS,
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
         int_org_sid.party_sid AS INT_ORG_SID,
         --UPPER(VLXMLCNTR)||'|'||TO_NUMBER(VLXMWRNFL) AS INT_ORG_NATURAL_KEY,
         NULL AS INT_ORG_NATURAL_KEY,
        'COMPANY' AS INT_ORG_KEY_TYPE_CD,
        'COMPANY' AS INT_ORG_TYPE_CD ,
        'DUMMY_1|DUMMY_1' REAL_ESTATE_NATURAL_KEY,
        'DUMMY_1' REAL_ESTATE_KEY_TYPE_CD,
        TO_DATE(SRC.calday,'YYYYMMDD') AS CAL_DT,
        SRC.kyf_id ||'|'||decode(SRC.URGUNIT, 50, 'WH_DLV', 60, 'WH_SLS') AS PLANNED_VAL_TYPE_NATURAL_KEY,
        'PVAL' AS PLANNED_VAL_TYPE_KEY_TYPE_CD,
        SRC.VLXMSTORE AS PLAN_POS_NR,
        SUM(SRC.KYF_ALL) AS PLANNED_KPI_MEAS,
        MAX(SRC.EXTRACTION_DATE)       AS EXTRACTION_DT,        
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'         AS  FILENAME,
        'SAP_HANA_PLAN'                AS  DWH_NODE_CD,
        '${LOAD_ID}'                   AS DWH_LOAD_ID 
FROM 
   (
     SELECT VLXMLCNTR, CALDAY, KYF_ID, KYF_TYPE, KYF_ALL, VLXMSTORE, EXTRACTION_DATE, VLXMVERS, VLXMWRNFL, URGUNIT    
     FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}
     WHERE calday != 00000000 -- filter out invalid delivered business dates
     AND kyf_id = 157 -- 157 is "Daily Revenue Value"
     AND kyf_type = 2 -- 2:"Target/Plan", 1: "Actual"
     AND kyf_all IS NOT NULL -- eliminated empty target values
     AND URGUNIT in (50,60) -- targets for Delivery(50)/Sales_1(60) Companies
 --    AND vlxmvers = 'S2324' -- so far this revision ID is the most complete (contains data for highest number of stores)
     -- exclude rows which can be associated with Stores
     -- what is left we will associate with Companies
     AND UPPER(VLXMLCNTR)||to_number(VLXMSTORE) NOT IN
		(
			SELECT INT_ORG_NR
			FROM core_rel.T_INTERNAL_ORGANIZATION_1 io
			WHERE io.INT_ORG_TYPE_CD = 'STORE'
		)
     QUALIFY row_number() over (partition by vlxmlcntr, vlxmstore, calday, vlxmwrnfl ORDER BY EXTRACTION_DATE desc, URGUNIT asc) = 1
    -- For Stores we often get two (some thimes 3) rows per day for the plan turonver.
    -- One is asociated with Sales_1 Company (60/VGES) and the other is associated with Delivery Company (50/BGES). The Company numbers could be the same or different.
    -- If company numbers are the same we take only 1 row, if they are different we take both rows and link them to the respective companies. So we deduplicate by Store,Day AND COMPANY
    -- Duplicated rows have the same  value so we just take one. 
    -- BGES has priority over VGES because in LISY we have links between stores and delivery companies
   ) SRC
/*SID Lookup is done outside graph, because the key table can deliver more than one sid for the same natural key which in this case is correct*/   
INNER JOIN meta.t_party_key_1 int_org_sid 
 ON int_org_sid.DWH_VALID_FG = TRUE
 and UPPER(int_org_sid.party_key_type_cd) = UPPER('COMPANY')
 and UPPER(int_org_sid.party_nat_key_nr) = UPPER(VLXMLCNTR)||'|'||TO_NUMBER(VLXMWRNFL)  
 WHERE int_org_sid.party_sid IS NOT NULL
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
