INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
cds_acceptance_dt,
authority_country_location_sid,
broker_declarant_party_sid,
consignor_party_sid,
customs_declaration_type_cd,
customs_product_sid,
customs_procedure_cd,
total_line_cnt,
alcoholic_line_cnt,
non_alcoholic_line_cnt,
dwh_mapping_tmsp,
dwh_src_file_name,
dwh_src_1_tmsp,
tf_error_fg,
dwh_load_id,
record_id,
filename,
deleted_fg
)
 SELECT 
coalesce(br.cds_acceptance_dt, br.cds_clearance_dt, trunc(br.acceptance_tmsp, 'dd')) as cds_acceptance_dt,
       br.authority_country_location_sid,
       br.broker_declarant_party_sid,
       br.consignor_party_sid,
       br.customs_declaration_type_cd,
       brl.customs_product_sid,
       brl.customs_procedure_cd,
       count(*) as total_line_cnt,
       sum(case when rl.customs_tariff_code_type_cd is not null then 1 else 0 end) as alcoholic_line_cnt,
       sum(case when rl.customs_tariff_code_type_cd is null then 1 else 0 end) as non_alcoholic_line_cnt,
max(br.dwh_src_1_tmsp) dwh_mapping_tmsp,
max(br.dwh_src_file_name),
max(br.dwh_src_1_tmsp),
0 tf_error_fg,
0 as dwh_load_id,
0 record_id,
max(br.dwh_src_file_name)  filename,
0 deleted_fg
 from core_rel.t_broker_report_2 br
  join core_rel.t_broker_report_line_2 brl
    on br.movement_ref_number = brl.movement_ref_number
  join core_rel.t_customs_product_2 cp
    on brl.customs_product_sid = cp.product_sid
     and cp.DWH_VALID_FG=1
  left
  join core_rel.t_customs_tariff_code_type_rel_2 rl
    on cp.customs_tariff_code_cd = rl.customs_tariff_code_cd
   and rl.customs_tariff_category_cd = 'ABV'
 group
    by 1, 2, 3, 4, 5, 6, 7,14,15,16,18
;
