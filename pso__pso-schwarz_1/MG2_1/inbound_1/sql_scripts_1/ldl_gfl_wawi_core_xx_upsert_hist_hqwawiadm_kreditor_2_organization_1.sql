-- WAWI_HQ country_1 deduplication mapping table (used by CBX, FV, EKS)
CREATE OR REPLACE TEMPORARY TABLE ETL.T_wawi_instanz_kzl_MAP_${LOAD_ID} AS (
    SELECT
        INT_ORG_CTR_CD AS wawi_instanz_kzl_TGT
      , PARTY_NAT_KEY_NR AS wawi_instanz_kzl_SRC
      , ROW_NUMBER() OVER (PARTITION BY PARTY_SID
                          ORDER BY CASE WHEN PARTY_NAT_KEY_NR = INT_ORG_CTR_CD
                                            THEN 0 ELSE 1
                                    END, PARTY_NAT_KEY_NR
                          ) AS wawi_instanz_kzl_RANK
    FROM
    (
        SELECT DISTINCT
            PK.PARTY_SID
          , PK.PARTY_NAT_KEY_NR
          , LEFT(IO.INT_ORG_NR, 2) AS INT_ORG_CTR_CD
        FROM META.T_PARTY_KEY_1 AS PK
        INNER JOIN CORE_REL.T_INTERNAL_ORGANIZATION_1 AS IO
        ON  PK.PARTY_SID = IO.INT_ORG_SID
        AND PK.DWH_VALID_FG
        AND IO.DWH_VALID_FG
        AND PK.PARTY_KEY_TYPE_CD = 'COUNTRY_1'
    )
);


INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
	ORG_NAT_KEY_NR,
        ORG_KEY_TYPE_CD,
	ORG_TYPE_CD,
	ORG_NAME,
	LEGAL_NAME,
	VAT_NR,
	IS_SUP_FG,
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
    C.wawi_instanz_kzl_TGT
  , CAST(K.KREDNR AS NUMBER) AS KREDNR
  , K.SUCHNAME
  , '' NAME1 -- K.NAME1
  , K.TAX_KEY
  , K.EXTRACTION_TMSP
FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.kreditor_1 AS K
INNER JOIN ETL.T_wawi_instanz_kzl_MAP_${LOAD_ID} AS C
ON  LEFT(K.wawi_instanz_kzl,2) = C.wawi_instanz_kzl_SRC
WHERE delete_fg IS NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY C.wawi_instanz_kzl_TGT, CAST(K.KREDNR AS NUMBER)
                           ORDER BY C.wawi_instanz_kzl_RANK) = 1
)

SELECT DISTINCT
       wawi_instanz_kzl_TGT || '|' || CAST(KREDNR AS NUMBER) AS ORG_NAT_KEY_NR,
       'SUPPLIER_1' AS ORG_KEY_TYPE_CD,
       'COMPANY' AS ORG_TYPE_CD,
       SUCHNAME AS ORG_NAME,
       NAME1 AS LEGAL_NAME,
       TAX_KEY AS VAT_NR,
       TRUE AS IS_SUP_FG,
       'WAWI_HQ' AS SOURCE_SYSTEM,
       EXTRACTION_TMSP AS EXTRACTION_DT,
       EXTRACTION_TMSP AS DWH_MAPPING_TMSP,
       0 AS TF_ERROR_FG,
       0 AS DELETED_FG,
       0 AS RECORD_ID,
       'T_${SRC_INPUT_TABLE}' AS FILENAME,
       'WAWI_HQ' AS DWH_NODE_CD,
       '${LOAD_ID}' AS DWH_LOAD_ID  
FROM SELECTED_SRC;
