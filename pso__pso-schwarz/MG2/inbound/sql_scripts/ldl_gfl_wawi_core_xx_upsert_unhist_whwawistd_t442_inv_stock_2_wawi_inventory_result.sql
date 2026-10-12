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
WITH t180 AS
(
   SELECT 
     src.wawi_instanz_kzl,src.wh_nr,src.c180_id,c180_inventorydate,src.c180_storenr,src.c180_inv_flag
   FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawiadm.t180_stinventory src
   JOIN etl_process.t_wawi_extract_control co 
     ON co.schema_name=UPPER('whwawiadm') AND co.table_name=UPPER('t180_stinventory') 
   JOIN etl_process.t_wawi_extract_control_status st 
     ON st.schema_name=UPPER('whwawiadm') AND st.table_name=UPPER('t180_stinventory') AND ai_graph_name='${AI_GRAPH_NAME}'
     AND src.wawi_instanz_kzl=st.wawi_instanz_kzl AND src.wh_nr=st.wh_nr and src.scn>=IFF(co.delta_fg,st.last_scn,0) 
   WHERE delete_fg IS NULL and src.c180_inv_flag = 71 --AND t182.c182_status = 64 Getting all statuses 
   QUALIFY row_number() OVER (PARTITION BY src.wawi_instanz_kzl,src.wh_nr,c180_id ORDER BY extraction_tmsp DESC ) = 1

),
t182 AS
(
   SELECT 
     src.wawi_instanz_kzl,src.wh_nr,src.c182_id,src.c182_status
   FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawiadm.t182_sic_inventory src
   JOIN etl_process.t_wawi_extract_control co 
     ON co.schema_name=UPPER('whwawiadm') AND co.table_name=UPPER('t182_sic_inventory') 
   JOIN etl_process.t_wawi_extract_control_status st 
     ON st.schema_name=UPPER('whwawiadm') AND st.table_name=UPPER('t182_sic_inventory') AND ai_graph_name='${AI_GRAPH_NAME}'
     AND src.wawi_instanz_kzl=st.wawi_instanz_kzl AND src.wh_nr=st.wh_nr and src.scn>=IFF(co.delta_fg,st.last_scn,0) 
   WHERE delete_fg IS NULL
   QUALIFY row_number() OVER (PARTITION BY src.wawi_instanz_kzl,src.wh_nr,c182_id ORDER BY extraction_tmsp DESC ) = 1 

)

SELECT  
        'FULL' AS INV_KEY_TYPE_CD,
        o.country_org_cd || '|' || src.WH_NR || '|' || src.C180_ID  AS INV_NATURAL_KEY,
        wawi_itm.WAWI_ITEM_SID,
        C442_DATE AS INV_DT,
        'FULL' AS INV_TYPE_CD,
        'STORE' AS INT_ORG_KEY_TYPE_CD,
        o.country_org_cd || '|' || src.C442_STORENR AS INT_ORG_NATURAL_KEY,
        'STORE' AS INT_ORG_TYPE_CD,
        o.country_org_cd AS COUNTRY_ORG_CD,
        o.country_org_cd AS COUNTRY_ORG_NATURAL_KEY,
        'COUNTRY' AS COUNTRY_ORG_KEY_TYPE_CD,
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
        AND o.country_org_cd <> 'US' THEN 'KG'
        WHEN ((dist_wbf=1 and wawi_itm.weight_based_fg = 1) OR (dist_wbf>1 and decimal_fg=1))
        AND o.country_org_cd = 'US' THEN 'LB'
        ELSE NULL
        END AS UOM_CD,
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
LEFT(src.wawi_instanz_kzl,2) AS wawi_instanz_kzl,
f_inv.WH_NR,
f_inv.C180_ID,
src.C442_DATE,
src.C442_STORENR,
src.c442_itemnr,
src.C442_INV_STOCK,
src.C442_DIFF,
src.EXTRACTION_TMSP,
CASE WHEN (src.C442_INV_STOCK<>CAST(src.C442_INV_STOCK AS  INTEGER) or src.C442_DIFF<>CAST(src.C442_DIFF AS  INTEGER)) then 1 else 0 end decimal_fg
FROM
(SELECT t442.wawi_instanz_kzl,C442_STORENR,C442_DATE,c442_itemnr,C442_INV_STOCK,C442_DIFF,EXTRACTION_TMSP
FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawistd.t442_inv_stock t442
   JOIN etl_process.t_wawi_extract_control co 
     ON co.schema_name=UPPER('whwawistd') AND co.table_name=UPPER('t442_inv_stock') 
   JOIN etl_process.t_wawi_extract_control_status st 
     ON st.schema_name=UPPER('whwawistd') AND st.table_name=UPPER('t442_inv_stock') AND ai_graph_name='${AI_GRAPH_NAME}'
     AND t442.wawi_instanz_kzl=st.wawi_instanz_kzl AND t442.wh_nr=st.wh_nr and t442.scn>=IFF(co.delta_fg,st.last_scn,0) 
   WHERE delete_fg IS NULL
   QUALIFY row_number() OVER (PARTITION BY t442.wawi_instanz_kzl,t442.c442_storenr,c442_date,C442_ITEMNR ORDER BY t442.extraction_tmsp DESC ) = 1 
) src
INNER JOIN 
     ( SELECT t180.* FROM  t180
       INNER JOIN t182 
        ON t180.wawi_instanz_kzl = t182.wawi_instanz_kzl
           AND t180.wh_nr = t182.wh_nr
           AND t180.c180_id = t182.c182_id
      )
     f_inv ON src.wawi_instanz_kzl = f_inv.wawi_instanz_kzl
    --AND src.wh_nr = f_inv.wh_nr excluded due to wh can be updated
    AND src.c442_storenr = f_inv.c180_storenr
    AND src.c442_date = f_inv.c180_inventorydate
) src
JOIN meta.t_party_key k ON src.wawi_instanz_kzl=k.party_nat_key_nr 
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
ON wawi_itm.wawi_item_nat_key_nr = o.country_org_cd || '|' || TRY_CAST(src.c442_itemnr AS INTEGER)
;


