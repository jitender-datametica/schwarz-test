INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        product_id,
        product_key_type_cd,
        customs_product_type_cd,
        origin_country_location_id,
        origin_country_location_key_type_cd,
        consignor_stream_cd,
        customs_classification_scheme_cd,
        customs_tariff_code_cd,
        product_variant_id,
        product_variant_key_type_cd,
        parent_product_id,
        parent_product_key_type_cd,
        customs_product_nr,
        additional_cd,
        customs_product_name,
        preferential_origin_fg,
        allocation_cnt,
        alcoholic_beverage_tax_rate_cd,
        alcoholic_beverage_pct,
        alcoholic_beverage_volume_qty,
       alcoholic_beverage_duty_per_lpa_val,
        alcoholic_beverage_duty_per_unit_val,
        special_excise_rate_val,
        dwh_src_file_name,
        dwh_src_1_tmsp,
        dwh_mapping_tmsp,
   dwh_valid_fg,
  TF_ERROR_FG,
  DELETED_FG,
 RECORD_ID,
  FILENAME,
volume_unit_id,
        alcoholic_beverage_uom_id,
        volume_unit_qty,
        alcoholic_beverage_adjusted_pct,
        alcoholic_beverage_volume_lpa_qty
)
select 
TRIM(trunc(try_cast(PRVSY as NUMBER(38,0))))||'||'||TRIM(LPAD(SUBSTR(REPLACE(CCNGN, ' ', ''), 1, 10), 10, '0'))||'|'||TRIM(CUCOO) product_id,
'CUSTOMS_PRODUCT' product_key_type_cd,
'GTS' customs_product_type_cd,
TRIM(CUCOO) origin_country_location_id,
'COUNTRY_2' origin_country_location_key_type_cd,
'LEXI' consignor_stream_cd,
'CTC_GB' customs_classification_scheme_cd,
LPAD(SUBSTR(REPLACE(CCNGN, ' ', ''), 1, 10), 10, '0') customs_tariff_code_cd,
trunc(try_cast(PRVSY as number(38,0))) product_variant_id,
'SALES_VARIANT' product_variant_key_type_cd,
'-1' parent_product_id,
'PRODUCT' parent_product_key_type_cd,
trunc(try_cast(PRVSY as number(38,0))) customs_product_nr,
'' additional_cd,
TRIM(PRTXT) customs_product_name  ,
case when COALESCE(PAPTY,'NULL')!='NULL' then true else false end preferential_origin_fg,
NULL allocation_cnt,
TRIM(
coalesce(case when coalesce(ETD, ETATS) < '2023-08-01'
            then NULLIF(ab.excise_code,'NULL') 
            else Coalesce(NULLIF(em.tax_code_,'NULL'), NULLIF(EXCISE_DUTY_CODE,'NULL'))
        end,'-1')) alcoholic_beverage_tax_rate_cd,
case when coalesce(ETD, ETATS) < '2023-08-01'
            then ab.alcohol_percentage
            else coalesce(em.ABV_, ab.alcohol_percentage)
        end  alcoholic_beverage_pct,
case when coalesce(ETD, ETATS) < '2023-08-01'
            then ab.bottle_size
            else coalesce(em.volume__in_l_, ab.bottle_size)
        end alcoholic_beverage_volume_qty,
case when Coalesce(ETD, ETAts) < '2023-08-01'
          then null
          else em.Duty_per_LPA
  end alcoholic_beverage_duty_per_lpa_val,
case when Coalesce(ETD, ETATS) < '2023-08-01'
          then null
          else em.Duty_per_Unit
  end
 alcoholic_beverage_duty_per_unit_val,
ex.excise_rate special_excise_rate_val,
MAX(pd.dwh_src_file_name ) over (partition by product_id, origin_country_location_id,CCNGN,PRVSY) dwh_src_file_name ,
pd.dwh_src_1_tmsp dwh_src_1_tmsp,
coalesce(pd.etd,pd.etats)  dwh_mapping_tmsp,
1 dwh_valid_fg,
0 tf_error_fg,
0 deleted_fg,
0 record_id,
MAX(pd.dwh_src_file_name ) over (partition by product_id, origin_country_location_id,CCNGN,PRVSY) filename,
'-1' as volume_unit_id,
COALESCE(unit_id, -1) alcoholic_beverage_uom_id,
NULL as volume_unit_qty,
case when Coalesce(ETD, ETATS) < '2023-08-01'
          then null
          else em.adjusted_abv__wine_only_
  end alcoholic_beverage_adjusted_pct,
  case when coalesce(ETD, ETATS) < '2023-08-01'
            then ab.bottle_size
            else coalesce(em.volume__in_l_, ab.bottle_size)
        end * alcoholic_beverage_pct / 100 alcoholic_beverage_volume_lpa_qty
