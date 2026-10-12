
/* Create records for those stores that have never been replaced */

INSERT INTO  ETL.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        INT_ORG_SID,
        INT_ORG_TYPE_CD,
        INT_ORG_NR,
        INT_ORG_NAME,
        COUNTRY_ORG_NAME,
        OPEN_DT,
        PLANNED_OPEN_DT,
        CLOSE_DT,
        CURR_CD,
        HOLIDAY_STORE_FG,
        LEGAL_NAME,
        VAT_NR,
        COUNTRY_ORG_CD,
        COMMENT_TXT,
        IS_SALES_COMPANY_FG,
        IS_DELIV_COMPANY_FG,
        IS_COUNTRY_ORG_FG,
        IS_EXPANSION_COMPANY_FG,
        IS_BAL_SHEET_COMPANY_FG,
        IS_OWNER_COMPANY_FG,
        IS_TRUST_FG,
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



-- Source is deduplicated data from LISY_CDS_ACCOUNT, filtered to contain only buildings related to stores. And the building must have OPEN_DT. We also check it we already have existing records from LISY to decide if validity_2 date (DWH_VALID_FROM_TMSP) should be OPEN_DT  (for the first records) or ""now"" (the date of change for the any following records) 
WITH 
SRC_SEL AS
(
    SELECT *
    FROM etl_process.T_${SRC_INPUT_TABLE}
    WHERE 1=1
        AND IGL_ACCOUNTTYPECODE IN (285540000, 285540009) -- real estate associated with stores and special sale stores
        AND IGL_NUMBER IS NOT NULL -- only objects with assigned object number should be considered
        AND (IGL_NEODATE IS NOT NULL OR IGL_CLOSINGDATE IS NOT NULL) -- if a building should be counted as a Store, it must have at least one of these dates 
)

-- the first two parts of the mapping are responsible for generating SIDs in the META schema
-- so we can use inner join with the KEY table - the NKs are already there and mapped to SIDs
,SRC_WITH_SID AS
(
    SELECT 
        ST_K.PARTY_SID AS STORE_SID
        ,SRC_SEL.*
    FROM SRC_SEL
        JOIN META.T_PARTY_KEY_2 ST_K  
            ON ST_K.PARTY_NAT_KEY_NR = UPPER(SUBSTR(IGL_NUMBER, 1, 2)) ||'|'||TO_NUMBER(SUBSTR(IGL_NUMBER,3,5))
    WHERE ST_K.PARTY_KEY_TYPE_CD = 'STORE'
        AND ST_K.DWH_VALID_FG = TRUE
	-- we will not update the information for the store based on the info for older buildings
	-- if source provides info for two buildings that represent the same store,
	-- we want to take only the information for the most recent building
	QUALIFY ROW_NUMBER() over (partition by st_k.PARTY_SID order by IGL_NEODATE desc) = 1
)
,LISY_HIST_EXISTS AS
(
    SELECT DISTINCT INT_ORG_SID AS STORE_SID
    FROM CORE_REL.T_INTERNAL_ORGANIZATION_2
    WHERE UPPER(DWH_NODE_CD) = 'LISY'
        and INT_ORG_TYPE_CD = 'STORE' 
)
SELECT
        SRC.STORE_SID AS INT_ORG_SID,
        'STORE' AS INT_ORG_TYPE_CD,
        UPPER(SUBSTR(IGL_NUMBER, 1, 2)) ||TO_NUMBER(SUBSTR(IGL_NUMBER,3,5)) AS INT_ORG_NR,
        SUBSTR(SRC.NAME, 11) AS INT_ORG_NAME,
        CASE
                WHEN IGL_ISOCODE2 = 'LU' THEN 'Belgien'
                WHEN IGL_ISOCODE2 = 'NI' THEN 'Nordirland'
                ELSE CTRY.COUNTRY_NAME
        END AS COUNTRY_ORG_NAME,
        MIN(TO_DATE(IGL_NEODATE)) OVER (PARTITION BY LOWER(SUBSTR(IGL_NUMBER, 1, 2)) ||'|'||TO_NUMBER(SUBSTR(IGL_NUMBER,3,5))) AS OPEN_DT,
        MIN(TO_DATE(IGL_EXPECTEDOPENINGDATE)) OVER (PARTITION BY LOWER(SUBSTR(IGL_NUMBER, 1, 2)) ||'|'||TO_NUMBER(SUBSTR(IGL_NUMBER,3,5))) AS PLANNED_OPEN_DT,
        LAST_VALUE(TO_DATE(IGL_CLOSINGDATE)) OVER (PARTITION BY LOWER(SUBSTR(IGL_NUMBER, 1, 2)) ||'|'||TO_NUMBER(SUBSTR(IGL_NUMBER,3,5)) ORDER BY IGL_CLOSINGDATE ASC NULLS LAST) AS CLOSE_DT,
        NULL AS CURR_CD,
        NULL AS HOLIDAY_STORE_FG,
        NULL AS LEGAL_NAME,
        NULL AS VAT_NR,
        CASE
            WHEN IGL_ISOCODE2 = 'LU' THEN 'BE'
            ELSE IGL_ISOCODE2
        END AS COUNTRY_ORG_CD,
        NULL AS COMMENT_TXT,
        NULL AS IS_SALES_COMPANY_FG,
        NULL AS IS_DELIV_COMPANY_FG,
        NULL AS IS_COUNTRY_ORG_FG,
        NULL AS IS_EXPANSION_COMPANY_FG,
        NULL AS IS_BAL_SHEET_COMPANY_FG,
        NULL AS IS_OWNER_COMPANY_FG,
        NULL AS IS_TRUST_FG,
        'LISY' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        CASE
                WHEN LHE.STORE_SID IS NULL AND SRC.IGL_NEODATE <= CURRENT_DATE() THEN SRC.IGL_NEODATE -- no records from LISY exist, therefore for the first we take the OPEN_DT as start of validity_2 in case this opening date has passed or coincides with the date of loading. 
                WHEN LHE.STORE_SID IS NULL AND SRC.IGL_NEODATE > CURRENT_DATE() THEN SRC.SINKMODIFIEDON -- IF THE OPENING DATE LIES IN THE FUTURE, WE TAKE SINKMODIFIEDON BECAUSE WE WANT TO HISTORIZE THE CHANGES IN ATTRIBUTES WE ALREADY KNOW ABOUT PRIOR TO THE STORE OPENING.
                WHEN LHE.STORE_SID IS NOT NULL AND SRC.IGL_CLOSINGDATE < SRC.SINKMODIFIEDON THEN NVL(SRC.IGL_NEODATE, SRC.IGL_CONTRACTDATE) -- this is a case of a predessesor store that is already closed and should have their validity_2 from the opening date only and not be updated with sinkmodifiedon as its lifecycle is already completed.
                ELSE SRC.SINKMODIFIEDON  -- there are some records from LISY, so if there is a change in some attribute and it is valid from this moment
        END AS DWH_VALID_FROM_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'LISY' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID 
FROM SRC_WITH_SID SRC
        -- check if we already have LISY history in the hierarchy_2
LEFT JOIN LISY_HIST_EXISTS LHE ON LHE.STORE_SID = SRC.STORE_SID
LEFT JOIN CORE_REL.T_COUNTRY_2 CTRY
        ON SRC.IGL_ISOCODE2=CTRY.ISO_COUNTRY_CD
             AND CTRY.DWH_VALID_FG = TRUE 
;
