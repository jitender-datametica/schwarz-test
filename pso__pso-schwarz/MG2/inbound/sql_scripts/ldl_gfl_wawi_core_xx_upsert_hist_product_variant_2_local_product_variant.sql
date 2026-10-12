-- WAWI_HQ country deduplication mapping table (used by CBX, FV, EKS)
CREATE OR REPLACE TEMPORARY TABLE ETL.t_wawi_instanz_kzl_map_${LOAD_ID} AS (
    SELECT
        int_org_ctr_cd AS wawi_instanz_kzl_tgt
      , party_nat_key_nr AS wawi_instanz_kzl_src
      , Row_Number() OVER (PARTITION BY party_sid
                          ORDER BY CASE WHEN party_nat_key_nr = int_org_ctr_cd
                                            THEN 0 ELSE 1
                                    END, party_nat_key_nr
                          ) AS wawi_instanz_kzl_rank
    FROM
    (
        SELECT DISTINCT
            pk.party_sid
          , pk.party_nat_key_nr
          , Left(io.int_org_nr, 2) as int_org_ctr_cd
        FROM meta.t_party_key AS pk
        INNER JOIN core_rel.t_internal_organization AS io
        ON  pk.party_sid = io.int_org_sid
        AND pk.dwh_valid_fg
        AND io.dwh_valid_fg
        AND pk.party_key_type_cd = 'COUNTRY'
    )
);


INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PROD_VARIANT_SID,
        INT_ORG_SID,
        LOCAL_PROD_VARIANT_NR,
        LOCAL_PROD_VARIANT_NAME,
        PROD_SID,
-- FRAMEWORK AND TECHNICAL COLUMNS
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
-- EKS_LOG

WITH EKS_LOG_SEL AS (
        SELECT    
            cm.wawi_instanz_kzl_tgt AS wawi_instanz_kzl
          , k.prod_variant_sid
          , pk2.party_sid
          , pv.prod_sid
          , k.wawi_itemnr
          , art.bez_lang
          , art.deutschtext
          , art.extraction_tmsp
        FROM
        (
            SELECT DISTINCT
                
                prod_variant_sid
              , Cast(Split(prod_variant_nat_key_nr, '|')[0] AS String) AS wawi_instanz_kzl
              , Try_Cast(Cast(Split(prod_variant_nat_key_nr, '|')[1] AS String) AS Number) AS wawi_itemnr   
            FROM META.t_product_variant_key
            WHERE prod_variant_key_type_cd = 'LOG'
              AND dwh_valid_fg
              AND prod_variant_sid IN
                (
                    SELECT prod_variant_sid
                    FROM META.t_product_variant_key AS pvk
                    WHERE prod_variant_key_type_cd IN ('EKS_LOG', 'EKS_LOG_UNK')
                      AND dwh_valid_fg    
                )
        ) AS k
        INNER JOIN CORE_REL.t_product_variant AS pv
        ON  k.prod_variant_sid = pv.prod_variant_sid
        AND pv.dwh_valid_fg
        INNER JOIN  ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel AS art
        ON  k.wawi_instanz_kzl     = art.wawi_instanz_kzl
        AND k.wawi_itemnr = Try_Cast(art.artnrvier AS Number)
        INNER JOIN ETL.t_wawi_instanz_kzl_map_${LOAD_ID} AS cm
        ON  k.wawi_instanz_kzl = cm.wawi_instanz_kzl_src
        INNER JOIN META.T_PARTY_KEY pk2
        ON k.wawi_instanz_kzl = pk2.party_nat_key_nr
        AND pk2.party_key_type_cd = 'COUNTRY'
        AND pk2.dwh_valid_fg = 'TRUE'
        WHERE art.delete_fg IS NULL
        QUALIFY Row_Number() OVER (PARTITION BY k.prod_variant_sid, cm.wawi_instanz_kzl_tgt
                                   ORDER BY cm.wawi_instanz_kzl_rank, art.gueltig_ab DESC NULLS LAST, art.artikelnr) = 1
)
SELECT DISTINCT
        src.prod_variant_sid AS PROD_VARIANT_SID,
        src.party_sid AS INT_ORG_SID,
        src.wawi_itemnr AS LOCAL_PROD_VARIANT_NR,
        Coalesce(src.bez_lang, src.deutschtext) AS LOCAL_PROD_VARIANT_NAME,
        src.prod_sid AS PROD_SID,
        -- FRAMEWORK AND TECHNICAL COLUMNS
        'WAWI' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        CURRENT_TIMESTAMP AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'WAWI_HQ' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID
  FROM EKS_LOG_SEL AS SRC

UNION ALL

-- EKS_SLS
SELECT DISTINCT
        src.prod_variant_sid AS PROD_VARIANT_SID,
        lp.int_org_sid AS INT_ORG_SID,
        src.prod_variant_nr AS LOCAL_PROD_VARIANT_NR,
        src.prod_variant_name AS LOCAL_PROD_VARIANT_NAME,
        src.prod_sid AS PROD_SID,
        -- FRAMEWORK AND TECHNICAL COLUMNS
        'WAWI' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        CURRENT_TIMESTAMP AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'WAWI_HQ' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID
  FROM ${TARGET_DB}.t_${SRC_INPUT_TABLE} AS SRC
INNER JOIN core_rel.t_local_product AS LP
ON  lp.prod_sid = src.prod_sid
WHERE src.prod_variant_sid IN (SELECT prod_variant_sid FROM META.t_product_variant_key WHERE prod_variant_key_type_cd IN ('EKS_SLS', 'EKS_SLS_UNK'))
  AND src.dwh_valid_fg = TRUE
  AND lp.dwh_valid_fg = TRUE
;




