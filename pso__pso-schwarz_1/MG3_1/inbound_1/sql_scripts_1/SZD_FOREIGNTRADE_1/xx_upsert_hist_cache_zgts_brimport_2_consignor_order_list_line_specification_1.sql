INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
trader_reference_nr,
       order_dt,
       item_position_seq,
       specification_seq,
       spec_uom_id,
       spec_meas,
     dwh_src_file_name,
dwh_src_1_tmsp, 
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
)
select trader_reference_nr,
       order_dt,
       item_position_seq,
       specification_seq,
       spec_uom_id,
       spec_meas,
       MAX(dwh_src_file_name),
       MAX(dwh_src_1_tmsp),
       current_timestamp dwh_mapping_tmsp,
       0 tf_error_fg,
       0 deleted_fg,
       0 record_id,
       'bei' filename
  from(select corder as trader_reference_nr,
       coalesce(etd, etats) as order_dt,
       ROW_NUMBER() OVER (PARTITION BY CORDER ORDER BY ITVSY_ID_NO)
       --corder_item 
       as item_position_seq,
       1 as specification_seq,
       coalesce(u.unit_id, -1) as spec_uom_id,
       case when trim(bei.CTSMU1) = 'LTR' then 'l'
            when trim(bei.CTSMU1) = 'HLT' then 'hl_1'
            else trim(lower(bei.CTSMU1))
        end test1_1,
       bei.CTSMU1_Q as spec_meas,
       bei.dwh_src_file_name as dwh_src_file_name,
       bei.dwh_src_1_tmsp as dwh_src_1_tmsp
  from etl.t_cache_zgts_brimport_1 bei
  left  join   core_rel.t_unit_1 u
    on test1_1 = u.unit_cd
 where coalesce(etd, etats) is not null
 union all
select corder as trader_reference_nr,
       coalesce(etd, etats) as order_dt,
       ROW_NUMBER() OVER (PARTITION BY CORDER ORDER BY ITVSY_ID_NO)
       --corder_item 
       as item_position_seq,
       2 as specification_seq,
       coalesce(u.unit_id, -1) as spec_uom_id,
       case when trim(bei.CTSMU2) = 'LTR' then 'l'
            when trim(bei.CTSMU2) = 'HLT' then 'hl_1'
            else trim(lower(bei.CTSMU2))
        end test1_1,
       bei.CTSMU2_Q as spec_meas,
       bei.dwh_src_file_name as dwh_src_file_name,
       bei.dwh_src_1_tmsp as dwh_src_1_tmsp
  from etl.t_cache_zgts_brimport_1 bei
  left  join   core_rel.t_unit_1 u
    on test1_1 = u.unit_cd
 where coalesce(etd, etats) is not null
 union    all
select corder as trader_reference_nr,
       coalesce(etd, etats) as order_dt,
       ROW_NUMBER() OVER (PARTITION BY CORDER ORDER BY ITVSY_ID_NO)
       --corder_item 
       as item_position_seq,
       3 as specification_seq,
       coalesce(u.unit_id, -1) as spec_uom_id,
       case when trim(bei.CTSMU3) = 'LTR' then 'l'
            when trim(bei.CTSMU3) = 'HLT' then 'hl_1'
            else trim(lower(bei.CTSMU3))
        end test1_1,
       bei.CTSMU3_Q as spec_meas,
       bei.dwh_src_file_name as dwh_src_file_name,
       bei.dwh_src_1_tmsp as dwh_src_1_tmsp
  from etl.t_cache_zgts_brimport_1 bei
  left  join   core_rel.t_unit_1 u
    on test1_1 = u.unit_cd
 where coalesce(etd, etats) is not null) 
group by 
trader_reference_nr,
       order_dt,
       item_position_seq,
       specification_seq,
       spec_uom_id,
       spec_meas
; 
