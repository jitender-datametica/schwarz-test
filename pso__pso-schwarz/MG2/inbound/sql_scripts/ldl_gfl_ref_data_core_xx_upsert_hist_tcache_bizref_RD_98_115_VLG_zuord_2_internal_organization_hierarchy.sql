INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        INT_ORG_KEY_TYPE_CD,
        INT_ORG_NATURAL_KEY,
        INT_ORG_HIERARCHY_TYPE_CD,
        PARENT_INT_ORG_KEY_TYPE_CD,
        PARENT_INT_ORG_NATURAL_KEY,
        SOURCE_SYSTEM,
        EXTRACTION_DT,
        DWH_MAPPING_TMSP,
        TF_ERROR_FG,
        DELETED_FG,
        RECORD_ID,
        FILENAME,
        DWH_NODE_CD,
        DWH_LOAD_ID
)

/* n countries could be related to n SIDs, for example CS/ES, so dedupe the source first via a keys lookup.
*/

WITH DEDUPE_SRC AS (
SELECT  
        KEYS.PARTY_SID                  AS COUNTRY_SID,
        'COUNTRY'                       AS INT_ORG_KEY_TYPE_CD,
        MAX(UPPER(TRIM(LAND)))          AS INT_ORG_NATURAL_KEY,
        'CNTRY_GRP_CNTRY_ORG'           AS INT_ORG_HIERARCHY_TYPE_CD,
        'COUNTRY_GRP'                   AS PARENT_INT_ORG_KEY_TYPE_CD,
        MAX(TRIM(VS_LANDERGRUPPEN_ID))  AS PARENT_INT_ORG_NATURAL_KEY,
        'BIZREF'                        AS SOURCE_SYSTEM,
        CURRENT_DATE                    AS EXTRACTION_DT,
        CURRENT_TIMESTAMP               AS DWH_VALID_FROM_TMSP,
        0                               AS TF_ERROR_FG,
        0                               AS DELETED_FG,
        0                               AS RECORD_ID,
        't_${SRC_INPUT_TABLE}'          AS FILENAME,
        'EXTERNAL_CSV'                  AS DWH_NODE_CD,
        '${LOAD_ID}'                    AS DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
INNER JOIN META.T_PARTY_KEY KEYS
ON UPPER(TRIM(LAND))  = UPPER(KEYS.PARTY_NAT_KEY_NR)
AND UPPER(KEYS.PARTY_KEY_TYPE_CD) = 'COUNTRY'
AND DWH_VALID_FG = 'TRUE'
GROUP BY COUNTRY_SID
                        )

SELECT 

        INT_ORG_KEY_TYPE_CD,
        INT_ORG_NATURAL_KEY,
        INT_ORG_HIERARCHY_TYPE_CD,
        PARENT_INT_ORG_KEY_TYPE_CD,
        PARENT_INT_ORG_NATURAL_KEY,
        SOURCE_SYSTEM,
        EXTRACTION_DT,
        DWH_VALID_FROM_TMSP,
        TF_ERROR_FG,
        DELETED_FG,
        RECORD_ID,
        FILENAME,
        DWH_NODE_CD,
        DWH_LOAD_ID 
FROM DEDUPE_SRC;

