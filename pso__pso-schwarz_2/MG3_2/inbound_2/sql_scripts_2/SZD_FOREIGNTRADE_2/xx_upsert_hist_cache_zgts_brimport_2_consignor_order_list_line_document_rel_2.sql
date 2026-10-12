INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
trader_reference_nr,
       order_dt,
       item_position_seq,
       resource_item_sid,
       preference_indicator_fg,
     dwh_src_file_name,
dwh_src_1_tmsp, 
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
)
select br.trader_reference_nr,
       br.order_dt,
       br.item_position_seq,
       rk.resource_item_sid,
       MAX(br.preference_indicator_fg),
       MAX(dwh_src_file_name),
       MAX(dwh_src_1_tmsp),
       current_timestamp dwh_mapping_tmsp,
       0 tf_error_fg,
       0 deleted_fg,
       0 record_id,
       'bei' filename
  from(select 
              br.corder as trader_reference_nr,         
              coalesce(br.etd, br.etats) as order_dt,
              --br.CORDER_ITEM as item_position_seq,
              row_number() over (partition by trim(corder) order by trim(itvsy_id_no)) as item_position_seq,
              trim(sp.value) as document_code,
              true as preference_indicator_fg ,
              dwh_src_file_name,
              dwh_src_1_tmsp
         from etl.t_cache_zgts_brimport_2 br, 
              table(split_to_table(br.PAPTY , ';')) sp
        where sp.value is not null      
        union
       select 
              br.corder as trader_reference_nr,         
              coalesce(br.etd, br.etats) as order_dt,
              --br.CORDER_ITEM as item_position_seq,
              row_number() over (partition by trim(corder) order by trim(itvsy_id_no)) as item_position_seq,
              trim(sp.value) as document_code,
              false as preference_indicator_fg,
              dwh_src_file_name,
              dwh_src_1_tmsp
         from etl.t_cache_zgts_brimport_2 br, 
              table(split_to_table(br.OTHER_DOCS, ';')) sp 
        where sp.value is not null      
      ) br
  join meta.t_resource_item_key_2 rk
    on 'GB|' || upper(br.document_code) = rk.resource_item_nat_key_nr
   and rk.resource_item_key_type_cd = 'CUSTOMS_DOCUMENT'  
 where br.order_dt is not null
group by 
br.trader_reference_nr,
       br.order_dt,
       br.item_position_seq,
       rk.resource_item_sid
; 
