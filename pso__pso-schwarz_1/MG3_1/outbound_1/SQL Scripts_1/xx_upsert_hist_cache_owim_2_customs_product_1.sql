INSERT INTO SZD_PRODUCTON.${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (product_id, product_key_type_cd, customs_product_type_cd, origin_country_location_id, origin_country_location_key_type_cd, consignor_stream_cd, customs_classification_scheme_cd, customs_tariff_code_cd, product_variant_id, product_variant_key_type_cd, parent_product_id, parent_product_key_type_cd, customs_product_nr, additional_cd, customs_product_name, preferential_origin_fg, allocation_cnt, alcoholic_beverage_tax_rate_cd, alcoholic_beverage_pct, alcoholic_beverage_volume_qty, alcoholic_beverage_duty_per_lpa_val, alcoholic_beverage_duty_per_unit_val, special_excise_rate_val, dwh_src_file_name, dwh_src_1_tmsp, dwh_mapping_tmsp, dwh_valid_fg, tf_error_fg, deleted_fg, record_id, filename, volume_unit_id, alcoholic_beverage_uom_id, volume_unit_qty, alcoholic_beverage_adjusted_pct, alcoholic_beverage_volume_lpa_qty)
  SELECT
      any_value(product_id) AS PRODUCT_ID,
      'CUSTOMS_PRODUCT' AS PRODUCT_KEY_TYPE_CD,
      'GTS' AS CUSTOMS_PRODUCT_TYPE_CD,
      any_value(origin_country_location_id) AS ORIGIN_COUNTRY_LOCATION_ID,
      'COUNTRY_1' AS ORIGIN_COUNTRY_LOCATION_KEY_TYPE_CD,
      'LEXI' AS CONSIGNOR_STREAM_CD,
      'CTC_GB' AS CUSTOMS_CLASSIFICATION_SCHEME_CD,
      lpad(substr(replace(ccngn, ' ', ''), 1, 10), 10, '0') AS CUSTOMS_TARIFF_CODE_CD,
      trunc(prvsy) AS PRODUCT_VARIANT_ID,
      'SALES_VARIANT' AS PRODUCT_VARIANT_KEY_TYPE_CD,
      '-1' AS PARENT_PRODUCT_ID,
      'PRODUCT' AS PARENT_PRODUCT_KEY_TYPE_CD,
      trunc(prvsy) AS CUSTOMS_PRODUCT_NR,
      '' AS ADDITIONAL_CD,
      trim(prtxt, ' ') AS CUSTOMS_PRODUCT_NAME,
      case
        when coalesce(papty, 'NULL') <> 'NULL' then true
        else false
      end as preferential_origin_fg,
      NULL as allocation_cnt,
      trim(coalesce(case
        when coalesce(etd, etats) < '2023-08-01' then NULLif(ab.excise_code, 'NULL')
        else coalesce(NULLif(em.tax_code_, 'NULL'), NULLif(excise_duty_code, 'NULL'))
      end, '-1'), ' ') as alcoholic_beverage_tax_rate_cd,
      alcoholic_beverage_pct as alcoholic_beverage_pct,
      case
        when coalesce(etd, etats) < '2023-08-01' then ab.bottle_size
        else coalesce(em.volume__in_l_, ab.bottle_size)
      end as alcoholic_beverage_volume_qty,
      case
        when coalesce(etd, etats) < '2023-08-01' then NULL
        else em.duty_per_lpa
      end as alcoholic_beverage_duty_per_lpa_val,
      case
        when coalesce(etd, etats) < '2023-08-01' then NULL
        else em.duty_per_unit
      end as alcoholic_beverage_duty_per_unit_val,
      ex.excise_rate as special_excise_rate_val,
      max(pd.dwh_src_file_name) over (partition by any_value(product_id), any_value(origin_country_location_id), ccngn, prvsy) as dwh_src_file_name,
      pd.dwh_src_1_tmsp as dwh_src_1_tmsp,
      coalesce(pd.etd, pd.etats) as dwh_mapping_tmsp,
      1 as dwh_valid_fg,
      0 as tf_error_fg,
      0 as deleted_fg,
      0 as record_id,
      max(pd.dwh_src_file_name) over (partition by any_value(product_id), any_value(origin_country_location_id), ccngn, prvsy) as filename,
      '-1' as volume_unit_id,
      coalesce(unit_id, -1) as alcoholic_beverage_uom_id,
      NULL as volume_unit_qty,
      case
        when coalesce(etd, etats) < '2023-08-01' then NULL
        else em.adjusted_abv__wine_only_
      end as alcoholic_beverage_adjusted_pct,
      case
        when coalesce(etd, etats) < '2023-08-01' then ab.bottle_size
        else coalesce(em.volume__in_l_, ab.bottle_size)
      end * alcoholic_beverage_pct / 100 as alcoholic_beverage_volume_lpa_qty
    from
      szd_production.etl.t_cache_zgts_brimport_1 as pd_1
      left outer join (
        select
            *
          from
            szd_production.etl.t_cache_abv_1
      ) as ab on round(safe_cast(prvsy as bignumeric), 0) = round(safe_cast(ab.article_number as bignumeric), 0)
      left outer join (
        select
            *
          from
            szd_production.etl.t_cache_excise_masterlist_1
      ) as em on round(safe_cast(prvsy as bignumeric), 0) = round(safe_cast(em.single_article_no as bignumeric), 0)
       and coalesce(etd, etats) between em.dwh_valid_from_tmsp and em.dwh_valid_to_tmsp
      left outer join szd_production.etl.t_cache_product_excise_rate_exceptions_1 as ex on upper(concat(ex.product_nr, '|', coalesce(ex.additional_cd, ''), '|', ex.commodity_cd, '|', trim(ex.country_of_origin, ' '))) = upper(concat(trim(cast(trunc(prvsy) as string), ' '), '||', trim(lpad(substr(replace(ccngn, ' ', ''), 1, 10), 10, '0'), ' '), '|', trim(cucoo, ' ')))
      left outer join szd_production.core_rel.t_unit_1 as un on un.unit_cd = case
        when trim(ctsmu1, ' ') = 'LTR' then 'l'
        else trim(lower(ctsmu1), ' ')
      end
      cross join unnest(array[
        case
          when coalesce(etd, etats) < '2023-08-01' then ab.alcohol_percentage
          else coalesce(em.abv_, ab.alcohol_percentage)
        end
      ]) as alcoholic_beverage_pct
      cross join unnest(array[
        trim(cucoo, ' ')
      ]) as origin_country_location_id
      cross join unnest(array[
        concat(trim(cast(trunc(prvsy) as string), ' '), '||', trim(lpad(substr(replace(ccngn, ' ', ''), 1, 10), 10, '0'), ' '), '|', trim(cucoo, ' '))
      ]) as product_id
    where product_id not like '%NULL%'
    qualify row_number() over (partition by product_id, origin_country_location_id, ccngn, prvsy, dwh_mapping_tmsp order by if(preferential_origin_fg is NULL, 0, 1), preferential_origin_fg desc) = dwh_valid_fg
  union distinct
  select
      a.product_id,
      a.product_key_type_cd,
      a.customs_product_type_cd,
      trim(a.origin_country_location_id, ' '),
      a.origin_country_location_key_type_cd,
      a.consignor_stream_cd,
      a.customs_classification_scheme_cd,
      a.customs_tariff_code_cd,
      a.product_variant_id,
      a.product_variant_key_type_cd,
      a.parent_product_id,
      a.parent_product_key_type_cd,
      a.customs_product_nr,
      a.additional_cd,
      trim(a.customs_product_name, ' '),
      a.preferential_origin_fg,
      a.allocation_cnt,
      trim(a.alcoholic_beverage_tax_rate_cd, ' '),
      a.alcoholic_beverage_pct,
      a.alcoholic_beverage_volume_qty,
      a.alcoholic_beverage_duty_per_lpa_val,
      a.alcoholic_beverage_duty_per_unit_val,
      a.special_excise_rate_val,
      a.dwh_src_file_name,
      a.dwh_src_1_tmsp,
      a.dwh_mapping_tmsp,
      a.dwh_valid_fg,
      a.tf_error_fg,
      a.deleted_fg,
      a.record_id,
      a.filename,
      coalesce(cast(a.volume_unit_id as bignumeric), -1) as volume_unit_id,
      coalesce(cast(a.alcoholic_beverage_uom_id as bignumeric), -1) as alcoholic_beverage_uom_id,
      a.volume_unit_qty,
      a.alcoholic_beverage_adjusted_pct,
      a.alcoholic_beverage_volume_lpa_qty
    from
      (
        select
            product_id as product_id,
            'CUSTOMS_PRODUCT' as product_key_type_cd,
            pd.customs_product_type_cd,
            coalesce(pd.country_of_origin, '-1') as origin_country_location_id,
            'COUNTRY_1' as origin_country_location_key_type_cd,
            pd.consignor_stream_cd,
            'CTC_GB' as customs_classification_scheme_cd,
            pd.customs_tariff_code_cd,
            coalesce(cast(trunc(cast(pd.product_number as bignumeric)) as string), '-1') as product_variant_id,
            'SALES_VARIANT' as product_variant_key_type_cd,
            coalesce(cast(trunc(cast(pd.product_number as bignumeric)) as string), '-1') as parent_product_id,
            'PRODUCT' as parent_product_key_type_cd,
            trunc(cast(pd.product_number as bignumeric)) as customs_product_nr,
            pd.additional_cd,
            max(coalesce(pd.product_name, 'unknown')) over (partition by product_id) as customs_product_name,
            case
              when pd.preferential_origin_fg = 'yes' then true
              else false
            end as preferential_origin_fg,
            sum(pd.allocation_cnt) over (partition by pd.product_number, pd.customs_tariff_code_cd, pd.country_of_origin) as allocation_cnt,
            case
              when coalesce(pd.alcoholic_beverage_tax_rate_cd, 'NULL') = 'NULL' then '-1'
              else pd.alcoholic_beverage_tax_rate_cd
            end as alcoholic_beverage_tax_rate_cd,
            pd.abv_pct as alcoholic_beverage_pct,
            case
              when pd.uom = 'l'
               and pd.alcoholic_beverage_tax_rate_cd like 'x%' then pd.quantity_in_uom
              else case
                when pd.dwh_src_1_tmsp < '2023-08-01' then pd.bottle_size
                else coalesce(pd.volume__in_l_, pd.bottle_size)
              end
            end as alcoholic_beverage_volume_qty,
            case
              when pd.dwh_src_1_tmsp < '2023-08-01' then NULL
              else pd.alcoholic_beverage_duty_per_lpa_val
            end as alcoholic_beverage_duty_per_lpa_val,
            case
              when pd.dwh_src_1_tmsp < '2023-08-01' then NULL
              else pd.alcoholic_beverage_duty_per_unit_val
            end as alcoholic_beverage_duty_per_unit_val,
            ex.excise_rate as special_excise_rate_val,
            pd.dwh_src_file_name as dwh_src_file_name,
            pd.dwh_src_1_tmsp as dwh_src_1_tmsp,
            pd.dwh_src_1_tmsp as dwh_mapping_tmsp,
            1 as dwh_valid_fg,
            0 as tf_error_fg,
            0 as deleted_fg,
            0 as record_id,
            pd.dwh_src_file_name as filename,
            un.unit_id as volume_unit_id,
            case
              when pd.alcoholic_beverage_tax_rate_cd like 'x%' then un.unit_id
              else NULL
            end as alcoholic_beverage_uom_id,
            pd.quantity_in_uom as volume_unit_qty,
            pd.adjusted_abv__wine_only_ as alcoholic_beverage_adjusted_pct,
            case
              when pd.uom = 'lpa'
               and pd.alcoholic_beverage_tax_rate_cd like 'x%' then pd.quantity_in_uom
              else case
                when pd.dwh_src_1_tmsp < '2023-08-01' then pd.alcohol_percentage
                else coalesce(pd.abv_, pd.alcohol_percentage)
              end * pd.quantity_in_uom / 100
            end as alcoholic_beverage_volume_lpa_qty
          from
            (
              select
                  pd_0.dwh_src_1_tmsp,
                  pd_0.dwh_src_file_name,
                  case
                    when strpos(pd_0.product_number, '_') > 0 then substr(pd_0.product_number, 1, cast(strpos(pd_0.product_number, '_') - 1 as int64))
                    else pd_0.product_number
                  end as product_number,
                  case
                    when strpos(pd_0.product_number, '_') > 0 then substr(pd_0.product_number, cast(strpos(pd_0.product_number, '_') + 1 as int64))
                    else ''
                  end as additional_cd,
                  lpad(substr(replace(pd_0.customs_tariff_code_cd, ' ', ''), 1, 10), 10, '0') as customs_tariff_code_cd,
                  pd_0.country_of_origin,
                  pd_0.consignor_stream_cd,
                  pd_0.customs_product_type_cd,
                  case
                    when pd_0.alcoholic_beverage_tax_rate_cd = 'NULL' then NULL
                    else pd_0.alcoholic_beverage_tax_rate_cd
                  end as alcoholic_beverage_tax_rate_cd,
                  em.duty_per_lpa as alcoholic_beverage_duty_per_lpa_val,
                  em.duty_per_unit as alcoholic_beverage_duty_per_unit_val,
                  case
                    when pd_0.dwh_src_1_tmsp < '2023-08-01' then ab.alcohol_percentage
                    else coalesce(em.abv_, ab.alcohol_percentage)
                  end as abv_pct,
                  ab.alcohol_percentage,
                  volume__in_l_,
                  em.abv_,
                  pd_0.product_name as product_name,
                  pd_0.preferential_origin_fg as preferential_origin_fg,
                  coalesce(pd_0.quantity_in_uom, 0) as quantity_in_uom,
                  pd_0.allocation_cnt as allocation_cnt,
                  pd_0.uom,
                  ab.bottle_size,
                  em.adjusted_abv__wine_only_
                  -- products from gs upload for lidl stiftung
                from
                  (
                    select
                        trim(cast(t_cache_list.article_number as string), ' ') as product_number,
                        t_cache_list.article as product_name,
                        trim(cast(t_cache_list.customs_tariff_number as string), ' ') as customs_tariff_code_cd,
                        t_cache_list.country_of_origin,
                        'LST' as consignor_stream_cd,
                        'WWT' as customs_product_type_cd,
                        t_cache_list.preferential_origin as preferential_origin_fg,
                        t_cache_list.allocation as allocation_cnt,
                        t_cache_list.tax_code as alcoholic_beverage_tax_rate_cd,
                        t_cache_list.quantity_in_uom as quantity_in_uom,
                        t_cache_list.unit_of_measure as uom,
                        t_cache_list.dwh_src_1_tmsp,
                        t_cache_list.dwh_src_file_name
                      from
                        szd_production.etl.t_cache_list_1
                    union all
                    select
                        -- products from gs upload for owim
                        trim(cast(t_cache_owim.article_number as string), ' ') as product_number,
                        t_cache_owim.article as product_name,
                        trim(cast(t_cache_owim.customs_tariff_number as string), ' ') as customs_tariff_code_cd,
                        t_cache_owim.country_of_origin,
                        'OWIM' as consignor_stream_cd,
                        'WWT' as customs_product_type_cd,
                        t_cache_owim.preferential_origin as preferential_origin_fg,
                        t_cache_owim.allocation as allocation_cnt,
                        t_cache_owim.tax_code as alcoholic_beverage_tax_rate_cd,
                        t_cache_owim.quantity_in_uom as quantity_in_uom,
                        t_cache_owim.unit_of_measure as uom,
                        t_cache_owim.dwh_src_1_tmsp,
                        t_cache_owim.dwh_src_file_name
                      from
                        szd_production.etl.t_cache_owim_1
                  ) as pd_0
                  left outer join szd_production.etl.t_cache_abv_1 as ab on pd_0.product_number = ab.article_number
                  left outer join (
                    select
                        *
                      from
                        szd_production.etl.t_cache_excise_masterlist_1
                  ) as em on round(safe_cast(case
                    when strpos(pd_0.product_number, '_') > 0 then substr(pd_0.product_number, 1, cast(strpos(pd_0.product_number, '_') - 1 as int64))
                    else pd_0.product_number
                  end as bignumeric), 0) = round(safe_cast(em.single_article_no as bignumeric), 0)
                   and pd_0.dwh_src_1_tmsp between em.dwh_valid_from_tmsp and em.dwh_valid_to_tmsp
            ) as pd_1
            left outer join szd_production.core_rel.t_unit_1 as un on unit_cd = case
               pd.uom
              when 'ltr' then 'l'
              when 'm2' then 'm²'
              when '1 000 p/st' then '1000 p/st'
              else pd.uom
            end
            left outer join szd_production.etl.t_cache_product_excise_rate_exceptions_1 as ex on upper(concat(ex.product_nr, '|', coalesce(ex.additional_cd, ''), '|', ex.commodity_cd, '|', ex.country_of_origin)) = upper(concat(trim(pd.product_number, ' '), '|', trim(pd.additional_cd, ' '), '|', trim(pd.customs_tariff_code_cd, ' '), '|', trim(pd.country_of_origin, ' ')))
            cross join unnest(array[
              concat(trim(pd.product_number, ' '), '|', trim(pd.additional_cd, ' '), '|', trim(pd.customs_tariff_code_cd, ' '), '|', trim(pd.country_of_origin, ' '))
            ]) as product_id
        union all
        select
            product_id as product_id,
            'CUSTOMS_PRODUCT' as product_key_type_cd,
            '-1' as customs_product_type_cd,
            origin_country_location_id as origin_country_location_id,
            'COUNTRY_1' as origin_country_location_key_type_cd,
            'EXTERNAL' as consignor_stream_cd,
            'CTC_GB' as customs_classification_scheme_cd,
            lpad(substr(replace(pd.item_commodity_code, ' ', ''), 1, 10), 10, '0') as customs_tariff_code_cd,
            '-1' as product_variant_id,
            'SALES_VARIANT' as product_variant_key_type_cd,
            '-1' as parent_product_id,
            'PRODUCT' as parent_product_key_type_cd,
            case
              when strpos(pd.item_product, '_') > 0 then trim(substr(pd.item_product, 1, cast(strpos(pd.item_product, '_') - 1 as int64)), ' ')
              else trim(pd.item_product, ' ')
            end as customs_product_nr,
            additional_code as additional_cd,
            trim(max(substr(pd.item_description, 1, 250)) over (partition by product_id), ' ') as customs_product_name,
            false as preferential_origin_fg,
            NULL as allocation_cnt,
            coalesce(case
              when pd.item_national_additional_code = 'NULL' then NULL
              else pd.item_national_additional_code
            end, '-1') as alcoholic_beverage_tax_rate_cd,
            NULL as alcoholic_beverage_pct,
            NULL as alcoholic_beverage_volume_qty,
            NULL as alcoholic_beverage_duty_per_lpa_val,
            NULL as alcoholic_beverage_duty_per_unit_val,
            NULL as special_excise_rate_val,
            max(pd.dwh_src_file_name) over (partition by product_id, origin_country_location_id, additional_code) as dwh_src_file_name,
            pd.dwh_src_1_tmsp as dwh_src_1_tmsp,
            pd.dwh_src_1_tmsp as dwh_mapping_tmsp,
            1 as dwh_valid_fg,
            0 as tf_error_fg,
            0 as deleted_fg,
            0 as record_id,
            max(pd.dwh_src_file_name) over (partition by product_id, origin_country_location_id, additional_code) as filename,
            '-1' as volume_unit_id,
            NULL as alcoholic_beverage_uom_id,
            NULL as volume_unit_qty,
            NULL as alcoholic_beverage_adjusted_pct,
            NULL as alcoholic_beverage_volume_lpa_qty
          from
            (
              (
                select
                    t_cache_ceva.item_description,
                    t_cache_ceva.item_product,
                    t_cache_ceva.item_national_additional_code,
                    t_cache_ceva.item_commodity_code,
                    t_cache_ceva.item_non_preferential_country_code,
                    t_cache_ceva.item_preferential_country_code,
                    t_cache_ceva.importer_eori,
                    t_cache_ceva.dwh_src_file_name,
                    t_cache_ceva.dwh_src_1_tmsp
                  from
                    szd_production.etl.t_cache_ceva_1
                union all
                select
                    t_cache_maersk_lukt.item_description,
                    t_cache_maersk_lukt.item_product,
                    t_cache_maersk_lukt.item_national_additional_code,
                    t_cache_maersk_lukt.item_commodity_code,
                    t_cache_maersk_lukt.item_non_preferential_country_code,
                    t_cache_maersk_lukt.item_preferential_country_code,
                    t_cache_maersk_lukt.importer_eori,
                    t_cache_maersk_lukt.dwh_src_file_name,
                    t_cache_maersk_lukt.dwh_src_1_tmsp
                  from
                    szd_production.etl.t_cache_maersk_lukt_1
              )
              union distinct
              select
                  t_cache_maersk_lgb.item_description,
                  t_cache_maersk_lgb.item_product,
                  t_cache_maersk_lgb.item_national_additional_code,
                  t_cache_maersk_lgb.item_commodity_code,
                  t_cache_maersk_lgb.item_non_preferential_country_code,
                  t_cache_maersk_lgb.item_preferential_country_code,
                  t_cache_maersk_lgb.importer_eori,
                  t_cache_maersk_lgb.dwh_src_file_name,
                  t_cache_maersk_lgb.dwh_src_1_tmsp
                from
                  szd_production.etl.t_cache_maersk_lgb_1
            ) as pd_1
            left outer join szd_production.meta.t_product_key_1 as pp on pp.product_nat_key_nr = concat(trim(case
              when strpos(pd.item_product, '_') > 0 then substr(pd.item_product, 0, cast(strpos(pd.item_product, '_') - 1 as int64))
              else pd.item_product
            end, ' '), '|', trim(case
              when strpos(pd.item_product, '_') > 0 then trim(substr(pd.item_product, cast(strpos(pd.item_product, '_') + 1 as int64)), ' ')
              else ''
            end, ' '), '|', trim(lpad(substr(replace(pd.item_commodity_code, ' ', ''), 1, 10), 10, '0'), ' '), '|', trim(coalesce(case
              when pd.item_non_preferential_country_code = 'NULL' then NULL
              else pd.item_non_preferential_country_code
            end, case
              when pd.item_preferential_country_code = 'NULL' then NULL
              else pd.item_preferential_country_code
            end), ' '))
            left outer join (
              select
                  *
                from
                  szd_production.core_rel.t_customs_product_1
                where t_customs_product.dwh_valid_fg
            ) as cpp on cpp.product_sid = pp.product_sid
            cross join unnest(array[
              case
                when strpos(pd.item_product, '_') > 0 then trim(substr(pd.item_product, cast(strpos(pd.item_product, '_') + 1 as int64)), ' ')
                else ''
              end
            ]) as additional_code
            cross join unnest(array[
              coalesce(pd.item_non_preferential_country_code, pd.item_preferential_country_code, '-1')
            ]) as origin_country_location_id
            cross join unnest(array[
              concat(trim(case
                when strpos(pd.item_product, '_') > 0 then substr(pd.item_product, 0, cast(strpos(pd.item_product, '_') - 1 as int64))
                else pd.item_product
              end, ' '), '|', trim(case
                when strpos(pd.item_product, '_') > 0 then trim(substr(pd.item_product, cast(strpos(pd.item_product, '_') + 1 as int64)), ' ')
                else ''
              end, ' '), '|', trim(lpad(substr(replace(pd.item_commodity_code, ' ', ''), 1, 10), 10, '0'), ' '), '|', trim(coalesce(case
                when pd.item_non_preferential_country_code = 'NULL' then NULL
                else pd.item_non_preferential_country_code
              end, case
                when pd.item_preferential_country_code = 'NULL' then NULL
                else pd.item_preferential_country_code
              end), ' '))
            ]) as product_id
          where case
            when strpos(pd.item_product, '_') > 0 then substr(pd.item_product, 0, cast(strpos(pd.item_product, '_') - 1 as int64))
            else pd.item_product
          end <> 'NULL'
           and round(safe_cast(trim(case
            when strpos(pd.item_product, '_') > 0 then substr(pd.item_product, 0, cast(strpos(pd.item_product, '_') - 1 as int64))
            else pd.item_product
          end, ' ') as bignumeric), 0) is not NULL
           and cpp.product_sid is NULL
      ) as a
    qualify row_number() over (partition by a.product_id order by if(a.customs_product_type_cd is NULL, 0, 1), a.customs_product_type_cd desc) = 1
;
