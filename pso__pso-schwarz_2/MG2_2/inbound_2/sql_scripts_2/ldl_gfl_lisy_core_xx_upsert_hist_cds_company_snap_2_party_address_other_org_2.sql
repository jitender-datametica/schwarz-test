INSERT INTO  ETL.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
	PARTY_KEY_TYPE_CD,
        PARTY_NATURAL_KEY,
	ADDR_KEY_TYPE_CD,
        ADDR_NATURAL_KEY,
	ADDR_USG_TYPE_CD,
        PARTY_TYPE_CD,
	ADDR_TYPE_CD,        
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

-- Address_2 prioritization strategy in case of having multiple addresses derived from the different roles of one company:

WITH 
RANKED_ADDR AS 
(
    SELECT
        SUBSTR(IGL_ASSOCIATIONNUMBER, 1,2)||'|'||TO_NUMBER(REGEXP_REPLACE(IGL_ASSOCIATIONNUMBER, '[^0-9]', '')) AS PARTY_NATURAL_KEY,
    	COALESCE(SRC.IGL_ISOCODE2, '') 
    			|| '|' || COALESCE(SRC.IGL_CITY, '') 
    			|| '|' || COALESCE(SRC.IGL_POSTALCODE, '') 
    			|| '|' || COALESCE(SRC.IGL_STREET, '') || '|' || COALESCE(SRC.IGL_HOUSENUMBER, '') AS ADDR_NATURAL_KEY,
        CASE
            WHEN igl_companytypecode = 285540000 THEN 1 -- (delivery company)
            WHEN igl_companytypecode = 285540002 THEN 2 -- (sales_2 company)
            WHEN igl_companytypecode = 285540001 THEN 3 -- (head office)
            WHEN igl_companytypecode = 285540003 THEN 4 -- (expansion company)
            ELSE 99 --(lowest ranking)
    	END as ranking,
        sum(decode(IGL_COMPANYTYPECODE, 285540001, 1, 0)) over (partition by PARTY_NATURAL_KEY) as is_country_org,
        src.*
    FROM etl_process.T_${SRC_INPUT_TABLE} SRC
    WHERE IGL_COMPANYTYPECODE IS NOT NULL
    		AND IGL_COMPANYTYPECODE IN (285540000, 285540002, 285540003, 285540005, 285540006, 285540001)
    		AND IGL_ASSOCIATIONNUMBER IS NOT NULL
            AND regexp_like(igl_associationnumber, '^[A-Z]{2}.*') 
    		AND IGL_ISOCODE2 IS NOT NULL
    		AND DELETED != 'x'
)

SELECT
     'COMPANY' AS PARTY_KEY_TYPE_CD,
     PARTY_NATURAL_KEY AS PARTY_NATURAL_KEY,
     'STAD' AS ADDR_KEY_TYPE_CD,
     ADDR_NATURAL_KEY AS ADDR_NATURAL_KEY,
     'SA_MN' AS ADDR_USG_TYPE_CD,
     'INT_ORG' AS PARTY_TYPE_CD,
     'STAD' AS ADDR_TYPE_CD,
     'LISY' AS SOURCE_SYSTEM,
     CURRENT_DATE AS EXTRACTION_DT,
     SRC.SINKMODIFIEDON AS DWH_MAPPING_TMSP,
     0 AS TF_ERROR_FG,
     0 AS DELETED_FG,
     0 AS RECORD_ID,
     't_${SRC_INPUT_TABLE}' AS FILENAME,
     'LISY' AS DWH_NODE_CD,
     '${LOAD_ID}' as DWH_LOAD_ID 
FROM RANKED_ADDR SRC
WHERE 1=1
    and (is_country_org = 0
		-- companies that do not have the flag for Country_2 Organization 
		-- and the companies that even if they have the flag, we do not consider them country_2 orgs,
		-- because we have chosen other company to be the Country_2 Org for this country_2
        or PARTY_NATURAL_KEY in ('FR|1', 'FR|2', 'CZ|2', 'SI|5', 'DE|10', 'DE|79')
    )
QUALIFY ROW_NUMBER() OVER (PARTITION BY PARTY_NATURAL_KEY ORDER BY RANKING) = 1
;