from etl.t_cache_zgts_brimport_2 pd_2
left
         join (select * from etl.t_cache_abv_2   ) ab
           on try_to_number(PRVSY) = try_to_number(ab.article_number)
left
         join (select * from etl.t_cache_excise_masterlist_2   ) em
           on try_to_number(PRVSY) = try_to_number(em.single_article_no)
           and coalesce(ETD, ETATS) between em.dwh_valid_from_tmsp and em.dwh_valid_to_tmsp
left
  join etl.t_cache_product_excise_rate_exceptions_2 ex
    on UPPER(ex.product_nr || '|' || coalesce(ex.additional_cd, '') || '|' || ex.commodity_cd || '|' || TRIM(ex.country_of_origin)) = UPPER(product_id)
left join core_rel.t_unit_2 un
on un.unit_cd = case when TRIM(CTSMU1) = 'LTR' then 'l'
            else trim(lower(CTSMU1))
        end
 where product_id not like '%NULL%'
qualify row_number() OVER(partition by product_id, origin_country_location_id,CCNGN,PRVSY,coalesce(pd.etd,pd.etats) order by preferential_origin_fg desc)=1
union 


select 
        product_id,
        product_key_type_cd,
        customs_product_type_cd,
        TRIM(origin_country_location_id),
        origin_country_location_key_type_cd,
        consignor_stream_cd,
        customs_classification_scheme_cd,
        customs_tariff_code_cd,
        product_variant_id,
        product_variant_key_type_cd,
        parent_product_id,
        parent_product_key_type_cd,
        customs_product_nr,
        additional_cd,
        TRIM(customs_product_name),
        preferential_origin_fg,
        allocation_cnt,
        TRIM(alcoholic_beverage_tax_rate_cd),
        alcoholic_beverage_pct,
        alcoholic_beverage_volume_qty,
        alcoholic_beverage_duty_per_lpa_val,
        alcoholic_beverage_duty_per_unit_val,
        special_excise_rate_val,
        dwh_src_file_name,
        dwh_src_1_tmsp,
        dwh_mapping_tmsp,
        dwh_valid_fg,
        tf_error_fg,
        deleted_fg,
        record_id,
        filename,
        COALESCE(volume_unit_id, -1) volume_unit_id,
        COALESCE(alcoholic_beverage_uom_id, -1) alcoholic_beverage_uom_id,
        volume_unit_qty,
        alcoholic_beverage_adjusted_pct,
        alcoholic_beverage_volume_lpa_qty
