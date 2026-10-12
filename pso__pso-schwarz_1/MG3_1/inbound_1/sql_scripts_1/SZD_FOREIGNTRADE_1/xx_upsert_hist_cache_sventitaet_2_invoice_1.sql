INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  finance_key_type_cd,
  finance_id,
  invoice_type_cd,
  consignee_party_key_type_cd,
  consignee_party_id,
  consignor_stream_cd,
  invoice_nr,
  booking_type_cd,
  invoice_reference_nr,
  receipt_txt,  
  dwh_src_file_name, 
  dwh_src_1_tmsp,  
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
)
                         
  select  ct.finance_key_type_cd,
   ct.finance_id,
   ct.invoice_type_cd,
   ct.consignee_party_key_type_cd,
   ct.consignee_party_id,
   ct.consignor_stream_cd,
   ct.invoice_nr,
   ct.booking_type_cd,
   ct.invoice_reference_nr,
   ct.receipt_txt,        
   max(ct.dwh_src_file_name), 
   max(ct.dwh_src_1_tmsp),  
  ct.dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  max(filename)
from (select distinct
'INVOICE' as finance_key_type_cd,
  a.RECHID as finance_id,
  'CONSIGNEE_INVOICE' as invoice_type_cd,
  'CONSIGNEE' as consignee_party_key_type_cd,
  UPPER(TRIM(eg.ENTITAETSNR)) as consignee_party_id,
   case when eb.mutterid = 193 then 'LST'
            when eb.mutterid = 23761979 then 'OWIM'
            else '-1'
        end as consignor_stream_cd,
  TRIM(ea.ENTITAETSNR) as invoice_nr,
  TRIM(eb.ENTITAETSNR) as booking_type_cd,
  TRIM(a.REFERENZ) as invoice_reference_nr,
  SUBSTR(TRIM(tx.FREITEXT), 1, 1000) as receipt_txt,        
  a.dwh_src_file_name, 
  a.dwh_src_1_tmsp as dwh_src_1_tmsp,  
  a.AENDDATUM as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  a.dwh_src_file_name as filename
  from (select RECHID,gpid,buchungskzid,REFERENZ,AENDDATUM,dwh_src_file_name,dwh_src_1_tmsp from etl.t_cache_abrech_1 QUALIFY ROW_NUMBER() OVER (PARTITION BY rechid ORDER BY DWH_SRC_1_TMSP desc) = 1) a  
  join (select entitaetsid,ENTITAETSNR from etl.t_cache_sventitaet_1 QUALIFY  ROW_NUMBER() OVER (PARTITION BY entitaetsid ORDER BY DWH_SRC_1_TMSP desc) = 1) eg
    on a.gpid = eg.entitaetsid
  join (select entitaetsid,ENTITAETSNR,mutterid from etl.t_cache_sventitaet_1 QUALIFY ROW_NUMBER() OVER (PARTITION BY entitaetsid ORDER BY DWH_SRC_1_TMSP desc) = 1) eb
    on a.buchungskzid = eb.entitaetsid
  join (select entitaetsid,ENTITAETSNR from etl.t_cache_sventitaet_1 QUALIFY ROW_NUMBER() OVER (PARTITION BY entitaetsid ORDER BY DWH_SRC_1_TMSP desc) = 1) ea
    on a.rechid = ea.entitaetsid 
left join (select entitaetsid,FREITEXT,SPRID,TEXTNR from etl.t_cache_svtext_1  QUALIFY ROW_NUMBER() OVER (PARTITION BY entitaetsid ORDER BY DWH_SRC_1_TMSP desc) = 1) tx
    on a.rechid = tx.entitaetsid 
   and tx.sprid = 165
   and tx.textnr = 1) as ct
left join META.T_FINANCE_KEY_1 fk
   on fk.FINANCE_KEY_TYPE_CD=ct.finance_key_type_cd
   and ct.finance_id=fk.FINANCE_NAT_KEY_NR
   left join core_rel.t_invoice_1 i
   on fk.FINANCE_SID= i.FINANCE_SID
   left join meta.t_party_key_1 pak
   on pak.PARTY_KEY_TYPE_CD  =ct.consignee_party_key_type_cd
   and ct.consignee_party_id=pak.PARTY_NAT_KEY_NR
   left join core_rel.t_invoice_1 ip1
   on pak.party_sid= ip1.consignee_party_sid
   group by 1,2,3,4,5,6,7,8,9,10,13,14,15,16;
