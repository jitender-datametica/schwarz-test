INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
movement_ref_number
,item_position
,authority_country_location_id
,authority_country_location_key_type_cd
,customs_procedure_cd
,customs_classification_scheme_cd
,customs_tariff_code_cd
,customs_preference_cd
,non_preferential_country_location_id
,non_preferential_country_location_key_type_cd
,preferential_country_location_id
,preferential_country_location_key_type_cd
,product_number
,additional_code
,commodity_code
,country_of_origin
,customs_product_key_type_cd
,invoice_number
,gross_mass_meas
,net_mass_meas
,charge_amount_curr_cd
,charge_amount_val
,item_descr
,abv_pct
,item_piece_cnt
,item_tariff_qty_uom_id
,item_tariff_qty
,alcoholic_beverage_tax_rate_cd
,duty_excise_rate_txt
,excise_payment_amount_val
,value_for_duty_val
,duty_payment_amount_val
,value_for_vat_val
,vat_payment_amount_val
,vat_tax_assessed_amount_val
,supplementary_cd
,documents_txt
,customer_product_number
,trader_reference
,DWH_MAPPING_TMSP
,TF_ERROR_FG
,DWH_VALID_FG
,DELETED_FG
,RECORD_ID
,FILENAME
,dwh_src_file_name
,dwh_src_1_tmsp
)
select  mrn as movement_ref_number,
TRY_TO_NUMBER(Item_Sequence_Number) as item_position,
'GB' as authority_country_location_id,
'COUNTRY_2' as authority_country_location_key_type_cd,
LPAD(Item_Government_Procedure_Current_Code, 2, '0') 
  || LPAD(Item_Government_Procedure_Previous_Code, 2, '0')
  || LPAD(Item_Government_Procedure_Current_Code_Special, 3, '0') as customs_procedure_cd,
'CTC_GB' as customs_classification_scheme_cd, 
LPAD(SUBSTR(REPLACE(Item_Commodity_Code, ' ', ''), 1, 10), 10, '0') as customs_tariff_code_cd,
COALESCE(Item_Preference, '-1') as customs_preference_cd,
COALESCE(NULLIF(Item_Non_Preferential_Country_Code,'NULL'),'-1') as non_preferential_country_location_id,
'COUNTRY_2' as non_preferential_country_location_key_type_cd,
COALESCE(NULLIF(Item_Preferential_Country_Code,'NULL'), '-1') as preferential_country_location_id,
'COUNTRY_2' as preferential_country_location_key_type_cd ,
case when try_to_number(CASE
    WHEN CHARINDEX('_',Item_Product,0)>0 THEN TRIM(SUBSTR(Item_Product,0,CHARINDEX('_',Item_Product,0)-1))
     ELSE TRIM(Item_Product)
END) is null then '-1' else CASE
    WHEN CHARINDEX('_',Item_Product,0)>0 THEN TRIM(SUBSTR(Item_Product,0,CHARINDEX('_',Item_Product,0)-1))
     ELSE TRIM(Item_Product)
