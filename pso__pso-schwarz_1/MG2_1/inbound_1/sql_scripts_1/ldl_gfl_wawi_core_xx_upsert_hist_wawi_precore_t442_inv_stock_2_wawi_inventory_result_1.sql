INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        INV_KEY_TYPE_CD
       ,INV_NATURAL_KEY
       ,WAWI_ITEM_SID
       ,INV_DT
       ,INV_TYPE_CD
       ,INT_ORG_KEY_TYPE_CD
       ,INT_ORG_NATURAL_KEY
       ,INT_ORG_TYPE_CD
       ,COUNTRY_ORG_CD
       ,COUNTRY_ORG_NATURAL_KEY
       ,COUNTRY_ORG_KEY_TYPE_CD
       ,INV_SALES_UNIT_CNT
       ,INV_DIFF_SALES_UNIT_CNT
       ,INV_QTY
       ,INV_DIFF_QTY
       ,UOM_CD
       ,SOURCE_SYSTEM
       ,EXTRACTION_DT
       ,DWH_MAPPING_TMSP
       ,TF_ERROR_FG
       ,DELETED_FG
       ,RECORD_ID
       ,FILENAME
       ,DWH_NODE_CD
       ,DWH_LOAD_ID
)
SELECT  
        'FULL' AS INV_KEY_TYPE_CD,
        src.CTRCODE || '|' || src.WH_NR || '|' || src.C180_ID  AS INV_NATURAL_KEY,
        wawi_itm.WAWI_ITEM_SID,
        C442_DATE AS INV_DT,
        'FULL' AS INV_TYPE_CD,
        'STORE' AS INT_ORG_KEY_TYPE_CD,
        src.CTRCODE || '|' || src.C442_STORENR AS INT_ORG_NATURAL_KEY,
        'STORE' AS INT_ORG_TYPE_CD,
        LEFT(src.ctrcode,2) AS COUNTRY_ORG_CD,
        LEFT(src.ctrcode,2) AS COUNTRY_ORG_NATURAL_KEY,
        'COUNTRY_1' AS COUNTRY_ORG_KEY_TYPE_CD,
        CASE
        WHEN dist_wbf=1 and wawi_itm.weight_based_fg = 0 THEN src.C442_INV_STOCK
        WHEN dist_wbf>1 and decimal_fg=0 THEN src.C442_INV_STOCK
        ELSE NULL
        END AS INV_SALES_UNIT_CNT,
        CASE
        WHEN dist_wbf=1 and wawi_itm.weight_based_fg = 0 THEN src.C442_DIFF
        WHEN dist_wbf>1 and decimal_fg=0 THEN src.C442_DIFF
        ELSE NULL
        END AS INV_DIFF_SALES_UNIT_CNT,
        CASE
        WHEN dist_wbf=1 and wawi_itm.weight_based_fg = 1 THEN src.C442_INV_STOCK
        WHEN dist_wbf>1 and decimal_fg=1 THEN src.C442_INV_STOCK
        ELSE NULL
        END AS INV_QTY,
        CASE
        WHEN dist_wbf=1 and wawi_itm.weight_based_fg = 1 THEN C442_DIFF
        WHEN dist_wbf>1 and decimal_fg=1 THEN src.C442_DIFF
        ELSE NULL
        END AS INV_DIFF_QTY,
        CASE
        WHEN ((dist_wbf=1 and wawi_itm.weight_based_fg = 0) OR (dist_wbf>1 and decimal_fg=0)) THEN NULL
        WHEN ((dist_wbf=1 and wawi_itm.weight_based_fg = 1) OR (dist_wbf>1 and decimal_fg=1))
        AND src.CTRCODE <> 'US' THEN 'KG'
        WHEN ((dist_wbf=1 and wawi_itm.weight_based_fg = 1) OR (dist_wbf>1 and decimal_fg=1))
        AND src.CTRCODE = 'US' THEN 'LB'
        ELSE NULL
        END AS UOM_CD,
        'WAWI_WH' AS SOURCE_SYSTEM,
        src.EXTRACTION_TMSP AS EXTRACTION_DT,
        CURRENT_TIMESTAMP() AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'WAWI_WH' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID 
FROM
(
SELECT 
src.CTRCODE,
f_inv.WH_NR,
f_inv.C180_ID,
src.C442_DATE,
src.C442_STORENR,
src.c442_itemnr,
src.C442_INV_STOCK,
src.C442_DIFF,
src.EXTRACTION_TMSP,
CASE WHEN (src.C442_INV_STOCK<>CAST(src.C442_INV_STOCK AS  INTEGER) or src.C442_DIFF<>CAST(src.C442_DIFF AS  INTEGER)) then 1 else 0 end decimal_fg,
FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}  src   
INNER JOIN ${TEMP_DB}.t_wawi_full_inventory_1 f_inv ON src.ctrcode = f_inv.ctrcode
    --AND src.wh_nr = f_inv.wh_nr excluded due to wh can be updated
    AND src.c442_storenr = f_inv.c180_storenr
    AND src.c442_date = f_inv.c180_inventorydate
) src
INNER JOIN 
(select 
wik.wawi_item_nat_key_nr,wik.wawi_item_sid,
count(distinct wiv.weight_based_fg) as dist_wbf,
any_value(wiv.weight_based_fg) as weight_based_fg  
from  meta.t_wawi_item_key_1 wik    
INNER JOIN core_rel.t_wawi_item_variant_1 wiv ON wiv.dwh_valid_fg
    AND wiv.wawi_item_sid = wik.wawi_item_sid
    AND wik.dwh_valid_fg
    AND wik.wawi_item_key_type_cd='WAWI'
group by wik.wawi_item_nat_key_nr,wik.wawi_item_sid
) wawi_itm
ON wawi_itm.wawi_item_nat_key_nr = src.ctrcode || '|' || TRY_CAST(src.c442_itemnr AS INTEGER)
;
