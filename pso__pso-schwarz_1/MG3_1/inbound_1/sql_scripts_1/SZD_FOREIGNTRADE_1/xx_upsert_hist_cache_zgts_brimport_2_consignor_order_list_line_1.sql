INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
trader_reference_nr, order_dt, item_position_seq, product_sid, customs_product_sid, origin_country_location_sid, alcoholic_beverage_tax_rate_cd, 
invoice_finance_sid, invoice_position_finance_sid, purchase_order_item_nr, product_nr, additional_cd, product_name, net_weight_meas, gross_weight_meas, 
weight_uom_id, allocation_cnt, packages_cnt, packages_uom_id, item_cnt, item_uom_id, net_val, net_curr_cd, original_amount_val, original_amount_curr_cd, 
item_price_val, freight_cost_val, freight_cost_curr_cd, insurance_cost_val, insurance_cost_curr_cd, license_cost_val, license_cost_curr_cd, abv_pct, 
inbound_item_nr, tax_indicator_txt, article_variant_nr, additional_codes_txt, gtin_nr,batch_nr,
  dwh_src_1_tmsp,  
  dwh_src_file_name,
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
)
select 
trader_reference_nr, order_dt, item_position_seq, product_sid, customs_product_sid, origin_country_location_sid, 
case when TRIM(alcoholic_beverage_tax_rate_cd)='NULL' then '-1' else TRIM(alcoholic_beverage_tax_rate_cd) end , 
invoice_finance_sid, invoice_position_finance_sid, ltrim(purchase_order_item_nr,'0'), 
ltrim(product_nr,'0'), additional_cd, trim(product_name), net_weight_meas, gross_weight_meas, 
weight_uom_id, allocation_cnt, packages_cnt, packages_uom_id, item_cnt, item_uom_id, net_val, net_curr_cd, original_amount_val, original_amount_curr_cd, 
item_price_val, freight_cost_val, freight_cost_curr_cd, insurance_cost_val, 
case when insurance_cost_curr_cd like 'NUL%' then '-1'else insurance_cost_curr_cd end, license_cost_val, 
case when license_cost_curr_cd like 'NUL%' then '-1'else license_cost_curr_cd end license_cost_curr_cd, abv_pct, 
ltrim(inbound_item_nr,'0'), tax_indicator_txt, article_variant_nr, 
case when additional_codes_txt='NULL' then null else additional_codes_txt end , gtin_nr, batch_nr,
  MAX(dwh_src_1_tmsp),  
  MAX(dwh_src_file_name),
  current_timestamp dwh_mapping_tmsp,
  0 tf_error_fg,
  0 deleted_fg,
  0 record_id,
  MAX(dwh_src_file_name) filename
