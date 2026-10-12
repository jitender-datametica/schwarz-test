INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(       prod_variant_nr,
        prod_variant_key_type_cd,
        prod_nr,
        prod_key_type_cd,
        prod_variant_name,
        prod_variant_type_cd,
        weight_based_fg,
        logistic_variant_type_cd,
        case_size_cnt,
        gtin,
        sales_variant_type_cd,
        sales_variant_content_meas,
        unit_cnt,
        unit_content_meas,
        content_uom_cd,
        non_food_variant_type_cd,
        size_name,
        style_name,
        kind_name,
        fruits_and_vegetables_class_cd,
        min_caliber_meas,
        max_caliber_meas,
        caliber_uom_cd,
  --      country_of_origin_sid,
        extraction_dt,
        dwh_mapping_tmsp,
        tf_error_fg,
        deleted_fg,
        record_id,
        filename,
        dwh_node_cd,
        dwh_load_id )
WITH t026 AS   
    ( 
     SELECT * FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t026_wawi_item_1
     WHERE delete_fg IS NULL
     QUALIFY ROW_NUMBER() OVER (PARTITION BY itemno ORDER BY seqid DESC) = 1
    ),
eks_item AS (
    SELECT
        itemno
      , CASE bitflag WHEN 0 THEN 1 /*EA*/ 
                     WHEN 4 THEN 2 /*SK*/
                     WHEN 2 THEN 3 /*BA*/
        END AS hier_level
    FROM t026
) ,
eks_dep AS (
    SELECT
        d.wawi_instanz_kzl
      , d.extraction_tmsp
      , d.seqid
      , d.itemno_head
      , i2.hier_level  AS level_head
      , d.itemno_detail
      , i1.hier_level  AS level_detail
      , d.posno
      , d.quantity
      , d.transferdate
      , d.transferflag
      , d.action_flag
      , d.location_1
      , d.scn
      , CASE WHEN i1.hier_level = 1 AND i2.hier_level = 2 THEN 'EA-SK'
             WHEN i1.hier_level = 1 AND i2.hier_level = 3 THEN 'EA-BA'
             WHEN i1.hier_level = 2 AND i2.hier_level = 3 THEN 'SK-BA'
        END AS dep_descr
    FROM
    (
        /* Keep source data per Item_1 pair with the most recent SeqID */
        SELECT s.*
        FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t024_wawi_item_dep_1 AS s
        WHERE delete_fg IS NULL
        QUALIFY Row_Number() OVER (PARTITION BY s.itemno_head, s.itemno_detail ORDER BY s.seqid DESC) = 1
    ) AS d
    INNER JOIN eks_item AS i1
    ON  d.itemno_detail = i1.itemno
    INNER JOIN eks_item AS i2
    ON  d.itemno_head = i2.itemno
    AND i1.hier_level < i2.hier_level
    QUALIFY (dep_descr = 'EA-SK' AND d.seqid = Max(d.seqid) OVER (PARTITION BY d.itemno_head, dep_descr))
         OR (dep_descr IN ('EA-BA', 'SK-BA') AND Row_Number() OVER (PARTITION BY i1.itemno, dep_descr ORDER BY d.seqid DESC) = 1)
),
t024_1 AS (
SELECT d1.*
FROM eks_dep AS d1
LEFT OUTER JOIN eks_dep AS d2
ON  d1.dep_descr = 'EA-SK'
AND d2.dep_descr = 'SK-BA'
AND d1.itemno_head = d2.itemno_detail
QUALIFY d1.dep_descr <> 'EA-SK'
     /* Verify EA-SK dependencies additionally using the BA (product), use only most recent BA. */
     OR FIRST_VALUE(d2.itemno_head) IGNORE NULLS OVER (PARTITION BY d1.itemno_detail ORDER BY d2.seqid DESC) = d2.itemno_head
)
SELECT
        h.itemno_ea as prod_variant_nr,
        'EKS_SLS', 
        h.itemno_ba as product_nr,
        'EKS',
        src.itemdesc as prod_variant_name,
        'SALES_1' AS prod_variant_type_cd,
        NULL AS weight_based_fg,
        NULL AS logistic_variant_type_cd,
        NULL AS case_size_cnt,
        ean.ean_1 as gtin,
        'FOOD' AS sales_variant_type_cd,
        src.bundlefact*src.volume as sales_variant_content_meas,
        src.bundlefact as unit_cnt,
        src.volume as unit_content_meas,
        null as  content_uom_cd,
        null as  non_food_variant_type_cd,
        null as  size_name,
        null as  style_name,
        null as  kind_name,
        null as  fruits_and_vegetables_class_cd,
        null as  min_caliber_meas,
        null as  max_caliber_meas,
        null as  caliber_uom_cd,
  --      null as  country_of_origin_sid,
        src.extraction_tmsp as extraction_dt,
        src.extraction_tmsp as dwh_mapping_tmsp,
        0 as tf_error_fg,
        0 as deleted_fg,
        0 as record_id,
        't_${SRC_INPUT_TABLE}' AS filename,
        'WAWI_HQ' AS dwh_node_cd,
        '${LOAD_ID}' as dwh_load_id 
