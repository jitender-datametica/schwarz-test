INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
   MOVEMENT_REF_NUMBER  ,
   trader_reference, 
   ITEM_POSITION  ,
   ORIGIN_COUNTRY_LOCATION_SID,
   CUSTOMS_PREFERENCE_CD  ,
   CUSTOMS_VALUATION_METHOD_ID,
   CUSTOMS_PRODUCT_SID ,
   CUSTOMS_PROCEDURE_CD ,
   ADDITIONAL_SPECIAL_CPC_CODES,
   CUSTOMS_CLASSIFICATION_SCHEME_CD,
   CUSTOMS_TARIFF_CODE_CD,
   FIRST_SUPPLEMENTARY_CD,
   SECOND_SUPPLEMENTARY_CD,
   INVENTORY_UCR , 
   DECLARATION_PART_NUMBER ,
   ITEM_PRICE   ,
   CUSTOMS_VAL,
   DUTY_PAID_VAL ,
   VAT_VAL,
   VAT_PAID_VAL,
   DUTY_SUSPENDED_VAL ,
   DUTY_SECURED_VAL, 
   NET_MASS_QTY,
   SUPPLEMENTARY_UNITS_QTY  ,
   GOODS_DESCR   ,
   DOCUMENT_REFERENCES,
   CLEARANCE_DT,
	DWH_SRC_FILE_NAME,
	DWH_SRC_1_TMSP,
	DWH_MAPPING_TMSP,
	TF_ERROR_FG,
	DELETED_FG,
	RECORD_ID,
DWH_VALID_FG,
	FILENAME 
)
select distinct  ci.entry_identifier as movement_ref_number,
       ci.trader_reference,
       ci.item_number as item_position,
       coalesce(ci.location_sid, -1) as origin_country_location_sid,
       coalesce(NULLIF(ci.preference,'NULL'), '-1') as customs_preference_cd,
       coalesce(try_to_number(ci.valuation_method), -1) as customs_valuation_method_id,
       ci.customs_product_sid,
       ci.cpc as customs_procedure_cd,
       NULLIF(ci.additional_special_procedure_codes,'NULL') as additional_special_cpc_codes,
       case when ci.commodity_code!='-1' then 'CTC_GB' else '-1' end as customs_classification_scheme_cd,
       coalesce(ci.commodity_code, '-1') as commodity_code,
       NULLIF(ci.supplementary_commodity_1,'NULL') as first_supplementary_cd,
       NULLIF(ci.supplementary_commodity_2,'NULL') as second_supplementary_cd,
       NULLIF(ci.mucr,'NULL')  as inventory_ucr,
       NULLIF(ci.declaration_part_mumber,'NULL') as declaration_part_number,
       try_to_decimal(ci.item_price, 38, 5) item_price,
       try_to_decimal(ci.customs_value, 38, 5) as customs_val,
       try_to_decimal(ci.duty_paid, 38, 5) as duty_paid_val,
       try_to_decimal(ci.vat_value, 38, 5) as vat_val,
       try_to_decimal(ci.vat_paid, 38, 5) as vat_paid_val,
       try_to_decimal(ci.duty_suspended, 38, 5) as duty_suspended_val,
       try_to_decimal(ci.duty_secured, 38, 5) as duty_secured_val,
       try_to_decimal(ci.net_mass, 38, 5) as net_mass_qty,
       try_to_decimal(ci.supplementary_units, 38, 5) as supplementary_units_qty,
       TRIM(substr(NULLIF(ci.goods_description,'NULL'), 1, 250)) as goods_descr,
       NULLIF(ci.document_references,'NULL') as document_references,
