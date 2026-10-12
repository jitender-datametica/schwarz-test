TRUNCATE TABLE ${TARGET_DB}.${TGT_TARGET_TABLE};

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PROD_NUM,
        ITEMNO,
        CTRCODE,
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
SELECT
        eh.prod_num,
        eh.itemno,
        ii.ctrcode,
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
    FROM ETL.t_wawi_precore_eks_hierarchy
    UNION
    SELECT itemno_ba AS prod_num, itemno_sk AS itemno
    FROM ETL.t_wawi_precore_eks_hierarchy
    UNION
    SELECT itemno_ba AS prod_num, itemno_ba AS itemno
    FROM ETL.t_wawi_precore_eks_hierarchy
) AS eh
INNER JOIN
(
    SELECT DISTINCT							
        left(src.ctrcode, 2) as ctrcode
      , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr							
      , Cast(c215_int_itemnr AS Number) AS itemno_int							
    FROM ETL.t_wawi_precore_t215_int_itemnr src
    INNER JOIN ETL.WAWI_CONTROL_TABLE ctrl
    ON  ctrl.SOURCE_TABLE_NAME = UPPER('${TEMP_DB}.${SRC_INPUT_TABLE}')
    AND ctrl.SOURCE_STATUS = 'A'
    AND src.EXTRACTION_TMSP between ctrl.BEGIN_TMSP and ctrl.END_TMSP							
) AS ii							
ON  eh.itemno = ii.itemno_int							
INNER JOIN ETL.t_wawi_precore_t026_wawi_item AS wi							
ON  eh.prod_num = wi.itemno							
QUALIFY Dense_Rank() OVER (PARTITION BY eh.itemno							
                           ORDER BY wi.seqid DESC) = 1							
;							
