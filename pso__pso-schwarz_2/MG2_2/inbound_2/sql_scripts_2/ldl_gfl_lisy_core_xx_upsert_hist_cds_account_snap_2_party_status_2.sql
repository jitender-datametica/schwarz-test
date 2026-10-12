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
/*
The source is the same as source for T_INTERNAL_ORGANIZATION_2, so there is no point for negative key capture.
Keys were generated in the previous step when we loaded T_INTERNAL_ORGANIZATION.

We join the source with the key table to find if we need to group several buildings into one organization
and calcualte the first opening date  and last closing dat

Date for status_2 ""Planned"" was the first date of extraction when we get source with the following conditions:
     igl_expectedopeningdate is not null 
     and igl_neodate is null 
     and igl_closingdate is null
Each day we get a source with these conditions we will get bigger min(sinkmodifiedon) but the ETL framework will not overwrite the status_2 ""Planned""
with the bigger date so we are fine.
Once we move to other status_2 (ACTIVE/INACTIVE) we will not use the ""sinkmodifiedon"" so we are fine again.

Bottom line - this is ""the source"" data set
*/
WITH 
SELECTED_SET AS
(
    SELECT *
    FROM etl_process.t_tcache_lisy_cds_account_snap_2 
    WHERE 1=1
        AND IGL_ACCOUNTTYPECODE IN (285540000, 285540009) -- real estate associated with stores and special sale stores
        AND IGL_NUMBER IS NOT NULL -- only objects with assigned object number 
        AND (IGL_EXPECTEDOPENINGDATE IS NOT NULL OR IGL_NEODATE IS NOT NULL OR IGL_CLOSINGDATE IS NOT NULL)
        AND DELETED <> 'x'
),
        SRC AS
        (SELECT 
            K.PARTY_SID AS PARTY_SID,
            MIN(SELECTED_SET.IGL_ISOCODE2) AS IGL_ISOCODE2, 
            MIN(SELECTED_SET.IGL_EXPECTEDOPENINGDATE) AS IGL_EXPECTEDOPENINGDATE,
            MIN(SELECTED_SET.SINKMODIFIEDON) AS STATUS_DATE, -- meaningful only for PLAN status. The other statuses have their own date.
            MIN(SELECTED_SET.IGL_NEODATE) AS IGL_NEODATE,
            MAX(SELECTED_SET.IGL_CLOSINGDATE) AS IGL_CLOSINGDATE
        FROM SELECTED_SET
            INNER JOIN META.T_PARTY_KEY_2 K
                    ON K.PARTY_NAT_KEY_NR =  UPPER(SUBSTR(SELECTED_SET.IGL_NUMBER, 1, 2)) ||'|'||TO_NUMBER(SUBSTR(SELECTED_SET.IGL_NUMBER,3,5)) 
                    AND K.PARTY_KEY_TYPE_CD = 'STORE'
        GROUP BY K.PARTY_SID
        )
SELECT
        SRC.PARTY_SID,
        CASE
            WHEN SRC.IGL_ISOCODE2 IN ('AL', 'BA', 'ME', 'MK', 'XK') THEN 'PRE-PROCESS'
            WHEN (SRC.IGL_EXPECTEDOPENINGDATE IS NOT NULL AND SRC.IGL_NEODATE IS NULL AND SRC.IGL_CLOSINGDATE IS NULL) THEN 'PLAN'
            WHEN (SRC.IGL_NEODATE IS NOT NULL AND (SRC.IGL_CLOSINGDATE IS NULL OR SRC.IGL_CLOSINGDATE > CURRENT_TIMESTAMP)) THEN 'ACTIVE'
            WHEN (SRC.IGL_CLOSINGDATE IS NOT NULL AND SRC.IGL_CLOSINGDATE < CURRENT_TIMESTAMP) THEN 'INACTIVE'
        END AS PARTY_STATUS_TYPE_CD,
        'INT_ORG' AS PARTY_TYPE_CD,
        CASE
                WHEN SRC.IGL_EXPECTEDOPENINGDATE IS NOT NULL AND SRC.IGL_NEODATE IS NULL AND SRC.IGL_CLOSINGDATE IS NULL THEN SRC.STATUS_DATE
                WHEN SRC.IGL_NEODATE IS NOT NULL AND SRC.IGL_CLOSINGDATE IS NULL THEN SRC.IGL_NEODATE
                WHEN SRC.IGL_CLOSINGDATE IS NOT NULL THEN SRC.IGL_CLOSINGDATE
        END AS DWH_MAPPING_TMSP,
        'LISY' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_tcache_lisy_cds_account_snap_2' AS FILENAME,
        'LISY' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID 
FROM  SRC
;
