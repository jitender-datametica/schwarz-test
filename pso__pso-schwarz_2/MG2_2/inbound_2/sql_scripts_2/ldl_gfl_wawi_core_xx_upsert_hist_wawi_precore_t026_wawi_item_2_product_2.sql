INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PROD_KEY_TYPE_CD,
	PROD_TYPE_CD,
	ITEM_TYPE_CD,
	PROD_NR,
	PROD_NAME,
	PROD_DESCR,
	PROD_CREATION_DT,
	PACKING_TYPE_CD,
	GOODS_ON_CONSIGNMENT_FG,
	EXCL_FROM_VAT_CALC_FG,
	COUNTRY_SPECIFIC_PROD_FG,
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
SELECT DISTINCT
    'EKS' as PROD_KEY_TYPE_CD,
    'ITEM_2' as PROD_TYPE_CD,
    'FOOD' as ITEM_TYPE_CD,
    wi.itemno as PROD_NR,
    wi.itemdesc as PROD_NAME,
    wi.itemdesc as PROD_DESCR,
    cast( wi.insertdate as DATE) as PROD_CREATION_DT,
    pt.c271_int_short as PACKING_TYPE_CD,
    0 as GOODS_ON_CONSIGNMENT_FG,  -- FALSE
    0 as  EXCL_FROM_VAT_CALC_FG,   -- FALSE
    0 as COUNTRY_SPECIFIC_PROD_FG,  -- FALSE
    'WAWI_HQ' AS SOURCE_SYSTEM,
    wi.extraction_tmsp AS EXTRACTION_DT,
    wi.dwh_updated_tmsp AS DWH_MAPPING_TMSP,
    0 AS TF_ERROR_FG,
    0 AS DELETED_FG,
    0 AS RECORD_ID,
    't_${SRC_INPUT_TABLE}' AS FILENAME,
    'WAWI_HQ' AS DWH_NODE_CD,
    '${LOAD_ID}' as DWH_LOAD_ID 
FROM
(
    SELECT DISTINCT itemno_ba
    FROM ETL.t_wawi_precore_eks_hierarchy_2
) AS ba
INNER JOIN ETL.t_wawi_precore_t026_wawi_item_2 AS wi
ON  ba.itemno_ba = wi.itemno
LEFT OUTER JOIN etl.t_wawi_precore_t271_packagetype_2 AS pt
ON  wi.ctrcode = pt.ctrcode
AND wi.packageid = pt.c271_packnr
;
