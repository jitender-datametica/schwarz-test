MERGE into ETL.T_CACHE_CEVA_1 n
 using(select job_ref,
              mrn,
              job_type_code,
              sum(try_to_number(item_excise_payment_amount, 38, 6)) as excise_payment_amount,
              sum(try_to_number(item_excise_tax_assessed_amount, 38, 6)) as excise_tax_assessed_amount,
              sum(try_to_number(item_value_for_duty, 38, 6)) as value_for_duty,
              sum(try_to_number(item_duty_payment_amount, 38, 6)) as duty_payment_amount,
              sum(try_to_number(item_duty_tax_assessed_amount, 38, 6)) as duty_tax_assessed_amount,
              sum(try_to_number(item_value_for_vat, 38, 6)) as value_for_vat,
              sum(try_to_number(item_vat_payment_amount, 38, 6)) as vat_payment_amount,
              sum(try_to_number(item_vat_tax_assessed_amount, 38, 6)) as vat_tax_assessed_amount
         from ETL.T_CACHE_CEVA_1 
        group
           by 1, 2, 3
      ) a
    on(    n.job_ref = a.job_ref
       and n.mrn = a.mrn
       and n.job_type_code = a.job_type_code
      )
  when matched
  then update 
          set n.excise_payment_amount = a.excise_payment_amount,
              n.excise_tax_assessed_amount = a.excise_tax_assessed_amount,
              n.value_for_duty = a.value_for_duty,
              n.duty_payment_amount = a.duty_payment_amount,
              n.duty_tax_assessed_amount = a.duty_tax_assessed_amount,
              n.value_for_vat = a.value_for_vat,
              n.vat_payment_amount = a.vat_payment_amount,
              n.vat_taxassessed_amount = a.vat_tax_assessed_amount
; 

MERGE into ETL.T_CACHE_MAERSK_LGB_1 n
 using(select job_ref,
              mrn,
              job_type_code,
              sum(try_to_number(item_excise_payment_amount, 38, 6)) as excise_payment_amount,
              sum(try_to_number(item_excise_tax_assessed_amount, 38, 6)) as excise_tax_assessed_amount,
              sum(try_to_number(item_value_for_duty, 38, 6)) as value_for_duty,
              sum(try_to_number(item_duty_payment_amount, 38, 6)) as duty_payment_amount,
              sum(try_to_number(item_duty_tax_assessed_amount, 38, 6)) as duty_tax_assessed_amount,
              sum(try_to_number(item_value_for_vat, 38, 6)) as value_for_vat,
              sum(try_to_number(item_vat_payment_amount, 38, 6)) as vat_payment_amount,
              sum(try_to_number(item_vat_tax_assessed_amount, 38, 6)) as vat_tax_assessed_amount
         from ETL.T_CACHE_MAERSK_LGB_1
        group
           by 1, 2, 3
      ) a
    on(    n.job_ref = a.job_ref
       and n.mrn = a.mrn
       and n.job_type_code = a.job_type_code
      )
  when matched
  then update 
          set n.excise_payment_amount = a.excise_payment_amount,
              n.excise_tax_assessed_amount = a.excise_tax_assessed_amount,
              n.value_for_duty = a.value_for_duty,
              n.duty_payment_amount = a.duty_payment_amount,
              n.duty_tax_assessed_amount = a.duty_tax_assessed_amount,
              n.value_for_vat = a.value_for_vat,
              n.vat_payment_amount = a.vat_payment_amount,
              n.vat_taxassessed_amount = a.vat_tax_assessed_amount
; 

MERGE into ETL.T_CACHE_MAERSK_LUKT_1 n
 using(select job_ref,
              mrn,
              job_type_code,
              sum(try_to_number(item_excise_payment_amount, 38, 6)) as excise_payment_amount,
              sum(try_to_number(item_excise_tax_assessed_amount, 38, 6)) as excise_tax_assessed_amount,
              sum(try_to_number(item_value_for_duty, 38, 6)) as value_for_duty,
              sum(try_to_number(item_duty_payment_amount, 38, 6)) as duty_payment_amount,
              sum(try_to_number(item_duty_tax_assessed_amount, 38, 6)) as duty_tax_assessed_amount,
              sum(try_to_number(item_value_for_vat, 38, 6)) as value_for_vat,
              sum(try_to_number(item_vat_payment_amount, 38, 6)) as vat_payment_amount,
              sum(try_to_number(item_vat_tax_assessed_amount, 38, 6)) as vat_tax_assessed_amount
         from ETL.T_CACHE_MAERSK_LUKT_1 
        group
           by 1, 2, 3
      ) a
    on(    n.job_ref = a.job_ref
       and n.mrn = a.mrn
       and n.job_type_code = a.job_type_code
      )
  when matched
  then update 
          set n.excise_payment_amount = a.excise_payment_amount,
              n.excise_tax_assessed_amount = a.excise_tax_assessed_amount,
              n.value_for_duty = a.value_for_duty,
              n.duty_payment_amount = a.duty_payment_amount,
              n.duty_tax_assessed_amount = a.duty_tax_assessed_amount,
              n.value_for_vat = a.value_for_vat,
              n.vat_payment_amount = a.vat_payment_amount,
              n.vat_taxassessed_amount = a.vat_tax_assessed_amount
; 