END end  as product_number,
TRIM(CASE
    WHEN CHARINDEX('_',Item_Product,0)>0 THEN TRIM(SUBSTR(Item_Product,CHARINDEX('_',Item_Product)+1,LEN(Item_Product))) 
     ELSE ''
END) as  additional_code,
TRIM(LPAD(SUBSTR(REPLACE(Item_Commodity_Code, ' ', ''), 1, 10), 10, '0')) as Commodity_Code,
TRIM(COALESCE(NULLIF(TRIM(Item_Non_Preferential_Country_Code),'NULL'), TRIM(Item_Preferential_Country_Code))) as Country_of_Origin,
'CUSTOMS_PRODUCT' as customs_product_key_type_cd ,
COALESCE(NULLIF(Item_Invoice_Number,'NULL'),'-1') as invoice_number,
COALESCE(TRY_TO_NUMBER(Item_Gross_Mass_Measure, 38, 6), 0) as gross_mass_meas,
COALESCE(TRY_TO_NUMBER(Item_Net_Weight_Measure, 38, 6), 0) as net_mass_meas,
COALESCE(Item_Charge_Amount_Currency, '-1') as charge_amount_curr_cd,
COALESCE(TRY_TO_NUMBER(Item_Charge_Amount, 38, 6), 0) as charge_amount_val,
SUBSTR(COALESCE(Item_Description, 'Unknown'), 1, 250) as item_descr,
TRY_TO_DECIMAL(Abv_Pct, 10, 5) as abv_pct,
COALESCE(TRY_TO_NUMBER(Item_Pieces), 0) as item_piece_cnt,
CASE  WHEN Item_Tariff_Quantity_Unit_Code = 'LTR' THEN 29
            WHEN Item_Tariff_Quantity_Unit_Code = 'KGM' THEN 10
            WHEN Item_Tariff_Quantity_Unit_Code  = 'NAR' THEN 26
            WHEN Item_Tariff_Quantity_Unit_Code  = 'LPA' THEN 24
            WHEN Item_Tariff_Quantity_Unit_Code  = 'NPR' THEN 27
            WHEN Item_Tariff_Quantity_Unit_Code  = 'MIL' THEN 25
            WHEN Item_Tariff_Quantity_Unit_Code  = 'HTL' THEN 28
            ELSE -1
        END as item_tariff_qty_uom_id,
COALESCE(TRY_TO_NUMBER(Item_Tariff_Quantity, 38, 6), 0) as item_tariff_qty,
COALESCE(NULLIF(Item_National_Additional_Code,'NULL'), '-1') as alcoholic_beverage_tax_rate_cd,
nullif(Duty_Excise_Rate,'NULL') as duty_excise_rate_txt,
COALESCE(TRY_TO_NUMBER(Item_Excise_Payment_Amount, 38, 6), 0) as excise_payment_amount_val,
COALESCE(TRY_TO_NUMBER(Item_Value_for_Duty, 38, 6), 0) as value_for_duty_val,
COALESCE(TRY_TO_NUMBER(Item_Duty_Payment_Amount, 38, 6), 0) as duty_payment_amount_val,
COALESCE(TRY_TO_NUMBER(Item_Value_for_VAT, 38, 6), 0) as value_for_vat_val,
COALESCE(TRY_TO_NUMBER(Item_VAT_Payment_Amount, 38, 6), 0) as vat_payment_amount_val,
COALESCE(TRY_TO_NUMBER(Item_VAT_Tax_Assessed_Amount, 38, 6), 0) as vat_tax_assessed_amount_val,
NULLIF(Item_Taric_Additional_Code,'NULL') as supplementary_cd,
NULLIF(Documents,'NULL') as documents_txt,
CASE  WHEN product_number='-1' THEN '-1' 
      WHEN additional_code ='-1' THEN '-1'  
      WHEN commodity_code='-1' THEN '-1' 
      WHEN country_of_origin='-1' THEN '-1'
      ELSE product_number||'|'||additional_code||'|'||commodity_code||'|'||country_of_origin END as customer_product_number,
trader_reference,
dwh_src_1_tmsp,
0,
1,
0,
0,
dwh_src_file_name,
dwh_src_file_name,
dwh_src_1_tmsp
from etl.t_cache_ceva_2
where job_type_code in ('IMY', 'IMA', 'IMD')
union all
select mrn  as movement_ref_number,
TRY_TO_NUMBER(Item_Sequence_Number) as item_position,
'GB' as authority_country_location_id,
'COUNTRY_2' as authority_country_location_key_type_cd,
LPAD(Item_Government_Procedure_Current_Code, 2, '0') 
  || LPAD(Item_Government_Procedure_Previous_Code, 2, '0')
  || LPAD(Item_Government_Procedure_Current_Code_Special, 3, '0') as customs_procedure_cd,
