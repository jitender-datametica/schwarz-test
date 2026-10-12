
CREATE OR REPLACE TEMPORARY TABLE ETL.t_ctrcode_map_${LOAD_ID} AS (
    SELECT
        int_org_ctr_cd AS ctrcode_tgt
      , party_nat_key_nr AS ctrcode_src
      , Row_Number() OVER (PARTITION BY party_sid
                          ORDER BY CASE WHEN party_nat_key_nr = int_org_ctr_cd
                                            THEN 0 ELSE 1
                                    END, party_nat_key_nr
                          ) AS ctrcode_rank
    FROM
    (
        SELECT DISTINCT
            pk.party_sid
          , pk.party_nat_key_nr
          , Left(io.int_org_nr, 2) as int_org_ctr_cd
        FROM meta.t_party_key_2 AS pk
        INNER JOIN core_rel.t_internal_organization_2 AS io
        ON  pk.party_sid = io.int_org_sid
        AND pk.dwh_valid_fg
        AND io.dwh_valid_fg
        AND pk.party_key_type_cd = 'COUNTRY_2'
    )
);


INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PARTY_SID,
	PARTY_KEY_TYPE_CD,
        PARTY_NAT_KEY_NR,
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
WITH SELECTED_SRC AS (
SELECT
    PARTY_SID.PARTY_SID AS PARTY_SID,    
    C.CTRCODE_SRC
  , C.CTRCODE_TGT
  , CAST(K.KREDNR AS NUMBER) AS KREDNR
  , K.EXTRACTION_TMSP
FROM ETL.T_WAWI_PRECORE_KREDITOR_2 AS K
INNER JOIN ETL.T_CTRCODE_MAP_${LOAD_ID} AS C
ON  K.CTRCODE = C.CTRCODE_SRC
INNER JOIN META.T_PARTY_KEY_2 PARTY_SID 
ON PARTY_SID.DWH_VALID_FG = TRUE
AND UPPER(PARTY_SID.PARTY_KEY_TYPE_CD) = 'SUPPLIER_2'
AND UPPER(PARTY_SID.PARTY_NAT_KEY_NR) = UPPER(C.CTRCODE_TGT) || '|' || CAST(KREDNR AS NUMBER)
QUALIFY ROW_NUMBER() OVER (PARTITION BY C.CTRCODE_TGT, CAST(K.KREDNR AS NUMBER)
                           ORDER BY C.CTRCODE_RANK) > 1
)

SELECT
        PARTY_SID AS PARTY_SID,
        'SUPPLIER_2' AS PARTY_KEY_TYPE_CD,
        UPPER(CTRCODE_SRC || '|' || CAST(KREDNR AS NUMBER)) AS PARTY_NAT_KEY_NR,
        'WAWI_HQ' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        EXTRACTION_TMSP AS DWH_MAPPING_TMSP, -- TBC
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        'T_${SRC_INPUT_TABLE}' AS FILENAME,
        'WAWI_HQ' AS DWH_NODE_CD,
        '${LOAD_ID}' AS DWH_LOAD_ID 
FROM SELECTED_SRC
;
