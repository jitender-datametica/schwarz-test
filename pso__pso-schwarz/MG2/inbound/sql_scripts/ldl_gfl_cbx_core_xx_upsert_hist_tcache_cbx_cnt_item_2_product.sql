INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        PROD_KEY_TYPE_CD,
        PROD_TYPE_CD,
        ITEM_TYPE_CD,
        PROD_NR,
        PROD_NAME,
        PROD_DESCR,
        PROD_CREATION_DT,
        /* BRAND_NAME, */
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
    'CBX' as PROD_KEY_TYPE_CD,
    'ITEM' as PROD_TYPE_CD,
    'NON FOOD' as ITEM_TYPE_CD,
    src.item_no as PROD_NR,
    SUBSTRING(src.short_desc,1,100) as PROD_NAME,
    SUBSTRING(src.item_desc, 1, 250) as PROD_DESCR,
    cast( src.updated_on as date) as PROD_CREATION_DT,
    /* src.ldl_brand as BRAND_NAME, */
    src.ldl_packing_type as PACKING_TYPE_CD,
    0 as GOODS_ON_CONSIGNMENT_FG,  -- FALSE
    0 as  EXCL_FROM_VAT_CALC_FG,   -- FALSE
    COUNTRY_SPECIFIC_PROD_FG,
    'CBX' AS SOURCE_SYSTEM,
    CURRENT_DATE AS EXTRACTION_DT,
    src.updated_on AS DWH_MAPPING_TMSP,
    0 AS TF_ERROR_FG,
    0 AS DELETED_FG,
    0 AS RECORD_ID,
    't_${SRC_INPUT_TABLE}' AS FILENAME,
    'CBX' AS DWH_NODE_CD,
    '${LOAD_ID}' as DWH_LOAD_ID 
FROM --${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
(select 
item_no 
,min (created_on) as prod_creation_dt
,short_desc 
,item_desc 
,ldl_packing_type 
--,case when ldl_lot_no = 9999 then TRUE else FALSE end country_specific_prod_fg
,FALSE country_specific_prod_fg
,ldl_brand
,MAX(updated_on) as updated_on 
from ${TEMP_DB}.t_${SRC_INPUT_TABLE} 
where item_no != '0'
group by item_no ,short_desc ,item_desc ,ldl_packing_type ,country_specific_prod_fg ,ldl_brand) SRC
--qualify ROW_NUMBER() OVER (PARTITION BY item_no, short_desc, item_desc, PROD_CREATION_DT ORDER BY updated_on desc) = 1
UNION ALL
SELECT DISTINCT 
    'CBX_CANCELED' as PROD_KEY_TYPE_CD,
    'ITEM' as PROD_TYPE_CD,
    'NON FOOD' as ITEM_TYPE_CD,
    src.ref_no as PROD_NR,
    SUBSTRING(src.short_desc,1,100) as PROD_NAME,
    SUBSTRING(src.item_desc, 1, 250) as PROD_DESCR,
    cast( src.updated_on as date) as PROD_CREATION_DT,
    /* src.ldl_brand as BRAND_NAME, */
    src.ldl_packing_type as PACKING_TYPE_CD,
    0 as GOODS_ON_CONSIGNMENT_FG,  -- FALSE
    0 as  EXCL_FROM_VAT_CALC_FG,   -- FALSE
    case when src.ldl_lot_no = 9999 then 1 -- TRUE
         else 0 -- FALSE
     end as COUNTRY_SPECIFIC_PROD_FG,
    'CBX' AS SOURCE_SYSTEM,
    CURRENT_DATE AS EXTRACTION_DT,
    src.updated_on AS DWH_MAPPING_TMSP,
    0 AS TF_ERROR_FG,
    0 AS DELETED_FG,
    0 AS RECORD_ID,
    't_${SRC_INPUT_TABLE}' AS FILENAME,
    'CBX' AS DWH_NODE_CD,
    '${LOAD_ID}' as DWH_LOAD_ID 
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
WHERE src.item_no = '0'
qualify ROW_NUMBER() OVER (PARTITION BY item_no, short_desc, item_desc, PROD_CREATION_DT ORDER BY updated_on desc) = 1
;
