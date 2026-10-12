INSERT INTO ldl_data_production_$_2{temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
        prod_nat_key_nr,    
        prod_key_type_cd,  
        prod_variant_key_type_cd,  
        prod_variant_nr,
        int_org_key_type_cd,
        party_nat_key_nr,

        prod_variant_nat_key_nr,
        local_prod_variant_nr,
        local_prod_variant_name,

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
        LEFT(wawi_instanz_kzl,2) || '|' || LTRIM(CAST(itemnr AS STRING),'0') AS prod_nat_key_nr,
        'WAWI' AS prod_key_type_cd, 
        'WAW_LOG' AS prod_variant_key_type_cd, 
        LEFT(wawi_instanz_kzl,2) || '|' || CAST(itemnr AS STRING) || '|' || CAST(case_size AS STRING) AS prod_variant_nr,
        'COUNTRY_2' AS int_org_key_type_cd,	
        LEFT(wawi_instanz_kzl,2) AS party_nat_key_nr,

        LEFT(wawi_instanz_kzl,2) || '|' || CAST(itemnr AS STRING) || '|' || CAST(case_size AS STRING) AS prod_variant_nat_key_nr,
        itemnr AS local_prod_variant_nr,
        COALESCE(bez_lang, deutschtext) AS local_prod_variant_name,

        'WAWI' AS source_system,
        extraction_tmsp AS extraction_dt,
        extraction_tmsp AS dwh_mapping_tmsp,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        't_${SRC_INPUT_TABLE}' AS filename,
        'WAWI_HQ' AS dwh_node_cd,
        '${LOAD_ID}' AS dwh_load_id 
FROM
(
    -- EXTRACTION/FILTER LOGIC FOR EACH INDIVIDUAL WAWI HQ DB:
    SELECT
          art.wawi_instanz_kzl,
          art.itemnr,
          art.case_size,
          art.artikelnr,
          art.extraction_tmsp,
          art.bez_lang,
          art.deutschtext
    FROM
        (
            SELECT
                wawi_instanz_kzl,
                CAST(artnrvier AS INT64) AS itemnr,
                CAST(RIGHT(artikelnr, 4) AS INT64) AS case_size,
                artikelnr,
                bez_lang,
                deutschtext,
                extraction_tmsp
            FROM
                (SELECT src.*
                 FROM ${ldl_wawi_common_snflk_cl_db_name}.${src_input_table} AS src
                 WHERE src.delete_fg IS NULL)
        ) AS art_2
    LEFT JOIN
        (
            SELECT DISTINCT
                wawi_instanz_kzl,
                CAST(SUBSTR(c215_itemnr, 1, LENGTH(c215_itemnr)-4) AS INT64) AS itemnr,
                CAST(c215_int_itemnr AS INT64) AS int_itemnr
            FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t215_int_itemnr_2
            WHERE delete_fg IS NULL
        ) AS ii
      ON art.wawi_instanz_kzl = ii.wawi_instanz_kzl
     AND art.itemnr = ii.itemnr
    LEFT JOIN ldl_data_production_meta.t_product_key_2 AS ipk
      ON CAST(ii.int_itemnr AS STRING) = ipk.prod_nat_key_nr
     AND ipk.prod_key_type_cd IN ('CBX','FV')
     AND ipk.dwh_valid_fg
    LEFT JOIN
        (
            SELECT DISTINCT
                itemno
            FROM ldl_data_production_etl.t_tcache_eks_item_wawi_item_2
        ) AS eks
      ON ii.int_itemnr = eks.itemno
    WHERE
    (
        ii.itemnr IS NULL -- NO LINK TO INTERNATIONAL ITEM_2 NUMBER
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
) AS subq
;
