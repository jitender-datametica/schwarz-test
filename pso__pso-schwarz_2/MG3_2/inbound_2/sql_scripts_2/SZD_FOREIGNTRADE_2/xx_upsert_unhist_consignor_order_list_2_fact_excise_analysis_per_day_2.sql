INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(trader_reference_nr, customs_product_sid, authority_country_location_sid, 
report_dt, broker_declarant_party_sid, consignor_party_sid, broker_consignor_party_sid, cds_consignor_party_sid, 
original_consignor_party_sid, customs_declaration_type_cd, customs_preference_cd, curr_cd, movement_ref_number_txt, item_position_txt,article_variant_nr_txt, 
broker_line_cnt, broker_line_missing_cnt, consignor_line_cnt, consignor_line_missing_cnt, broker_tax_cd, consignor_tax_cd, 
different_tax_code_cnt, broker_excise_qty, consignor_excise_qty, different_excise_quantity_cnt, broker_excise_val, 
consignor_excise_val, overpaid_excise_val, underpaid_excise_val, different_excise_amount_cnt, correct_excise_amount_cnt, 
dwh_mapping_tmsp,
dwh_src_file_name,
dwh_src_1_tmsp,
tf_error_fg,
dwh_load_id,
record_id,
filename,
deleted_fg)
select 
trader_reference_nr,
customs_product_sid,
authority_country_location_sid,
report_dt,
broker_declarant_party_sid,
consignor_party_sid,
broker_consignor_party_sid,
cds_consignor_party_sid,
original_consignor_party_sid,
customs_declaration_type_cd,
customs_preference_cd,
'GBP' as curr_cd,
movement_ref_number_txt,
item_position_txt,
article_variant_nr_txt,
broker_line_cnt,
broker_line_missing_cnt,
consignor_line_cnt,
consignor_line_missing_cnt,
broker_tax_cd,
consignor_tax_cd,
case when broker_tax_cd != consignor_tax_cd
            then coalesce(nullif(broker_line_cnt, 0), consignor_line_cnt)
            else 0
        end as different_tax_code_cnt,
broker_excise_qty,
consignor_excise_qty,
case when abs(broker_excise_qty - consignor_excise_qty) > 0.3
            then coalesce(nullif(broker_line_cnt, 0), consignor_line_cnt)
            else 0
        end as different_excise_quantity_cnt,
broker_excise_val,
consignor_excise_val,
case when broker_excise_val > consignor_excise_val
            then broker_excise_val - consignor_excise_val
            else 0
        end as overpaid_excise_val,
case when consignor_excise_val > broker_excise_val
            then consignor_excise_val - broker_excise_val
            else 0
        end as underpaid_excise_val,
case when abs(broker_excise_val - consignor_excise_val) > 0.3
            then coalesce(nullif(broker_line_cnt, 0), consignor_line_cnt)
            else 0
        end as different_excise_amount_cnt,
case when abs(broker_excise_val - consignor_excise_val) <= 0.3
            then coalesce(nullif(broker_line_cnt, 0), consignor_line_cnt)
            else 0
        end as correct_excise_amount_cnt,