FROM 
(
    SELECT DISTINCT itemno_ea, itemno_ba
    FROM etl.t_tcache_eks_hierarchy_1
) AS h
INNER JOIN t026 AS src
ON  h.itemno_ea = src.itemno
LEFT OUTER JOIN
(
    SELECT itemno, ean_1
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t029_wawi_item_ean_1
    WHERE delete_fg IS NULL
    QUALIFY Row_Number() OVER (PARTITION BY itemno ORDER BY ean_1) = 1
) AS ean_1
ON h.itemno_ea = ean.itemno
qualify row_number() over (partition by  h.itemno_ea order by  h.itemno_ba)=1
UNION ALL
SELECT
        src.itemno as prod_variant_nr,
        'EKS_SLS_UNK', 
        src.itemno as product_nr,
        'EKS',
        src.itemdesc as prod_variant_name,
        'SALES_1' as prod_variant_type_cd,
        null as weight_based_fg,
        null as logistic_variant_type_cd,
        null as case_size_cnt,
        null as gtin,
        'FOOD' as sales_variant_type_cd,
        null as sales_variant_content_meas,
        null as unit_cnt,
        null as unit_content_meas,
        null as  content_uom_cd,
        null as  non_food_variant_type_cd,
        null as  size_name,
        null as  style_name,
        null as  kind_name,
        null as  fruits_and_vegetables_class_cd,
        null as  min_caliber_meas,
        null as  max_caliber_meas,
        null as  caliber_uom_cd,
       -- null as  country_of_origin_sid,
        src.extraction_tmsp as extraction_dt,
        src.extraction_tmsp as dwh_mapping_tmsp,
        0 as tf_error_fg,
        0 as deleted_fg,
        0 as record_id,
        't_${SRC_INPUT_TABLE}' as filename,
        'WAWI_HQ' as dwh_node_cd,
        '${LOAD_ID}' as dwh_load_id 
FROM 
(
    select distinct  itemno_ba
    FROM etl.t_tcache_eks_hierarchy_1
    where itemno_ba <> itemno_ea
) as h
inner join t026 as src
on  h.itemno_ba = src.itemno

UNION ALL

SELECT
        itemno_sk as prod_variant_nr,
        'EKS_LOG', 
        itemno_ba as product_nr,
        'EKS',
        src.itemdesc as prod_variant_name,
        'LOGISTIC' AS prod_variant_type_cd,
        null as weight_based_fg,
        logistic_variant_type_cd as logistic_variant_type_cd,
        coalesce(quantity, casesize, 1) as case_size_cnt,
        null as gtin,
        'FOOD' AS sales_variant_type_cd,
        null as sales_variant_content_meas,
        null as unit_cnt,
        null as unit_content_meas,
        null as  content_uom_cd,
        null as  non_food_variant_type_cd,
        null as  size_name,
        null as  style_name,
        null as  kind_name,
        null as  fruits_and_vegetables_class_cd,
        null as  min_caliber_meas,
        null as  max_caliber_meas,
        null as  caliber_uom_cd,
       -- null as  country_of_origin_sid,
        src.extraction_tmsp as extraction_dt,
        src.extraction_tmsp as dwh_mapping_tmsp,
        0 as tf_error_fg,
        0 as deleted_fg,
        0 as record_id,
        't_${SRC_INPUT_TABLE}' as filename,
        'WAWI_HQ' as dwh_node_cd,
        '${LOAD_ID}' as dwh_load_id 
from
(
    select
        itemno_sk
      , case when sum(case when itemno_sk = itemno_ea then 1 else 0 end) >= 1
                 then 'SINGLE'
                 else 'MIXED'
        end as logistic_variant_type_cd
      , max(itemno_ba) as itemno_ba
    FROM etl.t_tcache_eks_hierarchy_1
    group by 1
) as sk
inner join t026 as src
on  sk.itemno_sk = src.itemno
left outer join
(
    select itemno_head, sum(quantity) as quantity
    FROM t024_1
    where level_head = 2
    group by 1
) as mqty
on  sk.itemno_sk = mqty.itemno_head

UNION ALL

SELECT
        itm.itemno as prod_variant_nr,
        'EKS_LOG_UNK',
        itm.itemno as product_nr,
        'EKS',
        itm.itemdesc as prod_variant_name,
        'LOGISTIC' AS prod_variant_type_cd,
        null as weight_based_fg,
        'SINGLE' as logistic_variant_type_cd,
        1 as case_size_cnt,
        null as gtin,
        'FOOD' AS sales_variant_type_cd,
        null as sales_variant_content_meas,
        null as unit_cnt,
        null as unit_content_meas,
        null as  content_uom_cd,
        null as  non_food_variant_type_cd,
        null as  size_name,
        null as  style_name,
        null as  kind_name,
        null as  fruits_and_vegetables_class_cd,
        null as  min_caliber_meas,
        null as  max_caliber_meas,
        null as  caliber_uom_cd,
       -- null as  country_of_origin_sid,
        itm.extraction_tmsp as extraction_dt,
        itm.extraction_tmsp as dwh_mapping_tmsp,
        0 as tf_error_fg,
        0 as deleted_fg,
        0 as record_id,
        't_${SRC_INPUT_TABLE}' as filename,
        'WAWI_HQ' as dwh_node_cd,
        '${LOAD_ID}' as dwh_load_id
FROM
(
    SELECT DISTINCT itemno_ba AS prod_num
    FROM etl.t_tcache_eks_hierarchy_1
    WHERE itemno_ba <> itemno_ea
) AS nr
INNER JOIN t026 AS itm
ON  nr.prod_num = itm.itemno
;


