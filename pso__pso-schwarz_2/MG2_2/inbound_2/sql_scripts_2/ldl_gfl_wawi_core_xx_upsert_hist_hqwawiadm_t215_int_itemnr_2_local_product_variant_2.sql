-- WAWI_HQ country_2 deduplication mapping table
CREATE TEMPORARY TABLE ETL.t_wawi_instanz_kzl_map AS
(
    SELECT
        Left(com.party_nat_key_nr, 2) AS wawi_instanz_kzl_tgt
      , ctr.party_nat_key_nr AS wawi_instanz_kzl_src
      , Row_Number() OVER (PARTITION BY ctr.party_sid
                          ORDER BY CASE WHEN ctr.party_nat_key_nr = Left(com.party_nat_key_nr, 2)
                                            THEN 0 ELSE 1
                                    END, ctr.party_nat_key_nr
                          ) AS wawi_instanz_kzl_rank
    FROM meta.t_party_key_2 AS ctr
    INNER JOIN meta.t_party_key_2 AS com
    ON  ctr.party_key_type_cd = 'COUNTRY_2'
    AND ctr.party_sid = com.party_sid
    AND com.party_key_type_cd = 'COMPANY'
);

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
   ctrcode
 , PROD_KEY_TYPE_CD
 , INT_ORG_KEY_TYPE_CD
 , PROD_VARIANT_KEY_TYPE_CD
 , LOCAL_PROD_VARIANT_NR
 , LOCAL_PROD_VARIANT_NAME
 , LOCAL_PROD_NR
 , PROD_NR

 , SOURCE_SYSTEM
 , EXTRACTION_DT
 , DWH_MAPPING_TMSP
 , TF_ERROR_FG
 , DELETED_FG
 , RECORD_ID
 , FILENAME
 , DWH_NODE_CD
 , DWH_LOAD_ID
)

-- Extraction/Filter Logic:
SELECT DISTINCT
   iit.wawi_instanz_kzl    AS ctrcode   -- for retrieving the int_org_sid
 , 'CBX'                       AS PROD_KEY_TYPE_CD
 , 'COUNTRY_2'                   AS INT_ORG_KEY_TYPE_CD
 , pv.prod_variant_key_type_cd AS PROD_VARIANT_KEY_TYPE_CD
 , pv.prod_variant_nr          AS LOCAL_PROD_VARIANT_NR
 , pv.prod_variant_name        AS LOCAL_PROD_VARIANT_NAME
 , p.prod_nr                   AS LOCAL_PROD_NR  
 , p.prod_nr                   AS PROD_NR  
  
 , 'CBX'                       AS SOURCE_SYSTEM
 , CURRENT_DATE                AS EXTRACTION_DT
 , iit.extraction_tmsp         AS DWH_MAPPING_TMSP   --<--- added in subquery
 , 0                           AS TF_ERROR_FG
 , 0                           AS DELETED_FG
 , 0                           AS RECORD_ID
 , 't_${SRC_INPUT_TABLE}'      AS FILENAME
 , pv.p_dwh_node_cd            AS DWH_NODE_CD
 , '${LOAD_ID}'                AS DWH_LOAD_ID  
FROM
(
    SELECT 
      t_product_variant.*
    , t_product_variant_key.*
    , t_product_variant.dwh_node_cd AS p_dwh_node_cd
    FROM CORE_REL.t_product_variant_2
    INNER JOIN META.t_product_variant_key_2       
    ON t_product_variant.prod_variant_sid = t_product_variant_key.prod_variant_sid
    AND t_product_variant_key.prod_variant_key_type_cd IN ('CBX_SLS', 'CBX_SLS_UNK', 'CBX_LOG')
    WHERE t_product_variant.dwh_valid_fg
) AS pv
INNER JOIN CORE_REL.t_product_2 AS p
ON  pv.prod_sid = p.prod_sid
AND p.dwh_valid_fg
INNER JOIN
(
    SELECT iit.*
    FROM
    (
        SELECT *
        FROM
        (
            SELECT DISTINCT
                LEFT(wawi_instanz_kzl,2) AS wawi_instanz_kzl
              , extraction_tmsp  --<--- added
              , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
              , Cast(c215_int_itemnr AS Number) AS c215_int_itemnr
            FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t215_int_itemnr_2 SRC
            WHERE delete_fg IS NULL
            QUALIFY Row_Number() OVER (PARTITION BY LEFT( src.wawi_instanz_kzl, 2), src.C215_INT_ITEMNR ORDER BY src.EXTRACTION_TMSP DESC) = 1
            
        )
        QUALIFY Row_Number() OVER (PARTITION BY wawi_instanz_kzl, c215_int_itemnr
                                   /* By NF/CBX product prefer the WAWI item_2 with matching number */
                                   ORDER BY CASE WHEN c215_int_itemnr = itemnr THEN 0 ELSE 1 END
                                            , itemnr
                                  ) = 1
    ) AS iit
    INNER JOIN ETL.t_wawi_instanz_kzl_map AS cm
    ON  iit.wawi_instanz_kzl = cm.wawi_instanz_kzl_src
    QUALIFY Row_Number() OVER (PARTITION BY iit.c215_int_itemnr, cm.wawi_instanz_kzl_tgt ORDER BY cm.wawi_instanz_kzl_rank) = 1
) AS iit
ON  Try_Cast(p.prod_nr AS Number) = iit.c215_int_itemnr
;
