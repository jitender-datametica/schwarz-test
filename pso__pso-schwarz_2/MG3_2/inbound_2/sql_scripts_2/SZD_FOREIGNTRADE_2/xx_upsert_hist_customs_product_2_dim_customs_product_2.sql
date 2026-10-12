INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
product_sid,   
dwh_valid_fg, 
customs_product_type_cd, 
customs_product_type_descr, 
origin_country_location_sid, 
consignor_stream_cd, 
origin_iso_country_cd, 
origin_country_name_de, 
origin_country_name_en, 
customs_product_nr, 
customs_additional_cd, 
customs_tariff_number_cd, 
customs_classification_scheme_cd, 
customs_tariff_number_descr, 
food_nonfood_type_cd, 
food_nonfood_type_name, 
alcoholic_beverage_tax_rate_cd, 
alcoholic_beverage_type_cd, 
alcoholic_beverage_type_name,
alcoholic_beverage_volume_qty,
alcoholic_beverage_pct,
alcoholic_beverage_duty_per_unit_val, 
customs_product_name, 
preferential_origin_fg, 
parent_product_sid, 
parent_product_name,
dwh_mapping_tmsp,
dwh_src_file_name,
dwh_src_1_tmsp,
tf_error_fg,
record_id,
filename,
deleted_fg
)
select cp.product_sid,
       cp.dwh_valid_fg,
       cpt.customs_product_type_cd,
       cpt.customs_product_type_descr,
       cp.origin_country_location_sid,
       cp.consignor_stream_cd,
       coalesce(ctp_de.iso_country_cd, '-1') as origin_iso_country_cd,
       coalesce(ctp_de.country_name, 'Unknown') as origin_country_name_de,
       coalesce(ctp_en.country_name, 'Unknown') as origin_country_name_en,
       coalesce(try_to_number(cp.customs_product_nr), '-1') as customs_product_nr,
       cp.additional_cd as customs_additional_cd,
       coalesce(ctn.customs_tariff_number_cd, '-1') as customs_tariff_number_cd,
       coalesce(ctn.customs_classification_scheme_cd, '-1') as customs_classification_scheme_cd,
       ctn.customs_tariff_number_descr,
       coalesce(ctn.food_nonfood_type_cd, '-1') as food_nonfood_type_cd,
       coalesce(ctn.food_nonfood_type_name, 'N/A') as food_nonfood_type_name,
       cp.alcoholic_beverage_tax_rate_cd,
       coalesce(ctn.alcoholic_beverage_type_cd, '-1') as alcoholic_beverage_type_cd,
       coalesce(ctn.alcoholic_beverage_type_name, 'N/A') as alcoholic_beverage_type_name,
       cp.alcoholic_beverage_volume_qty,
       cp.alcoholic_beverage_pct,
       cp.alcoholic_beverage_duty_per_unit_val,
       cp.customs_product_name,
       cp.preferential_origin_fg,
       coalesce(p.product_sid, -1) as parent_product_sid,
       coalesce(p.product_name, 'Unknown') as parent_product_name,
cp.DWH_VALID_FROM_TMSP dwh_mapping_tmsp,
cp.dwh_src_file_name,
cp.dwh_src_1_tmsp,
0 tf_error_fg,
0 record_id,
cp.dwh_src_file_name filename,
0 deleted_fg
  from core_rel.t_customs_product_2 cp
  left
  join core_rel.t_customs_product_type_2 cpt
    on cp.customs_product_type_cd = cpt.customs_product_type_cd
  left
  join core_rel.t_country_political_2 ctp_de
    on cp.origin_country_location_sid = ctp_de.location_sid
   and ctp_de.lang_cd =  decode(cp.origin_country_location_sid, -1, '-1', 'DE')
   and ctp_de.DWH_VALID_FG=1
  left 
  join core_rel.t_country_political_2 ctp_en
    on cp.origin_country_location_sid = ctp_en.location_sid
   and ctp_en.lang_cd = decode(cp.origin_country_location_sid, -1, '-1', 'EN')  
   and ctp_en.DWH_VALID_FG=1
  left
  join core.t_dim_customs_tariff_number_2 ctn
    on cp.customs_tariff_code_cd = ctn.customs_tariff_number_cd
   and cp.customs_classification_scheme_cd = ctn.customs_classification_scheme_cd
  left 
  join core_rel.t_product_2 p
    on cp.parent_product_sid = p.product_sid
   and p.dwh_valid_fg = true;