dwh_mapping_tmsp,
dwh_src_file_name,
dwh_src_1_tmsp,
0 as tf_error_fg,
0 as dwh_load_id,
0 as record_id,
dwh_src_file_name as filename,
0 as deleted_fg
from (
select coalesce(br.trader_reference_nr, cs.trader_reference_nr) as trader_reference_nr,
       coalesce(br.customs_product_sid, cs.customs_product_sid) as customs_product_sid,
       coalesce(br.authority_country_location_sid, cs.authority_country_location_sid) as authority_country_location_sid,
       coalesce(br.cds_acceptance_dt, cs.order_dt) as report_dt,
       coalesce(br.broker_declarant_party_sid, -1) as broker_declarant_party_sid,
       coalesce(cs.consignor_party_sid, -1) as consignor_party_sid,
       coalesce(br.consignor_party_sid_br, -1) as broker_consignor_party_sid,
       coalesce(br.cds_consignor_party_sid, -1) as cds_consignor_party_sid,
       coalesce(cs.original_consignor_party_sid, -1) as original_consignor_party_sid,
       coalesce(br.customs_declaration_type_cd, '-1') as customs_declaration_type_cd,
	   CASE WHEN cp.preferential_origin_fg
            THEN '300'
            ELSE '100'
        END as customs_preference_cd,
      /* 'GBP' as curr_cd,*/
       coalesce(max(br.movement_ref_number_txt), 'Unknown') as movement_ref_number_txt,
       coalesce(max(br.item_position_txt), 'Unknown') as item_position_txt,
       coalesce(max(cs.article_variant_nr), '') as article_variant_nr_txt,
       coalesce(sum(br.line_cnt), 0) as broker_line_cnt,
       sum(case when br.trader_reference_nr is null
                then cs.line_cnt
                else 0
            end) as broker_line_missing_cnt,		
       coalesce(sum(cs.line_cnt), 0) as consignor_line_cnt,     
       sum(case when cs.trader_reference_nr is null
                then br.line_cnt
                else 0
            end) as consignor_line_missing_cnt,
       coalesce(max(br.broker_tax_cd), 'Unknown') as broker_tax_cd,
       coalesce(max(cs.alcoholic_beverage_tax_rate_cd), 'Unknown') as consignor_tax_cd, 
       /*sum(case when coalesce(cp.alcoholic_beverage_tax_rate_cd, '-1') != coalesce(br.broker_tax_cd, '-1')
                then coalesce(br.line_cnt, cs.line_cnt)
                else 0
            end)*/
       /* case when broker_tax_cd != consignor_tax_cd
            then coalesce(nullfif(broker_line_cnt, 0), consignor_line_cnt)
            else 0
        end	as different_tax_code_cnt,*/
       coalesce(sum(br.excise_qty), 0) as broker_excise_qty,
       coalesce(sum(cs.excise_qty), 0) as consignor_excise_qty,   
       /*sum(case when coalesce(br.excise_qty, 0) != coalesce(cs.excise_qty, 0)
                then coalesce(br.line_cnt, cs.line_cnt)
                else 0
            end)*/
       /*case when abs(broker_excise_qty - consignor_excise_qty) > 0.3
            then coalesce(nullfif(broker_line_cnt, 0), consignor_line_cnt)
            else 0
        end as different_excise_quantity_cnt,*/
       coalesce(sum(br.excise_val), 0) as broker_excise_val,
       coalesce(floor(sum(case when coalesce(br.cds_acceptance_dt, cs.order_dt) >= '2023-08-01'
                then cs.item_cnt * cp.alcoholic_beverage_duty_per_unit_val
                when rl.customs_tariff_code_type_cd = 'BEER'
                then cs.excise_qty * cp.alcoholic_beverage_pct * 
                coalesce(cp.special_excise_rate_val, tr.excise_tax_rate_val)
                else cs.excise_qty * coalesce(cp.special_excise_rate_val, tr.excise_tax_rate_val)
                end) * 100) / 100, 0) as consignor_excise_val,
				coalesce(br.dwh_src_1_tmsp, cs.dwh_src_1_tmsp) as dwh_mapping_tmsp,
coalesce(br.dwh_src_file_name, cs.dwh_src_file_name) as dwh_src_file_name,
coalesce(br.dwh_src_1_tmsp, cs.dwh_src_1_tmsp) as dwh_src_1_tmsp
  from(-- Broker Report
       select case when br.trader_reference like '%-SDI'
                   then substr(br.trader_reference, 1, length(br.trader_reference) - 4)
                   else br.trader_reference 
               end as trader_reference_nr,
              coalesce(NULLIF(br.cds_acceptance_dt,'1900-01-01'), NULLIF(br.cds_clearance_dt,'1900-01-01'),trunc(br.acceptance_tmsp, 'dd')) as cds_acceptance_dt,
              br.broker_declarant_party_sid,
              br.customs_declaration_type_cd,
              br.consignor_party_sid as consignor_party_sid_br,
              cr.consignor_party_sid as cds_consignor_party_sid,
              br.authority_country_location_sid,
              brl.customs_product_sid,
		--	  brl.alcoholic_beverage_tax_rate_cd,
              cp.customs_product_nr,
              cp.additional_cd,
              cp.customs_tariff_code_cd,
              cp.origin_country_location_sid,
	      MIN(br.dwh_src_file_name) dwh_src_file_name,
              MIN(br.dwh_src_1_tmsp) dwh_src_1_tmsp,
              listagg(distinct brl.alcoholic_beverage_tax_rate_cd, ', ') within group (order by brl.alcoholic_beverage_tax_rate_cd) as broker_tax_cd,
              count(*) as line_cnt,
              sum(coalesce(brl.item_tariff_qty, 0)) as excise_qty,
              sum(coalesce(brl.excise_payment_amount_val, 0)) as excise_val,
              listagg(distinct br.movement_ref_number, ', ') within group (order by br.movement_ref_number) as movement_ref_number_txt,
              listagg(distinct to_char(brl.item_position), ', ') within group (order by to_char(brl.item_position)) as item_position_txt
         from core_rel.t_broker_report_2 br
         join core_rel.t_broker_report_line_2 brl
           on br.movement_ref_number = brl.movement_ref_number 
           and br.trader_reference = brl.trader_reference 
         join core_rel.t_customs_product_2 cp
           on brl.customs_product_sid = cp.product_sid
           and coalesce(nullif(br.cds_acceptance_dt, '1900-01-01'), trunc(br.acceptance_tmsp, 'dd'), br.cds_clearance_dt) between cp.dwh_valid_from_tmsp and cp.dwh_valid_to_tmsp 
          -- and YEAR(cp.dwh_valid_from_tmsp)>1900
         join core_rel.t_customs_tariff_code_type_rel_2 rl
           on cp.customs_tariff_code_cd = rl.customs_tariff_code_cd
          and rl.customs_tariff_category_cd = 'ABV'
         left
         join core_rel.t_customs_clearance_report_2 cr
           on br.movement_ref_number = cr.movement_ref_number
          and(   br.trader_reference = cr.trader_reference
              or brl.invoice_number = cr.trader_reference
              or br.declaration_ucr like '%' || cr.trader_reference || '%'
             )  
        where cp.alcoholic_beverage_tax_rate_cd like 'X%' 
          and br.trader_reference is not null /*and cp.dwh_valid_fg*/		
        group
           by 1, 2, 3, 4, 5, 6, 7, 8,9,10,11,12
      ) br
  full
  join(-- GTS
       select co.trader_reference_nr,
              co.order_dt,
              cp.product_sid as customs_product_sid,
              cp.customs_product_nr,
                     cp.additional_cd,
                     cp.customs_tariff_code_cd,
                     cp.origin_country_location_sid,
              col.article_variant_nr as article_variant_nr,
              co.authority_country_location_sid,
              co.consignor_party_sid,
              co.original_consignor_party_sid,
              col.alcoholic_beverage_tax_rate_cd as alcoholic_beverage_tax_rate_cd,
              count(*) as line_cnt,
              sum(col.item_cnt) as item_cnt,
              SUM(CASE WHEN cols.spec_uom_id = 28
                      THEN cols.spec_meas * 100
                      ELSE cols.spec_meas
              END) as excise_qty,
              /*floor(case when max(rl.customs_tariff_code_type_cd) = 'BEER'
                         then sum(cols.spec_meas * cp.alcoholic_beverage_pct * coalesce(cp.special_excise_rate_val, tr.excise_tax_rate_val))
                         else sum(cols.spec_meas * coalesce(cp.special_excise_rate_val, tr.excise_tax_rate_val)) 
                     end * 100) / 100 as excise_val*/
			 MAX(co.dwh_src_file_name) dwh_src_file_name,
              MAX(co.dwh_src_1_tmsp) dwh_src_1_tmsp
         from core_rel.t_consignor_order_list_2 co
         join core_rel.t_consignor_order_list_line_2 col
           on co.trader_reference_nr = col.trader_reference_nr
          and co.order_dt = col.order_dt
         join core_rel.t_customs_product_2 cp
           on col.customs_product_sid = cp.product_sid
           and cp.customs_product_type_cd = 'GTS'
          -- and YEAR(cp.dwh_valid_from_tmsp)>1900
           and co.order_dt between cp.dwh_valid_from_tmsp and cp.dwh_valid_to_tmsp 
         /*join core_rel.t_customs_tariff_code_type_rel_2 rl
           on cp.customs_tariff_code_cd = rl.customs_tariff_code_cd
          and rl.customs_tariff_category_cd = 'ABV' */
         join core_rel.t_consignor_order_list_line_specification_2 cols
           on col.trader_reference_nr = cols.trader_reference_nr
          and col.order_dt = cols.order_dt
          and col.item_position_seq = cols.item_position_seq
          and cols.specification_seq = 1
         /*join core_rel.t_alcoholic_beverage_tax_rate_2 tr
           on cp.alcoholic_beverage_tax_rate_cd = tr.alcoholic_beverage_tax_rate_cd*/
        where col.product_sid = -1 --and cp.dwh_valid_fg
        group  by 1, 2, 3, 4, 5, 6, 7, 8,9,10,11,12
        union
          all
       -- WWT
       select co.trader_reference_nr,
                     co.order_dt,
                     cp.product_sid as customs_product_sid,
                     cp.customs_product_nr,
                     cp.additional_cd,
                     cp.customs_tariff_code_cd,
                     cp.origin_country_location_sid,
                     null as article_variant_nr,
                     co.authority_country_location_sid,
                     co.consignor_party_sid,
                     co.original_consignor_party_sid,
        			 cp.alcoholic_beverage_tax_rate_cd,
                     count(*) as line_cnt,
                     sum(col.item_cnt) as item_cnt,
                     sum(case when cp.alcoholic_beverage_uom_id = 24
                              then col.item_cnt * cp.alcoholic_beverage_volume_lpa_qty
                              else col.item_cnt * cp.alcoholic_beverage_volume_qty
                          end) as excise_qty,
              MAX(co.dwh_src_file_name) dwh_src_file_name,
              MAX(co.dwh_src_1_tmsp) dwh_src_1_tmsp
                from core_rel.t_consignor_order_list_2 co
                join core_rel.t_consignor_order_list_line_2 col
                  on co.trader_reference_nr = col.trader_reference_nr
                 and co.order_dt = col.order_dt
                 and co.invoice_finance_sid = col.invoice_finance_sid
                join core_rel.t_customs_product_2 cp
                  on col.product_nr = cp.customs_product_nr
                -- and YEAR(cp.dwh_valid_from_tmsp)>1900
                 and col.additional_cd = cp.additional_cd 
                 and cp.customs_product_type_cd = 'WWT' 
                 and co.order_dt between cp.dwh_valid_from_tmsp and cp.dwh_valid_to_tmsp
                join core_rel.t_invoice_status_2 ist
                  on co.invoice_finance_sid = ist.invoice_finance_sid 
                 and co.order_dt between ist.dwh_valid_from_tmsp and ist.dwh_valid_to_tmsp
                join core_rel.t_invoice_position_2 inp
                  on col.invoice_position_finance_sid = inp.finance_sid 
                 and co.order_dt between inp.dwh_valid_from_tmsp and inp.dwh_valid_to_tmsp  
               where col.product_sid != -1
                 and ist.invoice_status_type_cd in ('UNCHARGED', 'CHARGED')
            	 and inp.reference_invoice_position_finance_sid = -1
                 and cp.alcoholic_beverage_volume_qty > 0
               group
                  by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
      ) cs
     on br.trader_reference_nr = cs.trader_reference_nr
          and br.customs_product_nr = cs.customs_product_nr
          and br.additional_cd = cs.additional_cd
          and br.customs_tariff_code_cd = cs.customs_tariff_code_cd
          and br.origin_country_location_sid = cs.origin_country_location_sid
         join core_rel.t_customs_product_2 cp
           on coalesce(br.customs_product_sid, cs.customs_product_sid) = cp.product_sid 
          and coalesce(br.cds_acceptance_dt, cs.order_dt) between cp.dwh_valid_from_tmsp and cp.dwh_valid_to_tmsp
        --  and YEAR(cp.dwh_valid_from_tmsp)>1900
         join core_rel.t_customs_tariff_code_type_rel_2 rl
           on cp.customs_tariff_code_cd = rl.customs_tariff_code_cd
          and rl.customs_tariff_category_cd = 'ABV' 
         join core_rel.t_alcoholic_beverage_tax_rate_2 tr
	 on cp.alcoholic_beverage_tax_rate_cd = tr.alcoholic_beverage_tax_rate_cd
         and coalesce(br.cds_acceptance_dt, cs.order_dt) between tr.dwh_valid_from_tmsp and tr.dwh_valid_to_tmsp
         group
           by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,25,26)
qualify rank() over (partition by trader_reference_nr order by case when broker_declarant_party_sid > -1 then 1 else -1 end desc) = 1;
