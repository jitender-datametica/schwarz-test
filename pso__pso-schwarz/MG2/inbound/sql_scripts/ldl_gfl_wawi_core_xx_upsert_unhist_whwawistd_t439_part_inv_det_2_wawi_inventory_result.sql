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
       ,INV_PROD_REASON_ID
       ,INV_RESULT_STATUS_TYPE_ID
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
WITH t438 AS
(
   SELECT 
     src.* 
   FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawistd.t438_part_inv_head src
   JOIN etl_process.t_wawi_extract_control co 
     ON co.schema_name=UPPER('whwawistd') AND co.table_name=UPPER('t438_part_inv_head') 
   JOIN etl_process.t_wawi_extract_control_status st 
     ON st.schema_name=UPPER('whwawistd') AND st.table_name=UPPER('t438_part_inv_head') AND ai_graph_name='${AI_GRAPH_NAME}'
     AND src.wawi_instanz_kzl=st.wawi_instanz_kzl AND src.wh_nr=st.wh_nr and src.scn>=IFF(co.delta_fg,st.last_scn,0) 
   WHERE delete_fg IS NULL
   QUALIFY row_number() OVER (PARTITION BY src.wawi_instanz_kzl,src.wh_nr,c438_inv_id ORDER BY extraction_tmsp DESC ) = 1

),
t439 AS
(
   SELECT 
     src.* 
   FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawistd.t439_part_inv_det src
   JOIN etl_process.t_wawi_extract_control co 
     ON co.schema_name=UPPER('whwawistd') AND co.table_name=UPPER('t439_part_inv_det') 
   JOIN etl_process.t_wawi_extract_control_status st 
     ON st.schema_name=UPPER('whwawistd') AND st.table_name=UPPER('t439_part_inv_det') AND ai_graph_name='${AI_GRAPH_NAME}'
     AND src.wawi_instanz_kzl=st.wawi_instanz_kzl AND src.wh_nr=st.wh_nr and src.scn>=IFF(co.delta_fg,st.last_scn,0) 
   WHERE delete_fg IS NULL
   QUALIFY row_number() OVER (PARTITION BY src.wawi_instanz_kzl,src.wh_nr,c439_inv_id ORDER BY extraction_tmsp DESC ) = 1 

)
SELECT  
       'PART' AS INV_KEY_TYPE_CD,
        o.country_org_cd || '|' || src.WH_NR || '|' || src.C438_INV_ID  AS INV_NATURAL_KEY,
        wawi_itm.WAWI_ITEM_SID,
        C438_INVENTORYDATE AS INV_DT,
        'PART' AS INV_TYPE_CD,
        'STORE' AS INT_ORG_KEY_TYPE_CD,
        o.country_org_cd || '|' || src.C438_STORENR AS INT_ORG_NATURAL_KEY,
        'STORE' AS INT_ORG_TYPE_CD,
        o.country_org_cd AS COUNTRY_ORG_CD,
        o.country_org_cd AS COUNTRY_ORG_NATURAL_KEY,
        'COUNTRY' AS COUNTRY_ORG_KEY_TYPE_CD,
        --Workaround has been applied for unit_cnt and qty fields. if we have multiple weight_based_fg for the item we try to find out using the stock information to distinguish whether the stock weight based or not. 
        CASE
        WHEN dist_wbf=1 and wawi_itm.weight_based_fg = 0 THEN src.c439_count_stock
        WHEN dist_wbf>1 and decimal_fg=0 THEN src.c439_count_stock
        ELSE NULL
        END AS INV_SALES_UNIT_CNT,
        CASE
        WHEN dist_wbf=1 and wawi_itm.weight_based_fg = 0 THEN src.c439_count_stock - src.c439_calc_stock
        WHEN dist_wbf>1 and decimal_fg=0 THEN src.c439_count_stock - src.c439_calc_stock
        ELSE NULL
        END AS INV_DIFF_SALES_UNIT_CNT,
        CASE
        WHEN dist_wbf=1 and wawi_itm.weight_based_fg = 1 THEN src.c439_count_stock
        WHEN dist_wbf>1 and decimal_fg=1 THEN src.c439_count_stock
        ELSE NULL
        END AS INV_QTY,
        CASE
        WHEN dist_wbf=1 and wawi_itm.weight_based_fg = 1 THEN src.c439_count_stock - src.c439_calc_stock
        WHEN dist_wbf>1 and decimal_fg=1 THEN src.c439_count_stock - src.c439_calc_stock
        ELSE NULL
        END AS INV_DIFF_QTY,
        CASE
        WHEN ((dist_wbf=1 and wawi_itm.weight_based_fg = 0) OR (dist_wbf>1 and decimal_fg=0)) THEN NULL
        WHEN ((dist_wbf=1 and wawi_itm.weight_based_fg = 1) OR (dist_wbf>1 and decimal_fg=1))
        AND src.wawi_instanz_kzl <> 'US' THEN 'KG'
        WHEN ((dist_wbf=1 and wawi_itm.weight_based_fg = 1) OR (dist_wbf>1 and decimal_fg=1))
        AND src.wawi_instanz_kzl = 'US' THEN 'LB'
        ELSE NULL
        END AS UOM_CD,
        CASE 
        WHEN (src.C439_ADD_REASON between 10 and 60 or src.C439_ADD_REASON>=63) THEN -2
        ELSE src.C439_ADD_REASON
        END AS INV_PROD_REASON_ID,
        src.C439_COUNTFLAG AS INV_RESULT_STATUS_TYPE_CD,
        'WAWI_WH' AS SOURCE_SYSTEM,
        src.EXTRACTION_TMSP AS EXTRACTION_DT,
        CURRENT_TIMESTAMP() AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        '${SRC_INPUT_TABLE}' AS FILENAME,
        'WAWI_WH' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID 
