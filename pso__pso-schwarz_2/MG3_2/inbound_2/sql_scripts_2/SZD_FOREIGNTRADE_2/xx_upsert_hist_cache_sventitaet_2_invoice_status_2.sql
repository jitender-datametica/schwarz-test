INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  invoice_finance_key_type_cd,
  invoice_finance_id, 
  invoice_status_type_cd,
  dwh_src_file_name, 
  dwh_src_1_tmsp,  
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
)
 select distinct ct.invoice_finance_key_type_cd,
  ct.invoice_finance_id, 
  ct.invoice_status_type_cd,
  max(ct.dwh_src_file_name), 
  max(ct.dwh_src_1_tmsp),  
  ct.dwh_mapping_tmsp,
  ct.tf_error_fg,
  ct.deleted_fg,
  ct.record_id,
  max(ct.filename) 
 from (select distinct
 'INVOICE' as  invoice_finance_key_type_cd,
  a.RECHID as invoice_finance_id, 
  case when a.stornokz = 'Y' then 'CANCEL_INVOICE'
            when a.stornokz = 'G' then 'CREDIT_INVOICE'
            when e.inarbeit = 'S' then 'CANCELLED'
            when e.inarbeit = 'Y' then 'CHARGED'
            else 'UNCHARGED'
        end     as invoice_status_type_cd,
  a.dwh_src_file_name, 
  a.dwh_src_1_tmsp as dwh_src_1_tmsp,  
  a.AENDDATUM as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  a.dwh_src_file_name as filename
  from (select rechid,STORNOKZ,AENDDATUM,DWH_SRC_FILE_NAME,DWH_SRC_1_TMSP 
        from etl.t_cache_abrech_2 QUALIFY ROW_NUMBER() OVER (PARTITION BY rechid ORDER BY DWH_SRC_1_TMSP desc) = 1) a 
  join (select entitaetsid,INARBEIT from etl.t_cache_sventitaet_2 QUALIFY ROW_NUMBER() OVER (PARTITION BY entitaetsid ORDER BY DWH_SRC_1_TMSP desc) = 1) e
    on a.rechid = e.entitaetsid) as ct
  left join META.T_FINANCE_KEY_2 fk
  on fk.FINANCE_KEY_TYPE_CD=ct.invoice_finance_key_type_cd
  and ct.invoice_finance_id=fk.FINANCE_NAT_KEY_NR
  left join core_rel.t_invoice_status_2 i
  on fk.FINANCE_SID= i.invoice_FINANCE_SID
  group by 1,2,3,6,7,8,9;
