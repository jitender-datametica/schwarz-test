INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  movement_ref_number,
  authority_country_location_sid,
  importer_party_sid,  
  importer_declarant_party_sid,
  broker_declarant_party_sid,
  customs_declaration_type_cd,
  export_country_location_sid,
  cds_acceptance_dt,
  cds_acceptance_tmsp,
  cds_clearance_dt,
  cds_clearance_tmsp,
  acceptance_tmsp,
  trader_reference,
  consignor_party_sid,
  consignor_name,
  first_deferment,
  goods_location,
  trade_terms, 
  trade_terms_location,
  declaration_ucr,  
  total_packages_cnt,
  excise_payment_amount_val,
  value_for_duty_val,
  duty_payment_amount_val,    
  duty_tax_assessed_amount_val, 
  value_for_vat_val,
  vat_payment_amount_val,
  vat_tax_assessed_amount_val,
  dwh_src_file_name,
  dwh_src_1_tmsp,
  dwh_mapping_tmsp,
  tf_error_fg,
  dwh_valid_fg,
  deleted_fg,
  record_id,
  filename  
)
   select  mrn as movement_ref_number,
  COALESCE(L1.LOCATION_SID, -1) as authority_country_location_sid,
  COALESCE(p1.importer_party_sid,p2.party_sid, -1) importer_party_sid,  
  COALESCE(p3.party_sid, -1) as importer_declarant_party_sid,
  COALESCE(p4.party_sid, -1) broker_declarant_party_sid,
  job_type_code as customs_declaration_type_cd,
  COALESCE(L2.LOCATION_SID, -1) as export_country_location_sid,
  case 
        when trim(cds_acceptance_date)='' or trim(cds_acceptance_date)='NULL' 
                then date('1900-01-01')  
        when substring(cds_acceptance_date,2,1)='/' 
                then COALESCE(date(SUBSTR('0'||cds_acceptance_date, 1, 10), 'DD/MM/YYYY'), date('1900-01-01'))
        when substring(cds_acceptance_date,5,1)='-' 
                then  COALESCE(date(SUBSTR(cds_acceptance_date, 1, 10), 'YYYY-MM-DD'), date('1900-01-01')) 
        else COALESCE(date(SUBSTR(cds_acceptance_date, 1, 10), 'DD/MM/YYYY'), date('1900-01-01')) end as cds_acceptance_dt,
  case 
        when trim(cds_acceptance_date)='' or trim(cds_acceptance_date)='NULL' 
                then  TO_TIMESTAMP_TZ('1900-01-01', 'YYYY-MM-DD') 
        when length(trim(cds_acceptance_date))=10 and substring(cds_acceptance_date,5,1)='-'  then TO_TIMESTAMP_TZ(SUBSTR(cds_acceptance_date, 1,10), 'YYYY-MM-DD')
         when length(trim(cds_acceptance_date))=10 and substring(cds_acceptance_date,3,1)='/'  then TO_TIMESTAMP_TZ(SUBSTR(cds_acceptance_date, 1,10), 'DD/MM/YYYY')
        else COALESCE(TO_TIMESTAMP_TZ(SUBSTR(cds_acceptance_date, 1, 19), 'DD/MM/YYYY HH24:MI:SS'),  TO_TIMESTAMP_TZ('1900-01-01', 'YYYY-MM-DD')) end as cds_acceptance_tmsp,
  case 
        when trim(cds_clearance_date)='' or trim(cds_clearance_date)='NULL' 
                then date('1900-01-01')
         when substring(cds_clearance_date,2,1)='/' 
                then COALESCE(date(SUBSTR('0'||cds_clearance_date, 1, 10), 'DD/MM/YYYY'), date('1900-01-01'))
        when substring(cds_clearance_date,5,1)='-' 
                then COALESCE(date(SUBSTR(TRIM(cds_clearance_date), 1, 10), 'YYYY-MM-DD'), date('1900-01-01')) 
        else COALESCE(date(SUBSTR(TRIM(cds_clearance_date), 1, 10), 'DD/MM/YYYY'), date('1900-01-01')) end as cds_clearance_dt,
  case 
        when trim(cds_clearance_date)='' or trim(cds_clearance_date)='NULL' 
                then  TO_TIMESTAMP_TZ('1900-01-01', 'YYYY-MM-DD') 
        when substring(cds_clearance_date,5,1)='-' 
                then COALESCE(TO_TIMESTAMP_TZ(SUBSTR(TRIM(cds_clearance_date), 1, 10)||' 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),  TO_TIMESTAMP_TZ('1900-01-01', 'YYYY-MM-DD')) 
        else COALESCE(TO_TIMESTAMP_TZ(SUBSTR(TRIM(cds_clearance_date), 1, 10)||' 00:00:00', 'DD/MM/YYYY HH24:MI:SS'),  TO_TIMESTAMP_TZ('1900-01-01', 'YYYY-MM-DD')) end as cds_clearance_tmsp,
  case 
        when trim(acceptance_date_time)='' or trim(acceptance_date_time)='NULL' 
                then TO_TIMESTAMP_TZ('1900-01-01', 'YYYY-MM-DD')  
        when  substring(acceptance_date_time,5,1)='-' 
                then COALESCE(TO_TIMESTAMP_TZ(SUBSTR(TRIM(acceptance_date_time), 1, 10)||' 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),  TO_TIMESTAMP_TZ('1900-01-01', 'YYYY-MM-DD'))
        else COALESCE(TO_TIMESTAMP_TZ(SUBSTR(TRIM(acceptance_date_time), 1, 10)||' 00:00:00', 'DD/MM/YYYY HH24:MI:SS'),  TO_TIMESTAMP_TZ('1900-01-01', 'YYYY-MM-DD')) end as acceptance_tmsp,
  trader_reference as trader_reference,
  COALESCE(p1.party_sid, -1) as consignor_party_sid,
  cc.consignor_name as consignor_name,
  case when dan_1='NULL' then null else dan_1 end as first_deferment,
  goods_location as goods_location,
  trade_terms_description as trade_terms, 
  trade_terms_location_id as trade_terms_location,
  decln_ucr as declaration_ucr,  
  case when trim(total_package_quantity)='' or trim(total_package_quantity)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(total_package_quantity), 0) end as total_packages_cnt,
  case when trim(excise_payment_amount)='' or trim(excise_payment_amount)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(excise_payment_amount, 38, 6), 0) end as excise_payment_amount_val,
  case when trim(value_for_duty)='' or trim(value_for_duty)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(value_for_duty, 38, 6), 0) end as value_for_duty_val,
  case when trim(duty_payment_amount)='' or trim(duty_payment_amount)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(duty_payment_amount, 38, 6), 0) end as duty_payment_amount_val,    
  case when trim(duty_tax_assessed_amount)='' or trim(duty_tax_assessed_amount)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(duty_tax_assessed_amount, 38, 6), 0) end as duty_tax_assessed_amount_val, 
  case when trim(value_for_vat)='' or trim(value_for_vat)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(value_for_vat, 38, 6), 0) end as value_for_vat_val,
  case when trim(vat_payment_amount)='' or trim(vat_payment_amount)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(vat_payment_amount, 38, 6), 0) end as vat_payment_amount_val,
  case when trim(vat_taxassessed_amount)='' or trim(vat_taxassessed_amount)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(vat_taxassessed_amount, 38, 6), 0) end as vat_tax_assessed_amount_val,
  --dwh_src_file_name as dwh_src_file_name,
  MAX(cc.dwh_src_file_name) over (partition by MOVEMENT_REF_NUMBER, TRADER_REFERENCE)  as dwh_src_file_name,
  cc.dwh_src_1_tmsp as dwh_src_1_tmsp,  
  cc.dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as dwh_valid_fg,
  0 as deleted_fg,
  0 as record_id,
  --dwh_src_file_name as filename,
  MAX(cc.dwh_src_file_name) over (partition by MOVEMENT_REF_NUMBER, TRADER_REFERENCE)  as filename
  from etl.t_cache_ceva cc
