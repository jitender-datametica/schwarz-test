INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (prod_variant_sid, prod_variant_key_type_cd, prod_variant_nat_key_nr, source_system, extraction_dt, dwh_mapping_tmsp, tf_error_fg, deleted_fg, record_id, filename, dwh_node_cd, dwh_load_id)
  SELECT DISTINCT
      vkey.prod_variant_sid AS prod_variant_sid,
      'SLS_GTIN' AS prod_variant_key_type_cd,
      UPPER(CONCAT(src.item_no, '|', ean.ldl_ean)) AS prod_variant_nat_key_nr,
      'CBX' AS source_system,
      CURRENT_DATE() AS extraction_dt,
      CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
      NUMERIC '0' AS tf_error_fg,
      NUMERIC '0' AS deleted_fg,
      NUMERIC '0' AS record_id,
      't_${SRC_INPUT_TABLE}' AS filename,
      'CBX' AS dwh_node_cd,
      '${LOAD_ID}' AS dwh_load_id
    FROM
      ${temp_db}.t_${src_input_table} AS src
      INNER JOIN ldl_data_production.etl.t_tcache_cbx_ldl_item_article_ean_1 AS ean_1 ON ean.item_id = src.id
      INNER JOIN ldl_data_production.meta.t_product_variant_key_1 AS vkey ON /* KEY MUST ALREADY EXIST AFTER THE T_PRODUCT_VARIANT_1 (CBX_SLS) JOB. */ vkey.prod_variant_nat_key_nr = UPPER(CONCAT(src.item_no, '|', ean.ldl_ean))
       AND vkey.prod_variant_key_type_cd = 'CBX_SLS'
    WHERE ean.ldl_ean IS NOT NULL
    QUALIFY ROW_NUMBER() OVER (PARTITION BY src.item_no, ean.ldl_ean ORDER BY IF(src.updated_on IS NULL, 0, 1), src.updated_on DESC) = NUMERIC '1'
  UNION ALL
  SELECT DISTINCT
      vkey.prod_variant_sid AS prod_variant_sid,
      'SLS_UNK' AS prod_variant_key_type_cd,
      UPPER(CONCAT(src.ctrcode, '|', CAST(src.wawi_item_no AS STRING))) AS prod_variant_nat_key_nr,
      'CBX' AS source_system,
      CURRENT_DATE() AS extraction_dt,
      CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
      NUMERIC '0' AS tf_error_fg,
      NUMERIC '0' AS deleted_fg,
      NUMERIC '0' AS record_id,
      't_${SRC_INPUT_TABLE}' AS filename,
      'CBX' AS dwh_node_cd,
      '${LOAD_ID}' AS dwh_load_id
    FROM
      (
        SELECT
            iit.ctrcode,
            cbx.item_no AS item_no,
            ROUND(CAST(SUBSTR(iit.c215_itemnr, 1, CAST(LENGTH(iit.c215_itemnr) - NUMERIC '4' AS INT64)) AS BIGNUMERIC), 0) AS wawi_item_no,
            MIN(iit.c215_moddate) AS moddate
          FROM
            ${temp_db}.t_${src_input_table} AS cbx
            INNER JOIN ldl_data_production.etl.t_wawi_precore_t215_int_itemnr_1 AS iit ON CAST(/* expression of unknown or erroneous type */ iit.c215_int_itemnr AS BIGNUMERIC) = cbx.item_no
          WHERE cbx.item_no IS NOT NULL
          GROUP BY 1, cbx.item_no, 3
      ) AS src
      INNER JOIN ldl_data_production.meta.t_product_variant_key_1 AS vkey ON /* KEY MUST ALREADY EXIST AFTER THE T_PRODUCT_VARIANT_1 (CBX_SLS) JOB. */ vkey.prod_variant_nat_key_nr = SUBSTR(CAST(src.item_no AS STRING), 1, 250)
       AND vkey.prod_variant_key_type_cd = 'CBX_SLS_UNK'
    QUALIFY ROW_NUMBER() OVER (PARTITION BY src.item_no, src.ctrcode ORDER BY IF(src.moddate IS NULL, 0, 1), src.moddate DESC) = NUMERIC '1'
  UNION ALL
  SELECT
      vkey.prod_variant_sid AS prod_variant_sid,
      'LOG' AS prod_variant_key_type_cd,
      all_src.prod_variant_nat_key_nr,
      'CBX' AS source_system,
      CURRENT_DATE() AS extraction_dt,
      CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
      NUMERIC '0' AS tf_error_fg,
      NUMERIC '0' AS deleted_fg,
      NUMERIC '0' AS record_id,
      't_${SRC_INPUT_TABLE}' AS filename,
      'CBX' AS dwh_node_cd,
      '${LOAD_ID}' AS dwh_load_id
    FROM
      (
        SELECT
            CONCAT(CAST(src.item_no AS STRING), '|', src.ldl_code) AS join_prod_variant_nat_key_nr,
            UPPER(CONCAT(wint.ctrcode, '|', CAST(wint.wawi_itemnr AS STRING))) AS prod_variant_nat_key_nr,
            wint.moddate
          FROM
            (
              SELECT DISTINCT
                  itm.item_no AS item_no,
                  ipm.ldl_code,
                  ipm.ldl_total_pack_ratio,
                  ipm.ldl_ctrcode
                FROM
                  (
                    SELECT
                        t_tcache_cbx_cnt_item.id,
                        t_tcache_cbx_cnt_item.item_no
                      FROM
                        ldl_data_production.etl.t_tcache_cbx_cnt_item_1
                      WHERE t_tcache_cbx_cnt_item.item_no <> NUMERIC '0'
                      QUALIFY ROW_NUMBER() OVER (PARTITION BY item_no ORDER BY t_tcache_cbx_cnt_item.version DESC, t_tcache_cbx_cnt_item.revision DESC) = NUMERIC '1'
                  ) AS itm
                  INNER JOIN (
                    SELECT
                        ipm_0.item_id,
                        ipm_0.ldl_code,
                        ipm_0.ldl_total_pack_ratio,
                        SUBSTR(SPLIT(ipmc.value, '-')[SAFE_ORDINAL(0)], 1, 16777216) AS ldl_ctr_block,
                        SUBSTR(SPLIT(ipmc.value, '-')[SAFE_ORDINAL(1)], 1, 16777216) AS ldl_ctrcode
                      FROM
                        ldl_data_production.etl.t_tcache_cbx_ldl_item_packing_method_1 AS ipm_0
                        CROSS JOIN ipmc
                  ) AS ipm ON itm.id = ipm.item_id
            ) AS src
            INNER JOIN (
              SELECT
                  t_wawi_precore_t215_int_itemnr.ctrcode,
                  t_wawi_precore_t215_int_itemnr.c215_int_itemnr AS int_itemnr,
                  ROUND(SAFE_CAST(SUBSTR(t_wawi_precore_t215_int_itemnr.c215_itemnr, 1, CAST(LENGTH(t_wawi_precore_t215_int_itemnr.c215_itemnr) - NUMERIC '4' AS INT64)) AS BIGNUMERIC), 0) AS wawi_itemnr,
                  ROUND(SAFE_CAST(RIGHT(t_wawi_precore_t215_int_itemnr.c215_itemnr, 4) AS BIGNUMERIC), 0) AS wawi_casesize,
                  t_wawi_precore_t215_int_itemnr.c215_moddate AS moddate
                FROM
                  ldl_data_production.etl.t_wawi_precore_t215_int_itemnr_1
            ) AS wint ON src.ldl_ctrcode = wint.ctrcode
             AND src.item_no = wint.int_itemnr
          QUALIFY ROW_NUMBER() OVER (PARTITION BY wint.ctrcode, wint.wawi_itemnr ORDER BY IF(ABS(src.ldl_total_pack_ratio - wint.wawi_casesize) IS NULL, 0, 1) DESC, ABS(src.ldl_total_pack_ratio - wint.wawi_casesize), IF(src.ldl_total_pack_ratio - wint.wawi_casesize IS NULL, 0, 1) DESC, src.ldl_total_pack_ratio - wint.wawi_casesize, wint.wawi_casesize DESC, IF(src.ldl_code IS NULL, 0, 1) DESC, src.ldl_code) = NUMERIC '1'
      ) AS all_src
      INNER JOIN ldl_data_production.meta.t_product_variant_key_1 AS vkey ON /* KEY MUST ALREADY EXIST AFTER THE T_PRODUCT_VARIANT_1 (CBX_SLS) JOB. */ vkey.prod_variant_nat_key_nr = all_src.join_prod_variant_nat_key_nr
       AND vkey.prod_variant_key_type_cd = 'CBX_LOG'
    QUALIFY ROW_NUMBER() OVER (PARTITION BY all_src.prod_variant_nat_key_nr ORDER BY IF(all_src.moddate IS NULL, 0, 1), all_src.moddate DESC) = NUMERIC '1'
;
