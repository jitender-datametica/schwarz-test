insert into szd_producton.${temp_db}.${src2tgt_temp_table1}_${src_context_area} (product_number, additional_code, country_of_origin, product_key_type_cd, commodity_code, document_code, resource_item_key_type_cd, dwh_mapping_tmsp, tf_error_fg, deleted_fg, record_id, dwh_valid_fg, dwh_src_file_name, dwh_src_1_tmsp)
  select
      trim(gs.product_number, ' '),
      trim(gs.additional_code, ' '),
      trim(gs.country_of_origin, ' '),
      'CUSTOMS_PRODUCT' as product_key_type_cd,
      concat('gb', gs.document_code),
      trim(gs.commodity_code, ' '),
      'CUSTOMS_DOCUMENT' as resource_item_key_type_cd,
      gs.dwh_src_1_tmsp as dwh_mapping_tmsp,
      0 as tf_error_fg,
      0 as deleted_fg,
      0 as record_id,
      1 as dwh_valid_fg,
      gs.dwh_src_file_name,
      gs.dwh_src_1_tmsp
    from
      (
        select
            case
              when strpos(article_number, '_') > 0 then trim(substr(article_number, 1, cast(strpos(article_number, '_') - 1 as int64)), ' ')
              else trim(article_number, ' ')
            end as product_number,
            case
              when strpos(article_number, '_') > 0 then trim(substr(article_number, cast(strpos(article_number, '_') + 1 as int64)), ' ')
              else ''
            end as additional_code,
            lpad(substr(replace(customs_tariff_number, ' ', ''), 1, 10), 10, '0') as commodity_code,
            country_of_origin,
            trim(case
              when sp.value <> '---' then sp.value
              else null
            end, ' ') as document_code,
            dwh_src_file_name,
            dwh_src_1_tmsp
          from
            szd_production.etl.t_cache_list_2 as gs_0
            cross join sp
        union distinct
        select
            case
              when strpos(article_number, '_') > 0 then trim(substr(article_number, 1, cast(strpos(article_number, '_') - 1 as int64)), ' ')
              else trim(article_number, ' ')
            end as product_number,
            case
              when strpos(article_number, '_') > 0 then trim(substr(article_number, cast(strpos(article_number, '_') + 1 as int64)), ' ')
              else ''
            end as additional_code,
            lpad(substr(replace(customs_tariff_number, ' ', ''), 1, 10), 10, '0') as commodity_code,
            country_of_origin,
            trim(case
              when sp.value <> '---' then sp.value
              else null
            end, ' ') as document_code,
            dwh_src_file_name,
            dwh_src_1_tmsp
          from
            szd_production.etl.t_cache_owim_2 as gs_0
            cross join sp
      ) as gs
;
