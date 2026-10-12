INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
customs_procedure_cd,
dwh_mapping_tmsp,
--dwh_valid_fg,
requested_procedure_cd,
requested_procedure_descr,
additional_procedure_cd,
additional_procedure_descr,
customs_procedure_approve_status_cd,
customs_procedure_approve_status_name,
customs_procedure_approved_fg,
dwh_src_file_name,
dwh_src_1_tmsp,
tf_error_fg,
dwh_load_id,
record_id,
filename,
deleted_fg
)
SELECT 
cpc.customs_procedure_cd,
cpc.dwh_src_1_tmsp dwh_mapping_tmsp,
--cpc.dwh_valid_from_tmsp dwh_mapping_tmsp,
--cpc.dwh_valid_fg,
coalesce(crc.requested_procedure_cd, '-1') requested_procedure_cd,
coalesce(crc.requested_procedure_descr, 'Unknown') requested_procedure_descr,
coalesce(cac.additional_procedure_cd, '-1') additional_procedure_cd,
coalesce(cac.additional_procedure_descr, 'Unknown') additional_procedure_descr,
cpa.customs_procedure_approve_status_cd,
cpa.customs_procedure_approve_status_name,
cpa.customs_procedure_approved_fg,
cpc.dwh_src_file_name,
cpc.dwh_src_1_tmsp,
0 as tf_error_fg,
0 as dwh_load_id,
0 record_id,
cpc.dwh_src_file_name filename,
0 deleted_fg
FROM 
core_rel.t_customs_procedure_1 cpc
join core.t_dim_customs_procedure_approve_status_1 cpa
on case when cpc.customs_procedure_cd = '-1' then '-1'
            when cpc.approved_fg = true then 'APPROVED'
            else 'NOT_APPROVED'
        end = cpa.customs_procedure_approve_status_cd
left join core_rel.t_customs_requested_procedure_1 crc
on cpc.requested_procedure_cd = crc.requested_procedure_cd
left join core_rel.t_customs_additional_procedure_1 cac
on cpc.additional_procedure_cd = cac.additional_procedure_cd;