'CTC_GB' as customs_classification_scheme_cd,
LPAD(SUBSTR(REPLACE(Item_Commodity_Code, ' ', ''), 1, 10), 10, '0') as customs_tariff_code_cd,  
 COALESCE(Item_Preference, '-1') as customs_preference_cd,
 
COALESCE(NULLIF(Item_Non_Preferential_Country_Code,'NULL'),'-1') as non_preferential_country_location_id,
'COUNTRY_2' as non_preferential_country_location_key_type_cd,
COALESCE(NULLIF(Item_Preferential_Country_Code,'NULL'), '-1') as preferential_country_location_id,
'COUNTRY_2' as preferential_country_location_key_type_cd ,
case when try_to_number(CASE
    WHEN CHARINDEX('_',Item_Product,0)>0 THEN TRIM(SUBSTR(Item_Product,0,CHARINDEX('_',Item_Product,0)-1))
     ELSE TRIM(Item_Product)
END) is null then '-1' else CASE
    WHEN CHARINDEX('_',Item_Product,0)>0 THEN TRIM(SUBSTR(Item_Product,0,CHARINDEX('_',Item_Product,0)-1))
     ELSE TRIM(Item_Product)
END end  as product_number,
TRIM(CASE
    WHEN CHARINDEX('_',Item_Product,0)>0 THEN TRIM(SUBSTR(Item_Product,CHARINDEX('_',Item_Product)+1,LEN(Item_Product))) 
     ELSE ''
END) as  additional_code,
TRIM(LPAD(SUBSTR(REPLACE(Item_Commodity_Code, ' ', ''), 1, 10), 10, '0')) as Commodity_Code,
TRIM(COALESCE(NULLIF(TRIM(Item_Non_Preferential_Country_Code),'NULL'), TRIM(Item_Preferential_Country_Code))) as Country_of_Origin,
'CUSTOMS_PRODUCT' as customs_product_key_type_cd ,
COALESCE(NULLIF(Item_Invoice_Number,'NULL'),'-1') as invoice_number,
COALESCE(TRY_TO_NUMBER(Item_Gross_Mass_Measure, 38, 6), 0) as gross_mass_meas,
COALESCE(TRY_TO_NUMBER(Item_Net_Weight_Measure, 38, 6), 0) as net_mass_meas,
COALESCE(Item_Charge_Amount_Currency, '-1') as charge_amount_curr_cd,
COALESCE(TRY_TO_NUMBER(Item_Charge_Amount, 38, 6), 0) as charge_amount_val,
SUBSTR(COALESCE(Item_Description, 'Unknown'), 1, 250) as item_descr,
TRY_TO_DECIMAL(Abv_Pct, 10, 5) as abv_pct,
COALESCE(TRY_TO_NUMBER(Item_Pieces), 0) as item_piece_cnt,
CASE  WHEN Item_Tariff_Quantity_Unit_Code = 'LTR' THEN 29
            WHEN Item_Tariff_Quantity_Unit_Code = 'KGM' THEN 10
            WHEN Item_Tariff_Quantity_Unit_Code  = 'NAR' THEN 26
            WHEN Item_Tariff_Quantity_Unit_Code  = 'LPA' THEN 24
            WHEN Item_Tariff_Quantity_Unit_Code  = 'NPR' THEN 27
            WHEN Item_Tariff_Quantity_Unit_Code  = 'MIL' THEN 25
            WHEN Item_Tariff_Quantity_Unit_Code  = 'HTL' THEN 28
            ELSE -1
        END as item_tariff_qty_uom_id,
