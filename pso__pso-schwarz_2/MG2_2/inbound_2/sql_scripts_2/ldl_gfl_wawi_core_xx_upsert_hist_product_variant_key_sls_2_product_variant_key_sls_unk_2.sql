INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PROD_VARIANT_SID,
        PROD_VARIANT_KEY_TYPE_CD,
        PROD_VARIANT_NAT_KEY_NR,
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
/* WAW SLS_UNK */
SELECT DISTINCT  
        ky.prod_variant_sid AS PROD_VARIANT_SID,
        'SLS_UNK' AS PROD_VARIANT_KEY_TYPE_CD,
        UPPER(LEFT(art.wawi_instanz_kzl,2) || '|' || art.itemnr) AS PROD_VARIANT_NAT_KEY_NR,
        'WAWI' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        CURRENT_TIMESTAMP AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'WAWI_HQ' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID
FROM
(
    SELECT a.*
      , Cast(artnrvier AS Number) AS itemnr
    FROM  ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel_2 AS a
    WHERE delete_fg IS NULL
    QUALIFY Row_Number() OVER (PARTITION BY wawi_instanz_kzl, itemnr ORDER BY artikelnr) = 1
) AS art_2
LEFT OUTER JOIN
(
    SELECT DISTINCT
        wawi_instanz_kzl
      , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
      , Cast(c215_int_itemnr AS Number) AS c215_int_itemnr
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t215_int_itemnr_2
    WHERE delete_fg IS NULL
) AS ii
ON  art.wawi_instanz_kzl = ii.wawi_instanz_kzl
AND art.itemnr = ii.itemnr
LEFT OUTER JOIN meta.t_product_key_2 AS ipk
ON  Cast(ii.c215_int_itemnr AS String) = ipk.prod_nat_key_nr
AND ipk.prod_key_type_cd IN ('CBX', 'FV')
AND ipk.dwh_valid_fg
LEFT OUTER JOIN
(
    SELECT DISTINCT itemno
    FROM etl.t_tcache_eks_item_wawi_item_2
) AS eks
ON  ii.c215_int_itemnr = eks.itemno
inner join meta.t_${SRC_INPUT_TABLE} as ky
--inner join meta.t_product_variant_key_2 as ky
on ky.prod_variant_key_type_cd = 'WAW_SLS'
  and ky.PROD_VARIANT_NAT_KEY_NR = UPPER(LEFT(art.wawi_instanz_kzl,2) || '|' || art.itemnr)
  AND ky.dwh_valid_fg = TRUE
WHERE
(
    ii.itemnr IS NULL /* No link to international item_2 number */
    OR
    (
      ipk.prod_sid IS NULL /* International number not found in international keys */
        AND eks.itemno IS NULL
    )
) 
  
