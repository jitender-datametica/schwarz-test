INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
clearance_dt, authority_country_location_sid, consignor_party_sid, declarant_party_sid, 
import_location_sid, customs_declaration_type_cd, dispatch_country_location_sid, transport_country_location_sid, 
curr_cd, declaration_cnt, duty_paid_val, excise_val,
dwh_mapping_tmsp,
dwh_src_file_name,
dwh_src_1_tmsp,
tf_error_fg,
dwh_load_id,
record_id,
filename,
deleted_fg
)
select ccr.clearance_dt,
       ccr.authority_country_location_sid,
       ccr.consignor_party_sid,
       coalesce(ccr.broker_declarant_party_sid, ccr.importer_declarant_party_sid, -1) as declarant_party_sid,
       ccr.import_location_sid,
       ccr.customs_declaration_type_cd,
       ccr.dispatch_country_location_sid,
       ccr.transport_country_location_sid,
       'GBP' as curr_cd,
       count(distinct ccr.movement_ref_number) as declaration_cnt,
       sum(coalesce(crl.duty_paid_val, 0)) as duty_paid_val,
       sum(case when crl.item_position = 1 
                then coalesce(ccr.total_excise_val, 0) 
                else 0 
            end) as excise_val,
  ccr.dwh_src_1_tmsp dwh_mapping_tmsp,
ccr.dwh_src_file_name,
ccr.dwh_src_1_tmsp,
0 tf_error_fg,
0 as dwh_load_id,
0 record_id,
ccr.dwh_src_file_name filename,
0 deleted_fg
  from core_rel.t_customs_clearance_report_1 ccr
  join core_rel.t_customs_clearance_report_line_1 crl
    on ccr.movement_ref_number = crl.movement_ref_number
 group
    by ccr.clearance_dt,
       ccr.authority_country_location_sid,
       ccr.consignor_party_sid,
       ccr.broker_declarant_party_sid, 
       ccr.importer_declarant_party_sid,
       ccr.import_location_sid,
       ccr.customs_declaration_type_cd,
       ccr.dispatch_country_location_sid,
       ccr.transport_country_location_sid,
ccr.dwh_src_file_name,
ccr.dwh_src_1_tmsp
;
