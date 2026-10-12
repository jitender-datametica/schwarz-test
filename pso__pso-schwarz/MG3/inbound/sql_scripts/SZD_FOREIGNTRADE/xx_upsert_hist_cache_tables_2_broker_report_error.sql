INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  movement_ref_number,
  item_position,
  broker_declarant_party_key_type_cd,
  broker_declarant_party_cd, 
  cds_acceptance_dt,
  attribute_name,attribute_value_txt,
  dwh_valid_fg,
  dwh_src_file_name, 
  dwh_src_1_tmsp,  
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename 
)
 select distinct movement_ref_number,
  item_position,
  broker_declarant_party_key_type_cd,
  broker_declarant_party_cd, 
  COALESCE(cds_acceptance_date, cds_clearance_date, TRUNC(acceptance_date_time, 'dd'), date('1900-01-01')) as cds_acceptance_dt,
  case when try_to_number(coalesce(total_package_quantity, '0')) is null then 'Total Packages Quantity'
            when try_to_number(coalesce(excise_payment_amount, '0')) is null then 'Excise Payment Amount'
            when try_to_number(coalesce(value_for_duty, '0')) is null then 'Value for Duty'
            when try_to_number(coalesce(duty_payment_amount, '0')) is null then 'Duty Payment Amount'
            when try_to_number(coalesce(duty_tax_assessed_amount, '0')) is null then 'Duty Tax Assessed Amount'
            when try_to_number(coalesce(value_for_vat, '0')) is null then 'Value for VAT'
            when try_to_number(coalesce(vat_payment_amount, '0')) is null then 'VAT Payment Amount'
            when try_to_number(coalesce(vat_taxassessed_amount, '0')) is null then 'VAT Tax Assessed Amount'
            when try_to_number(coalesce(case when charindex('_', item_product) > 0
                                             then substr(item_product, 1, charindex('_', item_product) - 1)
                                             else item_product
                                         end, '0')) is null then 'Item Product'
            when try_to_number(coalesce(item_gross_mass_measure, '0')) is null then 'Gross Mass Measure'
            when try_to_number(coalesce(item_net_weight_measure, '0')) is null then 'Net Weight Measure'
            when try_to_number(coalesce(item_charge_amount, '0')) is null then 'Item Charge Amount'
            when try_to_number(coalesce(item_pieces, '0')) is null then 'Item Pieces'
            when try_to_number(coalesce(item_tariff_quantity, '0')) is null then 'Item Tariff Quantity'
            when try_to_number(coalesce(item_excise_payment_amount, '0')) is null then 'Item Excise Payment Amount'
            when try_to_number(coalesce(item_value_for_duty, '0')) is null then 'Item Value for Duty'
            when try_to_number(coalesce(item_duty_payment_amount, '0')) is null then 'Item Duty Payment Amount'
            when try_to_number(coalesce(item_value_for_vat, '0')) is null then 'Item Value for VAT'
            when try_to_number(coalesce(item_vat_payment_amount, '0')) is null then 'VAT Payment Amount'
            when try_to_number(coalesce(item_vat_tax_assessed_amount, '0')) is null then 'VAT Tax Assessed Amount'
            end as attribute_name,          
        case when try_to_number(coalesce(total_package_quantity, '0')) is null then total_package_quantity
            when try_to_number(coalesce(excise_payment_amount, '0')) is null then excise_payment_amount
            when try_to_number(coalesce(value_for_duty, '0')) is null then value_for_duty
            when try_to_number(coalesce(duty_payment_amount, '0')) is null then duty_payment_amount
            when try_to_number(coalesce(duty_tax_assessed_amount, '0')) is null then duty_tax_assessed_amount
            when try_to_number(coalesce(value_for_vat, '0')) is null then value_for_vat
            when try_to_number(coalesce(vat_payment_amount, '0')) is null then vat_payment_amount
            when try_to_number(coalesce(vat_taxassessed_amount, '0')) is null then vat_taxassessed_amount
            when try_to_number(coalesce(case when charindex('_', item_product) > 0
                                             then substr(item_product, 1, charindex('_', item_product) - 1)
                                             else item_product
                                         end, '0')) is null then item_product
            when try_to_number(coalesce(item_gross_mass_measure, '0')) is null then item_gross_mass_measure
            when try_to_number(coalesce(item_net_weight_measure, '0')) is null then item_net_weight_measure
            when try_to_number(coalesce(item_charge_amount, '0')) is null then item_charge_amount
            when try_to_number(coalesce(item_pieces, '0')) is null then item_pieces
            when try_to_number(coalesce(item_tariff_quantity, '0')) is null then item_tariff_quantity
            when try_to_number(coalesce(item_excise_payment_amount, '0')) is null then item_excise_payment_amount
            when try_to_number(coalesce(item_value_for_duty, '0')) is null then item_value_for_duty
            when try_to_number(coalesce(item_duty_payment_amount, '0')) is null then item_duty_payment_amount
            when try_to_number(coalesce(item_value_for_vat, '0')) is null then item_value_for_vat
            when try_to_number(coalesce(item_vat_payment_amount, '0')) is null then item_vat_payment_amount
            when try_to_number(coalesce(item_vat_tax_assessed_amount, '0')) is null then item_vat_tax_assessed_amount
        end as attribute_value_txt,  
  dwh_valid_fg,
  dwh_src_file_name, 
  dwh_src_1_tmsp,  
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
  from(
  select job_type_code,
  mrn as movement_ref_number,
  coalesce(item_sequence_number,'-1') as item_position,
  'BROKER' as broker_declarant_party_key_type_cd,
  declarant_eori as broker_declarant_party_cd,  
  case when trim(cds_acceptance_date)='' or trim(cds_acceptance_date)='NULL' then NULL 
  when substring(cds_acceptance_date,5,1)='-' then date(SUBSTR(cds_acceptance_date, 1, 10), 'YYYY-MM-DD') 
  else date(SUBSTR(cds_acceptance_date, 1, 10), 'DD/MM/YYYY') end  as cds_acceptance_date,
  case when trim(cds_clearance_date)='' or trim(cds_clearance_date)='NULL' then NULL 
  when substring(cds_clearance_date,5,1)='-' then date(SUBSTR(cds_clearance_date, 1, 10), 'YYYY-MM-DD') else date(SUBSTR(cds_clearance_date, 1, 10), 'DD/MM/YYYY') end as cds_clearance_date,
  case when trim(acceptance_date_time)='' or trim(acceptance_date_time)='NULL' then NULL 
  when substring(acceptance_date_time,5,1)='-' then date(SUBSTR(acceptance_date_time, 1, 10), 'YYYY-MM-DD') 
  else date(SUBSTR(acceptance_date_time, 1, 10), 'DD/MM/YYYY') end as acceptance_date_time,
  case when trim(total_package_quantity)='' or trim(total_package_quantity)='NULL' then NULL else total_package_quantity end as total_package_quantity,
  case when trim(excise_payment_amount)='' or trim(excise_payment_amount)='NULL' then NULL else excise_payment_amount end as excise_payment_amount,
  case when trim(value_for_duty)='' or trim(value_for_duty)='NULL' then NULL else value_for_duty end as value_for_duty,
  case when trim(duty_payment_amount)='' or trim(duty_payment_amount)='NULL' then NULL else duty_payment_amount end as duty_payment_amount,
  case when trim(duty_tax_assessed_amount)='' or trim(duty_tax_assessed_amount)='NULL' then NULL else duty_tax_assessed_amount end as duty_tax_assessed_amount,
  case when trim(value_for_vat)='' or trim(value_for_vat)='NULL' then NULL else value_for_vat end as value_for_vat,
  case when trim(vat_payment_amount)='' or trim(vat_payment_amount)='NULL' then NULL else vat_payment_amount end as vat_payment_amount,
  case when trim(vat_taxassessed_amount)='' or trim(vat_taxassessed_amount)='NULL' then NULL else vat_taxassessed_amount end as vat_taxassessed_amount,
  case when trim(item_product)='' or trim(item_product)='NULL' then NULL else item_product end as item_product,
  case when trim(item_gross_mass_measure)='' or trim(item_gross_mass_measure)='NULL' then NULL else item_gross_mass_measure end as item_gross_mass_measure,
  case when trim(item_net_weight_measure)='' or trim(item_net_weight_measure)='NULL' then NULL else item_net_weight_measure end as item_net_weight_measure,
  case when trim(item_charge_amount)='' or trim(item_charge_amount)='NULL' then NULL else item_charge_amount end as item_charge_amount,
  case when trim(item_pieces)='' or trim(item_pieces)='NULL' then NULL else item_pieces end as item_pieces,
  case when trim(item_tariff_quantity)='' or trim(item_tariff_quantity)='NULL' then NULL else item_tariff_quantity end as item_tariff_quantity, 
  case when trim(item_excise_payment_amount)='' or trim(item_excise_payment_amount)='NULL' then NULL else item_excise_payment_amount end as item_excise_payment_amount,
  case when trim(item_value_for_duty)='' or trim(item_value_for_duty)='NULL' then NULL else item_value_for_duty end as item_value_for_duty, 
  case when trim(item_duty_payment_amount)='' or trim(item_duty_payment_amount)='NULL' then NULL else item_duty_payment_amount end as item_duty_payment_amount,
  case when trim(item_value_for_vat)='' or trim(item_value_for_vat)='NULL' then NULL else item_value_for_vat end as item_value_for_vat,
  case when trim(item_vat_payment_amount)='' or trim(item_vat_payment_amount)='NULL' then NULL else item_vat_payment_amount end as item_vat_payment_amount,  
  case when trim(item_vat_tax_assessed_amount)='' or trim(item_vat_tax_assessed_amount)='NULL' then NULL else item_vat_tax_assessed_amount end as item_vat_tax_assessed_amount,
  1 as dwh_valid_fg,
  dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
    from etl.t_cache_ceva)     
    where   
    job_type_code in ('IMY', 'IMA', 'IMD')
   and(   try_to_number(coalesce(total_package_quantity, '0')) is null
       or try_to_number(coalesce(excise_payment_amount, '0')) is null
       or try_to_number(coalesce(value_for_duty, '0')) is null
       or try_to_number(coalesce(duty_payment_amount, '0')) is null
       or try_to_number(coalesce(duty_tax_assessed_amount, '0')) is null
       or try_to_number(coalesce(value_for_vat, '0')) is null
       or try_to_number(coalesce(vat_payment_amount, '0')) is null
       or try_to_number(coalesce(vat_taxassessed_amount, '0')) is null
       or try_to_number(coalesce(case when charindex('_', item_product) > 0
                                      then substr(item_product, 1, charindex('_', item_product) - 1)
                                      else item_product
                                  end, '0')) is null
       or try_to_number(coalesce(item_gross_mass_measure, '0')) is null
       or try_to_number(coalesce(item_net_weight_measure, '0')) is null
       or try_to_number(coalesce(item_charge_amount, '0')) is null
       or try_to_number(coalesce(item_pieces, '0')) is null
       or try_to_number(coalesce(item_tariff_quantity, '0')) is null
       or try_to_number(coalesce(item_excise_payment_amount, '0')) is null
       or try_to_number(coalesce(item_value_for_duty, '0')) is null
       or try_to_number(coalesce(item_duty_payment_amount, '0')) is null
       or try_to_number(coalesce(item_value_for_vat, '0')) is null
       or try_to_number(coalesce(item_vat_payment_amount, '0')) is null
       or try_to_number(coalesce(item_vat_tax_assessed_amount, '0')) is null
      )