COALESCE(TRY_TO_NUMBER(Item_Tariff_Quantity, 38, 6), 0) as item_tariff_qty,
COALESCE(NULLIF(Item_National_Additional_Code,'NULL'), '-1') as alcoholic_beverage_tax_rate_cd,
nullif(Duty_Excise_Rate,'NULL') as duty_excise_rate_txt,
COALESCE(TRY_TO_NUMBER(Item_Excise_Payment_Amount, 38, 6), 0) as excise_payment_amount_val,
COALESCE(TRY_TO_NUMBER(Item_Value_for_Duty, 38, 6), 0) as value_for_duty_val,
COALESCE(TRY_TO_NUMBER(Item_Duty_Payment_Amount, 38, 6), 0) as duty_payment_amount_val,
COALESCE(TRY_TO_NUMBER(Item_Value_for_VAT, 38, 6), 0) as value_for_vat_val,
COALESCE(TRY_TO_NUMBER(Item_VAT_Payment_Amount, 38, 6), 0) as vat_payment_amount_val,
COALESCE(TRY_TO_NUMBER(Item_VAT_Tax_Assessed_Amount, 38, 6), 0),
NULLIF(Item_Taric_Additional_Code,'NULL') as supplementary_cd,
NULLIF(Documents,'NULL') as documents_txt,
CASE  WHEN product_number='-1' THEN '-1' 
      WHEN additional_code ='-1' THEN '-1'  
      WHEN commodity_code='-1' THEN '-1' 
      WHEN country_of_origin='-1' THEN '-1'
      ELSE product_number||'|'||additional_code||'|'||commodity_code||'|'||country_of_origin END as customer_product_number,
trader_reference,
dwh_src_1_tmsp,
0,
1,
0,
0,
dwh_src_file_name,
dwh_src_file_name,
dwh_src_1_tmsp
from etl.t_cache_Maersk_LGB_2
where job_type_code in ('IMY', 'IMA', 'IMD')
union all
select mrn  as movement_ref_number,
TRY_TO_NUMBER(Item_Sequence_Number) as item_position,
'GB' as authority_country_location_id,
'COUNTRY_2' as authority_country_location_key_type_cd,
LPAD(Item_Government_Procedure_Current_Code, 2, '0') 
  || LPAD(Item_Government_Procedure_Previous_Code, 2, '0')
  || LPAD(Item_Government_Procedure_Current_Code_Special, 3, '0') as customs_procedure_cd,
'CTC_GB' as customs_classification_scheme_cd,
LPAD(SUBSTR(REPLACE(Item_Commodity_Code, ' ', ''), 1, 10), 10, '0') as customs_tariff_code_cd,  
 COALESCE(Item_Preference, '-1') as customs_preference_cd, 
COALESCE(NULLIF(Item_Non_Preferential_Country_Code,'NULL'),'-1') as non_preferential_country_location_id,
'COUNTRY_2' as non_preferential_country_location_key_type_cd,
COALESCE(NULLIF(Item_Preferential_Country_Code,'NULL'), '-1') as preferential_country_location_id ,
'COUNTRY_2' as preferential_country_location_key_type_cd ,
case when try_to_number(CASE
    WHEN CHARINDEX('_',Item_Product,0)>0 THEN TRIM(SUBSTR(Item_Product,0,CHARINDEX('_',Item_Product,0)-1))
     ELSE TRIM(Item_Product)
END) is null then '-1' else CASE
    WHEN CHARINDEX('_',Item_Product,0)>0 THEN TRIM(SUBSTR(Item_Product,0,CHARINDEX('_',Item_Product,0)-1))
     ELSE TRIM(Item_Product)