from 
(select 
       TRIM(pd.product_number) || '|' || TRIM(pd.additional_cd) || '|' || TRIM(pd.customs_tariff_code_cd) || '|' || trim(pd.country_of_origin) product_id,
       'CUSTOMS_PRODUCT'product_key_type_cd ,
       pd.customs_product_type_cd,
       coalesce(pd.country_of_origin, '-1') origin_country_location_id,
       'COUNTRY_2' origin_country_location_key_type_cd,
       pd.consignor_stream_cd,
       'CTC_GB' as customs_classification_scheme_cd,
       pd.customs_tariff_code_cd,
       coalesce(trunc(pd.product_number),'-1') as product_variant_id,
       'SALES_VARIANT' product_variant_key_type_cd,
       coalesce(trunc(pd.product_number),'-1') as parent_product_id,
       'PRODUCT' parent_product_key_type_cd,
       trunc(pd.product_number) as customs_product_nr,
       pd.additional_cd,
       max(coalesce(pd.product_name, 'unknown')) over(partition by product_id) as customs_product_name,
       CASE WHEN pd.Preferential_Origin_fg = 'yes' THEN true ELSE false END preferential_origin_fg,
       sum(pd.allocation_cnt) over (partition by pd.product_number, pd.customs_tariff_code_cd, pd.country_of_origin) allocation_cnt,
       case when coalesce(pd.alcoholic_beverage_tax_rate_cd,'NULL')='NULL' then '-1' else pd.alcoholic_beverage_tax_rate_cd end as alcoholic_beverage_tax_rate_cd,
       abv_pct as alcoholic_beverage_pct,
       case when uom = 'l'
             and alcoholic_beverage_tax_rate_cd like 'X%'
            then quantity_in_uom
            else case when pd.dwh_src_1_tmsp < '2023-08-01'
                      then bottle_size 
                      else coalesce(volume__in_l_, bottle_size)
                  end
        end as alcoholic_beverage_volume_qty,
       case when pd.dwh_src_1_tmsp < '2023-08-01' then null else  alcoholic_beverage_duty_per_lpa_val end alcoholic_beverage_duty_per_lpa_val,
       case when pd.dwh_src_1_tmsp < '2023-08-01' then null else  alcoholic_beverage_duty_per_unit_val end alcoholic_beverage_duty_per_unit_val,
       ex.excise_rate as special_excise_rate_val,
       pd.dwh_src_file_name as dwh_src_file_name,
       pd.dwh_src_1_tmsp as dwh_src_1_tmsp,
       pd.dwh_src_1_tmsp as dwh_mapping_tmsp,
       1 dwh_valid_fg,
       0 as tf_error_fg,
	   0 deleted_fg,
	   0 record_id,
	   pd.dwh_src_file_name filename,
      un.unit_id as volume_unit_id,
case when alcoholic_beverage_tax_rate_cd like 'X%' 
          then volume_unit_id
         else  null
end  alcoholic_beverage_uom_id,
quantity_in_uom as volume_unit_qty,
ADJUSTED_ABV__WINE_ONLY_ alcoholic_beverage_adjusted_pct,
case when  uom = 'lpa'
             and alcoholic_beverage_tax_rate_cd like 'X%'
            then quantity_in_uom
            else case when pd.dwh_src_1_tmsp < '2023-08-01'
                      then alcohol_percentage 
                      else coalesce(abv_, alcohol_percentage)
                  end * quantity_in_uom / 100
        end alcoholic_beverage_volume_lpa_qty
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
              case when pd.alcoholic_beverage_tax_rate_cd='NULL' then null else pd.alcoholic_beverage_tax_rate_cd end alcoholic_beverage_tax_rate_cd,
              em.duty_per_lpa alcoholic_beverage_duty_per_lpa_val,
              em.duty_per_unit alcoholic_beverage_duty_per_unit_val,
              case when pd.dwh_src_1_tmsp < '2023-08-01'
            then ab.alcohol_percentage 
            else coalesce(em.abv_, ab.alcohol_percentage)
        end as abv_pct,
        ab.alcohol_percentage,
        volume__in_l_,
        Em.ABV_,
              pd.product_name as product_name,
              pd.preferential_origin_fg as preferential_origin_fg,
              COALESCE(pd.quantity_in_uom,0) as quantity_in_uom,
              pd.allocation_cnt as allocation_cnt,
              uom, ab.bottle_size,
              em.ADJUSTED_ABV__WINE_ONLY_
         from(-- products from gs upload for lidl stiftung
              select trim(to_char(article_number))        as product_number,
                     article                              as product_name,
                     trim(to_char(customs_tariff_number)) as customs_tariff_code_cd,
                     country_of_origin,
                     'LST' as consignor_stream_cd,
                     'WWT' as customs_product_type_cd,
                     preferential_origin          as preferential_origin_fg,
                     try_cast(allocation as decimal(38,5))                          as allocation_cnt,
                     tax_code                             as alcoholic_beverage_tax_rate_cd,
                     try_cast(quantity_in_uom as decimal(38,5)) quantity_in_uom,
                     unit_of_measure uom,
                     dwh_src_1_tmsp,
                     dwh_src_file_name
               from etl.t_cache_list_2 
               union
                 all
              -- products from gs upload for owim
              select trim(to_char(article_number))        as product_number,
                     article                              as product_name,
                     trim(to_char(customs_tariff_number)) as customs_tariff_code_cd,
                     country_of_origin,
                     'OWIM' as consignor_stream_cd,
                     'WWT' as customs_product_type_cd,
                     preferential_origin          as preferential_origin_fg,
                     try_cast(allocation as decimal(38,5))                           as allocation_cnt,
                     tax_code                             as alcoholic_beverage_tax_rate_cd,
                     try_cast(quantity_in_uom as decimal(38,5)) quantity_in_uom,
                     unit_of_measure,
dwh_src_1_tmsp,
dwh_src_file_name
            from etl.t_cache_owim_2
      )pd_2
         left
         join etl.t_cache_abv_2 ab
           on pd.product_number = ab.article_number
left
         join (select * from etl.t_cache_excise_masterlist_2) em
           on try_to_number(case when charindex('_', pd.product_number) > 0
                   then substr(pd.product_number, 1, charindex('_', pd.product_number) - 1)
                   else pd.product_number
               end) = try_to_number(em.single_article_no)  
           and pd.dwh_src_1_tmsp between em.dwh_valid_from_tmsp and em.dwh_valid_to_tmsp   
      ) pd_2
  left join core_rel.t_unit_2 un
  on  unit_cd =
