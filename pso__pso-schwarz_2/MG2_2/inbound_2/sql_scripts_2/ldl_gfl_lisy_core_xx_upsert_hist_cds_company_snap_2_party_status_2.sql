INSERT INTO  ETL.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PARTY_SID,
        PARTY_STATUS_TYPE_CD,
        PARTY_TYPE_CD,
        DWH_MAPPING_TMSP,
        SOURCE_SYSTEM,
        EXTRACTION_DT,
        TF_ERROR_FG,
        DELETED_FG,
        RECORD_ID,
        FILENAME,
        DWH_NODE_CD,
        DWH_LOAD_ID
)
with
-- for every row for each INT_ORG_SID (Company) see if this row represents ACTIVE or INACTIVE company (HAS_ANY_FG)
-- and then in columm 'PREV_HAS_ANY_FG' see if the previous history records was ACTIVE or INACTIVE
-- and then in column HAS_CHANGE_FG see if the two consequite history intervals represetn a change in the state of the company
BASE_WITH_CHANGE_FG AS
(
        SELECT
                INT_ORG_SID
                , INT_ORG_NR
                ,DWH_VALID_FROM_TMSP
                ,DWH_VALID_TO_TMSP
                ,(NVL(IS_SALES_COMPANY_FG, FALSE)
                OR NVL(IS_DELIV_COMPANY_FG, FALSE)
                OR NVL(IS_COUNTRY_ORG_FG, FALSE)
                OR NVL(IS_EXPANSION_COMPANY_FG, FALSE)
                OR NVL(IS_BAL_SHEET_COMPANY_FG, FALSE)
                OR NVL(IS_OWNER_COMPANY_FG, FALSE)
                OR NVL(IS_TRUST_FG, FALSE)) AS HAS_ANY_FG
                ,LAG(HAS_ANY_FG)
                OVER (PARTITION BY INT_ORG_SID
                ORDER BY DWH_VALID_FROM_TMSP) AS PREV_HAS_ANY_FG
                ,CASE
                WHEN NOT EQUAL_NULL(HAS_ANY_FG, PREV_HAS_ANY_FG) THEN 1
                ELSE 0
                END AS HAS_CHANGE_FG
        FROM CORE_REL.T_INTERNAL_ORGANIZATION_2
        WHERE INT_ORG_TYPE_CD = 'COMPANY'
        AND SUBSTR(INT_ORG_NR, 1, 2) NOT IN ('AL', 'BA', 'ME', 'MK', 'XK')
        UNION ALL
        SELECT
                INT_ORG_SID
                , INT_ORG_NR
                ,DWH_VALID_FROM_TMSP
                ,DWH_VALID_TO_TMSP
                ,TRUE AS HAS_ANY_FG
                ,TRUE AS PREV_HAS_ANY_FG
                ,0 AS HAS_CHANGE_FG
        FROM CORE_REL.T_INTERNAL_ORGANIZATION_2
        WHERE INT_ORG_TYPE_CD = 'COMPANY'
        AND SUBSTR(INT_ORG_NR, 1, 2) IN ('AL', 'BA', 'ME', 'MK', 'XK')
)
-- IF WE HAVE SEVERAL HISTORY RECORDS FOR THE SAME COMPANY WITH SAME STATUS_2 (ACTIVE OR INACTIVE) THEN ASSIGN SAME ""GROUP_ID"" TO THESE CONSEQUTIVE STATUES
-- SO IN THE END WE WILL MERGE THESE CONSEQUTIVE HISTORICAL ROWS WITH SAME STATUS_2 INTO ONE ROW FOR THE WHOLE INTERVAL
, BASE_WITH_GROUP_ID AS
(
        SELECT
                B.*
                ,SUM(HAS_CHANGE_FG)
                OVER (PARTITION BY INT_ORG_SID
                ORDER BY DWH_VALID_FROM_TMSP
                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS GROUP_ID
        FROM BASE_WITH_CHANGE_FG B
)
        
SELECT 
        INT_ORG_SID,
        CASE
                WHEN SUBSTR(INT_ORG_NR, 1, 2) IN ('AL', 'BA', 'ME', 'MK', 'XK') THEN 'PRE-PROCESS'
                ELSE DECODE(HAS_ANY_FG, TRUE, 'ACTIVE', 'INACTIVE') 
        END AS PARTY_STATUS_TYPE_CD,
        'INT_ORG' AS PARTY_TYPE_CD,
        MIN(DWH_VALID_FROM_TMSP) AS DWH_MAPPING_TMSP,
        'LISY' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_tcache_lisy_cds_account_snap_2' AS FILENAME,
        'LISY' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID 
FROM base_with_group_id
GROUP BY
        INT_ORG_SID
        , INT_ORG_NR
        ,HAS_ANY_FG
        ,GROUP_ID
;