clearance_date,
COALESCE(ci.DWH_SRC_FILE_NAME,'na') AS DWH_SRC_FILE_NAME,
COALESCE(ci.DWH_SRC_1_TMSP,current_timestamp) DWH_SRC_TMSP,
COALESCE(ci.DWH_SRC_1_TMSP,current_timestamp) DWH_MAPPING_TMSP,
0 TF_ERROR_FG ,
0 DELETED_FG    ,
0 RECORD_ID ,
1 AS DWH_VALID_FG,
COALESCE(DWH_SRC_FILE_NAME,'na') AS FILENAME
  from(select distinct coalesce(NULLIF(hd.declarant_reference,'NULL'),NULLIF(br.trader_reference,'NULL')) as trader_reference,
              case when substring(trim(hd.clearance_date),3,1)='/' then 
                  to_date(substring(hd.clearance_date,1,10), 'DD/MM_2/YYYY')
                  else to_date(substring(hd.clearance_date,1,10), 'YYYY-MM_2-DD') end clearance_date,
              --trunc(to_timestamp(hd.clearance_date), 'dd') clearance_date,
              coalesce(br.customs_product_sid, -1) as customs_product_sid,
              case when NULLIF(ci.commodity_code,'NULL') is not null then lpad(substr(replace(ci.commodity_code, ' ', ''), 1, 10), 10, '0') else '-1' end as commodity_code,
              ci.country_of_origin,
              ci.entry_identifier,
              ci.item_number,
              ci.preference,
              ci.valuation_method,
              ci.cpc,
              ci.additional_special_procedure_codes,
              ci.supplementary_commodity_1,
              ci.supplementary_commodity_2,
              ci.mucr,
              ci.declaration_part_mumber,
              try_to_decimal(ci.item_price, 38, 5) item_price,
              try_to_decimal(ci.customs_value, 38, 5) customs_value,
              try_to_decimal(ci.duty_paid, 38, 5) duty_paid,
              try_to_decimal(ci.vat_value, 38, 5) vat_value,
              try_to_decimal(ci.vat_paid, 38, 5) vat_paid,
              try_to_decimal(ci.duty_suspended, 38, 5) duty_suspended,
              try_to_decimal(ci.duty_secured, 38, 5) duty_secured,
              try_to_decimal(ci.net_mass, 38, 5) net_mass,
              try_to_decimal(ci.supplementary_units, 38, 5) supplementary_units,
              COALESCE(NULLIF(lk.location_sid,-1), NULLIF(lk1.location_sid,-1),-1) location_sid,
              ci.goods_description,
              ci.document_references,
              ci.dwh_src_file_name,
              ci.DWH_SRC_1_TMSP,
              case when hd.declarant_reference = br.trader_reference then 1
                   when hd.declarant_reference = br.invoice_number then 2
                   when br.declaration_ucr like '%' || hd.declarant_reference || '%' then 3
                   when abs(datediff(day, 
case 
        when substring(hd.clearance_date,2,1)='/' 
                then trunc(to_date(substring(hd.clearance_date,1,10), 'DD/MM_2/YYYY'), 'dd')
        when substring(hd.clearance_date,5,1)='-' 
                then trunc(to_date(substring(hd.clearance_date,1,10), 'YYYY-MM_2-DD'), 'dd')
        else NULL end
,
case 
        when substring(br.cds_clearance_dt,2,1)='/' 
                then trunc(to_date(substring(br.cds_clearance_dt,1,10), 'DD/MM_2/YYYY'), 'dd')
        when substring(br.cds_clearance_dt,5,1)='-' 
                then trunc(to_date(substring(br.cds_clearance_dt,1,10), 'YYYY-MM_2-DD'), 'dd')
        else NULL end )) < 2 then 4
                   else null
               end as rn
         from etl.t_cache_cds_item_2 ci
         join etl.t_cache_cds_header_2 hd
           on ci.entry_identifier = hd.entry_identifier
              and case when substring(trim(hd.clearance_date),3,1)='/' then 
                  to_date(substring(hd.clearance_date,1,10), 'DD/MM_2/YYYY')
                  else to_date(substring(hd.clearance_date,1,10), 'YYYY-MM_2-DD') end
                  = case when substring(trim(ci.clearance_date),3,1)='/' then 
                  to_date(substring(ci.clearance_date,1,10), 'DD/MM_2/YYYY')
                  else to_date(substring(ci.clearance_date,1,10), 'YYYY-MM_2-DD') end
         left
         join meta.t_location_key_2 lk
           on lk.location_key_type_cd = 'COUNTRY_2'
          and lk.location_nat_key_nr = COALESCE(NULLIF(ci.country_of_origin,'NULL'),'-1')
         left
         join meta.t_location_key_2 lk1
           on lk1.location_key_type_cd = 'COUNTRY_2'
          and lk1.location_nat_key_nr = COALESCE(NULLIF(ci.preferential_country_of_origin,'NULL'),'-1')
         /*left
         join(select entry_identifier as movement_ref_number
                from etl.t_cache_cds_header_2
               group
                  by 1
              having count(*) > 1

/*select movement_ref_number
                from core_rel.t_customs_clearance_report_2
               group
                  by 1
              having count(*) > 1
             ) nu
           on hd.entry_identifier = nu.movement_ref_number */
         left
         join(select distinct 
                     br.movement_ref_number,
                     br.trader_reference,
                     br.cds_clearance_dt,
                     brl.item_position,
                     brl.customs_product_sid,
                     brl.invoice_number,
                     br.declaration_ucr,
                     coalesce(nullif(brl.non_preferential_country_location_sid, -1), brl.preferential_country_location_sid) as origin_country_location_sid
                from core_rel.t_broker_report_2 br
                join core_rel.t_broker_report_line_2 brl
                  on br.movement_ref_number = brl.movement_ref_number
                  and br.trader_reference = brl.trader_reference
             ) br
           on ci.entry_identifier = br.movement_ref_number          
          and(   abs(datediff(day, 
case 
        when substring(hd.clearance_date,3,1)='/' 
                then trunc(to_date(substring(hd.clearance_date,1,10), 'DD/MM_2/YYYY'), 'dd')
        when substring(hd.clearance_date,5,1)='-' 
                then trunc(to_date(substring(hd.clearance_date,1,10), 'YYYY-MM_2-DD'), 'dd')
        else NULL end
,
case 
        when substring(br.cds_clearance_dt,3,1)='/' 
                then trunc(to_date(substring(br.cds_clearance_dt,1,10), 'DD/MM_2/YYYY'), 'dd')
        when substring(br.cds_clearance_dt,5,1)='-' 
                then trunc(to_date(substring(br.cds_clearance_dt,1,10), 'YYYY-MM_2-DD'), 'dd')
        else NULL end )) < 2
              or hd.declarant_reference = br.trader_reference
              or hd.declarant_reference = br.invoice_number
              or br.declaration_ucr like '%' || hd.declarant_reference || '%'
             )
         /*and year(br.cds_clearance_dt)= year(case when substring(trim(hd.clearance_date),3,1)='/' then 
                  to_date(substring(hd.clearance_date,1,10), 'DD/MM_2/YYYY')
                  else to_date(substring(hd.clearance_date,1,10), 'YYYY-MM_2-DD') end)
          and  month(br.cds_clearance_dt)= month(case when substring(trim(hd.clearance_date),3,1)='/' then 
                  to_date(substring(hd.clearance_date,1,10), 'DD/MM_2/YYYY')
                  else to_date(substring(hd.clearance_date,1,10), 'YYYY-MM_2-DD') end)*/
          --and br.cds_clearance_dt=trunc(to_timestamp(hd.clearance_date), 'dd')
          and ci.item_number = br.item_position 
          and COALESCE(NULLIF(lk.location_sid,-1), NULLIF(lk1.location_sid,-1),-1) = br.origin_country_location_sid
          where hd.declaration_category in ('IMD', 'IMA', 'IMY') 
           and   ci.declaration_category in ('IMD', 'IMA', 'IMY')          
      ) ci
   where NULLIF(ci.entry_identifier,'NULL') is not null
   and NULLIF(ci.trader_reference,'NULL') is not null
   and ci.item_number is not null
   qualify row_number() over (partition by ci.entry_identifier, ci.trader_reference, ci.item_number 
                              order by ci.rn) = 1;