LEFT JOIN meta.t_location_key l1
ON l1.LOCATION_KEY_TYPE_CD  ='COUNTRY'
AND L1.LOCATION_NAT_KEY_NR = 'GB'
/*LEFT JOIN meta.t_party_key p1
ON p1.PARTY_KEY_TYPE_CD ='CONSIGNOR'
AND p1.PARTY_NAT_KEY_NR = NULLIF(UPPER(cc.consignor_name), 'NULL')  */
left join core_rel.t_consignor p1
on Upper(cc.Consignor_Name) = Upper(p1.Consignor_Name)
and cc.dwh_src_1_tmsp between p1.dwh_valid_from_tmsp and p1.dwh_valid_to_tmsp
LEFT JOIN meta.t_party_key p2
ON p2.PARTY_KEY_TYPE_CD ='IMPORTER'
AND p2.PARTY_NAT_KEY_NR = NULLIF(UPPER(cc.importer_EORI), 'NULL')  
LEFT JOIN meta.t_party_key p3
ON p3.PARTY_KEY_TYPE_CD ='IMPORTER'
AND p3.PARTY_NAT_KEY_NR = NULLIF(UPPER(cc.declarant_EORI), 'NULL')
LEFT JOIN meta.t_party_key p4
ON p4.PARTY_KEY_TYPE_CD ='BROKER'
AND p4.PARTY_NAT_KEY_NR = NULLIF(UPPER(cc.declarant_EORI), 'NULL')
LEFT JOIN meta.t_location_key l2
ON l2.LOCATION_KEY_TYPE_CD  ='COUNTRY'
AND L2.LOCATION_NAT_KEY_NR = NULLIF(UPPER(cc.export_country), 'NULL')
where job_type_code in ('IMY', 'IMA', 'IMD')
UNION 
select  
  mrn as movement_ref_number,
  COALESCE(L1.LOCATION_SID, -1) as authority_country_location_sid,
  COALESCE(p1.importer_party_sid,p2.party_sid, -1) importer_party_sid,  
  COALESCE(p3.party_sid, -1) as importer_declarant_party_sid,
  COALESCE(p4.party_sid, -1) broker_declarant_party_sid,
  job_type_code as customs_declaration_type_cd,
  COALESCE(L2.LOCATION_SID, -1) as export_country_location_sid,
   case 
        when trim(cds_acceptance_date)='' or trim(cds_acceptance_date)='NULL' 
                then date('1900-01-01')  
        when  substring(cds_acceptance_date,3,1)='/' then to_date(SUBSTR(cds_acceptance_date, 1, 10), 'DD/MM/YYYY')
        when  substring(cds_acceptance_date,5,1)='-' then to_date(SUBSTR(cds_acceptance_date, 1, 10), 'YYYY-MM-DD')
        else COALESCE(date(SUBSTR(cds_acceptance_date, 1, 10), 'YYYY-MM-DD'), date('1900-01-01')) end as cds_acceptance_dt,
  case 
        when trim(cds_acceptance_date)='' or trim(cds_acceptance_date)='NULL' 
                then  TO_TIMESTAMP_TZ('1900-01-01', 'YYYY-MM-DD') 
        when  substring(cds_acceptance_date,3,1)='/' then to_date(SUBSTR(cds_acceptance_date, 1, 10), 'DD/MM/YYYY')
        when  substring(cds_acceptance_date,5,1)='-' then to_date(SUBSTR(cds_acceptance_date, 1, 10), 'YYYY-MM-DD')
        else COALESCE(TO_TIMESTAMP_TZ(SUBSTR(cds_acceptance_date, 1, 19), 'YYYY-MM-DD'),  TO_TIMESTAMP_TZ('01/01/1900', 'YYYY-MM-DD')) end as cds_acceptance_tmsp,
  case 
        when trim(cds_clearance_date)='' or trim(cds_clearance_date)='NULL' 
                then date('1900-01-01')  
                   when substring(trim(cds_clearance_date),3,1)='/' then to_date(SUBSTR(cds_clearance_date, 1, 10), 'DD/MM/YYYY')
        when substring(trim(cds_clearance_date),5,1)='-' then to_date(SUBSTR(cds_clearance_date, 1, 10), 'YYYY-MM-DD')
        else COALESCE(date(SUBSTR(cds_clearance_date, 1, 10), 'YYYY-MM-DD'), date('1900-01-01')) end as cds_clearance_dt,
  case 
        when trim(cds_clearance_date)='' or trim(cds_clearance_date)='NULL' 
                then  TO_TIMESTAMP_TZ('1900-01-01', 'YYYY-MM-DD') 
        when substring(trim(cds_clearance_date),3,1)='/' then to_date(SUBSTR(cds_clearance_date, 1, 10), 'DD/MM/YYYY')
        when substring(trim(cds_clearance_date),5,1)='-' then to_date(SUBSTR(cds_clearance_date, 1, 10), 'YYYY-MM-DD')
        else COALESCE(TO_TIMESTAMP_TZ(SUBSTR(cds_clearance_date, 1, 19), 'YYYY-MM-DD'),  TO_TIMESTAMP_TZ('1900-01-01', 'YYYY-MM-DD')) end as cds_clearance_tmsp,
  case 
        when trim(acceptance_date_time)='' or trim(acceptance_date_time)='NULL' 
                then TO_TIMESTAMP_TZ('1900-01-01', 'YYYY-MM-DD')  
        when length(trim(acceptance_date_time))=10 and substring(acceptance_date_time,3,1)='/' then to_date(SUBSTR(acceptance_date_time, 1, 10), 'DD/MM/YYYY')
        when length(trim(acceptance_date_time))=10 and substring(acceptance_date_time,5,1)='-' then to_date(SUBSTR(acceptance_date_time, 1, 10), 'YYYY-MM-DD')
        when length(trim(acceptance_date_time))=19 and substring(acceptance_date_time,3,1)='/' then to_date(SUBSTR(acceptance_date_time, 1, 10), 'DD/MM/YYYY' )
        else COALESCE(to_date(SUBSTR(acceptance_date_time, 1, 10), 'YYYY-MM-DD'),  to_date('1900-01-01', 'YYYY-MM-DD')) end as acceptance_tmsp,
  trader_reference as trader_reference,
  COALESCE(p1.party_sid, -1) as consignor_party_sid,
  cml.consignor_name as consignor_name,
   case when dan_1='NULL' then null else dan_1 end  as first_deferment,
  goods_location,
  trade_terms_condition_code as trade_terms, 
  trade_terms_location_name     as trade_terms_location,
  decln_ucr as declaration_ucr,  
  case when trim(total_package_quantity)='' or trim(total_package_quantity)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(total_package_quantity), 0) end as total_packages_cnt,
  case when trim(excise_payment_amount)='' or trim(excise_payment_amount)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(excise_payment_amount, 38, 6), 0) end as excise_payment_amount_val,
  case when trim(value_for_duty)='' or trim(value_for_duty)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(value_for_duty, 38, 6), 0) end as value_for_duty_val,
  case when trim(duty_payment_amount)='' or trim(duty_payment_amount)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(duty_payment_amount, 38, 6), 0) end as duty_payment_amount_val,    
  case when trim(duty_tax_assessed_amount)='' or trim(duty_tax_assessed_amount)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(duty_tax_assessed_amount, 38, 6), 0) end as duty_tax_assessed_amount_val, 
  case when trim(value_for_vat)='' or trim(value_for_vat)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(value_for_vat, 38, 6), 0) end as value_for_vat_val,
  case when trim(vat_payment_amount)='' or trim(vat_payment_amount)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(vat_payment_amount, 38, 6), 0) end as vat_payment_amount_val,
  case when trim(vat_taxassessed_amount)='' or trim(vat_taxassessed_amount)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(vat_taxassessed_amount, 38, 6), 0) end as vat_tax_assessed_amount_val,
  --dwh_src_file_name as dwh_src_file_name,
  MAX(cml.dwh_src_file_name) over (partition by MOVEMENT_REF_NUMBER, TRADER_REFERENCE)  as dwh_src_file_name,
  cml.dwh_src_1_tmsp as dwh_src_1_tmsp,  
  cml.dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as dwh_valid_fg,
  0 as deleted_fg,
  0 as record_id,
  --dwh_src_file_name as filename,
  MAX(cml.dwh_src_file_name) over (partition by MOVEMENT_REF_NUMBER, TRADER_REFERENCE)  as filename
  from etl.t_cache_maersk_lgb cml
