INSERT INTO ldl_data_production_$_1{temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
        prod_variant_nr,
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
        -- country_of_origin_sid,
        extraction_dt,
        dwh_mapping_tmsp,
        tf_error_fg,
        deleted_fg,
        record_id,
        filename,
        dwh_node_cd,
        dwh_load_id
)
WITH t026 AS
(
     SELECT *
     FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t026_wawi_item_1
     WHERE delete_fg IS NULL
     QUALIFY ROW_NUMBER() OVER (PARTITION BY itemno ORDER BY seqid DESC) = 1
),
eks_item AS (
    SELECT
        itemno,
        CASE bitflag WHEN 0 THEN 1 /*EA*/ 
                     WHEN 4 THEN 2 /*SK*/
                     WHEN 2 THEN 3 /*BA*/
        END AS hier_level
    FROM t026
),
eks_dep AS (
    SELECT
        d.wawi_instanz_kzl,
        d.extraction_tmsp,
        d.seqid,
        d.itemno_head,
        i2.hier_level AS level_head,
        d.itemno_detail,
        i1.hier_level AS level_detail,
        d.posno,
        d.quantity,
        d.transferdate,
        d.transferflag,
        d.action_flag,
        d.location_1,
        d.scn,
        CASE
            WHEN i1.hier_level = 1 AND i2.hier_level = 2 THEN 'EA-SK'
            WHEN i1.hier_level = 1 AND i2.hier_level = 3 THEN 'EA-BA'
            WHEN i1.hier_level = 2 AND i2.hier_level = 3 THEN 'SK-BA'
        END AS dep_descr
    FROM
    (
        -- Keep source data per Item_1 pair with the most recent SeqID
        SELECT s.*
        FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t024_wawi_item_dep_1 AS s
        WHERE delete_fg IS NULL
        QUALIFY ROW_NUMBER() OVER (PARTITION BY s.itemno_head, s.itemno_detail ORDER BY s.seqid DESC) = 1
    ) AS d
    INNER JOIN eks_item AS i1
        ON d.itemno_detail = i1.itemno
    INNER JOIN eks_item AS i2
        ON d.itemno_head = i2.itemno
       AND i1.hier_level < i2.hier_level
    QUALIFY
       (dep_descr = 'EA-SK' AND d.seqid = MAX(d.seqid) OVER (PARTITION BY d.itemno_head, dep_descr))
    OR (dep_descr IN ('EA-BA', 'SK-BA') AND ROW_NUMBER() OVER (PARTITION BY i1.itemno, dep_descr ORDER BY d.seqid DESC) = 1)
),
t024_1 AS (
    SELECT d1.*
    FROM eks_dep AS d1
    LEFT OUTER JOIN eks_dep AS d2
        ON d1.dep_descr = 'EA-SK'
       AND d2.dep_descr = 'SK-BA'
       AND d1.itemno_head = d2.itemno_detail
    QUALIFY d1.dep_descr <> 'EA-SK'
         -- Verify EA-SK dependencies additionally using the BA (product), use only most recent BA.
         OR FIRST_VALUE(d2.itemno_head) IGNORE NULLS OVER (PARTITION BY d1.itemno_detail ORDER BY d2.seqid DESC) = d2.itemno_head
)
SELECT
        h.itemno_ea AS prod_variant_nr,
        'EKS_SLS' AS prod_variant_key_type_cd,
        h.itemno_ba AS prod_nr,
        'EKS' AS prod_key_type_cd,
        src.itemdesc AS prod_variant_name,
        'SALES_1' AS prod_variant_type_cd,
        NULL AS weight_based_fg,
        NULL AS logistic_variant_type_cd,
        NULL AS case_size_cnt,
        ean.ean_1 AS gtin,
        'FOOD' AS sales_variant_type_cd,
        src.bundlefact * src.volume AS sales_variant_content_meas,
        src.bundlefact AS unit_cnt,
        src.volume AS unit_content_meas,
        NULL AS content_uom_cd,
        NULL AS non_food_variant_type_cd,
        NULL AS size_name,
        NULL AS style_name,
        NULL AS kind_name,
        NULL AS fruits_and_vegetables_class_cd,
        NULL AS min_caliber_meas,
        NULL AS max_caliber_meas,
        NULL AS caliber_uom_cd,
        -- NULL AS country_of_origin_sid,
        src.extraction_tmsp AS extraction_dt,
        src.extraction_tmsp AS dwh_mapping_tmsp,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        't_${SRC_INPUT_TABLE}' AS filename,
        'WAWI_HQ' AS dwh_node_cd,
        '${LOAD_ID}' AS dwh_load_id
FROM
(
    SELECT DISTINCT itemno_ea, itemno_ba
    FROM ldl_data_production_etl.t_tcache_eks_hierarchy_1
) AS h
INNER JOIN t026 AS src
    ON h.itemno_ea = src.itemno
LEFT OUTER JOIN
(
    SELECT itemno, ean_1
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t029_wawi_item_ean_1
    WHERE delete_fg IS NULL
    QUALIFY ROW_NUMBER() OVER (PARTITION BY itemno ORDER BY ean_1) = 1
) AS ean_1
    ON h.itemno_ea = ean.itemno
QUALIFY ROW_NUMBER() OVER (PARTITION BY h.itemno_ea ORDER BY h.itemno_ba) = 1

