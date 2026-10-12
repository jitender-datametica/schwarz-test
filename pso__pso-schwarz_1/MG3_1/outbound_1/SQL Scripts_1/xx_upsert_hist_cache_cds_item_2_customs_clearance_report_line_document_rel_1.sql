INSERT INTO szd_producton.${temp_db}.${src2tgt_temp_table1}_${src_context_area} (movement_ref_number, trader_reference, item_position, resource_item_sid, dwh_src_file_name, dwh_src_1_tmsp, dwh_mapping_tmsp, tf_error_fg, deleted_fg, record_id, dwh_valid_fg, filename)
  select
      src.entry_identifier as movement_ref_number,
      hd.declarant_reference,
      src.item_number as item_position,
      coalesce(ri.resource_item_sid, -1) as resource_item_sid,
      src.dwh_src_file_name,
      src.dwh_src_1_tmsp,
      src.dwh_src_1_tmsp as dwh_mapping_tmsp,
      0 as tf_error_fg,
      0 as deleted_fg,
      0 as record_id,
      1 as dwh_valid_fg,
      src.dwh_src_file_name as filename
    from
      (
        select
            entry_identifier,
            clearance_date,
            item_number,
            trim(son.value, ' ') as document_code,
            ca.dwh_src_file_name,
            ca.dwh_src_1_tmsp,
            son.value as val
          from
            szd_production.etl.t_cache_cds_item_1 as ca
            cross join son
          where entry_identifier <> 'null'
           and item_number <> 'null'
      ) as src
      inner join szd_production.etl.t_cache_cds_header_1 as hd on src.entry_identifier = hd.entry_identifier
       and case
        when substr(trim(hd.clearance_date, ' '), 3, 1) = '/' then parse_date('%d/%m/%y', substr(hd.clearance_date, 1, 10))
        else parse_date('%y-%m-%d', substr(hd.clearance_date, 1, 10))
      end = case
        when substr(trim(src.clearance_date, ' '), 3, 1) = '/' then parse_date('%d/%m/%y', substr(src.clearance_date, 1, 10))
        else parse_date('%y-%m-%d', substr(src.clearance_date, 1, 10))
      end
      inner join szd_production.meta.t_resource_item_key_1 as rk on concat('gb|', src.document_code) = rk.resource_item_nat_key_nr
       and rk.resource_item_key_type_cd = 'CUSTOMS_DOCUMENT'
      left outer join szd_production.meta.t_resource_item_key_1 as ri on ri.resource_item_key_type_cd = 'CUSTOMS_DOCUMENT'
       and ri.resource_item_nat_key_nr = upper(concat('gb', '|', src.val))
    where hd.declarant_reference is not null
;
