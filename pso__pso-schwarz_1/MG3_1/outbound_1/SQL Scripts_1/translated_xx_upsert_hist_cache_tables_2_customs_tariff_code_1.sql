
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, dwh_valid_fg, record_id, dwh_mapping_tmsp, filename, customs_tariff_code_cd
 , customs_classification_scheme_cd, customs_tariff_code_descr)
(SELECT ct.dwh_src_file_name,
  ct.tf_error_fg,
  ct.dwh_src_1_tmsp,
   ct.deleted_fg <> 0 AS deleted_fg,
   ct.dwh_valid_fg <> 0 AS dwh_valid_fg,
  CAST(ct.record_id AS STRING) AS record_id,
  ct.dwh_mapping_tmsp,
  ct.filename,
  ct.customs_tariff_code_cd,
  ct.customs_classification_scheme_cd,
  CAST(ct.customs_tariff_code_descr AS STRING) AS customs_tariff_code_descr
 FROM (SELECT *
   FROM (((((SELECT 'CTC_GB' AS customs_classification_scheme_cd,
           LPAD(SUBSTR(REPLACE(item_commodity_code, ' ', ''), 1, 10), 10, '0') AS customs_tariff_code_cd,
           NULL AS customs_tariff_code_descr,
           1 AS dwh_valid_fg,
           dwh_src_file_name,
           dwh_src_1_tmsp,
           dwh_src_1_tmsp AS dwh_mapping_tmsp,
           0 AS tf_error_fg,
           0 AS deleted_fg,
           0 AS record_id,
           dwh_src_file_name AS filename
          FROM szd_production_etl.t_cache_ceva_1
          WHERE item_commodity_code <> 'NULL'
          UNION DISTINCT
          SELECT 'CTC_GB' AS customs_classification_scheme_cd,
           LPAD(SUBSTR(REPLACE(item_commodity_code, ' ', ''), 1, 10), 10, '0') AS customs_tariff_code_cd,
           NULL AS customs_tariff_code_descr,
           1 AS dwh_valid_fg,
           dwh_src_file_name,
           dwh_src_1_tmsp,
           dwh_src_1_tmsp AS dwh_mapping_tmsp,
           0 AS tf_error_fg,
           0 AS deleted_fg,
           0 AS record_id,
           dwh_src_file_name AS filename
          FROM szd_production_etl.t_cache_maersk_lgb_1
          WHERE item_commodity_code <> 'NULL')
         UNION DISTINCT
         SELECT 'CTC_GB' AS customs_classification_scheme_cd,
          LPAD(SUBSTR(REPLACE(item_commodity_code, ' ', ''), 1, 10), 10, '0') AS customs_tariff_code_cd,
          NULL AS customs_tariff_code_descr,
          1 AS dwh_valid_fg,
          dwh_src_file_name,
          dwh_src_1_tmsp,
          dwh_src_1_tmsp AS dwh_mapping_tmsp,
          0 AS tf_error_fg,
          0 AS deleted_fg,
          0 AS record_id,
          dwh_src_file_name AS filename
         FROM szd_production_etl.t_cache_maersk_lukt_1
         WHERE item_commodity_code <> 'NULL')
        UNION DISTINCT
        SELECT 'CTC_GB' AS customs_classification_scheme_cd,
         LPAD(SUBSTR(REPLACE(commodity_code, ' ', ''), 1, 10), 10, '0') AS customs_tariff_code_cd,
         NULL AS customs_tariff_code_descr,
         1 AS dwh_valid_fg,
         dwh_src_file_name,
         dwh_src_1_tmsp,
         dwh_src_1_tmsp AS dwh_mapping_tmsp,
         0 AS tf_error_fg,
         0 AS deleted_fg,
         0 AS record_id,
         dwh_src_file_name AS filename
        FROM szd_production_etl.t_cache_cds_item_1
        WHERE commodity_code <> 'NULL')
       UNION DISTINCT
       SELECT 'CTC_GB' AS customs_classification_scheme_cd,
        LPAD(SUBSTR(REPLACE(customs_tariff_number, ' ', ''), 1, 10), 10, '0') AS customs_tariff_code_cd,
        NULL AS customs_tariff_code_descr,
        1 AS dwh_valid_fg,
        dwh_src_file_name,
        dwh_src_1_tmsp,
        dwh_src_1_tmsp AS dwh_mapping_tmsp,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        dwh_src_file_name AS filename
       FROM szd_production_etl.t_cache_owim_1
       WHERE customs_tariff_number <> 'NULL')
      UNION DISTINCT
      SELECT 'CTC_GB' AS customs_classification_scheme_cd,
       LPAD(SUBSTR(REPLACE(customs_tariff_number, ' ', ''), 1, 10), 10, '0') AS customs_tariff_code_cd,
       NULL AS customs_tariff_code_descr,
       1 AS dwh_valid_fg,
       dwh_src_file_name,
       dwh_src_1_tmsp,
       dwh_src_1_tmsp AS dwh_mapping_tmsp,
       0 AS tf_error_fg,
       0 AS deleted_fg,
       0 AS record_id,
       dwh_src_file_name AS filename
      FROM szd_production_etl.t_cache_list_1
      WHERE customs_tariff_number <> 'NULL'
        /* union 
select
 'CTC_GB' as customs_classification_scheme_cd,
 lpad(substr(replace(CCNGN, ' ', ''), 1, 10), 10, '0') as commodity_code,
NULL as customs_tariff_code_descr,
1 as dwh_valid_fg,
dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
         from SZD_PRODUCTION.etl.t_cache_zgts_brimport_1
        where CCNGN is not null */
        )
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY customs_tariff_code_cd ORDER BY dwh_src_file_name IS NULL, dwh_src_file_name
         )) = 1) AS ct
  LEFT JOIN szd_production_core_rel.t_customs_tariff_code_1 AS cfc ON ct.customs_tariff_code_cd = cfc.customs_tariff_code_cd
   
 WHERE cfc.customs_tariff_code_cd IS NULL);