LEFT JOIN meta.t_location_key l1
ON l1.LOCATION_KEY_TYPE_CD  ='COUNTRY'
AND L1.LOCATION_NAT_KEY_NR = 'GB'
/*LEFT JOIN meta.t_party_key p1
ON p1.PARTY_KEY_TYPE_CD ='CONSIGNOR'
AND p1.PARTY_NAT_KEY_NR = NULLIF(cml.consignor_name, 'NULL') */
left join core_rel.t_consignor p1
on Upper(cml.Consignor_Name) = Upper(p1.Consignor_Name)
and cml.dwh_src_1_tmsp between p1.dwh_valid_from_tmsp and p1.dwh_valid_to_tmsp
LEFT JOIN meta.t_party_key p2
ON p2.PARTY_KEY_TYPE_CD ='IMPORTER'
AND p2.PARTY_NAT_KEY_NR = NULLIF(cml.importer_EORI, 'NULL')
LEFT JOIN meta.t_party_key p3
ON p3.PARTY_KEY_TYPE_CD ='IMPORTER'
AND p3.PARTY_NAT_KEY_NR = NULLIF(cml.declarant_EORI, 'NULL')
LEFT JOIN meta.t_party_key p4
ON p4.PARTY_KEY_TYPE_CD ='BROKER'
AND p4.PARTY_NAT_KEY_NR = NULLIF(cml.declarant_EORI, 'NULL')
LEFT JOIN meta.t_location_key l2
ON l2.LOCATION_KEY_TYPE_CD  ='COUNTRY'
AND L2.LOCATION_NAT_KEY_NR = NULLIF(cml.export_country, 'NULL')
where job_type_code in ('IMY', 'IMA', 'IMD')
UNION
select  
  mrn as movement_ref_number,
  COALESCE(L1.LOCATION_SID, -1) as authority_country_location_sid,
  COALESCE(p1.importer_party_sid,p2.party_sid, -1) importer_party_sid,  
  COALESCE(p3.party_sid, -1) as importer_declarant_party_sid,
  COALESCE(p4.party_sid, -1) broker_declarant_party_sid,
  job_type_code as customs_declaration_type_cd,
  COALESCE(L2.LOCATION_SID, -1) as export_country_location_sid,
  case 
        when trim(cds_acceptance_date)='' or trim(cds_acceptance_date)='NULL' 
                then date('1900-01-01')  
        when  substring(cds_acceptance_date,3,1)='/' then to_date(SUBSTR(cds_acceptance_date, 1, 10), 'DD/MM/YYYY')
        when  substring(cds_acceptance_date,5,1)='-' then to_date(SUBSTR(cds_acceptance_date, 1, 10), 'YYYY-MM-DD')
        else COALESCE(date(SUBSTR(cds_acceptance_date, 1, 10), 'YYYY-MM-DD'), date('1900-01-01')) end as cds_acceptance_dt,
  case 
        when trim(cds_acceptance_date)='' or trim(cds_acceptance_date)='NULL' 
                then  TO_TIMESTAMP_TZ('1900-01-01', 'YYYY-MM-DD') 
        when  substring(cds_acceptance_date,3,1)='/' then to_date(SUBSTR(cds_acceptance_date, 1, 10), 'DD/MM/YYYY')
        when  substring(cds_acceptance_date,5,1)='-' then to_date(SUBSTR(cds_acceptance_date, 1, 10), 'YYYY-MM-DD')
        else COALESCE(TO_TIMESTAMP_TZ(SUBSTR(cds_acceptance_date, 1, 19), 'YYYY-MM-DD'),  TO_TIMESTAMP_TZ('01/01/1900', 'YYYY-MM-DD')) end as cds_acceptance_tmsp,
  case 
        when trim(cds_clearance_date)='' or trim(cds_clearance_date)='NULL' 
                then date('1900-01-01')  
                   when substring(trim(cds_clearance_date),3,1)='/' then to_date(SUBSTR(cds_clearance_date, 1, 10), 'DD/MM/YYYY')
        when substring(trim(cds_clearance_date),5,1)='-' then to_date(SUBSTR(cds_clearance_date, 1, 10), 'YYYY-MM-DD')
        else COALESCE(date(SUBSTR(cds_clearance_date, 1, 10), 'YYYY-MM-DD'), date('1900-01-01')) end as cds_clearance_dt,
  case 
        when trim(cds_clearance_date)='' or trim(cds_clearance_date)='NULL' 
                then  TO_TIMESTAMP_TZ('1900-01-01', 'YYYY-MM-DD') 
        when substring(trim(cds_clearance_date),3,1)='/' then to_date(SUBSTR(cds_clearance_date, 1, 10), 'DD/MM/YYYY')
        when substring(trim(cds_clearance_date),5,1)='-' then to_date(SUBSTR(cds_clearance_date, 1, 10), 'YYYY-MM-DD')
        else COALESCE(TO_TIMESTAMP_TZ(SUBSTR(cds_clearance_date, 1, 19), 'YYYY-MM-DD'),  TO_TIMESTAMP_TZ('1900-01-01', 'YYYY-MM-DD')) end as cds_clearance_tmsp,
  case 
        when trim(acceptance_date_time)='' or trim(acceptance_date_time)='NULL' 
                then TO_TIMESTAMP_TZ('1900-01-01', 'YYYY-MM-DD')  
        when length(trim(acceptance_date_time))=10 and substring(acceptance_date_time,3,1)='/' then to_date(SUBSTR(acceptance_date_time, 1, 10), 'DD/MM/YYYY')
        when length(trim(acceptance_date_time))=10 and substring(acceptance_date_time,5,1)='-' then to_date(SUBSTR(acceptance_date_time, 1, 10), 'YYYY-MM-DD')
        when length(trim(acceptance_date_time))=19 and substring(acceptance_date_time,3,1)='/' then to_date(SUBSTR(acceptance_date_time, 1, 10), 'DD/MM/YYYY' )
        else COALESCE(to_date(SUBSTR(acceptance_date_time, 1, 10), 'YYYY-MM-DD'),  to_date('1900-01-01', 'YYYY-MM-DD')) end as acceptance_tmsp,
  trader_reference as trader_reference,
  COALESCE(p1.party_sid, -1) as consignor_party_sid,
  cmlkt.consignor_name as consignor_name,
   case when dan_1='NULL' then null else dan_1 end  as first_deferment,
  goods_location as goods_location,
  trade_terms_condition_code as trade_terms, 
  trade_terms_location_id as trade_terms_location,
  decln_ucr as declaration_ucr,  
  case when trim(total_package_quantity)='' or trim(total_package_quantity)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(total_package_quantity), 0) end as total_packages_cnt,
  case when trim(excise_payment_amount)='' or trim(excise_payment_amount)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(excise_payment_amount, 38, 6), 0) end as excise_payment_amount_val,
  case when trim(value_for_duty)='' or trim(value_for_duty)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(value_for_duty, 38, 6), 0) end as value_for_duty_val,
  case when trim(duty_payment_amount)='' or trim(duty_payment_amount)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(duty_payment_amount, 38, 6), 0) end as duty_payment_amount_val,    
  case when trim(duty_tax_assessed_amount)='' or trim(duty_tax_assessed_amount)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(duty_tax_assessed_amount, 38, 6), 0) end as duty_tax_assessed_amount_val, 
  case when trim(value_for_vat)='' or trim(value_for_vat)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(value_for_vat, 38, 6), 0) end as value_for_vat_val,
  case when trim(vat_payment_amount)='' or trim(vat_payment_amount)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(vat_payment_amount, 38, 6), 0) end as vat_payment_amount_val,
  case when trim(vat_taxassessed_amount)='' or trim(vat_taxassessed_amount)='NULL' then 0 else COALESCE(TRY_TO_NUMBER(vat_taxassessed_amount, 38, 6), 0) end as vat_tax_assessed_amount_val,
  --dwh_src_file_name as dwh_src_file_name,
  MAX(cmlkt.dwh_src_file_name) over (partition by MOVEMENT_REF_NUMBER, TRADER_REFERENCE)  as dwh_src_file_name,
  cmlkt.dwh_src_1_tmsp as dwh_src_1_tmsp,  
  cmlkt.dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as dwh_valid_fg,
  0 as deleted_fg,
  0 as record_id,
  --dwh_src_file_name as filename,
  MAX(cmlkt.dwh_src_file_name) over (partition by MOVEMENT_REF_NUMBER, TRADER_REFERENCE)  as filename
  from etl.t_cache_maersk_lukt cmlkt
  LEFT JOIN meta.t_location_key l1