END end  as product_number,
TRIM(CASE
    WHEN CHARINDEX('_',Item_Product,0)>0 THEN TRIM(SUBSTR(Item_Product,CHARINDEX('_',Item_Product)+1,LEN(Item_Product))) 
     ELSE ''
END) as  additional_code,
TRIM(LPAD(SUBSTR(REPLACE(Item_Commodity_Code, ' ', ''), 1, 10), 10, '0')) as Commodity_Code,
TRIM(COALESCE(NULLIF(TRIM(Item_Non_Preferential_Country_Code),'NULL'), TRIM(Item_Preferential_Country_Code))) as Country_of_Origin,
'CUSTOMS_PRODUCT' as customs_product_key_type_cd ,
COALESCE(NULLIF(Item_Invoice_Number,'NULL'),'-1') as invoice_number,
COALESCE(TRY_TO_NUMBER(Item_Gross_Mass_Measure, 38, 6), 0) as gross_mass_meas,
COALESCE(TRY_TO_NUMBER(Item_Net_Weight_Measure, 38, 6), 0) as net_mass_meas,
COALESCE(Item_Charge_Amount_Currency, '-1') as charge_amount_curr_cd,
COALESCE(TRY_TO_NUMBER(Item_Charge_Amount, 38, 6), 0) as charge_amount_val,
SUBSTR(COALESCE(Item_Description, 'Unknown'), 1, 250) as item_descr,
TRY_TO_DECIMAL(Abv_Pct, 10, 5) as abv_pct,
COALESCE(TRY_TO_NUMBER(Item_Pieces), 0) as item_piece_cnt,
CASE  WHEN Item_Tariff_Quantity_Unit_Code = 'LTR' THEN 29
            WHEN Item_Tariff_Quantity_Unit_Code = 'KGM' THEN 10
            WHEN Item_Tariff_Quantity_Unit_Code  = 'NAR' THEN 26
            WHEN Item_Tariff_Quantity_Unit_Code  = 'LPA' THEN 24
            WHEN Item_Tariff_Quantity_Unit_Code  = 'NPR' THEN 27
            WHEN Item_Tariff_Quantity_Unit_Code  = 'MIL' THEN 25
            WHEN Item_Tariff_Quantity_Unit_Code  = 'HTL' THEN 28
            ELSE -1
        END as item_tariff_qty_uom_id,
COALESCE(TRY_TO_NUMBER(Item_Tariff_Quantity, 38, 6), 0) as item_tariff_qty,
COALESCE(NULLIF(Item_National_Additional_Code,'NULL'), '-1') as alcoholic_beverage_tax_rate_cd,
nullif(Duty_Excise_Rate,'NULL') as duty_excise_rate_txt,
COALESCE(TRY_TO_NUMBER(Item_Excise_Payment_Amount, 38, 6), 0) as excise_payment_amount_val,
COALESCE(TRY_TO_NUMBER(Item_Value_for_Duty, 38, 6), 0) as value_for_duty_val,
COALESCE(TRY_TO_NUMBER(Item_Duty_Payment_Amount, 38, 6), 0) as duty_payment_amount_val,
COALESCE(TRY_TO_NUMBER(Item_Value_for_VAT, 38, 6), 0) as value_for_vat_val,
COALESCE(TRY_TO_NUMBER(Item_VAT_Payment_Amount, 38, 6), 0) as vat_payment_amount_val,
COALESCE(TRY_TO_NUMBER(Item_VAT_Tax_Assessed_Amount, 38, 6), 0) as vat_tax_assessed_amount_val,
NULLIF(Item_Taric_Additional_Code,'NULL') as supplementary_cd,
NULLIF(Documents,'NULL') as documents_txt,
CASE  WHEN product_number='-1' THEN '-1' 
      WHEN additional_code ='-1' THEN '-1'  
      WHEN commodity_code='-1' THEN '-1' 
      WHEN country_of_origin='-1' THEN '-1'
      ELSE product_number||'|'||additional_code||'|'||commodity_code||'|'||country_of_origin END as customer_product_number,
trader_reference,
dwh_src_1_tmsp,
0,
1,
0,
0,
dwh_src_file_name,
dwh_src_file_name,
dwh_src_1_tmsp
from etl.t_cache_MAersk_LUKT_2
where job_type_code in ('IMY', 'IMA', 'IMD');
