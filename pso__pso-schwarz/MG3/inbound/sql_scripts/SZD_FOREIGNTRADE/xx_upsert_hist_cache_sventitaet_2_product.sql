INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
ian_nr, 
product_key_type_cd,
prod_id,
product_name, 
product_name_txt,
product_division_type_cd,
incoterm_name, 
product_status_cd,
dwh_src_file_name, 
dwh_src_1_tmsp,  
dwh_mapping_tmsp,
tf_error_fg,
deleted_fg,
record_id,
filename
)
select distinct src.ian_nr, 
   src.product_key_type_cd,
   src.prod_id,
   src.product_name, 
   src.product_name_txt,   
   src.product_division_type_cd,
   src.incoterm_name, 
   src.product_status_cd,
   src.dwh_src_file_name, 
   src.dwh_src_1_tmsp,  
   src.dwh_mapping_tmsp,
   src.tf_error_fg,
   src.deleted_fg,
   src.record_id,
   src.filename   
   from (
  select distinct
  case when charindex('_', trim(e.ENTITAETSNR)) > 0
         then substr(trim(e.ENTITAETSNR), 1, charindex('_', trim(e.ENTITAETSNR)) - 1)
         else trim(e.ENTITAETSNR)
 end as ian_nr, 
  'PRODUCT' as product_key_type_cd,
 case when charindex('_', trim(e.ENTITAETSNR)) > 0
         then substr(trim(e.ENTITAETSNR), 1, charindex('_', trim(e.ENTITAETSNR)) - 1)
         else trim(e.ENTITAETSNR) end as prod_id,
  MAX(SUBSTR(TRIM(spp.BEZ), 1, 100)) over (partition by prod_id order by spp.BEZ desc)as product_name, 
  MAX(spp.BEZ) over (partition by prod_id order by spp.BEZ desc) as product_name_txt,
  '-1' as product_division_type_cd,
  NULL as incoterm_name, 
  /*NULL as hs_list_txt,*/
  'A' as product_status_cd,
  MAX(spp.dwh_src_file_name) over (partition by ian_nr order by spp.dwh_src_file_name desc) as dwh_src_file_name, 
  spp.dwh_src_1_tmsp as dwh_src_1_tmsp,  
  spp.AENDDATUM as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  MAX(spp.dwh_src_file_name) over (partition by ian_nr order by spp.dwh_src_file_name desc) as filename
  from (select PRODID,BEZ,AENDDATUM, dwh_src_1_tmsp, dwh_src_file_name from etl.t_cache_SPPROD QUALIFY ROW_NUMBER() OVER (PARTITION BY PRODID ORDER BY DWH_SRC_1_TMSP desc) = 1) spp
  join (select ENTITAETSID,ENTITAETSNR from etl.t_cache_SVENTITAET QUALIFY ROW_NUMBER() OVER (PARTITION BY ENTITAETSID ORDER BY DWH_SRC_1_TMSP desc) = 1) e
  on spp.PRODID = e.ENTITAETSID
  where spp.bez!='NULL' 
  and  REGEXP_LIKE(case when charindex('_', trim(e.ENTITAETSNR)) > 0
  then substr(trim(e.ENTITAETSNR), 1, charindex('_', trim(e.ENTITAETSNR)) - 1)
  else trim(e.ENTITAETSNR) end, '^-?[0-9.]+$') ) src 
  left join meta.t_product_key mpk
  on mpk.PRODUCT_NAT_KEY_NR = src.ian_nr
  and mpk.PRODUCT_KEY_TYPE_CD = src.product_key_type_cd
  left join core_rel.t_product tp
  on tp.product_sid = mpk.product_sid
  and tp.dwh_valid_fg = true
  where tp.product_sid is null;     

