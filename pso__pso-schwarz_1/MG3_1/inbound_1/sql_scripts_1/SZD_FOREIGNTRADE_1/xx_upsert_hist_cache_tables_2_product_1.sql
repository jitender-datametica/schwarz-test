INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  ian_nr,
  product_name,
  product_name_txt,
  product_key_type_cd,
  prod_id,
  product_division_type_cd,
  incoterm_name,
  /*hs_list_txt,*/
  product_status_cd,   
  dwh_src_file_name, 
  dwh_src_1_tmsp,  
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
)
select ct.*
  from (select * 
  from ( 
  select   distinct
  case when trim(item_product)='' or trim(item_product)='NULL' then NULL else split_part(trim(item_product), '_',0) end as ian_nr,
  case when trim(item_description)='' or trim(item_description)='NULL' then NULL else SUBSTR(item_description, 0, 99) end as product_name,
  case when trim(item_description)='' or trim(item_description)='NULL' then NULL else item_description end as product_name_txt,
  'PRODUCT' as product_key_type_cd,
  case when trim(item_product)='' or trim(item_product)='NULL' then NULL else split_part(trim(item_product), '_',0) end as prod_id,
  '-1' as product_division_type_cd,
  NULL as incoterm_name,
  /*NULL as hs_list_txt,*/
 'A' as product_status_cd,  
  dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
  from etl.t_cache_ceva_1
  where item_product!='NULL' and TRY_TO_NUMBER(split_part(item_product, '_',0)) is not null
  and case when trim(item_product)='' or trim(item_product)='NULL' then NULL else split_part(trim(item_product), '_',0) end != 1234 
  union
  select distinct  
  case when trim(item_product)='' or trim(item_product)='NULL' then NULL else split_part(trim(item_product), '_',0) end as ian_nr,
  case when trim(item_description)='' or trim(item_description)='NULL' then NULL else SUBSTR(item_description, 0, 99)  end as product_name,
  case when trim(item_description)='' or trim(item_description)='NULL' then NULL else item_description end as product_name_txt,
  'PRODUCT' as product_key_type_cd,
  case when trim(item_product)='' or trim(item_product)='NULL' then NULL else split_part(trim(item_product), '_',0) end as prod_id,
  '-1' as product_division_type_cd,
  NULL as incoterm_name,
  /*NULL as hs_list_txt,*/
 'A' as product_status_cd,
  dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
  from etl.t_cache_maersk_lgb_1
  where item_product!='NULL' and TRY_TO_NUMBER(split_part(item_product, '_',0)) is not null 
  and case when trim(item_product)='' or trim(item_product)='NULL' then NULL else split_part(trim(item_product), '_',0) end != 1234
  union
  select distinct  
  case when trim(item_product)='' or trim(item_product)='NULL' then NULL else split_part(trim(item_product), '_',0) end as ian_nr,
  case when trim(item_description)='' or trim(item_description)='NULL' then NULL else SUBSTR(item_description, 0, 99)  end as product_name,
  case when trim(item_description)='' or trim(item_description)='NULL' then NULL else item_description end as product_name_txt,
  'PRODUCT' as product_key_type_cd,
  case when trim(item_product)='' or trim(item_product)='NULL' then NULL else split_part(trim(item_product), '_',0) end as prod_id,
  '-1' as product_division_type_cd,
  NULL as incoterm_name,
 /* NULL as hs_list_txt,*/
 'A' as product_status_cd,
  dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
  from etl.t_cache_maersk_lukt_1
  where item_product!='NULL' and TRY_TO_NUMBER(split_part(item_product, '_',0)) is not null
  and case when trim(item_product)='' or trim(item_product)='NULL' then NULL else split_part(trim(item_product), '_',0) end != 1234 
  union
  select distinct
  case when trim(article_number)='' or trim(article_number)='NULL' then NULL else split_part(trim(article_number), '_',0) end as ian_nr,
  case when trim(article)='' or trim(article)='NULL' then NULL else SUBSTR(article, 0, 99) end as product_name,
  case when trim(article)='' or trim(article)='NULL' then NULL else article end as product_name_txt,
  'PRODUCT' as product_key_type_cd,
  case when trim(article_number)='' or trim(article_number)='NULL' then NULL else split_part(trim(article_number), '_',0) end as prod_id,
  '-1' as product_division_type_cd,
  NULL as incoterm_name, 
 /* NULL as hs_list_txt,*/
  'A' as product_status_cd,
  dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
  from etl.t_cache_owim_1
  where article_number !='NULL' and TRY_TO_NUMBER(split_part(article_number, '_',0)) is not null
  union  
   select distinct
  case when trim(article_number)='' or trim(article_number)='NULL' then NULL else split_part(trim(article_number), '_',0) end as ian_nr,
  case when trim(article)='' or trim(article)='NULL' then NULL else SUBSTR(article, 0, 99) end as product_name,
  case when trim(article)='' or trim(article)='NULL' then NULL else article end as product_name_txt,
  'PRODUCT' as product_key_type_cd,
  case when trim(article_number)='' or trim(article_number)='NULL' then NULL else split_part(trim(article_number), '_',0) end as prod_id,
  '-1' as product_division_type_cd,
  NULL as incoterm_name, 
  /*NULL as hs_list_txt,*/
  'A' as product_status_cd,
  dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
  from etl.t_cache_list_1
  where article_number !='NULL'  and TRY_TO_NUMBER(split_part(article_number, '_',0)) is not null  
 /* union
        select distinct
  case when charindex('_', trim(e.ENTITAETSNR)) > 0
         then substr(trim(e.ENTITAETSNR), 1, charindex('_', trim(e.ENTITAETSNR)) - 1)
         else trim(e.ENTITAETSNR)
 end as ian_nr,
  SUBSTR(TRIM(spp.BEZ), 1, 100) as product_name,
  spp.BEZ as product_name_txt,
  'PRODUCT' as product_key_type_cd,
 case when charindex('_', trim(e.ENTITAETSNR)) > 0
         then substr(trim(e.ENTITAETSNR), 1, charindex('_', trim(e.ENTITAETSNR)) - 1)
         else trim(e.ENTITAETSNR) end as prod_id,
  '-1' as product_division_type_cd,
  NULL as incoterm_name, 
  /*NULL as hs_list_txt,*/
  /*'A' as product_status_cd,
  spp.dwh_src_file_name, 
  spp.dwh_src_1_tmsp as dwh_src_1_tmsp,  
  spp.dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  spp.dwh_src_file_name as filename
  from etl.t_cache_SPPROD_1 spp
  join etl.t_cache_SVENTITAET_1 e
  on spp.PRODID = e.ENTITAETSID
  where  spp.bez!='NULL' 
  and  REGEXP_LIKE(case when charindex('_', trim(e.ENTITAETSNR)) > 0
  then substr(trim(e.ENTITAETSNR), 1, charindex('_', trim(e.ENTITAETSNR)) - 1)
  else trim(e.ENTITAETSNR) end, '^-?[0-9.]+$')*/
) 
   QUALIFY ROW_NUMBER() OVER(PARTITION BY IAN_NR ORDER BY DWH_SRC_FILE_NAME) = 1
   ) ct
  left join meta.t_product_key_1 mpk
  on mpk.PRODUCT_NAT_KEY_NR = ct.ian_nr
  and mpk.PRODUCT_KEY_TYPE_CD = ct.product_key_type_cd
  left join core_rel.t_product_1 tp
  on tp.product_sid = mpk.product_sid
  and tp.dwh_valid_fg = true
  where tp.product_sid is null;
