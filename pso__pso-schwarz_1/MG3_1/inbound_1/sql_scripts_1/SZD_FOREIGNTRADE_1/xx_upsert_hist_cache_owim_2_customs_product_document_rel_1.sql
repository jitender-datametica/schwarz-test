INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
       product_number,
       additional_code,
       country_of_origin,
       product_key_type_cd,
       commodity_code,
       document_code,
       resource_item_key_type_cd,
       DWH_MAPPING_TMSP,
       TF_ERROR_FG ,
       DELETED_FG    ,
       RECORD_ID ,
       DWH_VALID_FG,
       DWH_SRC_FILE_NAME,
       DWH_SRC_1_TMSP 
)
select trim(product_number),
       TRIM(additional_code),
       TRIM(country_of_origin),
       'CUSTOMS_PRODUCT' product_key_type_cd,
       'GB'||document_code,
       TRIM(commodity_code),
       'CUSTOMS_DOCUMENT' resource_item_key_type_cd,
       DWH_SRC_1_TMSP DWH_MAPPING_TMSP,
       0 TF_ERROR_FG ,
       0 DELETED_FG    ,
       0 RECORD_ID ,
       1 AS DWH_VALID_FG,
       DWH_SRC_FILE_NAME,
       DWH_SRC_1_TMSP
  from(select
              case when charindex('_', article_number) > 0
                   then trim(substr(article_number, 1, charindex('_', article_number) - 1))
                   else trim(article_number)
               end as product_number,
              case when charindex('_', article_number) > 0
                   then trim(substr(article_number, charindex('_', article_number) + 1))
                   else ''
               end as additional_code,
              lpad(substr(replace(customs_tariff_number, ' ', ''), 1, 10), 10, '0') as commodity_code,
              country_of_origin,
              trim(case when sp.value != '---' then sp.value else null end) as document_code,
              DWH_SRC_FILE_NAME,
              DWH_SRC_1_TMSP
         from etl.t_cache_list_1 gs, table(split_to_table(gs.import_license_codes, ',')) sp
        UNION 
        select
              case when charindex('_', article_number) > 0
                   then trim(substr(article_number, 1, charindex('_', article_number) - 1))
                   else trim(article_number)
               end as product_number,
              case when charindex('_', article_number) > 0
                   then trim(substr(article_number, charindex('_', article_number) + 1))
                   else ''
               end as additional_code,
              lpad(substr(replace(customs_tariff_number, ' ', ''), 1, 10), 10, '0') as commodity_code,
              country_of_origin,
              trim(case when sp.value != '---' then sp.value else null end) as document_code,
              DWH_SRC_FILE_NAME,
              DWH_SRC_1_TMSP
         from etl.t_cache_owim_1 gs, table(split_to_table(gs.import_license_codes, ',')) sp
      ) gs