case when uom = 'ltr' then 'l'
                       when uom = 'm2' then 'm²'
                       when uom = '1 000 p/st' then '1000 p/st'
                       else uom
                   end
  left
  join etl.t_cache_product_excise_rate_exceptions_2 ex
    on UPPER(ex.product_nr || '|' || coalesce(ex.additional_cd, '') || '|' || ex.commodity_cd || '|' || ex.country_of_origin) = UPPER(product_id)
    union all
select 
   trim(case when charindex('_', item_product) > 0 then substr(item_product,0, charindex('_', item_product) -1) else item_product end) || '|' || TRIM(case when charindex('_', item_product) > 0 then trim(substr(item_product, charindex('_', item_product) + 1)) else '' end) || '|' ||TRIM(lpad(substr(replace(item_commodity_code, ' ', ''), 1, 10), 10, '0')) || '|' || TRIM(coalesce( case when item_non_preferential_country_code='NULL' then NULL else item_non_preferential_country_code end, case when item_preferential_country_code='NULL' then NULL else item_preferential_country_code end))  product_id,
   'CUSTOMS_PRODUCT' product_type_cd,
   '-1'  customs_product_type_cd,
   coalesce( item_non_preferential_country_code, item_preferential_country_code,'-1')  origin_country_location_id,
   'COUNTRY_2' origin_country_location_type_cd,
   'EXTERNAL' consignor_stream_cd,
   'CTC_GB' customs_classification_scheme_cd,
   lpad(substr(replace(item_commodity_code, ' ', ''), 1, 10), 10, '0')customs_tariff_code_cd,
   '-1' product_variant_id,
   'SALES_VARIANT' product_variant_type_cd,
   '-1' parent_product_id,
   'PRODUCT' parent_product_type_cd,
   case when charindex('_', item_product) > 0 then trim(substr(item_product, 1, charindex('_', item_product) - 1)) else trim(item_product) end customs_product_nr,
   case when charindex('_', item_product) > 0 then trim(substr(item_product, charindex('_', item_product) + 1)) else '' end additional_code,
   trim (max(substr(item_description, 1, 250)) over (partition by product_id)) customs_product_name,
   false preferential_origin_fg,
   null allocation_cnt,
   coalesce(case when item_national_additional_code='NULL' then null else item_national_additional_code end, '-1') alcoholic_beverage_tax_rate_cd,
   null alcoholic_beverage_pct,
   null alcoholic_beverage_volume_qty,
   null alcoholic_beverage_duty_per_lpa_val,
   null alcoholic_beverage_duty_per_unit_val,
   null special_excise_rate_val,
   max(pd.dwh_src_file_name) over (partition by product_id, origin_country_location_id,additional_code) as dwh_src_file_name,
       pd.dwh_src_1_tmsp as dwh_src_1_tmsp,
       pd.dwh_src_1_tmsp as dwh_mapping_tmsp,
  1 dwh_valid_fg,
  0 as tf_error_fg
  ,0 deleted_fg
  ,0 record_id
  ,max(pd.dwh_src_file_name) over (partition by product_id, origin_country_location_id,additional_code) filename,
'-1' as volume_unit_id,
null alcoholic_beverage_uom_id,
NULL as volume_unit_qty,
NULL alcoholic_beverage_adjusted_pct,
null alcoholic_beverage_volume_lpa_qty
from 
(select item_description,item_product,
item_national_additional_code,item_commodity_code,
item_non_preferential_country_code,item_preferential_country_code,
importer_eori,
dwh_src_file_name,
dwh_src_1_tmsp
from 
etl.t_cache_ceva_2
union all
select item_description,item_product,
item_national_additional_code,item_commodity_code,
item_non_preferential_country_code,item_preferential_country_code,
importer_eori,
dwh_src_file_name,
dwh_src_1_tmsp from etl.t_cache_maersk_lukt_2
union 
select item_description,item_product,
item_national_additional_code,item_commodity_code,
item_non_preferential_country_code,item_preferential_country_code,
Importer_EORI,
dwh_src_file_name,
dwh_src_1_tmsp from etl.t_cache_maersk_lgb_2)PD_2
left join meta.t_product_key_2 pp
on pp.product_nat_key_nr = product_id
left join (select * from core_rel.t_customs_product_2 where dwh_valid_fg) cpp
on cpp.product_sid = pp.product_sid
where case when charindex('_', item_product) > 0 then substr(item_product,0, charindex('_', item_product) -1) else item_product end!='NULL' 
and try_to_number(trim(case when charindex('_', item_product) > 0 then substr(item_product,0, charindex('_', item_product) -1) else item_product end)) is not NULL
and cpp.product_sid is null)a
qualify row_number() over (partition by product_id order by customs_product_type_cd desc)=1;