from (select to_char(bei.CORDER) as trader_reference_nr,
       coalesce(bei.etd, bei.etats) as order_dt,
       ROW_NUMBER() OVER (PARTITION BY bei.CORDER ORDER BY bei.ITVSY_ID_NO) as item_position_seq,
       -1 as product_sid,
       pk.product_sid as customs_product_sid,
       coalesce(ock.location_sid, -1) as origin_country_location_sid,
       CASE WHEN ETD >= '2023-08-01'
            THEN COALESCE(EXCISE_DUTY_CODE, '-1')
            ELSE COALESCE(abv.excise_code, EXCISE_DUTY_CODE, '-1')
        END as alcoholic_beverage_tax_rate_cd,
       -1 as invoice_finance_sid,
       -1 as invoice_position_finance_sid,       
       LTRIM(bei.ITVSY_PO_NO, '0') as purchase_order_item_nr,
       LTRIM(to_char(bei.PRVSY), '0') as product_nr,
       '' as additional_cd,
       TRIM(substr(bei.PRTXT, 1, 100)) as product_name,
       bei.WEINET_FLT as net_weight_meas,
       bei.WEIGRO_FLT as gross_weight_meas,
       10 as weight_uom_id,
       bei.allocation as allocation_cnt,
       bei.PGESU as packages_cnt,
       30 as packages_uom_id,
       bei.QUANT_FLT as item_cnt,
       19 as item_uom_id,
       bei.NETVAL_FLT as net_val,
       'EUR' as net_curr_cd,
       to_number(bei.ORIGINAL_VAL,38,5) as original_amount_val,
       coalesce(substr(bei.ORIG_VAL_CURR, 1, 3), '-1') as original_amount_curr_cd,
       0 as item_price_val,
       bei.FRT_COST as freight_cost_val,
       coalesce(substr(bei.FRT_COST_CURR, 1, 3), '-1') as freight_cost_curr_cd,
       bei.INS_COST as insurance_cost_val,
       coalesce(substr(bei.INS_COST_CURR , 1, 3), '-1') as insurance_cost_curr_cd,
       bei.licence_cost as license_cost_val,
       coalesce(substr(bei.LICENCE_COST_CURR, 1, 3), '-1') as license_cost_curr_cd,
       0 as abv_pct,
       LTRIM(bei.ITVSY_ID_NO, '0') as inbound_item_nr,
       bei.TAXID as tax_indicator_txt,
       TRIM(bei.ARTICLE_VARIANT) as article_variant_nr,
       bei.ADDITIONAL_CODES as additional_codes_txt,
       bei.GTIN_NUMBER as gtin_nr,
       NULL as batch_nr,
       current_timestamp as dwh_created_tmsp,
       current_timestamp as dwh_updated_tmsp,
       bei.dwh_src_file_name as dwh_src_file_name,
       current_timestamp as dwh_src_1_tmsp
  from etl.t_cache_zgts_brimport_1 bei
  join meta.t_product_key_1 pk
    on pk.product_key_type_cd = 'CUSTOMS_PRODUCT'
   and pk.product_nat_key_nr = try_to_number(bei.PRVSY) || '||' || lpad(substr(replace(bei.CCNGN, ' ', ''), 1, 10), 10, '0') || '|' || TRIM(bei.CUCOO)
  left
  join meta.t_location_key_1 ock
    on ock.location_key_type_cd = 'COUNTRY_1'
   and ock.location_nat_key_nr = UPPER(trim(bei.CUCOO))
  left
  join etl.t_cache_abv_1  abv
--  alter table etl.t_cache_abv_1 add column  
--ARTIKELNUMMER  varchar(100)
--excise_code varchar(100)
    on ltrim(bei.PRVSY,'0') = abv.article_number
 where coalesce(bei.etd, bei.etats) is not null
 union 
select  trader_reference_nr,
       order_dt,
       row_number() over (partition by consignee_additional_name || '-' || invoice_reference_nr,
                                       loading_dt
                              order by to_number(finance_nat_key_nr)) as item_position_seq,
       product_sid,
       -1 as customs_product_sid,
       origin_country_location_sid,
       '-1' as alocholic_beverage_tax_rate_cd,
       invoice_finance_sid,
       invoice_position_finance_sid,
       null as purchase_order_item_nr,
       product_nr,
       additional_product_cd,
       product_name,
       net_weight_meas,
       gross_weight_meas,
       10 as weight_uom_id,
       /*allocation_cnt,
       packages_qty,*/
	   case when allocation_cnt is NULL then 0
       else allocation_cnt end as allocation_cnt, 
       case when PACKAGES_CNT is NULL then 0
       else PACKAGES_CNT end as PACKAGES_CNT,
       30 as packages_uom_id,
       /*item_cnt,*/
	   case when item_cnt is NULL then 0
       else item_cnt end as item_cnt,
       19 as item_uom_id,
       net_val,
       'EUR' as net_curr_cd,
       0 as original_amount_val,
       '-1' as original_amount_curr_cd,
       item_price_val,
       0 as freight_cost_val,
       '-1' as freight_cost_curr_cd,
       0 as insurance_cost_val,
       '-1' as insurance_cost_curr_cd,
       0 as license_cost_val,
       '-1' as license_cost_curr_cd,
       0 as abv_pct,
       null as inbound_item_nr,
       null as tax_indicator_txt,
       null as article_variant_nr,
       null as additional_codes_txt,
       null as gtin_nr,
       batch_nr,
       current_timestamp as dwh_created_tmsp,
       current_timestamp as dwh_updated_tmsp,
       dwh_src_file_name as dwh_src_file_name,
       current_timestamp as dwh_src_1_tmsp
from(
select distinct c.consignee_additional_name || '-' || i.invoice_reference_nr as trader_reference_nr,
       p.loading_dt as order_dt,
       c.consignee_additional_name,
	   i.invoice_reference_nr,
	   p.loading_dt,
	   fk.finance_nat_key_nr,
       p.product_sid,       
       p.origin_country_location_sid,      
       p.invoice_finance_sid,
       p.finance_sid as invoice_position_finance_sid,       
       to_char(pr.ian_nr) as product_nr,
       p.additional_product_cd,
       p.product_name,
	   
	    case when case when st.invoice_status_type_cd in ('CREDIT_INVOICE', 'CANCEL_INVOICE')
            then p.package_qty * -1
            else p.package_qty
        end is NULL then 0
       else case when st.invoice_status_type_cd in ('CREDIT_INVOICE', 'CANCEL_INVOICE')
            then p.package_qty * -1
            else p.package_qty
        end end as PACKAGES_CNT,	   
       case when p.non_food_fg = true and st.invoice_status_type_cd in ('CREDIT_INVOICE', 'CANCEL_INVOICE')
            then p.item_net_weight_meas * PACKAGES_CNT * -1
            when p.non_food_fg = true and st.invoice_status_type_cd not in ('CREDIT_INVOICE', 'CANCEL_INVOICE')
            then p.item_net_weight_meas * PACKAGES_CNT 
            when p.non_food_fg = false and st.invoice_status_type_cd in ('CREDIT_INVOICE', 'CANCEL_INVOICE')
            then p.unit_net_weight_meas * PACKAGES_CNT * -1
            when p.non_food_fg = false and st.invoice_status_type_cd not in ('CREDIT_INVOICE', 'CANCEL_INVOICE')
            then p.unit_net_weight_meas * PACKAGES_CNT            
        end as net_weight_meas,
       case when st.invoice_status_type_cd in ('CREDIT_INVOICE', 'CANCEL_INVOICE')
            then p.unit_gross_weight_meas * PACKAGES_CNT * -1
            else p.unit_gross_weight_meas * PACKAGES_CNT
        end as gross_weight_meas,       
       p.package_content_cnt as allocation_cnt,
       /*case when st.invoice_status_type_cd in ('CREDIT_INVOICE', 'CANCEL_INVOICE')
            then p.package_qty * -1
            else p.package_qty
        end as packages_qty,*/     
       case when st.invoice_status_type_cd in ('CREDIT_INVOICE', 'CANCEL_INVOICE')
            then p.package_content_cnt * p.package_qty * -1
            else p.package_content_cnt * p.package_qty
        end as item_cnt,       
       case when st.invoice_status_type_cd in ('CREDIT_INVOICE', 'CANCEL_INVOICE')
            then p.amount_val * -1
            else p.amount_val 
        end as net_val,       
       p.price_val as item_price_val,
       p.batch_nr,
       p.dwh_src_file_name
  from core_rel.t_invoice_position_1 p
  join core_rel.t_invoice_1 i
    on p.invoice_finance_sid = i.finance_sid
  join core_rel.t_consignee_1 c
    on i.consignee_party_sid = c.party_sid
    and c.dwh_valid_fg='TRUE' 
  join core_rel.t_country_political_1 co
    on c.country_location_sid = co.location_sid 
   and co.lang_cd = 'DE'
  left  
  join core_rel.t_product_1 pr
    on p.product_sid = pr.product_sid
   and p.loading_dt between pr.dwh_valid_from_tmsp and pr.dwh_valid_to_tmsp  
  left
  join core_rel.t_invoice_status_1 st
    on i.finance_sid = st.invoice_finance_sid 
   and p.loading_dt between st.dwh_valid_from_tmsp and st.dwh_valid_to_tmsp
  left
  join meta.t_finance_key_1 fk
    on fk.finance_sid = p.finance_sid 
 where p.business_transaction_type_cd = '1-LAGER'   
   and co.iso_country_cd = 'GB'
   and i.consignor_stream_cd in ('LST', 'OWIM')
   and p.loading_dt >= '2021-12-01')) a
group by   
trader_reference_nr, order_dt, item_position_seq, product_sid, customs_product_sid, origin_country_location_sid, alcoholic_beverage_tax_rate_cd, 
invoice_finance_sid, invoice_position_finance_sid, purchase_order_item_nr, product_nr, additional_cd, product_name, net_weight_meas, gross_weight_meas, 
weight_uom_id, allocation_cnt, packages_cnt, packages_uom_id, item_cnt, item_uom_id, net_val, net_curr_cd, original_amount_val, original_amount_curr_cd, 
item_price_val, freight_cost_val, freight_cost_curr_cd, insurance_cost_val, insurance_cost_curr_cd, license_cost_val, license_cost_curr_cd, abv_pct, 
inbound_item_nr, tax_indicator_txt, article_variant_nr, additional_codes_txt, gtin_nr, batch_nr