union 
select distinct movement_ref_number,
  item_position,
  broker_declarant_party_key_type_cd,
  broker_declarant_party_cd, 
 COALESCE(cds_acceptance_date, cds_clearance_date, TRUNC(acceptance_date_time, 'dd'), date('1900-01-01')) as cds_acceptance_dt,
  case when try_to_number(coalesce(total_package_quantity, '0')) is null then 'Total Packages Quantity'
            when try_to_number(coalesce(excise_payment_amount, '0')) is null then 'Excise Payment Amount'
            when try_to_number(coalesce(value_for_duty, '0')) is null then 'Value for Duty'
            when try_to_number(coalesce(duty_payment_amount, '0')) is null then 'Duty Payment Amount'
            when try_to_number(coalesce(duty_tax_assessed_amount, '0')) is null then 'Duty Tax Assessed Amount'
            when try_to_number(coalesce(value_for_vat, '0')) is null then 'Value for VAT'
            when try_to_number(coalesce(vat_payment_amount, '0')) is null then 'VAT Payment Amount'
            when try_to_number(coalesce(vat_taxassessed_amount, '0')) is null then 'VAT Tax Assessed Amount'
            when try_to_number(coalesce(case when charindex('_', item_product) > 0
                                             then substr(item_product, 1, charindex('_', item_product) - 1)
                                             else item_product
                                         end, '0')) is null then 'Item Product'
            when try_to_number(coalesce(item_gross_mass_measure, '0')) is null then 'Gross Mass Measure'
            when try_to_number(coalesce(item_net_weight_measure, '0')) is null then 'Net Weight Measure'
            when try_to_number(coalesce(item_charge_amount, '0')) is null then 'Item Charge Amount'
            when try_to_number(coalesce(item_pieces, '0')) is null then 'Item Pieces'
            when try_to_number(coalesce(item_tariff_quantity, '0')) is null then 'Item Tariff Quantity'
            when try_to_number(coalesce(item_excise_payment_amount, '0')) is null then 'Item Excise Payment Amount'
            when try_to_number(coalesce(item_value_for_duty, '0')) is null then 'Item Value for Duty'
            when try_to_number(coalesce(item_duty_payment_amount, '0')) is null then 'Item Duty Payment Amount'
            when try_to_number(coalesce(item_value_for_vat, '0')) is null then 'Item Value for VAT'
            when try_to_number(coalesce(item_vat_payment_amount, '0')) is null then 'VAT Payment Amount'
            when try_to_number(coalesce(item_vat_tax_assessed_amount, '0')) is null then 'VAT Tax Assessed Amount'
            end as attribute_name,          
        case when try_to_number(coalesce(total_package_quantity, '0')) is null then total_package_quantity
            when try_to_number(coalesce(excise_payment_amount, '0')) is null then excise_payment_amount
            when try_to_number(coalesce(value_for_duty, '0')) is null then value_for_duty
            when try_to_number(coalesce(duty_payment_amount, '0')) is null then duty_payment_amount
            when try_to_number(coalesce(duty_tax_assessed_amount, '0')) is null then duty_tax_assessed_amount
            when try_to_number(coalesce(value_for_vat, '0')) is null then value_for_vat
            when try_to_number(coalesce(vat_payment_amount, '0')) is null then vat_payment_amount
            when try_to_number(coalesce(vat_taxassessed_amount, '0')) is null then vat_taxassessed_amount
            when try_to_number(coalesce(case when charindex('_', item_product) > 0
                                             then substr(item_product, 1, charindex('_', item_product) - 1)
                                             else item_product
                                         end, '0')) is null then item_product
            when try_to_number(coalesce(item_gross_mass_measure, '0')) is null then item_gross_mass_measure
            when try_to_number(coalesce(item_net_weight_measure, '0')) is null then item_net_weight_measure
            when try_to_number(coalesce(item_charge_amount, '0')) is null then item_charge_amount
            when try_to_number(coalesce(item_pieces, '0')) is null then item_pieces
            when try_to_number(coalesce(item_tariff_quantity, '0')) is null then item_tariff_quantity
            when try_to_number(coalesce(item_excise_payment_amount, '0')) is null then item_excise_payment_amount
            when try_to_number(coalesce(item_value_for_duty, '0')) is null then item_value_for_duty
            when try_to_number(coalesce(item_duty_payment_amount, '0')) is null then item_duty_payment_amount
            when try_to_number(coalesce(item_value_for_vat, '0')) is null then item_value_for_vat
            when try_to_number(coalesce(item_vat_payment_amount, '0')) is null then item_vat_payment_amount
            when try_to_number(coalesce(item_vat_tax_assessed_amount, '0')) is null then item_vat_tax_assessed_amount
        end as attribute_value_txt,  
  dwh_valid_fg,
  dwh_src_file_name, 
  dwh_src_1_tmsp,  
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
  from(
  select job_type_code,
  mrn as movement_ref_number,
  coalesce(item_sequence_number,'-1') as item_position,
  'BROKER' as broker_declarant_party_key_type_cd,
  declarant_eori as broker_declarant_party_cd,  
  case when trim(cds_acceptance_date)='' or trim(cds_acceptance_date)='NULL' then NULL 
  when SUBSTRING(cds_acceptance_date,3,1)='/' then date(SUBSTR(cds_acceptance_date, 1, 10), 'DD/MM/YYYY')
  else date(SUBSTR(cds_acceptance_date, 1, 10), 'YYYY-MM-DD') end as cds_acceptance_date,
 case when trim(cds_clearance_date)='' or trim(cds_clearance_date)='NULL' or length(trim(cds_clearance_date))!=10 then NULL
 when SUBSTRING(cds_clearance_date,5,1)='-' then date(SUBSTR(cds_clearance_date, 1, 10), 'YYYY-MM-DD')
 else date(SUBSTR(cds_clearance_date, 1, 10), 'DD/MM/YYYY') end as cds_clearance_date,
  case when trim(acceptance_date_time)='' or trim(acceptance_date_time)='NULL' then NULL 
  when SUBSTRING(acceptance_date_time,3,1)='/' then date(SUBSTR(acceptance_date_time, 1, 10), 'DD/MM/YYYY')
  else date(SUBSTR(acceptance_date_time, 1, 10), 'YYYY-MM-DD') end as acceptance_date_time, 
  case when trim(total_package_quantity)='' or trim(total_package_quantity)='NULL' then NULL else total_package_quantity end as total_package_quantity,
  case when trim(excise_payment_amount)='' or trim(excise_payment_amount)='NULL' then NULL else excise_payment_amount end as excise_payment_amount,
  case when trim(value_for_duty)='' or trim(value_for_duty)='NULL' then NULL else value_for_duty end as value_for_duty,
  case when trim(duty_payment_amount)='' or trim(duty_payment_amount)='NULL' then NULL else duty_payment_amount end as duty_payment_amount,
  case when trim(duty_tax_assessed_amount)='' or trim(duty_tax_assessed_amount)='NULL' then NULL else duty_tax_assessed_amount end as duty_tax_assessed_amount,
  case when trim(value_for_vat)='' or trim(value_for_vat)='NULL' then NULL else value_for_vat end as value_for_vat,
  case when trim(vat_payment_amount)='' or trim(vat_payment_amount)='NULL' then NULL else vat_payment_amount end as vat_payment_amount,
  case when trim(vat_taxassessed_amount)='' or trim(vat_taxassessed_amount)='NULL' then NULL else vat_taxassessed_amount end as vat_taxassessed_amount,
  case when trim(item_product)='' or trim(item_product)='NULL' then NULL else item_product end as item_product,
  case when trim(item_gross_mass_measure)='' or trim(item_gross_mass_measure)='NULL' then NULL else item_gross_mass_measure end as item_gross_mass_measure,
  case when trim(item_net_weight_measure)='' or trim(item_net_weight_measure)='NULL' then NULL else item_net_weight_measure end as item_net_weight_measure,
  case when trim(item_charge_amount)='' or trim(item_charge_amount)='NULL' then NULL else item_charge_amount end as item_charge_amount,
  case when trim(item_pieces)='' or trim(item_pieces)='NULL' then NULL else item_pieces end as item_pieces,
  case when trim(item_tariff_quantity)='' or trim(item_tariff_quantity)='NULL' then NULL else item_tariff_quantity end as item_tariff_quantity, 
  case when trim(item_excise_payment_amount)='' or trim(item_excise_payment_amount)='NULL' then NULL else item_excise_payment_amount end as item_excise_payment_amount,
  case when trim(item_value_for_duty)='' or trim(item_value_for_duty)='NULL' then NULL else item_value_for_duty end as item_value_for_duty, 
  case when trim(item_duty_payment_amount)='' or trim(item_duty_payment_amount)='NULL' then NULL else item_duty_payment_amount end as item_duty_payment_amount,
  case when trim(item_value_for_vat)='' or trim(item_value_for_vat)='NULL' then NULL else item_value_for_vat end as item_value_for_vat,
  case when trim(item_vat_payment_amount)='' or trim(item_vat_payment_amount)='NULL' then NULL else item_vat_payment_amount end as item_vat_payment_amount,  
  case when trim(item_vat_tax_assessed_amount)='' or trim(item_vat_tax_assessed_amount)='NULL' then NULL else item_vat_tax_assessed_amount end as item_vat_tax_assessed_amount,
  1 as dwh_valid_fg,
  dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
    from etl.t_cache_maersk_lgb)
    where job_type_code in ('IMY', 'IMA', 'IMD')
   and(   try_to_number(coalesce(total_package_quantity, '0')) is null
       or try_to_number(coalesce(excise_payment_amount, '0')) is null
       or try_to_number(coalesce(value_for_duty, '0')) is null
       or try_to_number(coalesce(duty_payment_amount, '0')) is null
       or try_to_number(coalesce(duty_tax_assessed_amount, '0')) is null
       or try_to_number(coalesce(value_for_vat, '0')) is null
       or try_to_number(coalesce(vat_payment_amount, '0')) is null
       or try_to_number(coalesce(vat_taxassessed_amount, '0')) is null
       or try_to_number(coalesce(case when charindex('_', item_product) > 0
                                      then substr(item_product, 1, charindex('_', item_product) - 1)
                                      else item_product
                                  end, '0')) is null
       or try_to_number(coalesce(item_gross_mass_measure, '0')) is null
       or try_to_number(coalesce(item_net_weight_measure, '0')) is null
       or try_to_number(coalesce(item_charge_amount, '0')) is null
       or try_to_number(coalesce(item_pieces, '0')) is null
       or try_to_number(coalesce(item_tariff_quantity, '0')) is null
       or try_to_number(coalesce(item_excise_payment_amount, '0')) is null
       or try_to_number(coalesce(item_value_for_duty, '0')) is null
       or try_to_number(coalesce(item_duty_payment_amount, '0')) is null
       or try_to_number(coalesce(item_value_for_vat, '0')) is null
       or try_to_number(coalesce(item_vat_payment_amount, '0')) is null
       or try_to_number(coalesce(item_vat_tax_assessed_amount, '0')) is null
      )
