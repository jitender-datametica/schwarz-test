insert into  meta.t_product_key
select 
  max_sid+row_number() over (order by 1) , 'CUSTOMS_PRODUCT',  current_timestamp, '9999-12-31', true,  lower(pd.product_number || '|' || pd.additional_cd || '|' || pd.customs_tariff_code_cd || '|' || pd.country_of_origin),
current_timestamp,
current_timestamp
  from(select pd.dwh_src_1_tmsp, pd.dwh_src_file_name,
case when charindex('_', pd.product_number) > 0
                   then substr(pd.product_number, 1, charindex('_', pd.product_number) - 1)
                   else pd.product_number
               end as product_number,
              case when charindex('_', pd.product_number) > 0
                   then substr(pd.product_number, charindex('_', pd.product_number) + 1)
                   else ''
               end as additional_cd,
              lpad(substr(replace(pd.customs_tariff_code_cd, ' ', ''), 1, 10), 10, '0') as customs_tariff_code_cd,
              pd.country_of_origin,
              pd.consignor_stream_cd,
              pd.customs_product_type_cd,
              pd.alcoholic_beverage_tax_rate_cd,
              max(ab.alcohol_percentage) as abv_pct,
              min(pd.product_name) as product_name,
              max(pd.preferential_origin_fg) as preferential_origin_fg,
              max(pd.quantity_in_uom) as quantity_in_uom,
              sum(pd.allocation_cnt) as allocation_cnt
         from(-- Products from GS Upload for Lidl Stiftung
              select trim(to_char(article_number))        as product_number,
                     article                              as product_name,
                     trim(to_char(customs_tariff_number)) as customs_tariff_code_cd,
                     country_of_origin,
                     'LST' as consignor_stream_cd,
                     'WWT' as customs_product_type_cd,
                     true          as preferential_origin_fg,
                     allocation                           as allocation_cnt,
                     tax_code                             as alcoholic_beverage_tax_rate_cd,
                     quantity_in_uom,
dwh_src_1_tmsp,
dwh_src_file_name
                from etl.T_CACHE_LIST 
               union
                 all
              -- Products from GS Upload for OWIM
              select trim(to_char(article_number))        as product_number,
                     article                              as product_name,
                     trim(to_char(customs_tariff_number)) as customs_tariff_code_cd,
                     country_of_origin,
                     'OWIM' as consignor_stream_cd,
                     'WWT' as customs_product_type_cd,
                     true          as preferential_origin_fg,
                     allocation                           as allocation_cnt,
                     tax_code                             as alcoholic_beverage_tax_rate_cd,
                     quantity_in_uom,
dwh_src_1_tmsp,
dwh_src_file_name
                from etl.t_cache_owim
      )pd
         left
         join etl.t_cache_abv ab
           on pd.product_number = ab.article_number
        group
           by 1, 2, 3, 4, 5, 6, 7, 8, 9
      ) pd
 cross join (select max(product_sid) as max_sid from meta.t_product_key)
 left join meta.t_product_key p
 on p.product_nat_key_nr = UPPER(pd.product_number || '|' || pd.additional_cd || '|' || pd.customs_tariff_code_cd || '|' || pd.country_of_origin)
 where p.product_nat_key_nr is null;
