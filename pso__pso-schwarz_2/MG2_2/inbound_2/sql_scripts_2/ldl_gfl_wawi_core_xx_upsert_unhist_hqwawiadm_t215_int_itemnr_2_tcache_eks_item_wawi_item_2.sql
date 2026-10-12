TRUNCATE TABLE ${TARGET_DB}.${TGT_TARGET_TABLE};

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PROD_NUM,
        ITEMNO,
        wawi_instanz_kzl,
        ITEMNO_WAWI,
-- FRAMEWORK AND TECHNICAL COLUMNS
        SOURCE_SYSTEM,
        EXTRACTION_DT,
        DWH_MAPPING_TMSP,
        TF_ERROR_FG,
        DELETED_FG,
        RECORD_ID,
        FILENAME,
        DWH_LOAD_ID
)
WITH tmp_t026_wawi_item AS       
(
  SELECT * 
  FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t026_wawi_item_2
  WHERE delete_fg IS NULL 
  QUALIFY ROW_NUMBER() OVER (PARTITION BY itemno ORDER BY seqid DESC) = 1 
)
SELECT
        eh.prod_num,
        eh.itemno,
        ii.wawi_instanz_kzl,
        ii.itemnr,
        'WAWI' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        current_timestamp AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        '${SRC_INPUT_TABLE}' AS FILENAME,
        '${LOAD_ID}' as DWH_LOAD_ID 
FROM
(
    SELECT itemno_ba AS prod_num, itemno_ea AS itemno
    FROM etl.t_tcache_eks_hierarchy_2
    UNION
    SELECT itemno_ba AS prod_num, itemno_sk AS itemno
    FROM etl.t_tcache_eks_hierarchy_2
    UNION
    SELECT itemno_ba AS prod_num, itemno_ba AS itemno
    FROM etl.t_tcache_eks_hierarchy_2
) AS eh
INNER JOIN
(
    SELECT DISTINCT							
        left(wawi_instanz_kzl, 2) as wawi_instanz_kzl
      , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr							
      , Cast(c215_int_itemnr AS Number) AS itemno_int							
    FROM 
      (  
      SELECT 
        src.* 
      FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.${SRC_INPUT_TABLE} src 
      WHERE delete_fg IS NULL

      ) waw 
) AS ii							
ON  eh.itemno = ii.itemno_int							
INNER JOIN tmp_t026_wawi_item AS wi							
ON  eh.prod_num = wi.itemno							
WHERE wi.delete_fg IS NULL
QUALIFY Dense_Rank() OVER (PARTITION BY eh.itemno							
                           ORDER BY wi.seqid DESC) = 1							
;							