ON l1.LOCATION_KEY_TYPE_CD  ='COUNTRY'
AND L1.LOCATION_NAT_KEY_NR = 'GB'
/*LEFT JOIN meta.t_party_key p1
ON p1.PARTY_KEY_TYPE_CD ='CONSIGNOR'
AND p1.PARTY_NAT_KEY_NR = NULLIF(cmlkt.consignor_name, 'NULL') */ 
left join core_rel.t_consignor p1
on Upper(cmlkt.Consignor_Name) = Upper(p1.Consignor_Name)
and cmlkt.dwh_src_1_tmsp between p1.dwh_valid_from_tmsp and p1.dwh_valid_to_tmsp
LEFT JOIN meta.t_party_key p2
ON p2.PARTY_KEY_TYPE_CD ='IMPORTER'
AND p2.PARTY_NAT_KEY_NR = NULLIF(cmlkt.importer_EORI, 'NULL')
LEFT JOIN meta.t_party_key p3
ON p3.PARTY_KEY_TYPE_CD ='IMPORTER'
AND p3.PARTY_NAT_KEY_NR = NULLIF(cmlkt.declarant_EORI, 'NULL')
LEFT JOIN meta.t_party_key p4
ON p4.PARTY_KEY_TYPE_CD ='BROKER'
AND p4.PARTY_NAT_KEY_NR = NULLIF(cmlkt.declarant_EORI, 'NULL')
LEFT JOIN meta.t_location_key l2
ON l2.LOCATION_KEY_TYPE_CD  ='COUNTRY'
AND L2.LOCATION_NAT_KEY_NR = NULLIF(cmlkt.export_country, 'NULL')
where job_type_code in ('IMY', 'IMA', 'IMD');