FROM
(
SELECT 
src.wawi_instanz_kzl,
src.WH_NR,
src_438.C438_INV_ID,
src_438.C438_INVENTORYDATE,
src_438.C438_STORENR,
src.c439_itemnr,
src.c439_count_stock,
src.c439_calc_stock,
src.C439_ADD_REASON,
src.C439_COUNTFLAG,
src.EXTRACTION_TMSP,
CASE WHEN (src.c439_count_stock<>CAST(src.c439_count_stock AS  INTEGER) or src.c439_calc_stock<>CAST(src.c439_calc_stock AS  INTEGER)) then 1 else 0 end decimal_fg --Based on decimal stock we find out weight_based_fg as a workaround
FROM  t439  src   
INNER JOIN t438 src_438
    ON src_438.wawi_instanz_kzl = src.wawi_instanz_kzl
    AND src_438.wh_nr = src.wh_nr
    AND src_438.c438_inv_id = src.c439_inv_id
) src
JOIN meta.t_party_key k ON LEFT(src.wawi_instanz_kzl,2)=k.party_nat_key_nr 
                           AND k.dwh_valid_fg 
                           AND k.party_key_type_cd='COUNTRY'
JOIN core_rel.t_internal_organization  o ON k.party_sid=o.int_org_sid AND o.dwh_valid_fg
INNER JOIN 
(select 
wik.wawi_item_nat_key_nr,wik.wawi_item_sid,
count(distinct wiv.weight_based_fg) as dist_wbf,
any_value(wiv.weight_based_fg) as weight_based_fg  
from  meta.t_wawi_item_key wik    
INNER JOIN core_rel.t_wawi_item_variant wiv ON wiv.dwh_valid_fg
    AND wiv.wawi_item_sid = wik.wawi_item_sid
    AND wik.dwh_valid_fg
    AND wik.wawi_item_key_type_cd='WAWI'
group by wik.wawi_item_nat_key_nr,wik.wawi_item_sid
) wawi_itm
ON wawi_itm.wawi_item_nat_key_nr = o.country_org_cd || '|' || CAST(src.c439_itemnr AS INTEGER)

;