UNION ALL

SELECT
        src.itemno AS prod_variant_nr,
        'EKS_SLS_UNK' AS prod_variant_key_type_cd,
        src.itemno AS prod_nr,
        'EKS' AS prod_key_type_cd,
        src.itemdesc AS prod_variant_name,
        'SALES_1' AS prod_variant_type_cd,
        NULL AS weight_based_fg,
        NULL AS logistic_variant_type_cd,
        NULL AS case_size_cnt,
        NULL AS gtin,
        'FOOD' AS sales_variant_type_cd,
        NULL AS sales_variant_content_meas,
        NULL AS unit_cnt,
        NULL AS unit_content_meas,
        NULL AS content_uom_cd,
        NULL AS non_food_variant_type_cd,
        NULL AS size_name,
        NULL AS style_name,
        NULL AS kind_name,
        NULL AS fruits_and_vegetables_class_cd,
        NULL AS min_caliber_meas,
        NULL AS max_caliber_meas,
        NULL AS caliber_uom_cd,
        -- NULL AS country_of_origin_sid,
        src.extraction_tmsp AS extraction_dt,
        src.extraction_tmsp AS dwh_mapping_tmsp,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        't_${SRC_INPUT_TABLE}' AS filename,
        'WAWI_HQ' AS dwh_node_cd,
        '${LOAD_ID}' AS dwh_load_id
FROM
(
    SELECT DISTINCT itemno_ba
    FROM ldl_data_production_etl.t_tcache_eks_hierarchy_1
    WHERE itemno_ba <> itemno_ea
) AS h
INNER JOIN t026 AS src
    ON h.itemno_ba = src.itemno

UNION ALL

SELECT
        itemno_sk AS prod_variant_nr,
        'EKS_LOG' AS prod_variant_key_type_cd,
        itemno_ba AS prod_nr,
        'EKS' AS prod_key_type_cd,
        src.itemdesc AS prod_variant_name,
        'LOGISTIC' AS prod_variant_type_cd,
        NULL AS weight_based_fg,
        sk.logistic_variant_type_cd AS logistic_variant_type_cd,
        COALESCE(mqty.quantity, sk.casesize, 1) AS case_size_cnt,
        NULL AS gtin,
        'FOOD' AS sales_variant_type_cd,
        NULL AS sales_variant_content_meas,
        NULL AS unit_cnt,
        NULL AS unit_content_meas,
        NULL AS content_uom_cd,
        NULL AS non_food_variant_type_cd,
        NULL AS size_name,
        NULL AS style_name,
        NULL AS kind_name,
        NULL AS fruits_and_vegetables_class_cd,
        NULL AS min_caliber_meas,
        NULL AS max_caliber_meas,
        NULL AS caliber_uom_cd,
        -- NULL AS country_of_origin_sid,
        src.extraction_tmsp AS extraction_dt,
        src.extraction_tmsp AS dwh_mapping_tmsp,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        't_${SRC_INPUT_TABLE}' AS filename,
        'WAWI_HQ' AS dwh_node_cd,
        '${LOAD_ID}' AS dwh_load_id
FROM
(
    SELECT
        itemno_sk,
        CASE WHEN SUM(CASE WHEN itemno_sk = itemno_ea THEN 1 ELSE 0 END) >= 1 THEN 'SINGLE' ELSE 'MIXED' END AS logistic_variant_type_cd,
        MAX(itemno_ba) AS itemno_ba,
        SUM(quantity) AS quantity
    FROM ldl_data_production_etl.t_tcache_eks_hierarchy_1
    GROUP BY itemno_sk

UNION ALL

SELECT
        itm.itemno AS prod_variant_nr,
        'EKS_LOG_UNK' AS prod_variant_key_type_cd,
        itm.itemno AS prod_nr,
        'EKS' AS prod_key_type_cd,
        itm.itemdesc AS prod_variant_name,
        'LOGISTIC' AS prod_variant_type_cd,
        NULL AS weight_based_fg,
        'SINGLE' AS logistic_variant_type_cd,
        1 AS case_size_cnt,
        NULL AS gtin,
        'FOOD' AS sales_variant_type_cd,
        NULL AS sales_variant_content_meas,
        NULL AS unit_cnt,
        NULL AS unit_content_meas,
        NULL AS content_uom_cd,
        NULL AS non_food_variant_type_cd,
        NULL AS size_name,
        NULL AS style_name,
        NULL AS kind_name,
        NULL AS fruits_and_vegetables_class_cd,
        NULL AS min_caliber_meas,
        NULL AS max_caliber_meas,
        NULL AS caliber_uom_cd,
        -- NULL AS country_of_origin_sid,
        itm.extraction_tmsp AS extraction_dt,
        itm.extraction_tmsp AS dwh_mapping_tmsp,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        't_${SRC_INPUT_TABLE}' AS filename,
        'WAWI_HQ' AS dwh_node_cd,
        '${LOAD_ID}' AS dwh_load_id
FROM
(
    SELECT DISTINCT itemno_ba
    FROM ldl_data_production_etl.t_tcache_eks_hierarchy_1
    WHERE itemno_ba <> itemno_ea
) nr
INNER JOIN t026 AS itm
    ON nr.itemno_ba = itm.itemno;
