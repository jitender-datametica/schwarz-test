INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  authority_country_location_sid,
  report_dt,
  original_consignor_party_sid,
  broker_declarant_party_sid,
  consignor_party_sid,
  customs_declaration_type_cd,
  trader_reference_nr,
  customs_product_sid,
  customs_product_nr,
  customs_product_descr,
  article_variant_nr_txt,
  movement_ref_number_txt,
  item_position_txt,
  broker_line_cnt,
  consignor_line_cnt,
  correct_line_cnt,
  invalid_consignor_cnt,
  invalid_importer_cnt,
  broker_trader_reference_missing_cnt,
  consignor_trader_reference_missing_cnt,
  broker_product_missing_cnt,
  consignor_product_missing_cnt,
  different_commodity_code_cnt,
  broker_commodity_code_nr,
  consignor_commodity_code_nr,
  different_country_of_origin_cnt,
  broker_origin_country_location_sid,
  broker_country_of_origin_cd,
  consignor_origin_country_location_sid,
  consignor_country_of_origin_cd,
  different_net_mass_cnt,
  cds_net_mass_meas,
  consignor_net_mass_meas,
  different_invoice_amount_cnt,
  cds_invoice_amount_val,
  consignor_invoice_amount_val,
  different_invoice_curr_cnt,
  cds_invoice_curr_cd,
  consignor_invoice_curr_cd,
  missing_document_codes_cnt,
  cds_document_codes_txt,
  consignor_document_codes_txt,
  missing_document_codes_txt,
  invalid_incoterm_cnt,
  incoterm_cd,
  dwh_mapping_tmsp,
  dwh_src_file_name,
  dwh_src_1_tmsp,
  tf_error_fg,
  dwh_load_id,
  record_id,
  filename,
  deleted_fg
)
select DISTINCT
  coalesce(bd.authority_country_location_sid, cd.authority_country_location_sid) as authority_country_location_sid,
  coalesce(bd.report_dt, cd.report_dt) as report_dt,
  coalesce(cd.original_consignor_party_sid, -1) as original_consignor_party_sid,
  coalesce(bd.broker_declarant_party_sid, -1) as broker_declarant_party_sid,
  coalesce(bd.consignor_party_sid, cd.consignor_party_sid) as consignor_party_sid,
  coalesce(bd.customs_declaration_type_cd, '-1') as customs_declaration_type_cd,
  coalesce(bd.trader_reference_nr, cd.trader_reference_nr) as trader_reference_nr,
  coalesce(bd.customs_product_sid, cd.customs_product_sid) as customs_product_sid,
  coalesce(bd.customs_product_nr, cd.customs_product_nr) as customs_product_nr,
  coalesce(bd.customs_product_name, cd.customs_product_name) as customs_product_descr,
  coalesce(cd.article_variant_nr_txt, 'Unknown') as article_variant_nr_txt,
  coalesce(bd.movement_ref_number_txt, trm.movement_ref_number_txt, 'Unknown') as movement_ref_number_txt,
  coalesce(bd.item_position_txt, cd.item_position_txt, 'Unknown') as item_position_txt,
  coalesce(bd.broker_line_cnt, 0) as broker_line_cnt,
  coalesce(cd.consignor_line_cnt, 0) as consignor_line_cnt,
  case when trm.broker_missing_fg = false
             and trm.consignor_missing_fg = false
             and bd.customs_product_nr = cd.customs_product_nr
             and bd.commodity_code_nr = cd.commodity_code_nr
             and bd.country_of_origin_cd = cd.country_of_origin_cd
             and bd.cds_net_mass_meas = cd.consignor_net_mass_meas
             and bd.cds_invoice_amount_val = cd.consignor_invoice_amount_val
            then bd.broker_line_cnt
            else 0
        end as correct_line_cnt,
  case when bd.consignor_stream_cd = 'EXTERNAL'
            then 1
            else 0
        end as invalid_consignor_cnt,
  case when bd.importer_party_sid = -1
            then 1
            else 0
        end as invalid_importer_cnt,
  case when trm.broker_missing_fg = true
            then cd.consignor_line_cnt
            else 0
        end as broker_trader_reference_missing_cnt,
  case when trm.consignor_missing_fg = true
            then bd.broker_line_cnt
            else 0
        end as consignor_trader_reference_missing_cnt,
  case when trm.broker_missing_fg = false
             and trm.consignor_missing_fg = false
             and bd.customs_product_nr is null
            then cd.consignor_line_cnt
            else 0
        end as broker_product_missing_cnt,
  case when trm.broker_missing_fg = false
             and trm.consignor_missing_fg = false
             and cd.customs_product_nr is null
            then bd.broker_line_cnt
            else 0
        end	 as consignor_product_missing_cnt,
  case when trm.broker_missing_fg = false
             and trm.consignor_missing_fg = false
             and bd.customs_product_nr = cd.customs_product_nr
             and bd.commodity_code_nr != cd.commodity_code_nr
            then bd.broker_line_cnt
            else 0
        end as different_commodity_code_cnt,
  coalesce(bd.commodity_code_nr, 'Unknown') as broker_commodity_code_nr,
  coalesce(cd.commodity_code_nr, 'Unknown') as consignor_commodity_code_nr,
  case when trm.broker_missing_fg = false
               and trm.consignor_missing_fg = false
               and bd.customs_product_nr = cd.customs_product_nr
               and bd.country_of_origin_cd != cd.country_of_origin_cd
              then bd.broker_line_cnt
              else 0
          end as different_country_of_origin_cnt,
  coalesce(bd.origin_country_location_sid, -1) as broker_origin_country_location_sid,
  coalesce(bd.country_of_origin_cd, 'Unknown') as broker_country_of_origin_cd,
  coalesce(cd.origin_country_location_sid, -1) as consignor_origin_country_location_sid,
  coalesce(cd.country_of_origin_cd, 'Unknown') as consignor_country_of_origin_cd,
  case when trm.broker_missing_fg = false
             and trm.consignor_missing_fg = false
             and bd.customs_product_nr = cd.customs_product_nr
             and bd.cds_net_mass_meas != cd.consignor_net_mass_meas
            then bd.broker_line_cnt
            else 0
        end as different_net_mass_cnt,
  bd.cds_net_mass_meas as cds_net_mass_meas,
  cd.consignor_net_mass_meas as consignor_net_mass_meas,
  case when trm.broker_missing_fg = false
             and trm.consignor_missing_fg = false
             and bd.customs_product_nr = cd.customs_product_nr
             and bd.cds_invoice_amount_val != cd.consignor_invoice_amount_val
            then bd.broker_line_cnt
            else 0
        end as different_invoice_amount_cnt,
   bd.cds_invoice_amount_val as cds_invoice_amount_val,
   cd.consignor_invoice_amount_val as consignor_invoice_amount_val,
  case when trm.broker_missing_fg = false
             and trm.consignor_missing_fg = false
             and bd.customs_product_nr = cd.customs_product_nr
             and bd.cds_invoice_curr_cd != cd.consignor_invoice_curr_cd
            then bd.broker_line_cnt
            else 0
        end as different_invoice_curr_cnt,
   bd.cds_invoice_curr_cd as cds_invoice_curr_cd,
   cd.consignor_invoice_curr_cd as consignor_invoice_curr_cd,
   coalesce(missing_document_codes_cnt, 0) as missing_document_codes_cnt,
   bdl.broker_document_codes_txt as cds_document_codes_txt,
   cdl.conisgnor_document_codes_txt as consignor_document_codes_txt,
   md.missing_document_codes_txt as missing_document_codes_txt,
   case when bd.trade_terms != 'DAP'
            then 1
            else 0
        end as invalid_incoterm_cnt,
   bd.trade_terms as incoterm_cd,
   coalesce(bd.dwh_src_1_tmsp, cd.dwh_src_1_tmsp) as dwh_mapping_tmsp,
   coalesce(bd.dwh_src_file_name, cd.dwh_src_file_name) as dwh_src_file_name,
   coalesce(bd.dwh_src_1_tmsp, cd.dwh_src_1_tmsp) as dwh_src_1_tmsp,
   0 as tf_error_fg,
   0 as dwh_load_id,
   0 as record_id,
   coalesce(bd.dwh_src_file_name, cd.dwh_src_file_name) as filename,
   0 as deleted_fg
  from 
  (select br.authority_country_location_sid,
      br.broker_declarant_party_sid,
      coalesce(cr.consignor_party_sid, br.consignor_party_sid) as consignor_party_sid, 
      coalesce(cr.customs_declaration_type_cd, br.customs_declaration_type_cd) as customs_declaration_type_cd,
      case when br.trader_reference like '%-SDI'
                then substr(br.trader_reference, 1, length(br.trader_reference) - 4)
                else br.trader_reference 
            end as trader_reference_nr,
      trunc(coalesce(nullif(cds_acceptance_dt, '1900-01-01'), acceptance_tmsp, cds_clearance_dt), 'dd') as report_dt,
      product_sid as customs_product_sid,
      case when p.additional_cd != ''
                then p.customs_product_nr || '_' || p.additional_cd
                else p.customs_product_nr 
            end as customs_product_nr, 
      p.customs_tariff_code_cd as commodity_code_nr,
      p.origin_country_location_sid,
      c.iso_country_cd as country_of_origin_cd,
      max(cg.consignor_stream_cd) as consignor_stream_cd,
      max(coalesce(cr.importer_party_sid, br.importer_party_sid)) as importer_party_sid,
      max(p.customs_product_name) as customs_product_name,
      listagg(distinct br.movement_ref_number, ', ') within group (order by br.movement_ref_number) as movement_ref_number_txt,
      listagg(distinct brl.item_position, ', ') within group (order by brl.item_position) as item_position_txt,
      round(sum(brl.net_mass_meas), 2) as broker_net_mass_meas,
      round(sum(crl.net_mass_qty), 2) as cds_net_mass_meas,
      round(sum(brl.charge_amount_val), 0) as broker_invoice_amount_val,
      round(sum(crl.item_price), 0) as cds_invoice_amount_val,
      max(brl.charge_amount_curr_cd) as broker_invoice_curr_cd,
      max(cr.invoice_trust_curr_cd) as cds_invoice_curr_cd,
      max(br.trade_terms) as trade_terms,
      count(*) as broker_line_cnt,      
      br.dwh_src_file_name,
      br.dwh_src_1_tmsp
      from core_rel.t_broker_report_1 br
      join core_rel.t_broker_report_line_1 brl
        on br.movement_ref_number = brl.movement_ref_number 
       and br.trader_reference = brl.trader_reference
      join core_rel.t_customs_product_1 p
        on brl.customs_product_sid = p.product_sid
       and coalesce(br.cds_acceptance_tmsp, br.acceptance_tmsp, br.cds_clearance_tmsp) between p.dwh_valid_from_tmsp and p.dwh_valid_to_tmsp  
      join core_rel.t_country_political_1 c
        on p.origin_country_location_sid = c.location_sid
        and coalesce(br.cds_acceptance_tmsp, br.acceptance_tmsp, br.cds_clearance_tmsp) between c.dwh_valid_from_tmsp and c.dwh_valid_to_tmsp  
       and c.lang_cd = 'DE'
      left
      join core_rel.t_customs_clearance_report_1 cr
        on br.movement_ref_number = cr.movement_ref_number
       and(   br.trader_reference = cr.trader_reference
           or brl.invoice_number = cr.trader_reference
           or br.declaration_ucr like '%' || cr.trader_reference || '%'
          )
      left
      join core_rel.t_customs_clearance_report_line_1 crl
        on cr.movement_ref_number = crl.movement_ref_number 
       and cr.clearance_dt = crl.clearance_dt 
       and brl.item_position = crl.item_position
      join core_rel.t_consignor_1 cg
        on coalesce(cr.consignor_party_sid, br.consignor_party_sid) = cg.party_sid
        and coalesce(br.cds_acceptance_tmsp, br.acceptance_tmsp, br.cds_clearance_tmsp) between cg.dwh_valid_from_tmsp and cg.dwh_valid_to_tmsp  
      GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,25,26) bd
  full
  join (--Consignor Data                                                                                              
    --GTS Data                                                                                             
     select 'GTS' as customs_product_type_cd,
     col.original_consignor_party_sid,
     col.authority_country_location_sid,
     col.consignor_party_sid,
     col.trader_reference_nr,
     col.order_dt as report_dt,
     p.product_sid as customs_product_sid,
     case when p.additional_cd != ''
          then p.customs_product_nr || '_' || p.additional_cd 
          else p.customs_product_nr 
          end as customs_product_nr,
     p.customs_tariff_code_cd as commodity_code_nr,
     p.origin_country_location_sid,
     c.iso_country_cd as country_of_origin_cd,
     listagg(coll.item_position_seq, ', ') within group (order by coll.item_position_seq) as item_position_txt,
     max(p.customs_product_name) as customs_product_name,
     listagg(coll.article_variant_nr, ', ') within group (order by coll.article_variant_nr) as article_variant_nr_txt,
     round(sum(coll.net_weight_meas), 2) as consignor_net_mass_meas,
     round(sum(coll.original_amount_val), 0) as consignor_invoice_amount_val,
     max(coll.original_amount_curr_cd) as consignor_invoice_curr_cd,                                                                                               
     count(*) as consignor_line_cnt,
     col.dwh_src_1_tmsp,
     col.dwh_src_file_name
     from core_rel.t_consignor_order_list_1 col
     join core_rel.t_consignor_order_list_line_1 coll
     on col.trader_reference_nr = coll.trader_reference_nr 
     and col.order_dt = coll.order_dt
     join core_rel.t_customs_product_1 p
     on coll.customs_product_sid = p.product_sid
     and coll.order_dt between p.dwh_valid_from_tmsp and p.dwh_valid_to_tmsp
     join core_rel.t_country_political_1 c
     on coll.origin_country_location_sid = c.location_sid 
     and coll.order_dt between c.dwh_valid_from_tmsp and c.dwh_valid_to_tmsp 
     and c.lang_cd = 'DE'
     where coll.customs_product_sid != -1                                                                                         
     GROUP BY 2, 3, 4, 5, 6, 7, 8, 9, 10,11,19,20
     union                                                                                        
    --WWT Data
      select 'WWT' as customs_product_type_cd,
      col.original_consignor_party_sid,
      COL.authority_country_location_sid,
      COL.consignor_party_sid,
      COL.trader_reference_nr,
      COL.order_dt as report_dt,
      cp.product_sid as customs_product_sid,
      case when cp.additional_cd != ''
           then cp.customs_product_nr || '_' || cp.additional_cd 
           else cp.customs_product_nr 
           end as customs_product_nr,
      cp.customs_tariff_code_cd as commodity_code_nr,
      cp.origin_country_location_sid,
      c.iso_country_cd as country_of_origin_cd,
      NULL as item_position_txt,
      max(cp.customs_product_name) as customs_product_name,
      NULL as article_variant_nr_txt,
      round(sum(coll.net_weight_meas), 2) as consignor_net_mass_meas,
      round(sum(coll.net_val), 0) as consignor_invoice_amount_val,
      --max(coll.net_val_curr_cd) as consignor_invoice_curr_cd,
      MAX(COLL.NET_CURR_CD)  as consignor_invoice_curr_cd,
      count(*) as consignor_line_cnt,
	  col.dwh_src_1_tmsp,
      col.dwh_src_file_name
      from CORE_REL.T_CONSIGNOR_ORDER_LIST_1 COL
      JOIN CORE_REL.T_CONSIGNOR_ORDER_LIST_LINE_1 COLL
        ON COL.TRADER_REFERENCE_NR = COLL.TRADER_REFERENCE_NR 
       AND COL.ORDER_DT = COLL.ORDER_DT
       and col.invoice_finance_sid = coll.invoice_finance_sid
      JOIN CORE_REL.T_COUNTRY_POLITICAL_1 C
        ON COLL.ORIGIN_COUNTRY_LOCATION_SID = C.LOCATION_SID 
        AND COL.ORDER_DT BETWEEN C.DWH_VALID_FROM_TMSP AND C.DWH_VALID_TO_TMSP 
       AND C.LANG_CD = 'DE' 
      JOIN CORE_REL.T_CUSTOMS_PRODUCT_1 CP
        ON COLL.PRODUCT_NR = CP.CUSTOMS_PRODUCT_NR
       AND COLL.ADDITIONAL_CD = CP.ADDITIONAL_CD 
       AND CP.CUSTOMS_PRODUCT_TYPE_CD='WWT'
       AND COLL.ORIGIN_COUNTRY_LOCATION_SID = CP.ORIGIN_COUNTRY_LOCATION_SID
       AND COL.ORDER_DT BETWEEN CP.DWH_VALID_FROM_TMSP AND CP.DWH_VALID_TO_TMSP 
      JOIN core_rel.t_invoice_status_1 ist
        on col.invoice_finance_sid = ist.invoice_finance_sid 
       and col.order_dt between ist.dwh_valid_from_tmsp and ist.dwh_valid_to_tmsp  
      join core_rel.t_invoice_position_1 inp
        on coll.invoice_position_finance_sid = inp.finance_sid 
       and col.order_dt between inp.dwh_valid_from_tmsp and inp.dwh_valid_to_tmsp
      where COLL.PRODUCT_SID != -1    
       AND ist.invoice_status_type_cd in ('CHARGED', 'UNCHARGED')
       AND inp.reference_invoice_position_finance_sid = -1
      GROUP BY  2, 3, 4, 5, 6, 7, 8, 9, 10,11,19,20) cd
    on bd.trader_reference_nr = cd.trader_reference_nr
   and bd.customs_product_nr = cd.customs_product_nr 
   --11.10.2024--and bd.commodity_code_nr = cd.commodity_code_nr 
  left
  join (   --Trader Reference Missing 
   select coalesce(bd.trader_reference_nr, cd.trader_reference_nr) as trader_reference_nr,
   bd.movement_ref_number_txt as movement_ref_number_txt,
   bd.trader_reference_nr is null as broker_missing_fg,
   cd.trader_reference_nr is null as consignor_missing_fg
   from
   (select distinct
                  trader_reference_nr,
                  movement_ref_number_txt
             from (--Broker Data                                                                                        
      select br.authority_country_location_sid,
      br.broker_declarant_party_sid,
      coalesce(cr.consignor_party_sid, br.consignor_party_sid) as consignor_party_sid, 
      coalesce(cr.customs_declaration_type_cd, br.customs_declaration_type_cd) as customs_declaration_type_cd,
      case when br.trader_reference like '%-SDI'
                then substr(br.trader_reference, 1, length(br.trader_reference) - 4)
                else br.trader_reference 
            end as trader_reference_nr,
      trunc(coalesce(nullif(cds_acceptance_dt, '1900-01-01'), acceptance_tmsp, cds_clearance_dt), 'dd') as report_dt,
      product_sid as custom_product_sid,
      case when p.additional_cd != ''
                then p.customs_product_nr || '_' || p.additional_cd
                else p.customs_product_nr 
            end as customs_product_nr, 
      p.customs_tariff_code_cd as commodity_code_nr,
      p.origin_country_location_sid,
      c.iso_country_cd as country_of_origin_cd,
      max(cg.consignor_stream_cd) as consignor_stream_cd,
      max(coalesce(cr.importer_party_sid, br.importer_party_sid)) as importer_party_sid,
      max(p.customs_product_name) as customs_product_name,
      listagg(distinct br.movement_ref_number, ', ') within group (order by br.movement_ref_number) as movement_ref_number_txt,
      listagg(distinct brl.item_position, ', ') within group (order by brl.item_position) as item_position_txt,
      round(sum(brl.net_mass_meas), 2) as broker_net_mass_meas,
      round(sum(crl.net_mass_qty), 2) as cds_net_mass_meas,
      round(sum(brl.charge_amount_val), 0) as broker_invoice_amount_val,
      round(sum(crl.item_price), 0) as cds_invoice_amount_val,
      max(brl.charge_amount_curr_cd) as broker_invoice_curr_cd,
      max(cr.invoice_trust_curr_cd) as cds_invoice_curr_cd,
      max(br.trade_terms) as trade_terms,
      count(*) as broker_line_cnt
      from core_rel.t_broker_report_1 br
      join core_rel.t_broker_report_line_1 brl
        on br.movement_ref_number = brl.movement_ref_number 
       and br.trader_reference = brl.trader_reference
      join core_rel.t_customs_product_1 p
        on brl.customs_product_sid = p.product_sid
       and coalesce(br.cds_acceptance_tmsp, br.acceptance_tmsp, br.cds_clearance_tmsp) between p.dwh_valid_from_tmsp and p.dwh_valid_to_tmsp  
      join core_rel.t_country_political_1 c
        on p.origin_country_location_sid = c.location_sid
        and coalesce(br.cds_acceptance_tmsp, br.acceptance_tmsp, br.cds_clearance_tmsp) between c.dwh_valid_from_tmsp and c.dwh_valid_to_tmsp
       and c.lang_cd = 'DE'
      left
      join core_rel.t_customs_clearance_report_1 cr
        on br.movement_ref_number = cr.movement_ref_number
       and(   br.trader_reference = cr.trader_reference
           or brl.invoice_number = cr.trader_reference
           or br.declaration_ucr like '%' || cr.trader_reference || '%'
          )
      left
      join core_rel.t_customs_clearance_report_line_1 crl
        on cr.movement_ref_number = crl.movement_ref_number 
       and cr.clearance_dt = crl.clearance_dt 
       and brl.item_position = crl.item_position
      join core_rel.t_consignor_1 cg
        on coalesce(cr.consignor_party_sid, br.consignor_party_sid) = cg.party_sid
      GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11)     
          ) bd
      full
      join(select distinct
                  trader_reference_nr
             from (--Consignor Data                                                                                              
    --GTS Data                                                                                             
     select 'GTS' as customs_product_type_cd,
     col.authority_country_location_sid,
     col.consignor_party_sid,
     col.trader_reference_nr,
     col.order_dt as report_dt,
     p.product_sid as customs_product_sid,
     case when p.additional_cd != ''
          then p.customs_product_nr || '_' || p.additional_cd 
          else p.customs_product_nr 
          end as customs_product_nr,
     p.customs_tariff_code_cd as commodity_code_nr,
     p.origin_country_location_sid,
     c.iso_country_cd as country_of_origin_cd,
     listagg(coll.item_position_seq, ', ') within group (order by coll.item_position_seq) as item_position_txt,
     max(p.customs_product_name) as customs_product_name,
     listagg(coll.article_variant_nr, ', ') within group (order by coll.article_variant_nr) as article_variant_nr_txt,
     round(sum(coll.net_weight_meas), 2) as consignor_net_mass_meas,
     round(sum(coll.original_amount_val), 0) as consignor_invoice_amount_val,
     max(coll.original_amount_curr_cd) as consignor_invoice_curr_cd,                                                                                               
     count(*) as consignor_line_cnt                                                           
     from core_rel.t_consignor_order_list_1 col
     join core_rel.t_consignor_order_list_line_1 coll
     on col.trader_reference_nr = coll.trader_reference_nr 
     and col.order_dt = coll.order_dt
     join core_rel.t_customs_product_1 p
     on coll.customs_product_sid = p.product_sid
     AND P.CUSTOMS_PRODUCT_TYPE_CD='GTS'
     and coll.order_dt between p.dwh_valid_from_tmsp and p.dwh_valid_to_tmsp
     join core_rel.t_country_political_1 c
     on coll.origin_country_location_sid = c.location_sid 
     and coll.order_dt between c.dwh_valid_from_tmsp and c.dwh_valid_to_tmsp
     and c.lang_cd = 'DE'
     where coll.customs_product_sid != -1                                                                                         
     GROUP BY 2, 3, 4, 5, 6, 7, 8, 9, 10
     union                                                                                        
    --WWT Data
      select 'WWT' as customs_product_type_cd,
      COL.authority_country_location_sid,
      COL.consignor_party_sid,
      COL.trader_reference_nr,
      COL.order_dt as report_dt,
      cp.product_sid as customs_product_sid,
      case when cp.additional_cd != ''
           then cp.customs_product_nr || '_' || cp.additional_cd 
           else cp.customs_product_nr 
           end as customs_product_nr,
      cp.customs_tariff_code_cd as commodity_code_nr,
      cp.origin_country_location_sid,
      c.iso_country_cd as country_of_origin_cd,
      NULL as item_position_txt,
      max(cp.customs_product_name) as customs_product_name,
      NULL as article_variant_nr_txt,
      round(sum(coll.net_weight_meas), 2) as consignor_net_mass_meas,
      round(sum(coll.net_val), 0) as consignor_invoice_amount_val,
      --max(coll.net_val_curr_cd) as consignor_invoice_curr_cd,
      MAX(COLL.NET_CURR_CD)  as consignor_invoice_curr_cd,
      count(*) as consignor_line_cnt       
      from CORE_REL.T_CONSIGNOR_ORDER_LIST_1 COL
      JOIN CORE_REL.T_CONSIGNOR_ORDER_LIST_LINE_1 COLL
        ON COL.TRADER_REFERENCE_NR = COLL.TRADER_REFERENCE_NR 
       AND COL.ORDER_DT = COLL.ORDER_DT
       and col.invoice_finance_sid = coll.invoice_finance_sid
      JOIN CORE_REL.T_COUNTRY_POLITICAL_1 C
        ON COLL.ORIGIN_COUNTRY_LOCATION_SID = C.LOCATION_SID
       AND COL.ORDER_DT BETWEEN C.DWH_VALID_FROM_TMSP AND C.DWH_VALID_TO_TMSP  
       AND C.LANG_CD = 'DE' 
      JOIN CORE_REL.T_CUSTOMS_PRODUCT_1 CP
        ON COLL.PRODUCT_NR = CP.CUSTOMS_PRODUCT_NR
       AND COLL.ADDITIONAL_CD = CP.ADDITIONAL_CD 
       AND CP.CUSTOMS_PRODUCT_TYPE_CD='WWT'
       AND COLL.ORIGIN_COUNTRY_LOCATION_SID = CP.ORIGIN_COUNTRY_LOCATION_SID
       AND COL.ORDER_DT BETWEEN CP.DWH_VALID_FROM_TMSP AND CP.DWH_VALID_TO_TMSP 
      JOIN core_rel.t_invoice_status_1 ist
        on col.invoice_finance_sid = ist.invoice_finance_sid 
       and col.order_dt between ist.dwh_valid_from_tmsp and ist.dwh_valid_to_tmsp  
      join core_rel.t_invoice_position_1 inp
        on coll.invoice_position_finance_sid = inp.finance_sid 
       and col.order_dt between inp.dwh_valid_from_tmsp and inp.dwh_valid_to_tmsp
      where COLL.PRODUCT_SID != -1    
       AND ist.invoice_status_type_cd in ('CHARGED', 'UNCHARGED')
       AND inp.reference_invoice_position_finance_sid = -1
      GROUP BY 2, 3, 4, 5, 6, 7, 8, 9, 10 )    
          ) cd
     on bd.trader_reference_nr = cd.trader_reference_nr) trm
    on coalesce(bd.trader_reference_nr, cd.trader_reference_nr) = trm.trader_reference_nr 
  left
  join (--Missing Documents
  select cd.trader_reference_nr,
  cd.customs_product_sid,
  listagg(distinct dc.customs_document_cd, ', ') within group (order by dc.customs_document_cd) as missing_document_codes_txt,
  count(*) as missing_document_codes_cnt                                                                                           
  from
  (--Consignor Documents                                                                                                 
   --GTS Documents 
     select
     coll.trader_reference_nr,
     coll.customs_product_sid,
     rel.resource_item_sid
     from core_rel.t_consignor_order_list_line_document_rel_1 rel
     join core_rel.t_consignor_order_list_line_1 coll
     on rel.trader_reference_nr = coll.trader_reference_nr 
     and rel.order_dt = coll.order_dt 
     and rel.item_position_seq = coll.item_position_seq
     where coll.customs_product_sid != -1
    union
   --WWT Documents                                                                                            
  select coll.trader_reference_nr,
  cpr.product_sid,
  0 as resource_item_sid
  from core_rel.t_consignor_order_list_line_1 coll
  join core_rel.t_customs_product_1 cpr
    on coll.product_nr = cpr.customs_product_nr 
   and coll.additional_cd = cpr.additional_cd 
   and coll.order_dt between cpr.dwh_valid_from_tmsp and cpr.dwh_valid_to_tmsp
  join core_rel.t_customs_product_document_rel_1 cpdr
    on cpr.product_sid = cpdr.product_sid
   and coll.order_dt between cpdr.dwh_valid_from_tmsp and cpdr.dwh_valid_to_tmsp  
   where coll.customs_product_sid = -1) cd
  join core_rel.t_customs_document_1 dc
    on cd.resource_item_sid = dc.resource_item_sid
  left
  join (select distinct 
   case when br.trader_reference like '%-SDI'
   then substr(br.trader_reference, 1, length(br.trader_reference) - 4)
   else to_char(br.trader_reference) 
   end as trader_reference_nr,
   brl.customs_product_sid,
   drl.resource_item_sid                                                                                            
   from core_rel.t_broker_report_1 br
   join core_rel.t_broker_report_line_1 brl
     on br.movement_ref_number = brl.movement_ref_number 
    and br.trader_reference = brl.trader_reference
   join core_rel.t_customs_clearance_report_1 cr
     on br.movement_ref_number = cr.movement_ref_number
    and(   br.trader_reference = cr.trader_reference
        or brl.invoice_number = cr.trader_reference
        or br.declaration_ucr like '%' || cr.trader_reference || '%'
       )
   join core_rel.t_customs_clearance_report_line_1 crl
     on cr.movement_ref_number = crl.movement_ref_number 
    and cr.clearance_dt = crl.clearance_dt 
    and brl.item_position = crl.item_position      
   join core_rel.t_customs_clearance_report_line_document_rel_1 drl
     on crl.movement_ref_number = drl.movement_ref_number 
    and crl.item_position = drl.item_position) bd
    on cd.trader_reference_nr = bd.trader_reference_nr
   and cd.customs_product_sid = bd.customs_product_sid
   and cd.resource_item_sid = bd.resource_item_sid
  left
  join core_rel.t_customs_document_1 bc
    on bd.resource_item_sid = bc.resource_item_sid
  where bd.resource_item_sid is null
  group by  1, 2) md
    on coalesce(bd.trader_reference_nr, cd.trader_reference_nr) = md.trader_reference_nr
   and coalesce(bd.customs_product_sid, cd.customs_product_sid) = md.customs_product_sid
  left
  join (--Broker Document List
   select  bd.trader_reference_nr,
   bd.customs_product_sid,
   listagg(distinct dc.customs_document_cd, ', ') within group (order by dc.customs_document_cd) as  broker_document_codes_txt,                                                                                          
   from (
  --Broker Documents                
   select distinct 
   case when br.trader_reference like '%-SDI'
   then substr(br.trader_reference, 1, length(br.trader_reference) - 4)
   else to_char(br.trader_reference) 
   end as trader_reference_nr,
   brl.customs_product_sid,
   drl.resource_item_sid                                                                                            
   from core_rel.t_broker_report_1 br
   join core_rel.t_broker_report_line_1 brl
     on br.movement_ref_number = brl.movement_ref_number 
    and br.trader_reference = brl.trader_reference
   join core_rel.t_customs_clearance_report_1 cr
     on br.movement_ref_number = cr.movement_ref_number
    and(   br.trader_reference = cr.trader_reference
        or brl.invoice_number = cr.trader_reference
        or br.declaration_ucr like '%' || cr.trader_reference || '%'
       )
   join core_rel.t_customs_clearance_report_line_1 crl
     on cr.movement_ref_number = crl.movement_ref_number 
    and cr.clearance_dt = crl.clearance_dt 
    and brl.item_position = crl.item_position      
   join core_rel.t_customs_clearance_report_line_document_rel_1 drl
     on crl.movement_ref_number = drl.movement_ref_number 
    and crl.item_position = drl.item_position) bd
   join core_rel.t_customs_document_1 dc
     on bd.resource_item_sid = dc.resource_item_sid
   GROUP BY 1, 2) bdl
    on coalesce(bd.trader_reference_nr, cd.trader_reference_nr) = bdl.trader_reference_nr
   and coalesce(bd.customs_product_sid, cd.customs_product_sid) = bdl.customs_product_sid
  left
  join (--Consignor Document List                                                                                              
   select trader_reference_nr,
   customs_product_sid,
   listagg(distinct dc.customs_document_cd, ', ') within group (order by dc.customs_document_cd) as CONISGNOR_DOCUMENT_CODES_TXT
   from                                                                                              
   (--Consignor Documents                                                                                                 
   --GTS Documents 
     select
     coll.trader_reference_nr,
     coll.customs_product_sid,
     rel.resource_item_sid
     from core_rel.t_consignor_order_list_line_document_rel_1 rel
     join core_rel.t_consignor_order_list_line_1 coll
     on rel.trader_reference_nr = coll.trader_reference_nr 
     and rel.order_dt = coll.order_dt 
     and rel.item_position_seq = coll.item_position_seq
     where coll.customs_product_sid != -1
    union
   --WWT Documents                                                                                            
  select coll.trader_reference_nr,
  cpr.product_sid,
  0 as resource_item_sid
  from core_rel.t_consignor_order_list_line_1 coll
  join core_rel.t_customs_product_1 cpr
    on coll.product_nr = cpr.customs_product_nr 
   and coll.additional_cd = cpr.additional_cd 
   and coll.order_dt between cpr.dwh_valid_from_tmsp and cpr.dwh_valid_to_tmsp
  join core_rel.t_customs_product_document_rel_1 cpdr
    on cpr.product_sid = cpdr.product_sid
   and coll.order_dt between cpdr.dwh_valid_from_tmsp and cpdr.dwh_valid_to_tmsp  
   where coll.customs_product_sid = -1) bd
   join core_rel.t_customs_document_1 dc
   on bd.resource_item_sid = dc.resource_item_sid                                                                                            
  GROUP BY 1, 2) cdl
    on coalesce(bd.trader_reference_nr, cd.trader_reference_nr) = cdl.trader_reference_nr
   and coalesce(bd.customs_product_sid, cd.customs_product_sid) = cdl.customs_product_sid
   qualify row_number() over (partition by coalesce(bd.trader_reference_nr, cd.trader_reference_nr),
                                        coalesce(bd.customs_product_nr, cd.customs_product_nr)
                               order by case when bd.commodity_code_nr = cd.commodity_code_nr then 0 else 1 end) = 1;