UNION
select distinct movement_ref_number,
  item_position,
  broker_declarant_party_key_type_cd,
  broker_declarant_party_cd, 
  COALESCE(cds_acceptance_date, cds_clearance_date, TRUNC(acceptance_date_time, 'dd'), date('1900-01-01')) as cds_acceptance_dt,
  case when try_to_number(coalesce(total_package_quantity, '0')) is null then 'Total Packages Quantity'
            when try_to_number(coalesce(excise_payment_amount, '0')) is null then 'Excise Payment Amount'
            when try_to_number(coalesce(value_for_duty, '0')) is null then 'Value for Duty'
            when try_to_number(coalesce(duty_payment_amount, '0')) is null then 'Duty Payment Amount'
            when try_to_number(coalesce(duty_tax_assessed_amount, '0')) is null then 'Duty Tax Assessed Amount'
            when try_to_number(coalesce(value_for_vat, '0')) is null then 'Value for VAT'
            when try_to_number(coalesce(vat_payment_amount, '0')) is null then 'VAT Payment Amount'
            when try_to_number(coalesce(vat_taxassessed_amount, '0')) is null then 'VAT Tax Assessed Amount'
            when try_to_number(coalesce(case when charindex('_', item_product) > 0
                                             then substr(item_product, 1, charindex('_', item_product) - 1)
                                             else item_product
                                         end, '0')) is null then 'Item Product'
            when try_to_number(coalesce(item_gross_mass_measure, '0')) is null then 'Gross Mass Measure'
            when try_to_number(coalesce(item_net_weight_measure, '0')) is null then 'Net Weight Measure'
            when try_to_number(coalesce(item_charge_amount, '0')) is null then 'Item Charge Amount'
            when try_to_number(coalesce(item_pieces, '0')) is null then 'Item Pieces'
            when try_to_number(coalesce(item_tariff_quantity, '0')) is null then 'Item Tariff Quantity'
            when try_to_number(coalesce(item_excise_payment_amount, '0')) is null then 'Item Excise Payment Amount'
            when try_to_number(coalesce(item_value_for_duty, '0')) is null then 'Item Value for Duty'
            when try_to_number(coalesce(item_duty_payment_amount, '0')) is null then 'Item Duty Payment Amount'
            when try_to_number(coalesce(item_value_for_vat, '0')) is null then 'Item Value for VAT'
            when try_to_number(coalesce(item_vat_payment_amount, '0')) is null then 'VAT Payment Amount'
            when try_to_number(coalesce(item_vat_tax_assessed_amount, '0')) is null then 'VAT Tax Assessed Amount'
            end as attribute_name,          
        case when try_to_number(coalesce(total_package_quantity, '0')) is null then total_package_quantity
            when try_to_number(coalesce(excise_payment_amount, '0')) is null then excise_payment_amount
            when try_to_number(coalesce(value_for_duty, '0')) is null then value_for_duty
            when try_to_number(coalesce(duty_payment_amount, '0')) is null then duty_payment_amount
            when try_to_number(coalesce(duty_tax_assessed_amount, '0')) is null then duty_tax_assessed_amount
            when try_to_number(coalesce(value_for_vat, '0')) is null then value_for_vat
            when try_to_number(coalesce(vat_payment_amount, '0')) is null then vat_payment_amount
            when try_to_number(coalesce(vat_taxassessed_amount, '0')) is null then vat_taxassessed_amount
            when try_to_number(coalesce(case when charindex('_', item_product) > 0
                                             then substr(item_product, 1, charindex('_', item_product) - 1)
                                             else item_product
                                         end, '0')) is null then item_product
            when try_to_number(coalesce(item_gross_mass_measure, '0')) is null then item_gross_mass_measure
            when try_to_number(coalesce(item_net_weight_measure, '0')) is null then item_net_weight_measure
            when try_to_number(coalesce(item_charge_amount, '0')) is null then item_charge_amount
            when try_to_number(coalesce(item_pieces, '0')) is null then item_pieces
            when try_to_number(coalesce(item_tariff_quantity, '0')) is null then item_tariff_quantity
            when try_to_number(coalesce(item_excise_payment_amount, '0')) is null then item_excise_payment_amount
            when try_to_number(coalesce(item_value_for_duty, '0')) is null then item_value_for_duty
            when try_to_number(coalesce(item_duty_payment_amount, '0')) is null then item_duty_payment_amount
            when try_to_number(coalesce(item_value_for_vat, '0')) is null then item_value_for_vat
            when try_to_number(coalesce(item_vat_payment_amount, '0')) is null then item_vat_payment_amount
            when try_to_number(coalesce(item_vat_tax_assessed_amount, '0')) is null then item_vat_tax_assessed_amount
        end as attribute_value_txt,  
  dwh_valid_fg,
  dwh_src_file_name, 
  dwh_src_1_tmsp,  
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
  from(
  
       select job_type_code,
  mrn as movement_ref_number,
  coalesce(item_sequence_number,'-1') as item_position,
  'BROKER' as broker_declarant_party_key_type_cd,
  declarant_eori as broker_declarant_party_cd,  
  case when trim(cds_acceptance_date)='' or trim(cds_acceptance_date)='NULL' then NULL else date(SUBSTR(cds_acceptance_date, 1, 10), 'YYYY-MM-DD') end as cds_acceptance_date,
  case when trim(cds_clearance_date)='' or trim(cds_clearance_date)='NULL' then NULL else date(SUBSTR(cds_clearance_date, 1, 10), 'YYYY-MM-DD') end as cds_clearance_date,
  case when trim(acceptance_date_time)='' or trim(acceptance_date_time)='NULL' then NULL else date(SUBSTR(acceptance_date_time, 1, 10), 'YYYY-MM-DD') end as acceptance_date_time, 
  case when trim(total_package_quantity)='' or trim(total_package_quantity)='NULL' then NULL else total_package_quantity end as total_package_quantity,
  case when trim(excise_payment_amount)='' or trim(excise_payment_amount)='NULL' then NULL else excise_payment_amount end as excise_payment_amount,
  case when trim(value_for_duty)='' or trim(value_for_duty)='NULL' then NULL else value_for_duty end as value_for_duty,
  case when trim(duty_payment_amount)='' or trim(duty_payment_amount)='NULL' then NULL else duty_payment_amount end as duty_payment_amount,
  case when trim(duty_tax_assessed_amount)='' or trim(duty_tax_assessed_amount)='NULL' then NULL else duty_tax_assessed_amount end as duty_tax_assessed_amount,
  case when trim(value_for_vat)='' or trim(value_for_vat)='NULL' then NULL else value_for_vat end as value_for_vat,
  case when trim(vat_payment_amount)='' or trim(vat_payment_amount)='NULL' then NULL else vat_payment_amount end as vat_payment_amount,
  case when trim(vat_taxassessed_amount)='' or trim(vat_taxassessed_amount)='NULL' then NULL else vat_taxassessed_amount end as vat_taxassessed_amount,
  case when trim(item_product)='' or trim(item_product)='NULL' then NULL else item_product end as item_product,
  case when trim(item_gross_mass_measure)='' or trim(item_gross_mass_measure)='NULL' then NULL else item_gross_mass_measure end as item_gross_mass_measure,
  case when trim(item_net_weight_measure)='' or trim(item_net_weight_measure)='NULL' then NULL else item_net_weight_measure end as item_net_weight_measure,
  case when trim(item_charge_amount)='' or trim(item_charge_amount)='NULL' then NULL else item_charge_amount end as item_charge_amount,
  case when trim(item_pieces)='' or trim(item_pieces)='NULL' then NULL else item_pieces end as item_pieces,
  case when trim(item_tariff_quantity)='' or trim(item_tariff_quantity)='NULL' then NULL else item_tariff_quantity end as item_tariff_quantity, 
  case when trim(item_excise_payment_amount)='' or trim(item_excise_payment_amount)='NULL' then NULL else item_excise_payment_amount end as item_excise_payment_amount,
  case when trim(item_value_for_duty)='' or trim(item_value_for_duty)='NULL' then NULL else item_value_for_duty end as item_value_for_duty, 
  case when trim(item_duty_payment_amount)='' or trim(item_duty_payment_amount)='NULL' then NULL else item_duty_payment_amount end as item_duty_payment_amount,
  case when trim(item_value_for_vat)='' or trim(item_value_for_vat)='NULL' then NULL else item_value_for_vat end as item_value_for_vat,
  case when trim(item_vat_payment_amount)='' or trim(item_vat_payment_amount)='NULL' then NULL else item_vat_payment_amount end as item_vat_payment_amount,  
  case when trim(item_vat_tax_assessed_amount)='' or trim(item_vat_tax_assessed_amount)='NULL' then NULL else item_vat_tax_assessed_amount end as item_vat_tax_assessed_amount,
  1 as dwh_valid_fg,
  dwh_src_file_name, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
    from etl.t_cache_maersk_lukt)
    where job_type_code in ('IMY', 'IMA', 'IMD')
   and(   try_to_number(coalesce(total_package_quantity, '0')) is null
       or try_to_number(coalesce(excise_payment_amount, '0')) is null
       or try_to_number(coalesce(value_for_duty, '0')) is null
       or try_to_number(coalesce(duty_payment_amount, '0')) is null
       or try_to_number(coalesce(duty_tax_assessed_amount, '0')) is null
       or try_to_number(coalesce(value_for_vat, '0')) is null
       or try_to_number(coalesce(vat_payment_amount, '0')) is null
       or try_to_number(coalesce(vat_taxassessed_amount, '0')) is null
       or try_to_number(coalesce(case when charindex('_', item_product) > 0
                                      then substr(item_product, 1, charindex('_', item_product) - 1)
                                      else item_product
                                  end, '0')) is null
       or try_to_number(coalesce(item_gross_mass_measure, '0')) is null
       or try_to_number(coalesce(item_net_weight_measure, '0')) is null
       or try_to_number(coalesce(item_charge_amount, '0')) is null
       or try_to_number(coalesce(item_pieces, '0')) is null
       or try_to_number(coalesce(item_tariff_quantity, '0')) is null
       or try_to_number(coalesce(item_excise_payment_amount, '0')) is null
       or try_to_number(coalesce(item_value_for_duty, '0')) is null
       or try_to_number(coalesce(item_duty_payment_amount, '0')) is null
       or try_to_number(coalesce(item_value_for_vat, '0')) is null
       or try_to_number(coalesce(item_vat_payment_amount, '0')) is null
       or try_to_number(coalesce(item_vat_tax_assessed_amount, '0')) is null
      );
