INSERT INTO ldl_data_production_${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
        prod_nat_key_nr,    
        prod_key_type_cd,  
        prod_variant_key_type_cd,  
        prod_variant_nat_key_nr,
        prod_variant_nr,
        gtin,
        prod_variant_name,
        prod_variant_type_cd,
        weight_based_fg,
        logistic_variant_type_cd,
        case_size_cnt,

        source_system, 
        extraction_dt, 
        dwh_mapping_tmsp,  
        tf_error_fg, 
        deleted_fg, 
        record_id, 
        filename,
        dwh_node_cd, 
        dwh_load_id
)
SELECT
        art.wawi_instanz_kzl || '|' || LTRIM(CAST(art.itemnr AS STRING),'0') AS prod_nat_key_nr,
        'WAWI' AS prod_key_type_cd, 
        'WAW_LOG' AS prod_variant_key_type_cd, 
        art.wawi_instanz_kzl || '|' || CAST(art.itemnr AS STRING) AS prod_variant_nat_key_nr,
        art.wawi_instanz_kzl || '|' || CAST(art.itemnr AS STRING) AS prod_variant_nr,
        NULL AS gtin,
        art.deutschtext AS prod_variant_name,
        'LOGISTIC' AS prod_variant_type_cd,
        CASE WHEN COALESCE(itmo.gewichtsartikel, 0) = 1 THEN TRUE ELSE FALSE END AS weight_based_fg,
        NULL AS logistic_variant_type_cd,
        NULL AS case_size_cnt,
        'WAWI' AS source_system,
        art.extraction_tmsp AS extraction_dt,
        art.extraction_tmsp AS dwh_mapping_tmsp,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        't_${src_input_table}' AS filename,
        'wawi_hq' AS dwh_node_cd,
        '${load_id}' AS dwh_load_id 
FROM
(
    SELECT
          LEFT(art.wawi_instanz_kzl,2) AS wawi_instanz_kzl,
          art.itemnr,
          art.case_size,
          art.extraction_tmsp,
          art.deutschtext
    FROM
    (
        SELECT
            src.*,
            CAST(artnrvier AS INT64) AS itemnr,
            CAST(RIGHT(artikelnr, 4) AS INT64) AS case_size
        FROM
            ${ldl_wawi_common_snflk_cl_db_name}.${src_input_table} AS src
        WHERE src.delete_fg IS NULL
    ) AS art
    LEFT OUTER JOIN
    (
        SELECT DISTINCT
            wawi_instanz_kzl,
            CAST(SUBSTR(c215_itemnr, 1, LENGTH(c215_itemnr)-4) AS INT64) AS itemnr,
            CAST(c215_int_itemnr AS INT64) AS c215_int_itemnr
        FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t215_int_itemnr
        WHERE delete_fg IS NULL
    ) AS ii
      ON art.wawi_instanz_kzl = ii.wawi_instanz_kzl
     AND art.itemnr = ii.itemnr
    LEFT OUTER JOIN ldl_data_production_meta.t_product_key AS ipk
      ON CAST(ii.c215_int_itemnr AS STRING) = ipk.prod_nat_key_nr
     AND ipk.prod_key_type_cd IN ('CBX','FV')
     AND ipk.dwh_valid_fg
    LEFT OUTER JOIN
    (
        SELECT DISTINCT itemno
        FROM ldl_data_production_etl.t_tcache_eks_item_wawi_item
    ) AS eks
      ON ii.c215_int_itemnr = eks.itemno
    LEFT OUTER JOIN ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t271_packagetype AS pt
      ON art.wawi_instanz_kzl = pt.wawi_instanz_kzl
     AND art.packung = pt.c271_packdescript
     AND pt.delete_fg IS NULL
    INNER JOIN ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikelbestell AS itmo
      ON art.wawi_instanz_kzl = itmo.wawi_instanz_kzl
     AND art.artikelnr = itmo.artikelnr
     AND itmo.delete_fg IS NULL
    INNER JOIN ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t277_unitfactors AS unit
      ON art.wawi_instanz_kzl = unit.wawi_instanz_kzl
     AND art.unit_id = unit.c277_id
     AND unit.delete_fg IS NULL
    WHERE
    (
        ii.itemnr IS NULL -- NO LINK TO INTERNATIONAL ITEM NUMBER
        OR
        (
            ipk.prod_sid IS NULL -- INTERNATIONAL NUMBER NOT FOUND IN INTERNATIONAL KEYS
            AND eks.itemno IS NULL
        )
    )
    QUALIFY ROW_NUMBER() OVER (
            PARTITION BY art.wawi_instanz_kzl, art.itemnr
            ORDER BY art.case_size DESC NULLS LAST
    ) = 1
) AS art
;
